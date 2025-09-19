local Inputs = require "System.Inputs"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local StateMachine   = require "Dragontail.Character.Component.StateMachine"
local Fighter  = require "Dragontail.Character.Fighter"
local Character= require "Dragontail.Character"
local AttackerSlot = require "Dragontail.Character.Component.AttackerSlot"
local Characters   = require "Dragontail.Stage.Characters"
local Color        = require "Tiled.Color"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Component.Face"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Shoot        = require "Dragontail.Character.Action.Shoot"
local Body         = require "Dragontail.Character.Component.Body"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local WeaponInHand         = require "Dragontail.Character.Component.WeaponInHand"
local Inventory            = require "Dragontail.Character.Component.Inventory"
local InputLog          = require "Dragontail.Character.Component.InputLog"
local Combo                = require "Dragontail.Character.Component.Combo"
local Mana                 = require "Dragontail.Character.Component.Mana"
local Config               = require "System.Config"
local Guard                = require "Dragontail.Character.Action.Guard"
local AttackTarget         = require "Dragontail.Character.Component.AttackTarget"
local Catcher    = require "Dragontail.Character.Component.Catcher"

---@class Player:Fighter
---@field inventory Inventory
---@field inputlog InputLog
local Player = class(Fighter)

local NormalChargeRate = 2
local NormalDecayRate = 2
local ReversalChargeRate = 4
local ReversalDecayRate = 1

Player.ChargeAttacks = {
    "fireball-storm", "spit-multi-fireball", "spit-fireball"
}

local pi = math.pi
local cos = math.cos
local sin = math.sin
local atan2 = math.atan2
local acos = math.acos
local dot = math.dot
local det = math.det
local norm = math.norm
local abs = math.abs
local rot = math.rot
local lensq = math.lensq
local testcircles = math.testcircles
local yield = coroutine.yield

local NormalCombo = {"kick", "kick", "tail-swing-cw"}
local LungingCombo = {"lunging-kick", "lunging-kick", "lunging-tail-swing-cw"}
local SpecialCombo = {"spit-fireball", "spit-fireball", "fireball-spin-cw"}
local HoldCombo = {"holding-knee", "holding-knee", "spinning-throw"}
local RunningSpecialAttacks = { "running-spit-fat-fireball", "running-spit-fireball" }

local AirCombo = {"air-kick", "air-kick", "air-tail-swing-cw"}
local AirLungingCombo = {"air-lunging-kick", "air-lunging-kick", "air-lunging-tail-swing-cw"}
local AirHoldCombo = {"air-holding-knee", "air-holding-knee", "air-spinning-throw"}

function Player:getNextAttackType(heldenemy, lunging, inair)
    local comboindex = self.comboindex
    -- if special then
    --     local i = comboindex
    --     local specialattacktype, specialattackdata
    --     repeat
    --         specialattacktype = SpecialCombo[i]
    --         if Mana.canAffordAttack(self, specialattacktype) then
    --             return specialattacktype
    --         end
    --         i = i - 1
    --     until i <= 0
    --     comboindex = 3
    -- end

    local combo = heldenemy and HoldCombo
        or lunging and LungingCombo
        or NormalCombo
    return combo[comboindex]
end

--[[

Not holding:

kick -> kick -> tailspin
    |       |   ^
    |   ----|----
    v   ^   v
    fire    firespin

Holding:

knee -> knee -> spinthrow
    |       |   ^
    |   ----|----
    v   ^   v
    fire    firespin

]]
function Player:doComboAttack(faceangle, heldenemy, lunging, inair)
    local attacktype = self:getNextAttackType(heldenemy, lunging, inair)
    local attackdata = self.attacktable[attacktype]
    if attackdata and attackdata.endscombo or self.comboindex >= 3 then
        self.comboindex = 1
    else
        self.comboindex = self.comboindex + 1
    end

    return attacktype, faceangle, attackdata and attackdata.isholding and heldenemy
end

