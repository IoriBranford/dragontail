local Controls = require "System.Controls"
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

function Player:control()
    self.canbeattacked = true
    self.canbegrabbed = true
    local opponents = self.opponents
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    local targetfacex, targetfacey = self.facex, self.facey
    while true do
        yield()
        local inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()

        local facex, facey = self.facex, self.facey
        local targetvelx, targetvely = 0, 0
        local speed = 4
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        local turnspeed = self.turnspeed or pi/8
        local facedot = dot(facex, facey, targetfacex, targetfacey)
        if acos(facedot) <= turnspeed then
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

        if attackpressed then
            local spindir = facex < 0 and "ccw" or "cw"
            return Player.spinAttack, "tail-swing-"..spindir, atan2(-facey, -facex)
        end
        if runpressed then
            return Player.run
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 8)

        local x, y = self.x, self.y
        local velx, vely = self.velx, self.vely

        for i, opponent in ipairs(opponents) do
            if dot(opponent.x - x, opponent.y - y, inx, iny) > 0 then
                if opponent.canbegrabbed and self:testBodyCollision(opponent) then
                    return Player.hold, opponent
                end
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

function Player:run()
    Audio.play(self.dashsound)
    self.canbeattacked = true
    self.canbegrabbed = false
    local bounds = self.bounds
    local solids = self.solids
    local opponents = self.opponents
    local inx, iny = Controls.getDirectionInput()
    if inx ~= 0 or iny ~= 0 then
        self.facex, self.facey = norm(inx, iny)
    else
        self.facex = self.facex or 1
        self.facey = self.facey or 0
    end
    local targetfacex, targetfacey = self.facex, self.facey
    local facex, facey
    while true do
        yield()
        inx, iny = Controls.getDirectionInput()
        local attackpressed, runpressed = Controls.getButtonsPressed()

        facex, facey = self.facex, self.facey
        local speed = 8
        if inx ~= 0 or iny ~= 0 then
            if lensq(inx, iny) > 1 then
                inx, iny = norm(inx, iny)
                targetfacex, targetfacey = inx, iny
            else
                targetfacex, targetfacey = norm(inx, iny)
            end
        end

        local turnspeed = self.runturnspeed or pi/60
        local facedot = dot(facex, facey, targetfacex, targetfacey)
        local acosfacedot = acos(facedot)
        if acosfacedot <= turnspeed then
            facex, facey = targetfacex, targetfacey
        elseif acosfacedot <= pi/2 then
            local facedet = det(facex, facey, targetfacex, targetfacey)
            if facedet < 0 then
                turnspeed = -turnspeed
            end
            facex, facey = rot(facex, facey, turnspeed)
            facex, facey = norm(facex, facey)
        else
            Audio.play(self.stopdashsound)
            return Player.control
        end
        self.facex, self.facey = facex, facey
        self.velx = facex * speed
        self.vely = facey * speed

        if attackpressed then
            return Player.straightAttack, "running-kick", atan2(facey, facex)
        end
        if runpressed then
            Audio.play(self.stopdashsound)
            return Player.control
        end

        local x, y = self.x, self.y
        local velx, vely = self.velx, self.vely

        if math.floor(love.timer.getTime() * 60) % 3 == 0 then
            self:makeAfterImage()
        end

        local oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        if oobx or ooby then
            oobx, ooby = norm(oobx or 0, ooby or 0)
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

        for i, opponent in ipairs(opponents) do
            if dot(opponent.x - x, opponent.y - y, inx, iny) > 0 then
                if opponent.canbeattacked and self:testBodyCollision(opponent) then
                    return Player.straightAttack, "running-elbow", atan2(vely, velx)
                end
            end
        end
        for i, solid in ipairs(solids) do
            if dot(solid.x - x, solid.y - y, inx, iny) > 0 then
                if solid.canbeattacked and self:testBodyCollision(solid) then
                    return Player.straightAttack, "running-elbow", atan2(vely, velx)
                end
            end
        end

        local animation = "run"
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

        if runpressed then
            -- run with enemy
        end
        if attackpressed then
            return Player.spinThrow, "spinning-throw", holdangle, enemy
        end
    end
    Script.start(enemy, Fighter.breakaway, self)
    return Fighter.breakaway, enemy
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