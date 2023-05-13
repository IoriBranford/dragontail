local Controls = require "Dragontail.Controls"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local Script   = require "Component.Script"
local Fighter  = require "Dragontail.Character.Fighter"
local tablex   = require "pl.tablex"

local Player = tablex.copy(Fighter)

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
local yield = coroutine.yield

local function faceAngle(self, angle)
    self.facex, self.facey = cos(angle), sin(angle)
end

local function findOpponentToHold(self, inx, iny)
    local x, y, opponents = self.x, self.y, self.opponents
    for i, opponent in ipairs(opponents) do
        if dot(opponent.x - x, opponent.y - y, inx, iny) > 0 then
            if opponent.canbegrabbed and self:testBodyCollision(opponent) then
                return opponent
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
    local x, y, bounds = self.x, self.y, self.bounds
    local oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    if oobx or ooby then
        return norm(oobx or 0, ooby or 0)
    end
end

function Player:control()
    self.runenergy = self.runenergy or 100
    self.runenergymax = self.runenergymax or self.runenergy
    self.runenergycost = self.runenergycost or 25
    self.canbeattacked = true
    self.canbegrabbed = true
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    local targetfacex, targetfacey = self.facex, self.facey
    local running
    while true do
        yield()
        local facex, facey = self.facex, self.facey
        local inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
        end

        if runpressed and self.runenergy >= self.runenergycost then
            Audio.play(self.dashsound)
            running = true
            runpressed = false
            facex, facey = targetfacex or facex, targetfacey or facey
            self.runenergy = self.runenergy - self.runenergycost
        end

        local movespeed, turnspeed, acceltime
        if running then
            movespeed, turnspeed, acceltime = 8, pi/60, 1
        else
            movespeed, turnspeed, acceltime = 4, pi/8, 8
        end

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
        self.facex, self.facey = facex, facey

        if running then
            targetvelx = facex * movespeed
            targetvely = facey * movespeed
        else
            targetvelx = inx * movespeed
            targetvely = iny * movespeed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, acceltime)

        local velx, vely = self.velx, self.vely

        if running then
            if math.floor(love.timer.getTime() * 60) % 3 == 0 then
                self:makeAfterImage()
            end

            if attackpressed then
                return Player.straightAttack, "running-kick", atan2(vely, velx)
            end

            local attacktarget = findSomethingToRunningAttack(self, velx, vely)
            if attacktarget then
                return Player.straightAttack, "running-elbow", atan2(vely, velx)
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
                return Player.straightAttack, "running-elbow", atan2(vely, velx)
            end

            self.runenergy = self.runenergy - 1
            if self.runenergy <= 0 then
                running = false
                Audio.play(self.stopdashsound)
            end
        else
            self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
            if attackpressed then
                local spindir = facex < 0 and "ccw" or "cw"
                return Player.spinAttack, "tail-swing-"..spindir, atan2(-facey, -facex)
            end

            local opponenttohold = findOpponentToHold(self, inx, iny)
            if opponenttohold then
                return Player.hold, opponenttohold
            end
        end

        local animation
        if velx ~= 0 or vely ~= 0 then
            animation = "run"
        else
            animation = "stand"
        end
        animation = self.getDirectionalAnimation_angle(animation, atan2(facey, facex), self.animationdirections)
        self.sprite:changeAsepriteAnimation(animation)
    end
end

function Player:spinAttack(attacktype, angle)
    Database.fill(self, attacktype)
    local spinvel = self.attackspinspeed or 0
    local spintime = self.attackhittime or 0
    Audio.play(self.swingsound)
    local attackagain = false
    local t = spintime
    repeat
        local inx, iny = Controls.getDirectionInput()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 8)

        self:startAttack(angle)
        faceAngle(self, angle+pi)
        local attackanimation = self.swinganimation
        if attackanimation then
            attackanimation = self.getDirectionalAnimation_angle(attackanimation, angle, self.animationdirections)
            self.sprite:changeAsepriteAnimation(attackanimation)
        end

        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        angle = angle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    if attackagain then
        return Player.spinAttack, attacktype, angle
    end
    return Player.control
end