local function findInstantThrowDir(self, targetfacex, targetfacey)
    local throwdirx, throwdiry, throwdirz = targetfacex, targetfacey, 0
    local enemy, enemytargetingscore = nil, 128
    local throwz = self.z + self.bodyheight/2
    Characters.search("enemies",
    ---@param e Enemy
    function(e)
        if not e.getTargetingScore then
            return
        end
        local score = e:getTargetingScore(self.x, self.y, targetfacex, targetfacey)

        local etop, ebottom = e.z + self.bodyheight, e.z
        if ebottom > throwz or throwz > etop then
            score = score / 2
        end
        if score < enemytargetingscore then
            enemy, enemytargetingscore = e, score
        end
    end)
    if enemy then
        throwdirx, throwdiry, throwdirz = norm(enemy.x - self.x, enemy.y - self.y,
            (enemy.z + enemy.bodyheight/2) - (self.z + self.bodyheight/2))
    end
    return throwdirx, throwdiry, throwdirz
end

local updateEnemyTargetingScores_enemies = {}

local function updateEnemyTargetingScores(self, lookangle)
    local enemies = updateEnemyTargetingScores_enemies
    for i = #enemies, 1, -1 do enemies[i] = nil end

    -- local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    -- local projectilez = self.z + projectileheight
    local lookx, looky = cos(lookangle), sin(lookangle)
    Characters.search("enemies",
    ---@param e Enemy
    function(e)
        if not e.getTargetingScore then
            return
        end
        local score = e:getTargetingScore(self.x, self.y, lookx, looky)

        -- local etop, ebottom = e.z + self.bodyheight, e.z
        -- if ebottom > projectilez or projectilez > etop then
        --     score = score / 2
        -- end
        e.targetingscore = score
        enemies[#enemies+1] = e
    end)
    table.sort(enemies, function(a, b) return a.targetingscore < b.targetingscore end)
    return enemies
end

function Player:getAngleToBestTarget(lookangle, targets)
    lookangle = lookangle or self.faceangle
    targets = targets or updateEnemyTargetingScores(self, lookangle)
    if targets[1] then
        local dy, dx = targets[1].y - self.y, targets[1].x - self.x
        if dy ~= 0 or dx ~= 0 then
            if math.dot(cos(lookangle), sin(lookangle), dx, dy) >= 0 then
                return atan2(dy, dx)
            end
        end
    end
end

function Player:init()
    self.inputlog = InputLog(6)
    self.attackbutton = Inputs.getAction("attack")
    self.sprintbutton = Inputs.getAction("sprint")
    self.flybutton = Inputs.getAction("fly")
    Fighter.init(self)
    self.inventory = Inventory()
    Combo.reset(self)
    -- self.runenergy = self.runenergy or 100
    -- self.runenergymax = self.runenergymax or self.runenergy
    -- self.runenergycost = self.runenergycost or 25
    Mana.init(self)

    AttackTarget.initSlots(self)
end

-- function Player:addToScene(scene)
--     Character.addToScene(self, scene)
--     for _, slot in ipairs(self.attackerslots) do
--         slot.id = 0
--         slot.drawz = 0x1000
--         slot.visible = true
--         scene:add(slot)
--     end
-- end

function Player.getJoystick()
    local analogx = Inputs.getAction("analogx").position
    local analogy = Inputs.getAction("analogy").position
    local lsq = lensq(analogx, analogy)

    local deadzone = math.max(1/64, Config.joy_deadzone or .25)
    if lsq < deadzone*deadzone then
        analogx, analogy = 0, 0
    else
        local len = math.sqrt(lsq)
        len = (len - deadzone) / (1 - deadzone)
        analogx, analogy = norm(analogx, analogy)
        analogx, analogy = len*analogx, len*analogy
    end

    local digitalx = Inputs.getAction("digitalx").position
    local digitaly = Inputs.getAction("digitaly").position

    local inx, iny = digitalx + analogx, digitaly + analogy
    if lensq(inx, iny) > 1 then
        inx, iny = norm(inx, iny)
    end

    return inx, iny
end

function Player:getParryVector()
    local x1, y1 = self.inputlog:newestJoystick()
    if not x1 or not y1 or x1 == 0 and y1 == 0 then return end
    local x0, y0 = self.inputlog:oldestJoystick()
    if dot(x0, y0, x1, y1) <= 0 then
        return math.norm(x1, y1)
    end
end

function Player:isActionRecentlyPressed(actionname)
    return self.inputlog:findActionState(actionname, "pressed")
end

function Player:isActionDownAndRecentlyPressed(actionname)
    local action = Inputs.getAction(actionname)
    if not action then return false end
    return action.pressed or
        action.down and self:isActionRecentlyPressed(actionname)
end

function Player:tryToGiveWeapon(weapontype)
    if self.inventory:add(weapontype) then
        Audio.play(self.holdsound)
        self.weaponinhand = weapontype
        return true
    end
end

function Player:updateAttackerSlots()
    local attackerslots = self.attackerslots
    for _, slot in ipairs(attackerslots) do
        slot.x, slot.y, slot.z = self.x, self.y, self.z + self.bodyheight/2
        Characters.castRay3(slot, self)
    end
end

local ChargeAttacks = {
    "fireball-storm", "spit-multi-fireball", "spit-fireball"
}
local RunningChargeAttacks = {
    "fireball-storm", "running-spit-multi-fireball", "running-spit-fireball"
}

function Player:updateBreathCharge(chargerate, decayrate)
    if Config.player_autorevive and self.health <= 0 or self.attackbutton.down then
        Mana.charge(self, chargerate or NormalChargeRate)
    else
        Mana.decayCharge(self, decayrate or NormalDecayRate)
    end
end

function Player:getChargedAttack(chargeattacks)
    for _, chargeattack in ipairs(chargeattacks) do
        if Mana.hasChargeForAttack(self, chargeattack) then
            return chargeattack
        end
    end
end

function Player:fixedupdate()
    self.inputlog:logJoystick(self:getJoystick())
    self.inputlog:logActionState(self.attackbutton)
    self.inputlog:logActionState(self.sprintbutton)
    self.inputlog:logActionState(self.flybutton)
    self.inputlog:advance()
    self:updateBreathCharge(self.manachargerate, self.manadecayrate)
    Character.fixedupdate(self)
end

function Player:accelerateTowardsJoystick()
    local inx, iny = self:getJoystick()
    local mass = self.mass or 1
    local movespeed = self.speed or 1
    local targetvelx = inx * movespeed
    local targetvely = iny * movespeed
    self:accelerateTowardsVel(targetvelx, targetvely, mass)
end

function Player:accelerateTowardsFace()
    local inx, iny = cos(self.faceangle), sin(self.faceangle)
    local mass = self.mass or 1
    local movespeed = self.speed or 1
    local targetvelx = inx * movespeed
    local targetvely = iny * movespeed
    self:accelerateTowardsVel(targetvelx, targetvely, mass)
end

function Player:turnTowardsJoystick(movinganimation, notmovinganimation)
    local inx, iny = self:getJoystick()
    if inx ~= 0 or iny ~= 0 then
        self.facedestangle = atan2(iny, inx)
    else
        self.facedestangle = self.facedestangle or self.faceangle
    end
    local animation
    if self.velx ~= 0 or self.vely ~= 0 then
        animation = movinganimation
    else
        animation = notmovinganimation
    end
    return Face.updateTurnToDestAngle(self, nil, animation), self.facedestangle
end

function Player:catchProjectileAtJoystick()
    local parryx, parryy = self:getParryVector()
    if not (parryx and parryy) then return end

    local projectiles = Characters.getGroup("projectiles")
    return Catcher.findCharacterToCatch(self, projectiles, parryx, parryy)
end

function Player:getReversalChargedAttack()
    local chargedattack = self:getChargedAttack(ChargeAttacks)
    if chargedattack then
        local inx, iny = self:getJoystick()
        local angle = self.faceangle
        if inx ~= 0 or iny ~= 0 then
            angle = atan2(iny, inx)
        end
        return chargedattack, angle
    end
end

function Player:getup()
    if self.sprintbutton.down then
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            Face.faceAngle(self, atan2(iny, inx))
        end
        return "run", nil, true
    end
    if not self.attackbutton.down then
        local chargedattack, angle = self:getReversalChargedAttack()
        if chargedattack then
            Mana.releaseCharge(self)
            return chargedattack, angle
        end
    end
end

function Player:aimThrow()
    self.crosshair = self.crosshair or Characters.spawn({
        type = "rose-crosshair",
        visible = false
    })
    self.facedestangle = self.faceangle
    local lockonenemy
    while true do
        local attackbutton, runbutton = self.attackbutton.down, self.sprintbutton.down
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            self.facedestangle = atan2(iny, inx)
        end

        local targetvelx, targetvely
        local movespeed, turnspeed, acceltime
        movespeed, turnspeed, acceltime = 2, pi/8, 4

        targetvelx = inx * movespeed
        targetvely = iny * movespeed

        self:accelerateTowardsVel(targetvelx, targetvely, acceltime)

        local lockonenemyscore = 128
        if lockonenemy then
            local score = lockonenemy:getTargetingScore(self.x, self.y, math.cos(self.faceangle), math.sin(self.faceangle))
            if score > lockonenemyscore then
                lockonenemy = nil
            else
                lockonenemyscore = lockonenemy:getTargetingScore(self.x, self.y, cos(self.facedestangle), sin(self.facedestangle))
            end
        end

        Characters.search("enemies",
        ---@param enemy Enemy
        function(enemy)
            local score = enemy.getTargetingScore
                and enemy:getTargetingScore(self.x, self.y, cos(self.facedestangle), sin(self.facedestangle))
                or math.huge
            if score < lockonenemyscore then
                lockonenemy, lockonenemyscore = enemy, score
            end
        end)

        if lockonenemy then
            local targetfacex, targetfacey = lockonenemy.x - self.x, lockonenemy.y - self.y
            if targetfacex ~= 0 or targetfacey ~= 0 then
                self.facedestangle = atan2(targetfacey, targetfacex)
            end
        end
        Face.updateTurnToDestAngle(self, turnspeed)

        if runbutton then
            self.crosshair.visible = false
            return "walk"
        end

        if not attackbutton then
            self.crosshair.visible = false
            local throwx, throwy, throwz
            if lockonenemy then
                throwx, throwy, throwz = lockonenemy.x, lockonenemy.y, lockonenemy.z
            else
                throwx, throwy, throwz = self.x + math.cos(self.faceangle)*512, self.y + math.sin(self.faceangle)*512, self.z
            end
            return "throwWeapon", self.faceangle, 1, 1
        end

        local animation
        if self.velx ~= 0 or self.vely ~= 0 then
            animation = "Walk"
        else
            animation = "Stand"
        end
        DirectionalAnimation.set(self, animation, self.faceangle)

        self.crosshair.visible = lockonenemy ~= nil
        if lockonenemy then
            self.crosshair.x, self.crosshair.y = lockonenemy.x, lockonenemy.y
            self.crosshair.z = lockonenemy.z + lockonenemy.bodyheight/2
            self.crosshair.velx, self.crosshair.vely, self.crosshair.velz = lockonenemy.velx, lockonenemy.vely, lockonenemy.velz
        end
        yield()
    end
end

function Player:throwWeapon(angle, attackchoice, numprojectiles)
    attackchoice = attackchoice or 1
    numprojectiles = math.min(numprojectiles or 1, #self.inventory)
    Face.faceAngle(self, angle, self.state.animation)

    local function throw(targetx, targety, targetz)
        local projectiledata = Database.get(self.weaponinhand)
        local attackid = projectiledata and projectiledata.playerattack
        Shoot.launchProjectileAtPosition(self, {
            type = self.weaponinhand,
            gravity = 1/8,
            speed = 16
        }, targetx, targety, targetz, attackid)
        self.inventory:pop()
        self.weaponinhand = self.inventory:last()
    end

    local cosangle, sinangle = cos(angle), sin(angle)
    local targets = updateEnemyTargetingScores(self, angle)
    local arc = self.throwmultiarc or (pi/4)
    local cosarc = cos(arc)
    local numfired = 0
    local targetsz = 0
    for i = 1, math.min(numprojectiles, #targets) do
        local target = targets[i]
        local totargetx, totargety = target.x - self.x, target.y - self.y
        if dot(cosangle, sinangle, totargetx, totargety) >= cosarc*math.len(totargetx, totargety) then
            numfired = numfired + 1
            local targetx, targety, targetz =
                Shoot.getTargetObjectPosition(self, target)
            targetsz = targetsz + targetz
            throw(targetx, targety, targetz)
        end
    end

    numprojectiles = numprojectiles - numfired
    if numprojectiles > 0 then
        arc = arc/2
        targetsz = numfired > 0 and (targetsz/numfired) or self.z
        local projectileangle = angle
        local numgaps = numprojectiles - 1
        local gaparc = numgaps <= 0 and 0 or (arc / numgaps)
        projectileangle = projectileangle - gaparc*numgaps/2
        for i = 1, numprojectiles do
            local x = self.x + 512*cos(projectileangle)
            local y = self.y + 512*sin(projectileangle)
            throw(x, y, targetsz)
            projectileangle = projectileangle + gaparc
        end
    end

    for i = 1, self.throwtime or 6 do
        self:accelerateTowardsVel(0, 0, 4)
        yield()
    end
    return "walk"
end

function Player:hold(enemy)
    local time = enemy.timetobreakhold
    local holdfrombehind = dot(math.cos(enemy.faceangle), math.sin(enemy.faceangle), math.cos(self.faceangle), math.sin(self.faceangle)) >= 0
    if holdfrombehind then
    elseif Guard.isPointInGuardArc(enemy, self.x, self.y) then
        time = 10
    end
    if self.heldopponent ~= enemy then
        Combo.reset(self)
        HoldOpponent.startHolding(self, enemy)
    end
    self:stopAttack()
    local holddirx, holddiry = enemy.x - self.x, enemy.y - self.y
    if holddirx == 0 and holddiry == 0 then
        holddirx = 1
    else
        holddirx, holddiry = norm(holddirx, holddiry)
    end
    local holdangle = atan2(holddiry, holddirx)
    local holddestangle = holdangle
    while not time or time > 0 do
        yield()
        enemy = self.heldopponent
        if not enemy then
            return "walk"
        end
        if time then
            time = time - 1
        end

        local inx, iny = self:getJoystick()
        local normalattackpressed = self:isActionRecentlyPressed("attack")
        local runpressed = self:isActionDownAndRecentlyPressed("sprint")
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            holddestangle = atan2(iny, inx)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 4)
        local velx, vely = self.velx, self.vely

        holdangle = math.rotangletowards(holdangle, holddestangle, pi/64)
        self.holdangle = holdangle
        holddirx, holddiry = cos(holdangle), sin(holdangle)
        HoldOpponent.updateOpponentPosition(self)
        HoldOpponent.handleOpponentCollision(self)
        enemy.velz = 0

        local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
        Face.faceAngle(self, holdangle, holdanimation)

        local enemyfaceangle = holdfrombehind and self.faceangle or (self.faceangle + pi)
        Face.faceAngle(enemy, enemyfaceangle, "Hurt")

        -- self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
        if runpressed then --and self.runenergy >= self.runenergycost then
            Combo.reset(self)
            return "running-with-enemy", enemy, true
        end
        local chargedattack = not self.attackbutton.down and self:getChargedAttack(ChargeAttacks)
        if chargedattack then
            Mana.releaseCharge(self)
            HoldOpponent.stopHolding(self, enemy)
            return chargedattack, holdangle
        end
        -- if fireattackpressed then
        --     if Mana.canAffordAttack(self, "flaming-spinning-throw") then
        --         Combo.reset(self)
        --         return "flaming-spinning-throw", holdangle, enemy
        --     end
        -- end
        if normalattackpressed and (inx ~= 0 or iny ~= 0) then
            Combo.reset(self)
            return "spinning-throw", holdangle, enemy
        end
        if normalattackpressed then
            return self:doComboAttack(holdangle, enemy, inx ~= 0 or iny ~= 0)
        end
    end
    StateMachine.start(enemy, "breakaway", self)
    return "breakaway", enemy
end

function Player:spinAndKickEnemy(angle, enemy)
    Mana.store(self, -(self.attack.manacost or 0))
    StateMachine.start(enemy, self.attack.heldopponentstate or "human-in-spinning-throw", self)
    local spinvel = self.attack.spinspeed or 0
    local maxspunmag = self.attack.maxspin or (4*pi)
    local minspunmag = self.attack.minspin or 0
    local holddirx, holddiry = enemy.x - self.x, enemy.y - self.y
    if holddirx ~= 0 or holddiry ~= 0 then
        holddirx, holddiry = norm(holddirx, holddiry)
    else
        holddirx = 1
    end
    local throwx, throwy = cos(angle), sin(angle)
    local spunmag = 0
    local spinmag = abs(spinvel)
    repeat
        local inx, iny = self:getJoystick()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            throwx, throwy = inx, iny
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 4)

        if math.ceil(spunmag / 2 / pi) < math.ceil((spunmag+spinmag) / 2 / pi) then
            Audio.play(self.state.sound)
        end
        local remainder = maxspunmag - spunmag
        if remainder <= spinmag then
            angle = angle + (spinvel < 0 and -remainder or remainder)
            spunmag = maxspunmag
            throwx, throwy = cos(angle), sin(angle)
        else
            angle = angle + spinvel
            spunmag = spunmag + spinmag
        end

        enemy:startAttack(angle)
        Face.faceAngle(self, angle, self.state and self.state.animation)

        holddirx, holddiry = cos(angle), sin(angle)
        self.holdangle = angle
        HoldOpponent.updateOpponentPosition(self)
        HoldOpponent.handleOpponentCollision(self)

        yield()
    until spunmag >= minspunmag
    and dot(throwx, throwy, holddirx, holddiry) >= cos(spinmag)

    self.holdangle = atan2(throwy, throwx)
    HoldOpponent.updateOpponentPosition(self)
    HoldOpponent.handleOpponentCollision(self)
    Audio.play(self.throwsound)
    enemy:stopAttack()
    HoldOpponent.stopHolding(self, enemy)
    enemy.canbeattacked = true
    -- if self.attack.damage then
    --     enemy.health = enemy.health - self.attack.damage
    -- end
    -- StateMachine.start(enemy, enemy.thrownai or "thrown", self, atan2(throwy, throwx))
    return "holding-kick", atan2(throwy, throwx)
end

function Player:victory()
    self:stopAttack()
    local i = 0
    while true do
        self:accelerateTowardsVel(0, 0, 4)
        -- self.z = abs(sin(i*pi/30) * 8)
        yield()
        i = i + 1
    end
end

function Player:defeat()
    Audio.fadeMusic()
    self:stopAttack()
    self.velx, self.vely = 0, 0
    Audio.play(self.defeatsound)
    local GamePhase            = require "Dragontail.GamePhase"
    GamePhase.gameOver()
end

function Player:sequenceWalkTo(destx, desty, timelimit)
    HoldOpponent.stopHolding(self, self.heldopponent)
    self:walkTo(destx, desty, timelimit)
    self.velx, self.vely, self.velz = 0, 0, 0
    Face.faceVector(self, 1, 0, "Stand")
end

local FlyPeakHeight = 540
local FlyPeakTime = 60

function Player:flyStart()
    Combo.reset(self)
    self.camera.lockz = false
    self.velx = 0
    self.vely = 0
    local t = FlyPeakTime
    local h = FlyPeakHeight
    local g = self.gravity
    -- h+g = -g*t*t/2 + v*t
    self.velz = h/t + g*t/2 - g
    while self.velz >= 0 do
        yield()
    end
    self.velz = 0
    self.camera.z = self.z - self.camera.bodyheight/2
    self.camera.velz = 0
    self.camera.lockz = true
    self.gravity = 0
    return "walk"
end

function Player:flyEnd()
    self.camera.lockz = false
    repeat
        yield()
    until self.velz >= 0
    self.camera.z = self.z - self.camera.bodyheight/2
    self.camera.velz = 0
    self.camera.lockz = true
    return "walk"
end

return Player