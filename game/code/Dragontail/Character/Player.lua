local Controls = require "Dragontail.Controls"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local State   = require "Dragontail.Character.State"
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

---@class Player:Fighter
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
    local oobx, ooby = self:keepInBounds()
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        return norm(oobx, ooby)
    end
end

---@param self Player
local function doComboAttack(self, faceangle, heldenemy)
    if self.comboindex >= 2 then
        self.comboindex = 0
        if heldenemy then
            return "spinAndKickEnemy", "spinning-throw", faceangle, heldenemy
        end
        local spindir = pi*0.5 <= faceangle and faceangle < pi*1.5 and "ccw" or "cw"
        return "spinAttack", "tail-swing-"..spindir, faceangle
    else
        self.comboindex = self.comboindex + 1
        return "straightAttack", heldenemy and "holding-knee" or "kick", faceangle, heldenemy
    end
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
    Fighter.init(self)
    self.comboindex = 0
    -- self.runenergy = self.runenergy or 100
    -- self.runenergymax = self.runenergymax or self.runenergy
    -- self.runenergycost = self.runenergycost or 25
    self.manaunitsize = self.manaunitsize or 60
    self.manamax = self.manamax or (self.manaunitsize * 3)
    self.mana = self.mana or self.manaunitsize

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

function Player:updateAttackerSlots()
    local attackerslots = self.attackerslots
    local x, y = self.x, self.y
    for _, slot in ipairs(attackerslots) do
        Characters.castRay(slot, x, y)
    end
end

