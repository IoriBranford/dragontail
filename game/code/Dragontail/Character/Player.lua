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
local Slide      = require "Dragontail.Character.Component.Slide"
local Face       = require "Dragontail.Character.Component.Face"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Shoot        = require "Dragontail.Character.Component.Shoot"
local Body         = require "Dragontail.Character.Component.Body"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local WeaponInHand         = require "Dragontail.Character.Component.WeaponInHand"
local Inventory            = require "Dragontail.Character.Component.Inventory"
local InputLog          = require "Dragontail.Character.Component.InputLog"
local Combo                = require "Dragontail.Character.Component.Combo"
local Mana                 = require "Dragontail.Character.Component.Mana"
local Config               = require "System.Config"
local Guard                = require "Dragontail.Character.Component.Guard"
local AttackTarget         = require "Dragontail.Character.Component.AttackTarget"
local Catcher    = require "Dragontail.Character.Component.Catcher"
local Attacker   = require "Dragontail.Character.Component.Attacker"

---@class Player:Fighter
---@field inventory Inventory
---@field inputlog InputLog
local Player = class(Fighter)

local NormalChargeRate = 2
local NormalDecayRate = 2
local ReversalChargeRate = 4
local ReversalDecayRate = 1

Player.ChargeAttackStates = {
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

function Player:cheatRefillAll()
    self.health = self.maxhealth
    self.manastore = self.manastoremax
    self.inventory = Inventory()
    while self:tryToGiveWeapon("thrown-stone") do end
end

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

function Player:updateEnemyTargetingScores(lookangle)
    lookangle = lookangle or self.faceangle
    local lookx, looky = math.cos(lookangle), math.sin(lookangle)
    local x, y = self.x, self.y
    return Attacker.updateOpponentsByPriority(self, function(e)
        return e.getTargetingScore and
            e:getTargetingScore(x, y, lookx, looky)
    end)
end

function Player:init()
    self.inputlog = InputLog(10)
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

    Attacker.initCrosshairs(self, "Rose-crosshair", 0)--self.inventory.capacity)
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

function Player:consumeActionRecentlyPressed(actionname)
    local i = self.inputlog:findActionState(actionname, "pressed")
    if i then
        self.inputlog:clearActionLog(actionname)
    end
    return i
end

function Player:consumeActionDownAndRecentlyPressed(actionname)
    local action = Inputs.getAction(actionname)
    if not action then return false end
    local recentlypressed = action.pressed or
        action.down and self:isActionRecentlyPressed(actionname)
    if recentlypressed then
        self.inputlog:clearActionLog(actionname)
    end
    return recentlypressed
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

function Player:updateBreathCharge(chargerate, decayrate)
    if Config.player_autorevive and self.health <= 0 or self.attackbutton.down then
        Mana.charge(self, chargerate or NormalChargeRate)
    else
        Mana.decayCharge(self, decayrate or NormalDecayRate)
    end
end

function Player:getChargedAttack(chargeattackstates)
    for _, chargeattackstate in ipairs(chargeattackstates) do
        local state = self.statetable[chargeattackstate]
        local attack = state and state.attack
        if Mana.hasChargeForAttack(self, attack) then
            return chargeattackstate
        end
    end
end

function Player:getActivatedChargeAttackTowardsJoystick()
    local chargedattack = not self.attackbutton.down
        and self:getChargedAttack(Player.ChargeAttackStates)
    if chargedattack then
        local inx, iny = self:getJoystick()
        local attackangle = inx == 0 and iny == 0
            and (self.facedestangle or self.faceangle)
            or math.atan2(iny, inx)
        return chargedattack, attackangle
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
    local movespeed = self.speed or 1
    local targetvelx = inx * movespeed
    local targetvely = iny * movespeed
    Body.forceTowardsVelXY(self, targetvelx, targetvely, self.accel)
end

function Player:accelerateTowardsFace()
    local inx, iny = cos(self.faceangle), sin(self.faceangle)
    local movespeed = self.speed or 1
    local targetvelx = inx * movespeed
    local targetvely = iny * movespeed
    Body.forceTowardsVelXY(self, targetvelx, targetvely, self.accel)
end

function Player:stopRunning()
    local chargedattack, attackangle = self:getActivatedChargeAttackTowardsJoystick()
    if chargedattack then
        Mana.releaseCharge(self)
        return chargedattack, attackangle
    end

    local speed = self.speed or 4
    if math.lensq(self.velx, self.vely) <= speed*speed then
        return self.nextstate
    end

    self:decelerateXYto0()
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

function Player:getReversalChargedAttackState()
    local chargedattackstate = self:getChargedAttack(Player.ChargeAttackStates)
    if chargedattackstate then
        local inx, iny = self:getJoystick()
        local angle = self.faceangle
        if inx ~= 0 or iny ~= 0 then
            angle = atan2(iny, inx)
        end
        return chargedattackstate, angle
    end
end

function Player:getup()
    self:shakeOffColor()
    if self.sprintbutton.down then
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            Face.faceAngle(self, atan2(iny, inx))
        end
        return "run", nil, true
    end
    if not self.attackbutton.down then
        local chargedattack, angle = self:getReversalChargedAttackState()
        if chargedattack then
            Mana.releaseCharge(self)
            return chargedattack, angle
        end
    end
end

---@deprecated
function Player:aimThrow()
    if not self.crosshair then
        local crosshair = Character("rose-crosshair")
        crosshair.visible = false
        self.crosshair = Characters.spawn(crosshair)
    end
    self.facedestangle = self.faceangle
    local lockonenemy
    while true do
        local attackbutton, runbutton = self.attackbutton.down, self.sprintbutton.down
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            self.facedestangle = atan2(iny, inx)
        end

        local targetvelx, targetvely
        local movespeed, turnspeed = self.speed or 2, self.faceturnspeed or (pi/8)

        targetvelx = inx * movespeed
        targetvely = iny * movespeed

        Body.forceTowardsVelXY(self, targetvelx, targetvely, self.accel)

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
            return "throwWeapon", self.faceangle, 1
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

function Player:throwWeapon(angle, numprojectiles)
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
    local targets = self.opponentsbypriority
    local arc = self.throwmultiarc or (pi/4)
    local cosarc = cos(arc)
    local numfired = 0
    local targetsz = 0
    if targets then
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
        self:decelerateXYto0()
        yield()
    end
    return "walk"
end

function Player:runIntoWall()
    local velx, vely = self.velx, self.vely
    local oobx, ooby = math.norm(self.penex, self.peney)
    local velangle = velx == 0 and vely == 0
        and self.faceangle or math.atan2(vely, velx)
    local bodyradius = self.bodyradius
    local spark = Character(
        "spark-bighit",
        self.x + oobx*bodyradius,
        self.y + ooby*bodyradius,
        self.z + self.bodyheight/2)
    Characters.spawn(spark)
    self.hurtstun = 9
    self.velz = 0
    return "runIntoWall", velangle
end

function Player:updateRunIntoWall()
    if self.z > self.floorz then
        if (self.statetime or 1) <= 1 then
            self.statetime = 1
        end
    end
    self:decelerateXYto0()
end

---@deprecated
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

        Body.forceTowardsVelXY(self, targetvelx, targetvely, self.accel)

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
        self:decelerateXYto0()
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