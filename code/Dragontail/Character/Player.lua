local Controls = require "System.Controls"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Movement = require "Component.Movement"
local Ai       = require "Dragontail.Character.Ai"
local Script   = require "Component.Script"
local tablex   = require "pl.tablex"

local Player = tablex.copy(Ai)
local baseDefeat = Ai.defeat
local stopHolding = Ai.stopHolding

local pi = math.pi
local cos = math.cos
local sin = math.sin
local atan2 = math.atan2
local acos = math.acos
local dot = math.dot
local det = math.det
local norm = math.norm
local abs = math.abs
local yield = coroutine.yield

local function faceAngle(self, angle)
    self.facex, self.facey = cos(angle), sin(angle)
end

function Player:control()
    local opponents = self.opponents
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    while true do
        yield()
        local inx, iny = Controls.getDirectionInput()
        local b1pressed = Controls.getButtonsPressed()
        local _, b2down = Controls.getButtonsDown()

        local facex, facey = self.facex, self.facey
        local targetvelx, targetvely = 0, 0
        local speed = b2down and 2 or 5
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            facex, facey = inx, iny
            self.facex, self.facey = facex, facey
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        if b1pressed then
            return "attack", self.type.."-attack", atan2(-facey, -facex)
        end

        if b2down and not self.heldopponent then
            for i, opponent in ipairs(opponents) do
                if opponent.canbegrabbed and self:testBodyCollision(opponent) then
                    return "hold", opponent
                end
            end
        end

        self:accelerateTowardsVel(targetvelx, targetvely, b2down and 4 or 8)

        local velx, vely = self.velx, self.vely
        -- local veldot = dot(velx, vely, inx, iny)
        local attackangle
        -- if not b2
        -- and (inx ~= 0 or iny ~= 0)
        -- and veldot <= len(velx, vely) * speed * cos(pi/4) then
        --     attackangle = atan2(-iny, -inx)
        -- else
        --     attackangle = nil
        -- end
        -- self:startAttack(attackangle)
        local animation
        if attackangle then
            -- local attackanimation = self.getDirectionalAnimation_angle("attackA", attackangle, 8)
            -- self.sprite:changeAsepriteAnimation(attackanimation)
        elseif velx ~= 0 or vely ~= 0 then
            animation = "run"
        else
            animation = "stand"
        end
        animation = self.getDirectionalAnimation_angle(animation, atan2(facey, facex), 8)
        self.sprite:changeAsepriteAnimation(animation)
    end
end

function Player:attack(attacktype, angle)
    Database.fill(self, attacktype)
    local spinvel = self.attackspinspeed or (2*pi/16)
    local spintime = self.attackhittime or 16
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
        local spindir = spinvel < 0 and "B" or "A"
        local attackanimation = self.getDirectionalAnimation_angle("attack"..spindir, angle, 4)
        self.sprite:changeAsepriteAnimation(attackanimation)

        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        angle = angle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    if attackagain then
        return "attack", attacktype, angle
    end
    return "control"
end

function Player:hold(enemy)
    self:stopAttack()
    self.heldopponent = enemy
    enemy.bodysolid = nil
    enemy.heldby = self
    enemy.hurtstun = enemy.holdstun or 120
    local x, y = self.x, self.y
    local radii = self.bodyradius + enemy.bodyradius
    Audio.play(self.holdsound)
    local holddirx, holddiry = enemy.x - x, enemy.y - y
    if holddirx ~= 0 or holddiry ~= 0 then
        holddirx, holddiry = norm(holddirx, holddiry)
    else
        holddirx = 1
    end
    local holdangle = atan2(holddiry, holddirx)
    local holddestangle = holdangle
    local time = enemy.hurtstun
    while time > 0 do
        yield()
        enemy = self.heldopponent
        if not enemy then
            return "control"
        end
        time = time - 1

        local inx, iny = Controls.getDirectionInput()
        local b1pressed = Controls.getButtonsPressed()
        local _, b2down = Controls.getButtonsDown()
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
        enemy.y = y + velx + holddiry*radii
        self.facex, self.facey = holddirx, holddiry

        local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, 8)
        self.sprite:changeAsepriteAnimation(holdanimation)

        if b1pressed then
            stopHolding(self, enemy)
            return "holdAttack", self.type.."-kick-held-enemy", holdangle
        end
        if not b2down then
            Script.start(enemy, enemy.thrownai or "thrown", self, holdangle)
            Audio.play(self.throwsound)
            stopHolding(self, enemy)
            return "control"
        end
    end
    stopHolding(self, enemy)
    return "control"
end

function Player:holdAttack(attacktype, angle)
    Database.fill(self, attacktype)
    Audio.play(self.throwsound)
    self:startAttack(angle)
    self.velx, self.vely = 0, 0
    local attackanimation = self.getDirectionalAnimation_angle("kick", angle, 8)
    self.sprite:changeAsepriteAnimation(attackanimation)
    yield()
    self:stopAttack()
    return "control"
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
    return baseDefeat, defeatanimation
end

return Player