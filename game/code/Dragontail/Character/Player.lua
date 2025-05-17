local Inputs = require "System.Inputs"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local StateMachine   = require "Dragontail.Character.StateMachine"
local Fighter  = require "Dragontail.Character.Fighter"
local Character= require "Dragontail.Character"
local AttackerSlot = require "Dragontail.Character.AttackerSlot"
local Characters   = require "Dragontail.Stage.Characters"
local Color        = require "Tiled.Color"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Action.Face"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Shoot        = require "Dragontail.Character.Action.Shoot"
local Body         = require "Dragontail.Character.Body"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"
local WeaponInHand         = require "Dragontail.Character.Action.WeaponInHand"
local Inventory            = require "Dragontail.Character.Inventory"
local JoystickLog          = require "Dragontail.Character.Player.JoystickLog"
local Combo                = require "Dragontail.Character.Action.Combo"
local Mana                 = require "Dragontail.Character.Mana"

---@class Player:Fighter
---@field inventory Inventory
---@field joysticklog JoystickLog
local Player = class(Fighter)

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

local function findSomethingToRunningAttack(self, velx, vely)
    local x, y, opponents, solids = self.x, self.y, self.opponents, self.solids
    for i, opponent in ipairs(opponents) do
        if dot(opponent.x - x, opponent.y - y, velx, vely) > 0 then
            if opponent.canbeattacked and Body.testBodyCollision(self, opponent) then
                return opponent
            end
        end
    end
    for i, solid in ipairs(solids) do
        if dot(solid.x - x, solid.y - y, velx, vely) > 0 then
            if solid.canbeattacked and Body.testBodyCollision(self, solid) then
                return solid
            end
        end
    end
end

local function findWallCollision(self)
    local _, _, _, oobx, ooby = self:getVelocityWithinBounds()
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        return norm(oobx, ooby)
    end
end

local NormalCombo = {"kick", "kick", "tail-swing-cw"}
local SpecialCombo = {"spit-fireball", "spit-fireball", "fireball-spin-cw"}
local HoldCombo = {"holding-knee", "holding-knee", "spinning-throw"}
local RunningSpecialAttacks = { "running-spit-fat-fireball", "running-spit-fireball" }

function Player:getNextAttackType(heldenemy, special)
    local comboindex = self.comboindex
    if special then
        local i = comboindex
        local specialattacktype, specialattackdata
        repeat
            specialattacktype = SpecialCombo[i]
            if Mana.canAffordAttack(self, specialattacktype) then
                return specialattacktype
            end
            i = i - 1
        until i <= 0
        comboindex = 3
    end

    local combo = heldenemy and HoldCombo or NormalCombo
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
function Player:doComboAttack(faceangle, heldenemy, special)
    local attacktype = self:getNextAttackType(heldenemy, special)
    local attackdata = Database.get(attacktype)
    if attackdata and attackdata.attackendscombo or self.comboindex >= 3 then
        self.comboindex = 1
    else
        self.comboindex = self.comboindex + 1
    end

    return attacktype, faceangle, attackdata and attackdata.attackholds and heldenemy
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

local function findInstantThrowTarget(self, targetfacex, targetfacey)
    local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    local projectilez = self.z + projectileheight
    local enemy, enemytargetingscore = nil, 128
    Characters.search("enemies",
    ---@param e Enemy
    function(e)
        if not e.getTargetingScore then
            return
        end
        local score = e:getTargetingScore(self.x, self.y, targetfacex, targetfacey)

        local etop, ebottom = e.z + self.bodyheight, e.z
        if ebottom > projectilez or projectilez > etop then
            score = score / 2
        end
        if score < enemytargetingscore then
            enemy, enemytargetingscore = e, score
        end
    end)
    if enemy then
        return enemy.x, enemy.y, enemy.z
    end
    return self.x + targetfacex*512,
        self.y + targetfacey*512,
        self.z
end