function Player:hold(enemy)
    Audio.play(self.holdsound)
    Fighter.startHolding(self, enemy)
    Script.start(enemy, enemy.heldai or "held", self)
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
            return Player.control
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
            avel = -pi/16
        elseif holddestangle > holdangle then
            avel = pi/16
        end
        holdangle = Movement.moveTowards(holdangle, holddestangle, avel)
        holddirx, holddiry = cos(holdangle), sin(holdangle)
        x, y = self.x, self.y
        enemy.x = x + velx + holddirx*radii
        enemy.y = y + vely + holddiry*radii
        self.facex, self.facey = holddirx, holddiry

        local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, self.animationdirections)
        self.sprite:changeAsepriteAnimation(holdanimation)

        self.runenergy = math.min(self.runenergymax, self.runenergy + 1)
        if runpressed and self.runenergy >= self.runenergycost then
            return Player.runWithEnemy, enemy
        end
        if attackpressed then
            return Player.spinThrow, "spinning-throw", holdangle, enemy
        end
    end
    Script.start(enemy, Fighter.breakaway, self)
    return Fighter.breakaway, enemy
end

function Player:runWithEnemy(enemy)
    Audio.play(self.dashsound)
    enemy.canbeattacked = false
    self.canbeattacked = false
    self.canbegrabbed = false
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    local targetfacex, targetfacey = self.facex, self.facey
    local radii = self.bodyradius + enemy.bodyradius
    local holdangle = atan2(targetfacey, targetfacex)
    Database.fill(self, "running-with-enemy")
    Database.fill(enemy, "human-in-spinning-throw")
    enemy:startAttack(holdangle)
    while true do
        yield()
        local movespeed, turnspeed, acceltime = 8, pi/120, 1
        local facex, facey = self.facex, self.facey
        local inx, iny = Controls.getDirectionInput()
        local attackpressed = Controls.getButtonsPressed()

        local targetvelx, targetvely = 0, 0
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
        end

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
            return Player.straightAttack, "running-kick", holdangle
        end

        local oobx, ooby = findWallCollision(enemy)
        if oobx or ooby then
            Script.start(enemy, Fighter.wallSlammed, self, oobx, ooby)
            return Player.straightAttack, "running-elbow", holdangle
        end

        self.runenergy = self.runenergy - 2
        if self.runenergy <= 0 then
            Audio.play(self.stopdashsound)
            Audio.play(self.throwsound)
            enemy:stopAttack()
            Fighter.stopHolding(self, enemy)
            enemy.canbeattacked = true
            Script.start(enemy, Fighter.knockedBack, self, holdangle)
            return Player.control
        end

        local holdanimation = "holdwalk"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, self.animationdirections)
        self.sprite:changeAsepriteAnimation(holdanimation)
    end
end

function Player:spinThrow(attacktype, angle, enemy)
    enemy.canbeattacked = false
    self.canbeattacked = false
    self.canbegrabbed = false
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
            self.sprite:changeAsepriteAnimation(attackanimation)
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
    until 2*pi <= spunmag and (dot(throwx, throwy, holddirx, holddiry) >= cos(spinmag))
    Audio.play(self.throwsound)
    enemy:stopAttack()
    Fighter.stopHolding(self, enemy)
    enemy.canbeattacked = true
    if self.attackdamage then
        enemy.health = enemy.health - self.attackdamage
    end
    Script.start(enemy, enemy.thrownai or "thrown", self, atan2(throwy, throwx))
    self.canbeattacked = true
    self.canbegrabbed = true
    return Player.control
end

function Player:straightAttack(attacktype, angle)
    Database.fill(self, attacktype)
    Audio.play(self.swingsound)
    self:startAttack(angle)
    local attackanimation = self.swinganimation
    if attackanimation then
        attackanimation = self.getDirectionalAnimation_angle(attackanimation, angle, self.animationdirections)
        self.sprite:changeAsepriteAnimation(attackanimation)
    end
    local t = self.attackhittime or 1
    repeat
        yield()
        self:accelerateTowardsVel(0, 0, self.attackdecel or 8)
        local afterimageinterval = self.afterimageinterval or 0
        if afterimageinterval ~= 0 and t % afterimageinterval == 0 then
            self:makeAfterImage()
        end
        t = t - 1
    until t <= 0
    self:stopAttack()
    return Player.control
end

function Player:victory()
    self:stopAttack()
    Audio.play(self.victorysound)
    self.sprite:changeAsepriteAnimation("win")
    local i = 0
    while true do
        self:accelerateTowardsVel(0, 0, 4)
        self.z = abs(sin(i*pi/30) * 8)
        yield()
        i = i + 1
    end
end

function Player:defeat(defeatanimation)
    Audio.fadeMusic()
    yield()
    return Fighter.defeat, defeatanimation
end

return Player