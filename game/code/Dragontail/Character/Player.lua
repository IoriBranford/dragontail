local Controls = require "Dragontail.Controls"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local State   = require "Dragontail.Character.State"
local Fighter  = require "Dragontail.Character.Fighter"

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

function Player:control()
    self.comboindex = self.comboindex or 0
    self.runenergy = self.runenergy or 100
    self.runenergymax = self.runenergymax or self.runenergy
    self.runenergycost = self.runenergycost or 25
    self.facex = self.facex or 1
    self.facey = self.facey or 0
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
            movespeed, turnspeed, acceltime = 4, pi/8, 8
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
            if math.floor(love.timer.getTime() * 60) % 3 == 0 then
                self:makeAfterImage()
            end

            if attackpressed then
                return "straightAttack", "running-kick", atan2(vely, velx)
            end

            local attacktarget = findSomethingToRunningAttack(self, velx, vely)
            if attacktarget then
                return "straightAttack", "running-elbow", atan2(vely, velx)
            end

            local oobx, ooby = findWallCollision(self)
            if oobx or ooby then
                Audio.play(self.bodyslamsound)
                local Stage = require "Dragontail.Stage"
                Stage.addCharacter(
                    {
                        type = "spark-bighit",
                        x = self.x + oobx*self.bodyradius,
                        y = self.y + ooby*self.bodyradius
                    }
                )
                return "straightAttack", "running-elbow", atan2(vely, velx)
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

        if math.floor(love.timer.getTime() * 60) % 3 == 0 then
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
    if heldenemy then
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
        self.altitude = abs(sin(i*pi/30) * 8)
        yield()
        i = i + 1
    end
end

function Player:defeat(attacker)
    Audio.fadeMusic()
    return Fighter.defeat(self, attacker)
end

return Player