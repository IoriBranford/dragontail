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
local JoystickLog          = require "Dragontail.Character.Component.JoystickLog"
local Combo                = require "Dragontail.Character.Component.Combo"
local Mana                 = require "Dragontail.Character.Component.Mana"
local Config               = require "System.Config"
local Guard                = require "Dragontail.Character.Action.Guard"

---@class Player:Fighter
---@field inventory Inventory
---@field joysticklog JoystickLog
local Player = class(Fighter)

local NormalChargeRate = 2
local NormalDecayRate = 2
local ReversalChargeRate = 4
local ReversalDecayRate = 1

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

function Player:getNextAttackType(heldenemy, lunging)
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
function Player:doComboAttack(faceangle, heldenemy, lunging)
    local attacktype = self:getNextAttackType(heldenemy, lunging)
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
    self.joysticklog = JoystickLog(10)
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

    local x, y = self.x, self.y
    local slotz = self.z + self.bodyheight/2
    ---@class PlayerAttackerSlots
    ---@field [integer] AttackerSlot
    ---@field [string] AttackerSlot[]
    self.attackerslots = {
        AttackerSlot("melee",   x, y, slotz, 1024, 0, 0), -- 3 o clock
        AttackerSlot("melee",   x, y, slotz, 0, 1024, 0), -- 6 o clock
        AttackerSlot("melee",   x, y, slotz, -1024, 0, 0),-- 9 o clock
        AttackerSlot("melee",   x, y, slotz, 0, -1024, 0), -- 12 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(1*pi/6), 1024*sin(1*pi/6), 0), -- 4 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(2*pi/6), 1024*sin(2*pi/6), 0), -- 5 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(4*pi/6), 1024*sin(4*pi/6), 0), -- 7 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(5*pi/6), 1024*sin(5*pi/6), 0), -- 8 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(7*pi/6), 1024*sin(7*pi/6), 0), -- 10 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(8*pi/6), 1024*sin(8*pi/6), 0), -- 11 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(10*pi/6), 1024*sin(10*pi/6), 0), -- 1 o clock
        AttackerSlot("missile", x, y, slotz, 1024*cos(11*pi/6), 1024*sin(11*pi/6), 0), -- 2 o clock
        melee = {},
        missile = {}
    }

    for _, slot in ipairs(self.attackerslots) do
        local slotgroup = self.attackerslots[slot.type]
        if slotgroup then
            slotgroup[#slotgroup+1] = slot
        end
    end
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

function Player:initAseprite()
    Character.initAseprite(self)
    WeaponInHand.loadHandPositions(self)
end

function Player:drawAseprite(fixedfrac)
    local animation = self.aseanimation or self.aseprite
    local aframe = self.animationframe or 1
    local frame = animation and animation[aframe]
    if not frame then
        return
    end

    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)

    local velx, vely = self.velx or 0, self.vely or 0
    fixedfrac = fixedfrac or 0

    local x, y = self.x + velx*fixedfrac, self.y + vely*fixedfrac
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(self.rotation or 0)
    love.graphics.shear(self.skewx or 0, self.skewy or 0)
    love.graphics.scale(self.scalex or 1, self.scaley or 1)

    local originx, originy = self:getOrigin()
    love.graphics.translate(-originx, -originy)

    frame:draw()
    WeaponInHand.draw(self, frame, 0, 0)
    love.graphics.pop()
    -- if self.attacker then
    --     love.graphics.line(self.x, self.y, self.attacker.x, self.attacker.y)
    -- end

    -- local px1, py1 = self.joysticklog:newest()
    -- local px0, py0 = self.joysticklog:oldest()
    -- if px0 and py0 and px1 and py1 then
    --     love.graphics.line(self.x + px0*16, self.y + py0*16, self.x + px1*16, self.y + py1*16)
    -- end

    -- local px, py = self:getParryVector()
    -- if px and py then
    --     love.graphics.line(self.x, self.y, self.x + px*16, self.y + py*16)
    -- end
end

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

