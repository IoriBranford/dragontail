local Controls = require "Dragontail.Controls"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local State   = require "Dragontail.Character.State"
local Fighter  = require "Dragontail.Character.Fighter"
local Character= require "Dragontail.Character"
local Boundaries = require "Dragontail.Stage.Boundaries"
local AttackerSlot = require "Dragontail.Character.AttackerSlot"
local Characters   = require "Dragontail.Stage.Characters"
local Color        = require "Tiled.Color"
local Graphics     = require "Tiled.Graphics"
local Assets       = require "Tiled.Assets"

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

local function faceAngle(self, angle)
    self.facex, self.facey = cos(angle), sin(angle)
end

local function findOpponentToHold(self, inx, iny)
    local x, y, opponents = self.x, self.y, self.opponents
    local grabradius = self.grabradius or 8
    for i, opponent in ipairs(opponents) do
        if opponent.canbegrabbed then
            local oppox, oppoy = opponent.x, opponent.y
            if testcircles(x, y, grabradius, oppox, oppoy, opponent.bodyradius) then
                local distx = oppox - x
                local disty = oppoy - y
                if dot(distx, disty, inx, iny) > 0 then
                    return opponent
                end
            end
        end
    end
end

local function findSomethingToRunningAttack(self, velx, vely)
    local x, y, opponents, solids = self.x, self.y, self.opponents, self.solids
    for i, opponent in ipairs(opponents) do
        if dot(opponent.x - x, opponent.y - y, velx, vely) > 0 then
            if opponent.canbeattacked and self:testBodyCollision(opponent) then
                return opponent
            end
        end
    end
    for i, solid in ipairs(solids) do
        if dot(solid.x - x, solid.y - y, velx, vely) > 0 then
            if solid.canbeattacked and self:testBodyCollision(solid) then
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

local function updateFace(facex, facey, targetfacex, targetfacey, turnspeed)
    local facedot = dot(facex, facey, targetfacex, targetfacey)
    local acosfacedot = acos(facedot)
    if acosfacedot <= turnspeed then
        facex, facey = targetfacex, targetfacey
    else
        local facedet = det(facex, facey, targetfacex, targetfacey)
        if facedet < 0 then
            turnspeed = -turnspeed
        end
        facex, facey = rot(facex, facey, turnspeed)
        facex, facey = norm(facex, facey)
    end
    return facex, facey
end

local function doComboAttack(self, facex, facey, heldenemy)
    if self.comboindex >= 2 then
        self.comboindex = 0
        if heldenemy then
            return "spinAndKickEnemy", "spinning-throw", atan2(facey, facex), heldenemy
        end
        local spindir = facex < 0 and "ccw" or "cw"
        return "spinAttack", "tail-swing-"..spindir, atan2(-facey, -facex)
    else
        self.comboindex = self.comboindex + 1
        return "straightAttack", heldenemy and "holding-knee" or "kick", atan2(facey, facex), heldenemy
    end
end

function Player:init()
    Character.init(self)
    self.comboindex = 0
    self.runenergy = 100
    self.runenergymax = self.runenergy
    self.runenergycost = 25
    self.facex = 1
    self.facey = 0

    ---@type AttackerSlot[]
    self.attackerslots = {
        AttackerSlot(1024, 0),
        AttackerSlot(0, 1024),
        AttackerSlot(-1024, 0),
        AttackerSlot(0, -1024)
    }
end

---@param imagedata love.ImageData
---@param cel AseCel
local function getHandMarkers(imagedata, cel)
    local palmx, palmy, thumbx, thumby, fingersx, fingersy
    local x0, y0, w, h = cel.quad:getViewport()
    local x1, y1 = x0 + w - 1, y0 + h - 1
    for y = y0, y1 do
        for x = x0, x1 do
            local r, g, b, a = imagedata:getPixel(x, y)
            local color = Color.asARGBInt(r, g, b, a)
            if color == Color.Red then
                thumbx, thumby = x, y
                if palmx and palmy and fingersx and fingersy then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            elseif color == Color.Green then
                fingersx, fingersy = x, y
                if palmx and palmy and thumbx and thumby then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            elseif color == Color.Blue then
                palmx, palmy = x, y
                if fingersx and fingersy and thumbx and thumby then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            end
        end
    end
end