function Player:init()
    self.joysticklog = JoystickLog(10)
    self.joystickx = Inputs.getAction("movex")
    self.joysticky = Inputs.getAction("movey")
    self.attackbutton = Inputs.getAction("attack")
    self.fireattackbutton = Inputs.getAction("attack2")
    self.sprintbutton = Inputs.getAction("sprint")
    Fighter.init(self)
    self.inventory = Inventory()
    Combo.reset(self)
    -- self.runenergy = self.runenergy or 100
    -- self.runenergymax = self.runenergymax or self.runenergy
    -- self.runenergycost = self.runenergycost or 25
    Mana.init(self)

    ---@class PlayerAttackerSlots
    ---@field [integer] AttackerSlot
    ---@field [string] AttackerSlot[]
    self.attackerslots = {
        AttackerSlot("melee", 1024, 0), -- 3 o clock
        AttackerSlot("melee", 0, 1024), -- 6 o clock
        AttackerSlot("melee", -1024, 0),-- 9 o clock
        AttackerSlot("melee", 0, -1024), -- 12 o clock
        AttackerSlot("missile", 1024*cos(1*pi/6), 1024*sin(1*pi/6)), -- 4 o clock
        AttackerSlot("missile", 1024*cos(2*pi/6), 1024*sin(2*pi/6)), -- 5 o clock
        AttackerSlot("missile", 1024*cos(4*pi/6), 1024*sin(4*pi/6)), -- 7 o clock
        AttackerSlot("missile", 1024*cos(5*pi/6), 1024*sin(5*pi/6)), -- 8 o clock
        AttackerSlot("missile", 1024*cos(7*pi/6), 1024*sin(7*pi/6)), -- 10 o clock
        AttackerSlot("missile", 1024*cos(8*pi/6), 1024*sin(8*pi/6)), -- 11 o clock
        AttackerSlot("missile", 1024*cos(10*pi/6), 1024*sin(10*pi/6)), -- 1 o clock
        AttackerSlot("missile", 1024*cos(11*pi/6), 1024*sin(11*pi/6)), -- 2 o clock
        melee = {},
        missile = {}
    }

    for _, slot in ipairs(self.attackerslots) do
        local slotgroup = self.attackerslots[slot.type]
        if slotgroup then
            slotgroup[#slotgroup+1] = slot
        end
    end

    self.crosshair = Characters.spawn({
        type = "rose-crosshair",
        visible = false
    })
end

function Player:initAseprite()
    Character.initAseprite(self)
    WeaponInHand.loadHandPositions(self)
end

function Player:drawAseprite(fixedfrac)
    local animation = self.aseanimation or self.aseprite
    local aframe = self.animationframe or 1
    local frame = animation[aframe]
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
    love.graphics.translate(-self.originx or 0, -self.originy or 0)
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

function Player:findRandomAttackerSlot(attackrange, slottype)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local i = love.math.random(#attackerslots)
    for _ = 1, #attackerslots do
        local slot = attackerslots[i]
        if slot:hasSpace(attackrange) then
            return slot
        end
        if i >= #attackerslots then
            i = 1
        else
            i = i + 1
        end
    end
end

function Player:findClosestAttackerSlot(attackerx, attackery, attackrange, slottype)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local x, y = self.x, self.y
    local bestslot, bestslotdsq
    for _, slot in ipairs(attackerslots) do
        if slot:hasSpace(attackrange) then
            local slotx, sloty = slot:getPosition(x, y, attackrange)
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
            local catchprojradius = catchradius + math.max(projectile.attackradius, projectile.bodyradius)
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
    local x, y = self.x, self.y
    for _, slot in ipairs(attackerslots) do
        Characters.castRay(slot, x, y)
    end
end

function Player:catchProjectile(projectile)
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
    return "control"
end

local ChargeAttacks = {
    "fireball-storm", "spit-fat-fireball", "spit-fireball"
}
local RunningChargeAttacks = {
    "fireball-storm", "running-spit-fat-fireball", "running-spit-fireball"
}

function Player:updateBreathCharge(chargeattacks)
    if self.attackbutton.released then
        for _, chargeattack in ipairs(chargeattacks) do
            if Mana.hasChargeForAttack(self, chargeattack) then
                Mana.releaseCharge(self)
                return chargeattack
            end
        end
    end
    if self.attackbutton.down then
        Mana.charge(self, 1)
    else
        Mana.charge(self, -3)
    end
end

function Player:control()
    self.facedestangle = self.faceangle
    self.joysticklog:clear()
    local runningtime
    -- local attackdowntime
    while true do
        local inx, iny = self.joystickx.position, self.joysticky.position
        local normalattackpressed, runpressed = self.attackbutton.pressed, self.sprintbutton.pressed
        local fireattackpressed = self.fireattackbutton.pressed
        local anyattackpressed = normalattackpressed or fireattackpressed
        local rundown = self.sprintbutton.down

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
            end
            self.facedestangle = atan2(iny, inx)
        end

        self.joysticklog:put(inx, iny)
        local parryx, parryy = self:getParryVector()
        if parryx and parryy then
            local caughtprojectile = self:findProjectileToCatch(parryx, parryy)
            if caughtprojectile then
                Face.faceVector(self, parryx, parryy)
                return "catchProjectile", caughtprojectile
            end
        end

        local movespeed, turnspeed, acceltime
        if runningtime then
            movespeed, turnspeed, acceltime = 8, pi/60, 1
        else
            movespeed, turnspeed, acceltime = 4, pi/8, 4
        end

        if runpressed and not runningtime --and self.runenergy >= self.runenergycost
        then
            Combo.reset(self)
            Audio.play(self.dashsound)
            runningtime = 0
            turnspeed = 2*pi
            -- self.runenergy = self.runenergy - self.runenergycost
        end

        Face.updateTurnToDestAngle(self, turnspeed)

        if runningtime then
            targetvelx = cos(self.faceangle) * movespeed
            targetvely = sin(self.faceangle) * movespeed
        else
            targetvelx = inx * movespeed
            targetvely = iny * movespeed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, acceltime)

        local velx, vely = self.velx, self.vely

        if runningtime then
            if self.animationtime % 3 == 0 then
                self:makeAfterImage()
            end

            local chargedattack = self:updateBreathCharge(RunningChargeAttacks)
            if chargedattack then
                return chargedattack, self.facedestangle
            end

            if normalattackpressed or fireattackpressed then
                if self.weaponinhand then
                    local targetx, targety, targetz = findInstantThrowTarget(self, cos(self.facedestangle), sin(self.facedestangle))
                    local numtothrow = fireattackpressed and #self.inventory or 1
                    return "throwWeapon", targetx, targety, targetz, 2, numtothrow
                end

                if fireattackpressed then
                    for _, attacktype in ipairs(RunningSpecialAttacks) do
                        if Mana.canAffordAttack(self, attacktype) then
                            return attacktype, atan2(vely, velx)
                        end
                    end
                end
                return "running-kick", atan2(vely, velx)
            end

            local attacktarget = findSomethingToRunningAttack(self, velx, vely)
            if attacktarget then
                return "running-elbow", atan2(vely, velx)
            end

            local oobx, ooby = findWallCollision(self)
            if oobx or ooby then
                local oobdotvel = dot(oobx, ooby, velx, vely)
                local speed = math.len(velx, vely)
                local ooblen = math.len(oobx, ooby)
                if oobdotvel > speed*ooblen/2 then
                    Audio.play(self.bodyslamsound)
                    Characters.spawn(
                        {
                            type = "spark-bighit",
                            x = self.x + oobx*self.bodyradius,
                            y = self.y + ooby*self.bodyradius
                        }
                    )
                    self.hurtstun = 10
                    return "running-elbow", atan2(vely, velx)
                end
            end

            if runningtime < 15 then
                runningtime = runningtime + 1
            elseif rundown then --self.runenergy > 0 and rundown then
            --     self.runenergy = self.runenergy - 1
            else
                runningtime = nil
                Audio.play(self.stopdashsound)
            end
        else
            -- self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
            local chargedattack = self:updateBreathCharge(ChargeAttacks)
            if chargedattack then
                return chargedattack, self.facedestangle
            end

            if normalattackpressed or fireattackpressed then
                Face.updateTurnToDestAngle(self, pi)
                if self.weaponinhand then
                    local targetx, targety, targetz = findInstantThrowTarget(self, cos(self.facedestangle), sin(self.facedestangle))
                    local numtothrow = fireattackpressed and #self.inventory or 1
                    return "throwWeapon", targetx, targety, targetz, 1, numtothrow
                end
                return self:doComboAttack(self.facedestangle, nil, fireattackpressed)
            end

            local opponenttohold = HoldOpponent.findOpponentToHold(self, inx, iny)
            if opponenttohold then
                Audio.play(self.holdsound)
                return "hold", opponenttohold
            end
        end

        local animation
        if velx ~= 0 or vely ~= 0 then
            animation = "Walk"
        else
            animation = "Stand"
        end
        DirectionalAnimation.set(self, animation, self.faceangle)

        yield()
    end
end

function Player:spinAttack(attackangle)
    self.numopponentshit = 0
    local tailangle = attackangle
    local lungeangle = attackangle
    local originalfaceangle = self.faceangle
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    local pressedattackbutton
    local t = spintime
    local lungespeed = self.attacklungespeed
    local projectile = self.attackprojectile
    Mana.store(self, -(self.attackmanacost or 0))
    -- local buttonholdtimeforfireball = spintime/2
    repeat
        local faceangle = tailangle + pi
        if projectile then
            Shoot.launchProjectile(self, projectile, cos(faceangle), sin(faceangle), 0)
        end

        local inx, iny = self.joystickx.position, self.joysticky.position
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        if lungespeed then
            lungespeed = Slide.updateSlideSpeed(self, lungeangle, lungespeed)
        else
            self:accelerateTowardsVel(targetvelx, targetvely, 8)
        end

        self:startAttack(tailangle)
        Face.faceAngle(self, faceangle, self.state and self.state.animation)

        yield()
        if pressedattackbutton ~= self.fireattackbutton then
            if self.fireattackbutton.pressed then
                pressedattackbutton = self.fireattackbutton
            elseif self.attackbutton.pressed then
                pressedattackbutton = self.normalattackbutton
            end
        end
        tailangle = tailangle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    self.faceangle = originalfaceangle
    if pressedattackbutton then
        local inx, iny = self.joystickx.position, self.joysticky.position
        if inx ~= 0 or iny ~= 0 then
            originalfaceangle = atan2(iny, inx)
        end
        return self:doComboAttack(originalfaceangle, nil, pressedattackbutton == self.fireattackbutton)
    end
    return "control"
end

function Player:hurt(attacker)
    self.crosshair.visible = false
    return Fighter.hurt(self, attacker)
end

function Player:aimThrow()
    self.facedestangle = self.faceangle
    local lockonenemy
    while true do
        local attackbutton, runbutton = self.attackbutton.down, self.sprintbutton.down
        local inx, iny = self.joystickx.position, self.joysticky.position
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
            end
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
            return "control"
        end

        if not attackbutton then
            self.crosshair.visible = false
            local throwx, throwy, throwz
            if lockonenemy then
                throwx, throwy, throwz = lockonenemy.x, lockonenemy.y, lockonenemy.z
            else
                throwx, throwy, throwz = self.x + math.cos(self.faceangle)*512, self.y + math.sin(self.faceangle)*512, self.z
            end
            return "throwWeapon", throwx, throwy, throwz
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

function Player:throwWeapon(targetx, targety, targetz, attackchoice, numtothrow)
    attackchoice = attackchoice or 1
    numtothrow = math.min(numtothrow or 1, #self.inventory)
    local distx, disty = targetx - self.x, targety - self.y
    if distx == 0 and disty == 0 then
        distx = 1
    end
    Face.faceVector(self, distx, disty)
    local throwdeltaangle = pi/16
    distx, disty = math.rot(distx, disty, -throwdeltaangle * math.floor((numtothrow - 1) / 2))
    for i = 1, numtothrow do
        local projectiledata = Database.get(self.weaponinhand)
        local attackchoices = projectiledata and projectiledata.attackchoices
        local attackid = attackchoices and attackchoices[math.min(#attackchoices, attackchoice)]
        Shoot.launchProjectileAtPosition(self, {
            type = self.weaponinhand,
            gravity = 1/8,
            speed = 16
        }, self.x + distx, self.y + disty, targetz, attackid)
        self.inventory:pop()
        self.weaponinhand = self.inventory:last()
        distx, disty = math.rot(distx, disty, throwdeltaangle)
    end
    local t = self.throwtime or 6
    repeat
        self:accelerateTowardsVel(0, 0, 4)
        yield()
        t = t - 1
    until t <= 0
    return "control"
end

function Player:hold(enemy)
    if self.heldopponent ~= enemy then
        Combo.reset(self)
        HoldOpponent.startHolding(self, enemy)
    end
    self:stopAttack()
    local holddirx, holddiry = enemy.x - self.x, enemy.y - self.y
    if holddirx == 0 and holddiry == 0 then
        holddirx = 1
    end
    local holdangle = atan2(holddiry, holddirx)
    local holddestangle = holdangle
    local time = enemy.timetobreakhold
    local holdfrombehind = dot(math.cos(enemy.faceangle), math.sin(enemy.faceangle), math.cos(self.faceangle), math.sin(self.faceangle)) >= 0
    if holdfrombehind then
        -- DESIGNME
    end
    while not time or time > 0 do
        yield()
        enemy = self.heldopponent
        if not enemy then
            return "control"
        end
        if time then
            time = time - 1
        end

        local inx, iny = self.joystickx.position, self.joysticky.position
        local normalattackpressed, runpressed = self.attackbutton.pressed, self.sprintbutton.pressed
        local fireattackpressed = self.fireattackbutton.pressed
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            local turnamt = 0
            local turndir = det(holddirx, holddiry, inx, iny)
            if turndir < 0 then
                turnamt = -acos(dot(holddirx, holddiry, inx, iny))
            else
                turnamt = acos(dot(holddirx, holddiry, inx, iny))
            end
            holddestangle = holdangle + turnamt
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 4)
        local velx, vely = self.velx, self.vely

        local avel = 0
        if holddestangle < holdangle then
            avel = -pi/64
        elseif holddestangle > holdangle then
            avel = pi/64
        end
        holdangle = Movement.moveTowards(holdangle, holddestangle, avel)
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
        if fireattackpressed then
            if Mana.canAffordAttack(self, "flaming-spinning-throw") then
                Combo.reset(self)
                return "flaming-spinning-throw", holdangle, enemy
            end
        end
        if fireattackpressed or normalattackpressed and (inx ~= 0 or iny ~= 0) then
            Combo.reset(self)
            return "spinning-throw", holdangle, enemy
        end
        if normalattackpressed then
            return self:doComboAttack(holdangle, enemy, fireattackpressed)
        end
    end
    StateMachine.start(enemy, "breakaway", self)
    return "breakaway", enemy
end

function Player:runWithEnemy(enemy)
    self.facedestangle = self.faceangle
    StateMachine.start(enemy, self.attackofheldopponent or "human-in-spinning-throw", self)
    enemy:startAttack(self.faceangle)
    local runningtime = 0
    while true do
        yield()
        local inx, iny = self.joystickx.position, self.joysticky.position
        local normalattackpressed = self.attackbutton.pressed
        local fireattackpressed = self.fireattackbutton.pressed
        local _, rundown = self.attackbutton.down, self.sprintbutton.down

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
            end
            self.facedestangle = atan2(iny, inx)
        end

        local movespeed, turnspeed, acceltime = 8, pi/120, 1

        Face.updateTurnToDestAngle(self, turnspeed, "holdwalk")
        targetvelx = cos(self.faceangle) * movespeed
        targetvely = sin(self.faceangle) * movespeed

        self:accelerateTowardsVel(targetvelx, targetvely, acceltime)

        self.holdangle = self.faceangle
        HoldOpponent.updateOpponentPosition(self)

        if self.animationtime % 3 == 0 then
            self:makeAfterImage()
            enemy:makeAfterImage()
        end

        if normalattackpressed or fireattackpressed then
            enemy:stopAttack()
            HoldOpponent.stopHolding(self, enemy)
            enemy.canbeattacked = true

            if fireattackpressed then
                for _, attacktype in ipairs(RunningSpecialAttacks) do
                    if Mana.canAffordAttack(self, attacktype) then
                        return attacktype, self.faceangle
                    end
                end
            end

            return "running-kick", self.faceangle
        end

        local oobx, ooby = HoldOpponent.handleOpponentCollision(self)
        if oobx or ooby then
            HoldOpponent.stopHolding(self, enemy)
            StateMachine.start(enemy, "wallSlammed", self, oobx, ooby)
            return "running-elbow", self.faceangle
        end

        if runningtime < 15 then
            runningtime = runningtime + 1
        elseif rundown then --self.runenergy > 0 and rundown then
        --     self.runenergy = self.runenergy - 2
        else
            Audio.play(self.stopdashsound)
            Audio.play(self.throwsound)
            enemy:stopAttack()
            HoldOpponent.stopHolding(self, enemy)
            enemy.canbeattacked = true
            StateMachine.start(enemy, "knockedBack", self, self.faceangle)
            return "control"
        end
    end
end

function Player:spinAndKickEnemy(angle, enemy)
    Mana.store(self, -(self.attackmanacost or 0))
    StateMachine.start(enemy, self.attackofheldopponent or "human-in-spinning-throw", self)
    local spinvel = self.attackspinspeed or 0
    local maxspunmag = self.attackspinmax or (4*pi)
    local minspunmag = self.attackspinmin or 0
    local x, y = self.x, self.y
    local grabradius = self.grabradius or 8
    local radii = grabradius + enemy.bodyradius
    local holddirx, holddiry = enemy.x - x, enemy.y - y
    if holddirx ~= 0 or holddiry ~= 0 then
        holddirx, holddiry = norm(holddirx, holddiry)
    else
        holddirx = 1
    end
    local throwx, throwy = cos(angle), sin(angle)
    local spunmag = 0
    local spinmag = abs(spinvel)
    repeat
        local inx, iny = self.joystickx.position, self.joysticky.position
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            throwx, throwy = inx, iny
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 4)
        local velx, vely = self.velx, self.vely

        if math.ceil(spunmag / 2 / pi) < math.ceil((spunmag+spinmag) / 2 / pi) then
            Audio.play(self.windupsound)
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
        x, y = self.x, self.y
        enemy.x = x + velx + holddirx*radii
        enemy.y = y + vely + holddiry*radii

        yield()
    until spunmag >= minspunmag
    and dot(throwx, throwy, holddirx, holddiry) >= cos(spinmag)

    enemy.x = x + self.velx + throwx*radii
    enemy.y = y + self.vely + throwy*radii
    Audio.play(self.throwsound)
    enemy:stopAttack()
    HoldOpponent.stopHolding(self, enemy)
    enemy.canbeattacked = true
    -- if self.attackdamage then
    --     enemy.health = enemy.health - self.attackdamage
    -- end
    -- StateMachine.start(enemy, enemy.thrownai or "thrown", self, atan2(throwy, throwx))
    return "holding-kick", atan2(throwy, throwx)
end

function Player:straightAttack(angle, heldenemy)
    self.numopponentshit = 0
    local pressedattackbutton
    if self.attackprojectile then
        local targetx, targety, targetz = findInstantThrowTarget(self, cos(angle), sin(angle))
        Shoot.launchProjectileAtPosition(self, self.attackprojectile, targetx, targety, targetz)
    else
        self:startAttack(angle)
    end
    Mana.store(self, -(self.attackmanacost or 0))
    Face.faceAngle(self, angle)
    local t = self.attackhittime or 1
    local lungespeed = self.attacklungespeed
    repeat
        yield()
        if pressedattackbutton ~= self.fireattackbutton then
            if self.fireattackbutton.pressed then
                pressedattackbutton = self.fireattackbutton
            elseif self.attackbutton.pressed then
                pressedattackbutton = self.attackbutton
            end
        end
        if lungespeed then
            lungespeed = Slide.updateSlideSpeed(self, angle, lungespeed)
        else
            self:accelerateTowardsVel(0, 0, self.attackdecel or 8)
        end
        local afterimageinterval = self.afterimageinterval or 0
        if afterimageinterval ~= 0 and t % afterimageinterval == 0 then
            self:makeAfterImage()
        end
        t = t - 1
    until t <= 0
    if self.numopponentshit <= 0 then
        Combo.reset(self)
    end
    self:stopAttack()
    if pressedattackbutton then
        local faceangle = self.faceangle
        local inx, iny = self.joystickx.position, self.joysticky.position
        if not heldenemy then
            if inx ~= 0 or iny ~= 0 then
                faceangle = atan2(iny, inx)
            end
        end
        return self:doComboAttack(faceangle, heldenemy, pressedattackbutton == self.fireattackbutton)
    end
    if heldenemy and heldenemy.health > 0 then
        return "hold", heldenemy
    end
    return "control"
end

function Player:getup(attacker)
    local t = self.getuptime or 30
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    for i = 1, t do
        yield()
        local _, runpressed = self.attackbutton.pressed, self.sprintbutton.pressed
        if runpressed then
            break
        end
    end
    return recoverai
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

function Player:eventWalkTo(destx, desty, timelimit)
    HoldOpponent.stopHolding(self, self.heldopponent)
    self:walkTo(destx, desty, timelimit)
    self.velx, self.vely, self.velz = 0, 0, 0
    Face.faceVector(self, 1, 0, "Stand")
end

return Player