function Player:findRandomAttackerSlot(attackrange, slottype, fromx, fromy)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local i = love.math.random(#attackerslots)
    local vx, vy = fromx - self.x, fromy - self.y
    local mindot = math.len(vx, vy)*cos(pi*.75)
    for _ = 1, #attackerslots do
        local slot = attackerslots[i]
        if slot:hasSpace(attackrange)
        and dot(slot.dirx, slot.diry, vx, vy) > mindot then
            return slot
        end
        if i >= #attackerslots then
            i = 1
        else
            i = i + 1
        end
    end
end

function Player:findClosestAttackerSlot(attackrange, slottype, attackerx, attackery)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local bestslot, bestslotdsq = nil, math.huge
    for _, slot in ipairs(attackerslots) do
        if slot:hasSpace(attackrange) then
            local slotx, sloty = slot:getPosition(attackrange)
            local slotdsq = math.distsq(attackerx, attackery, slotx, sloty)
            if slotdsq < bestslotdsq then
                bestslot, bestslotdsq = slot, slotdsq
            end
        end
    end
    return bestslot
end

function Player:getParryVector()
    local x1, y1 = self.joysticklog:newest()
    if not x1 or not y1 or x1 == 0 and y1 == 0 then return end
    local x0, y0 = self.joysticklog:oldest()
    if dot(x0, y0, x1, y1) <= 0 then
        return math.norm(x1, y1)
    end
end

function Player:findProjectileToCatch(parryx, parryy)
    local catchradius = (self.catchradius or 20)
    local mindot = cos(pi/4) * catchradius
    local projectiles = Characters.getGroup("projectiles")
    local x, y, z = self.x, self.y, self.z
    local ztop = z + self.bodyheight + catchradius/2
    for _, projectile in ipairs(projectiles) do
        if self ~= projectile.thrower
        and projectile:isAttacking()
        and projectile.z >= z
        and projectile.z <= ztop
        then
            local catchprojradius = catchradius + math.max(projectile.attack.radius, projectile.bodyradius)
            local toprojx = projectile.x - x
            local toprojy = projectile.y - y
            local d = dot(parryx, parryy, toprojx, toprojy)
            if mindot <= d and d <= catchprojradius then
                return projectile
            end
            local toprojx2 = toprojx + projectile.velx
            local toprojy2 = toprojy + projectile.vely
            d = dot(parryx, parryy, toprojx2, toprojy2)
            if mindot <= d and d <= catchprojradius then
                return projectile
            end
        end
    end
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

function Player:catchProjectile(projectile)
    Face.faceObject(self, projectile, self.state.animation or "catch")
    projectile:stopAttack()
    if self:tryToGiveWeapon(projectile.type) then
        projectile:disappear()
    else
        StateMachine.start(projectile, "projectileBounce", self)
    end
    for i = 1, 15 do
        self:accelerateTowardsVel(0, 0, 8)
        yield()
    end
    return "walk"
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
    end
    local animation
    if self.velx ~= 0 or self.vely ~= 0 then
        animation = movinganimation
    else
        animation = notmovinganimation
    end
    Face.updateTurnToDestAngle(self, nil, animation)
end

function Player:catchProjectileAtJoystick()
    local parryx, parryy = self:getParryVector()
    return parryx and parryy and self:findProjectileToCatch(parryx, parryy)
end

function Player:spinAttack(attackangle)
    self.numopponentshit = 0
    local lungeangle = attackangle
    local originalfaceangle = self.faceangle
    local spinvel = self.attack.spinspeed or 0
    local spintime = self.attack.hittingduration or 0
    local pressedattackbutton
    local t = spintime
    local lungespeed = self.attack.lungespeed
    if lungespeed then
        Slide.updateSlideSpeed(self, lungeangle, lungespeed)
    end
    local projectile = self.attack.projectiletype
    Mana.store(self, -(self.attack.manacost or 0))
    -- local buttonholdtimeforfireball = spintime/2
    repeat
        if projectile then
            local projectileangle = attackangle + pi
            local cosangle, sinangle = cos(projectileangle), sin(projectileangle)
            Shoot.launchProjectile(self, "spark-spit-fireball", cosangle, sinangle, 0)
            Shoot.launchProjectile(self, projectile, cosangle, sinangle, 0)
        end

        local inx, iny = self:getJoystick()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        if lungespeed then
            if math.abs(lungespeed - math.len(self.velx, self.vely)) >= 1 then
                lungespeed = nil
            end
        end
        if lungespeed then
            lungespeed = Slide.updateSlideSpeed(self, lungeangle, lungespeed)
        else
            self:accelerateTowardsVel(targetvelx, targetvely, 8)
        end

        self:startAttack(attackangle)
        Face.faceAngle(self, attackangle, self.state and self.state.animation)

        yield()
        if pressedattackbutton ~= self.attackbutton then
            -- if self.fireattackbutton.pressed then
            --     pressedattackbutton = self.fireattackbutton
            --else
            if self.attackbutton.pressed then
                pressedattackbutton = self.attackbutton
            end
        end
        attackangle = attackangle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    self.faceangle = originalfaceangle
    if pressedattackbutton then
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            originalfaceangle = atan2(iny, inx)
        end
        return self:doComboAttack(originalfaceangle, nil, inx ~= 0 or iny ~= 0)
    end
    return "walk"
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

function Player:duringGetUp()
    if self.sprintbutton.down then
        local inx, iny = self:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            Face.faceAngle(self, atan2(iny, inx))
        end
        return "run"
    end
    if not self.attackbutton.down then
        local chargedattack, angle = self:getReversalChargedAttack()
        if chargedattack then
            Mana.releaseCharge(self)
            return chargedattack, angle
        end
    end
end

function Player:down(attacker)
    local nextstate, a, b, c, d, e = Fighter.down(self, attacker)
    if self.health <= 0 then
        local chargedattack, angle = self:getReversalChargedAttack()
        if chargedattack then
            self.health = 10
            Mana.releaseCharge(self)
            return chargedattack, angle
        end
    end
    return nextstate, a, b, c, d, e
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
            targetsz = targetsz + target.z
            throw(target.x, target.y, target.z)
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
        local normalattackpressed, runpressed = self.attackbutton.pressed, self.sprintbutton.pressed
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
            return "running-with-enemy", enemy
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

function Player:defeat(attacker)
    Audio.fadeMusic()
    self:stopAttack()
    self.velx, self.vely = 0, 0
    Audio.play(self.defeatsound)
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
    return "hover"
end

function Player:hover()
    self.facedestangle = self.faceangle
    self.joysticklog:clear()
    -- local attackdowntime
    while true do
        local inx, iny = self:getJoystick()
        self.joysticklog:put(inx, iny)
        self:turnTowardsJoystick("hover", "hover")
        self:accelerateTowardsJoystick()

        local caughtprojectile = self:catchProjectileAtJoystick()
        if caughtprojectile then
            return "catchProjectile", caughtprojectile
        end

        if self.flybutton.pressed then
            return "flyEnd"
        end

        if self.sprintbutton.pressed then
            Face.faceVector(self, inx, iny)
            return "run"
        end

        -- self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
        local chargedattack = not self.attackbutton.down and self:getChargedAttack(ChargeAttacks)
        if chargedattack then
            Mana.releaseCharge(self)
            return chargedattack, self.facedestangle
        end

        if self.attackbutton.pressed then
            local attackangle = self.facedestangle
            if self.weaponinhand then
                attackangle = self:getAngleToBestTarget(attackangle) or attackangle
            end
            self.faceangle = attackangle
            self.facedestangle = attackangle
            if self.weaponinhand then
                return "throwWeapon", self.facedestangle, 1, 1
            end
            return self:doComboAttack(self.facedestangle, nil, inx ~= 0 or iny ~= 0)
        end

        local opponenttohold = HoldOpponent.findOpponentToHold(self, inx, iny)
        if opponenttohold then
            Audio.play(self.holdsound)
            return "hold", opponenttohold
        end

        yield()
    end
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