---@param imagedata love.ImageData
---@param cel AseCel
local function readWeaponTransform(imagedata, cel)
    local palmx, palmy, thumbx, thumby, fingersx, fingersy
        = getHandMarkers(imagedata, cel)
    if not palmx then return end

    local x0, y0 = cel.quad:getViewport()
    local x = palmx - x0 + cel.x
    local y = palmy - y0 + cel.y
    return x, y, atan2(thumby-palmy, thumbx-palmx),
        det(thumbx-palmx, thumby-palmy, fingersx-palmx, fingersy-palmy) < 0 and -1 or 1
end

function Player:initAseprite()
    Character.initAseprite(self)
    local weaponposasefile = self.weaponposasefile
    if not weaponposasefile then return end

    local weaponposase = Assets.load(weaponposasefile, true)
    Assets.uncache(weaponposase.imagefile)
    Assets.uncache(weaponposasefile)
    local imagedata = weaponposase.imagedata

    ---@type number[]
    local weapontransforms = {}
    self.weapontransforms = weapontransforms

    for i = 1, #weaponposase do
        local frame = weaponposase[i]
        local cel = frame and frame[1]
        local x, y, r, sy
        if cel then
            x, y, r, sy = readWeaponTransform(imagedata, cel)
        end
        if not x then
            x, y, r, sy = 0, 0, 0, 0
        end
        weapontransforms[#weapontransforms+1] = x
        weapontransforms[#weapontransforms+1] = y
        weapontransforms[#weapontransforms+1] = r
        weapontransforms[#weapontransforms+1] = sy
    end
end

function Player:drawWeaponInHand(frame, x, y)
    local weapontype = Database.get(self.weaponinhand)
    if not weapontype then return end

    local weapontransforms = self.weapontransforms
    if not weapontransforms then return end

    local i = frame.index*4
    local weaponx, weapony, weaponr, weaponsy =
        weapontransforms[i-3], weapontransforms[i-2], weapontransforms[i-1], (weapontransforms[i] or 0)
    if weaponsy == 0 then
        return
    end

    local weaponasefile = weapontype.asefile
    local weaponase = Assets.get(weaponasefile) ---@type Aseprite
    if not weaponase then return end

    local weaponanim = weaponase.animations["inhand"]
    local weaponframe = weaponanim and weaponanim[1]
    if not weaponframe then return end

    love.graphics.push()
    love.graphics.translate(x + weaponx, y + weapony)
    love.graphics.rotate(weaponr)
    love.graphics.scale(1, weaponsy)
    love.graphics.translate(-weapontype.spriteoriginx, -weapontype.spriteoriginy)
    weaponframe:draw()
    love.graphics.pop()

    local weaponhandlayer = self.aseprite.layers["weaponhand"]
    if weaponhandlayer then
        frame:drawCels(weaponhandlayer, weaponhandlayer, x, y)
    end
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

    Graphics.pushTransform(self, 3)
    local x, y = self.x + velx*fixedfrac, self.y + vely*fixedfrac
    frame:draw(x, y)
    self:drawWeaponInHand(frame, x, y)
    love.graphics.pop()
end

function Player:findRandomAttackerSlot(attackrange)
    local attackerslots = self.attackerslots
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

function Player:findClosestAttackerSlot(attackerx, attackery, attackrange)
    local attackerslots = self.attackerslots
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
        Boundaries.castRay(slot, x, y)
    end
end

function Player:control()
    local targetfacex, targetfacey = self.facex, self.facey
    local runningtime
    while true do
        local facex, facey = self.facex, self.facey
        local inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()
        local _, rundown = Controls.getButtonsDown()

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
        end

        if runpressed and not runningtime and self.runenergy >= self.runenergycost then
            self.comboindex = 0
            Audio.play(self.dashsound)
            runningtime = 0
            facex, facey = targetfacex or facex, targetfacey or facey
            self.runenergy = self.runenergy - self.runenergycost
        end

        local movespeed, turnspeed, acceltime
        if runningtime then
            movespeed, turnspeed, acceltime = 8, pi/60, 1
        else
            movespeed, turnspeed, acceltime = 4, pi/8, 4
        end

        facex, facey = updateFace(facex, facey, targetfacex, targetfacey, turnspeed)
        self.facex, self.facey = facex, facey

        if runningtime then
            targetvelx = facex * movespeed
            targetvely = facey * movespeed
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
                    return "throwWeapon"
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
                    return "straightAttack", "running-elbow", atan2(vely, velx)
                end
            end

            if runningtime < 15 then
                runningtime = runningtime + 1
            elseif self.runenergy > 0 and rundown then
                -- self.runenergy = self.runenergy - 1
            else
                runningtime = nil
                Audio.play(self.stopdashsound)
            end
        else
            self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
            if attackpressed then
                if self.weaponinhand then
                    return "throwWeapon"
                end
                return doComboAttack(self, targetfacex, targetfacey)
            end

            local opponenttohold = findOpponentToHold(self, inx, iny)
            if opponenttohold then
                return "hold", opponenttohold
            end
        end

        local animation
        if velx ~= 0 or vely ~= 0 then
            animation = "run"
        else
            animation = "stand"
        end
        animation = self.getDirectionalAnimation_angle(animation, atan2(facey, facex), self.animationdirections)
        self:changeAseAnimation(animation)

        yield()
    end
end

function Player:spinAttack(attacktype, angle)
    local lungeangle = angle + pi
    local originalfacex, originalfacey = self.facex, self.facey
    Database.fill(self, attacktype)
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    Audio.play(self.swingsound)
    local attackagain = false
    local t = spintime
    local lungespeed = self.attacklungespeed
    repeat
        local inx, iny = Controls.getDirectionInput()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        if lungespeed then
            lungespeed = Fighter.updateSlideSpeed(self, lungeangle, lungespeed)
        else
            self:accelerateTowardsVel(targetvelx, targetvely, 8)
        end

        self:startAttack(angle)
        faceAngle(self, angle+pi)
        local attackanimation = self.swinganimation
        if attackanimation then
            attackanimation = self.getDirectionalAnimation_angle(attackanimation, angle, self.animationdirections)
            self:changeAseAnimation(attackanimation)
        end

        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        angle = angle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    self.facex, self.facey = originalfacex, originalfacey
    if attackagain then
        local inx, iny = Controls.getDirectionInput()
        if inx ~= 0 or iny ~= 0 then
            originalfacex, originalfacey = inx, iny
        end
        return doComboAttack(self, originalfacex, originalfacey)
    end
    return "control"
end

function Player:throwWeapon()
    local inx, iny = Controls.getDirectionInput()
    local inz = 0 -- TODO adjust for higher or lower enemy
    if inx == 0 and iny == 0 then
        inx, iny = self.facex, self.facey
    else
        inx, iny = norm(inx, iny)
        self.facex, self.facey = inx, iny
    end
    local angle = atan2(iny, inx)
    inx, iny, inz = norm(inx, iny, inz)
    self:setDirectionalAnimation("throw", angle, 1)
    self:launchProjectile(self.weaponinhand, inx, iny, inz)
    self.weaponinhand = nil
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
        Audio.play(self.holdsound)
        Fighter.startHolding(self, enemy)
        State.start(enemy, enemy.heldai or "held", self)
    end
    self:stopAttack()
    local x, y = self.x, self.y
    local radii = self.bodyradius + enemy.bodyradius
    local holddirx, holddiry = enemy.x - x, enemy.y - y
    if holddirx ~= 0 or holddiry ~= 0 then
        holddirx, holddiry = norm(holddirx, holddiry)
    else
        holddirx = 1
    end
    local holdangle = atan2(holddiry, holddirx)
    local holddestangle = holdangle
    local time = enemy.timetobreakhold or 60
    while time > 0 do
        yield()
        enemy = self.heldopponent
        if not enemy then
            return "control"
        end
        time = time - 1

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
        holddirx, holddiry = cos(holdangle), sin(holdangle)
        x, y = self.x, self.y
        enemy.x = x + velx + holddirx*radii
        enemy.y = y + vely + holddiry*radii
        self.facex, self.facey = holddirx, holddiry

        local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, self.animationdirections)
        self:changeAseAnimation(holdanimation)

        self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
        if runpressed and self.runenergy >= self.runenergycost then
            return "runWithEnemy", enemy
        end
        if attackpressed then
            if inx ~= 0 or iny ~= 0 then
                self.comboindex = 0
                return "spinAndKickEnemy", "spinning-throw", holdangle, enemy
            end
            return doComboAttack(self, holddirx, holddiry, enemy)
        end
    end
    State.start(enemy, "breakaway", self)
    return "breakaway", enemy
end

function Player:runWithEnemy(enemy)
    Audio.play(self.dashsound)
    enemy.canbeattacked = false
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    local targetfacex, targetfacey = self.facex, self.facey
    local radii = self.bodyradius + enemy.bodyradius
    local holdangle = atan2(targetfacey, targetfacex)
    Database.fill(self, "running-with-enemy")
    Database.fill(enemy, "human-in-spinning-throw")
    enemy:startAttack(holdangle)
    local runningtime = 0
    while true do
        yield()
        local facex, facey = self.facex, self.facey
        local inx, iny = Controls.getDirectionInput()
        local attackpressed = Controls.getButtonsPressed()
        local _, rundown = Controls.getButtonsDown()

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
        end

        local movespeed, turnspeed, acceltime = 8, pi/120, 1

        facex, facey = updateFace(facex, facey, targetfacex, targetfacey, turnspeed)
        self.facex, self.facey = facex, facey
        holdangle = atan2(facey, facex)
        targetvelx = facex * movespeed
        targetvely = facey * movespeed

        self:accelerateTowardsVel(targetvelx, targetvely, acceltime)

        local x, y = self.x, self.y
        enemy.x = x + self.velx + facex*radii
        enemy.y = y + self.vely + facey*radii

        if self.animationtime % 3 == 0 then
            self:makeAfterImage()
            enemy:makeAfterImage()
        end

        if attackpressed then
            enemy:stopAttack()
            Fighter.stopHolding(self, enemy)
            enemy.canbeattacked = true
            return "straightAttack", "running-kick", holdangle
        end

        local oobx, ooby = findWallCollision(enemy)
        if oobx or ooby then
            State.start(enemy, "wallSlammed", self, oobx, ooby)
            return "straightAttack", "running-elbow", holdangle
        end

        if runningtime < 15 then
            runningtime = runningtime + 1
        elseif self.runenergy > 0 and rundown then
            self.runenergy = self.runenergy - 2
        else
            Audio.play(self.stopdashsound)
            Audio.play(self.throwsound)
            enemy:stopAttack()
            Fighter.stopHolding(self, enemy)
            enemy.canbeattacked = true
            State.start(enemy, "knockedBack", self, holdangle)
            return "control"
        end

        local holdanimation = "holdwalk"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, self.animationdirections)
        self:changeAseAnimation(holdanimation)
    end
end

function Player:spinAndKickEnemy(attacktype, angle, enemy)
    enemy.canbeattacked = false
    Database.fill(self, attacktype)
    Database.fill(enemy, "human-in-spinning-throw")
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    local t = spintime
    local x, y = self.x, self.y
    local radii = self.bodyradius + enemy.bodyradius
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
        faceAngle(self, angle)
        local attackanimation = self.swinganimation
        if attackanimation then
            attackanimation = self.getDirectionalAnimation_angle(attackanimation, angle, self.animationdirections)
            self:changeAseAnimation(attackanimation)
        end

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
    Fighter.stopHolding(self, enemy)
    enemy.canbeattacked = true
    -- if self.attackdamage then
    --     enemy.health = enemy.health - self.attackdamage
    -- end
    -- State.start(enemy, enemy.thrownai or "thrown", self, atan2(throwy, throwx))
    return "straightAttack", "holding-kick", atan2(throwy, throwx)
end

function Player:straightAttack(attacktype, angle, heldenemy)
    Database.fill(self, attacktype)
    Audio.play(self.swingsound)
    local attackagain = false
    self:startAttack(angle)
    local attackanimation = self.swinganimation
    if attackanimation then
        attackanimation = self.getDirectionalAnimation_angle(attackanimation, angle, self.animationdirections)
        self:changeAseAnimation(attackanimation)
    end
    local t = self.attackhittime or 1
    local lungespeed = self.attacklungespeed
    repeat
        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        if lungespeed then
            lungespeed = Fighter.updateSlideSpeed(self, angle, lungespeed)
        else
            self:accelerateTowardsVel(0, 0, self.attackdecel or 8)
        end
        local afterimageinterval = self.afterimageinterval or 0
        if afterimageinterval ~= 0 and t % afterimageinterval == 0 then
            self:makeAfterImage()
        end
        t = t - 1
    until t <= 0
    self:stopAttack()
    if attackagain then
        local facex, facey = self.facex, self.facey
        local inx, iny = Controls.getDirectionInput()
        if not heldenemy then
            if inx ~= 0 or iny ~= 0 then
                facex, facey = inx, iny
            end
        end
        return doComboAttack(self, facex, facey, heldenemy)
    end
    if heldenemy and heldenemy.health > 0 then
        return "hold", heldenemy
    end
    return "control"
end

function Player:getup(attacker)
    Audio.play(self.getupsound)
    self:changeAseAnimation("FallRiseToFeet", 1, 0)
    local t = self.getuptime or 27
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
    self:changeAseAnimation("win")
    local i = 0
    while true do
        self:accelerateTowardsVel(0, 0, 4)
        self.z = abs(sin(i*pi/30) * 8)
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

return Player