function Player:control()
    self.facedestangle = self.faceangle
    local runningtime
    -- local attackdowntime
    while true do
        local inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()
        local attackdown, rundown = Controls.getButtonsDown()

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
            end
            self.facedestangle = atan2(iny, inx)
        end

        local movespeed, turnspeed, acceltime
        if runningtime then
            movespeed, turnspeed, acceltime = 8, pi/60, 1
        else
            movespeed, turnspeed, acceltime = 4, pi/8, 4
        end

        if runpressed and not runningtime --and self.runenergy >= self.runenergycost
        then
            self.comboindex = 0
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

            if attackpressed then
                if self.weaponinhand then
                    local projectiledata = Database.get(self.weaponinhand)
                    local attackchoices = projectiledata and projectiledata.attackchoices
                    local attackid = attackchoices and attackchoices[math.min(#attackchoices, 2)]
                    local targetx, targety, targetz = findInstantThrowTarget(self, cos(self.facedestangle), sin(self.facedestangle))
                    return "throwWeapon", targetx, targety, targetz, attackid
                end
                return "straightAttack", "running-kick", atan2(vely, velx)
            end

            local attacktarget = findSomethingToRunningAttack(self, velx, vely)
            if attacktarget then
                return "straightAttack", "running-elbow", atan2(vely, velx)
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
                    return "straightAttack", "running-elbow", atan2(vely, velx)
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
            if attackpressed then
                Face.updateTurnToDestAngle(self, pi)
                if not self.weaponinhand then
                    return doComboAttack(self, self.facedestangle)
            --     end
            --     attackdowntime = 0
            -- end
            -- if attackdowntime and self.weaponinhand then
            --     if attackdown then
            --         attackdowntime = attackdowntime + 1
            --         if attackdowntime > 10 then
            --             return "aimThrow"
            --         end
                else
                    return "throwWeapon", findInstantThrowTarget(self, cos(self.facedestangle), sin(self.facedestangle))
                end
            end

            local opponenttohold = HoldOpponent.findOpponentToHold(self, inx, iny)
            if opponenttohold then
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

function Player:spinAttack(attacktype, attackangle)
    self.numopponentshit = 0
    local tailangle = attackangle
    local lungeangle = attackangle
    local originalfaceangle = self.faceangle
    self.attacktype = attacktype
    Database.fill(self, attacktype)
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    Audio.play(self.swingsound)
    local attackagain = false
    local t = spintime
    local lungespeed = self.attacklungespeed
    local shootingfireballs
    local buttonholdtimeforfireball = spintime/2
    repeat
        if t == buttonholdtimeforfireball then
            if self.mana >= self.manaunitsize then
                if attackagain then
                    shootingfireballs = true
                    attackagain = false
                    self:giveMana(-self.manaunitsize)
                end
            end
        end

        local faceangle = tailangle + pi
        if shootingfireballs then
            Shoot.launchProjectile(self, "Rose-fireball", cos(faceangle), sin(faceangle), 0)
        end

        local inx, iny = Controls.getDirectionInput()
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
        Face.faceAngle(self, faceangle)
        DirectionalAnimation.set(self, self.swinganimation, tailangle)

        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        tailangle = tailangle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    self.faceangle = originalfaceangle
    if attackagain then
        local inx, iny = Controls.getDirectionInput()
        if inx ~= 0 or iny ~= 0 then
            originalfaceangle = atan2(iny, inx)
        end
        return doComboAttack(self, originalfaceangle)
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
        local attackbutton, runbutton = Controls.getButtonsDown()
        local inx, iny = Controls.getDirectionInput()
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

function Player:throwWeapon(targetx, targety, targetz, attackid)
    Face.faceVector(self, targetx - self.x, targety - self.y, "throw")
    Shoot.launchProjectileAtPosition(self, {
        type = self.weaponinhand,
        gravity = 1/8,
        speed = 16
    }, targetx, targety, targetz, attackid)
    self.numweaponinhand = self.numweaponinhand - 1
    if self.numweaponinhand <= 0 then
        self.numweaponinhand = nil
        self.weaponinhand = nil
    end
    Audio.play(self.throwsound)
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
        self.comboindex = 0
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

        local inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()
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
            return "runWithEnemy", enemy
        end
        if attackpressed then
            if inx ~= 0 or iny ~= 0 then
                self.comboindex = 0
                return "spinAndKickEnemy", "spinning-throw", holdangle, enemy
            end
            return doComboAttack(self, holdangle, enemy)
        end
    end
    State.start(enemy, "breakaway", self)
    return "breakaway", enemy
end

function Player:runWithEnemy(enemy)
    Audio.play(self.dashsound)
    enemy.canbeattacked = false
    self.facedestangle = self.faceangle
    Database.fill(self, "running-with-enemy")
    enemy.attacktype = "human-in-spinning-throw"
    Database.fill(enemy, "human-in-spinning-throw")
    enemy:startAttack(self.faceangle)
    local runningtime = 0
    while true do
        yield()
        local inx, iny = Controls.getDirectionInput()
        local attackpressed = Controls.getButtonsPressed()
        local _, rundown = Controls.getButtonsDown()

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

        if attackpressed then
            enemy:stopAttack()
            HoldOpponent.stopHolding(self, enemy)
            enemy.canbeattacked = true
            return "straightAttack", "running-kick", self.faceangle
        end

        local oobx, ooby = HoldOpponent.handleOpponentCollision(self)
        if oobx or ooby then
            HoldOpponent.stopHolding(self, enemy)
            State.start(enemy, "wallSlammed", self, oobx, ooby)
            return "straightAttack", "running-elbow", self.faceangle
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
            State.start(enemy, "knockedBack", self, self.faceangle)
            return "control"
        end
    end
end

function Player:spinAndKickEnemy(attacktype, angle, enemy)
    enemy.canbeattacked = false
    self.attacktype = attacktype
    Database.fill(self, attacktype)
    enemy.attacktype = "human-in-spinning-throw"
    Database.fill(enemy, "human-in-spinning-throw")
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    local t = spintime
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
        local inx, iny = Controls.getDirectionInput()
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

        enemy:startAttack(angle)
        Face.faceAngle(self, angle, self.swinganimation)

        holddirx, holddiry = cos(angle), sin(angle)
        x, y = self.x, self.y
        enemy.x = x + velx + holddirx*radii
        enemy.y = y + vely + holddiry*radii

        yield()
        angle = angle + spinvel
        if math.ceil(spunmag / 2 / pi) < math.ceil((spunmag+spinmag) / 2 / pi) then
            Audio.play(self.windupsound)
        end
        spunmag = spunmag + spinmag
        t = t - 1
    until (dot(throwx, throwy, holddirx, holddiry) >= cos(spinmag))
    enemy.x = x + self.velx + throwx*radii
    enemy.y = y + self.vely + throwy*radii
    Audio.play(self.throwsound)
    enemy:stopAttack()
    HoldOpponent.stopHolding(self, enemy)
    enemy.canbeattacked = true
    -- if self.attackdamage then
    --     enemy.health = enemy.health - self.attackdamage
    -- end
    -- State.start(enemy, enemy.thrownai or "thrown", self, atan2(throwy, throwx))
    return "straightAttack", "holding-kick", atan2(throwy, throwx)
end

function Player:straightAttack(attacktype, angle, heldenemy)
    self.numopponentshit = 0
    self.attacktype = attacktype
    Database.fill(self, attacktype)
    Audio.play(self.swingsound)
    local attackagain = false
    self:startAttack(angle)
    DirectionalAnimation.set(self, self.swinganimation, angle)
    local t = self.attackhittime or 1
    local lungespeed = self.attacklungespeed
    repeat
        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
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
        self.comboindex = 0
    end
    self:stopAttack()
    if attackagain then
        local faceangle = self.faceangle
        local inx, iny = Controls.getDirectionInput()
        if not heldenemy then
            if inx ~= 0 or iny ~= 0 then
                faceangle = atan2(iny, inx)
            end
        end
        return doComboAttack(self, faceangle, heldenemy)
    end
    if heldenemy and heldenemy.health > 0 then
        return "hold", heldenemy
    end
    return "control"
end

function Player:getup(attacker)
    Audio.play(self.getupsound)
    self:changeAseAnimation("FallRiseToFeet", 1, 0)
    local t = self.getuptime or 30
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    for i = 1, t do
        yield()
        local _, runpressed = Controls.getButtonsPressed()
        if runpressed then
            break
        end
    end
    return recoverai
end

function Player:victory()
    self:stopAttack()
    Audio.play(self.victorysound)
    self:changeAseAnimation("win", 1, 0)
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