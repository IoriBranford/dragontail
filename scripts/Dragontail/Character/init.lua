local SceneObject = require "System.SceneObject"
local Assets      = require "System.Assets"
local Sheets      = require "Data.Sheets"
local Audio       = require "System.Audio"
local pi = math.pi
local floor = math.floor
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local asin = math.asin
local lensq = math.lensq
local dot = math.dot
local min = math.min
local testcircles = math.testcircles

local Character = {}

Character.metatable = {
    __index = Character,
    __lt = SceneObject.__lt
}
local Metatable = Character.metatable

function Character.init(ch, chprefab)
    if chprefab then
        for k,v in pairs(chprefab) do
            ch[k] = v
        end
    end
    local type = ch.type
    if type then
        Sheets.fillBlanks(ch, type)
    end
    ch.health = ch.health or 1
    ch.maxhealth = ch.maxhealth or ch.health
    ch.x = ch.x or 0
    ch.y = ch.y or 0
    ch.z = ch.z or 0
    ch.velx = ch.velx or 0
    ch.vely = ch.vely or 0
    ch.velz = ch.velz or 0
    ch.speed = ch.speed or 1
    ch.bodyradius = ch.bodyradius or 1
    ch.attackradius = ch.attackradius or 0
    -- ch.attackangle = ch.attackangle or 0
    ch.attackarc = ch.attackarc or 0
    ch.attackdamage = ch.attackdamage or 1
    ch.attackstun = ch.attackstun or 1
    ch.hitstun = ch.hitstun or 0
    return setmetatable(ch, Metatable)
end
local init = Character.init

function Character.new(chprefab)
    return init({}, chprefab)
end

function Character:addToScene(scene)
    local asepritefile = self.asepritefile
    local aseprite = asepritefile and Assets.get(asepritefile)
    if aseprite then
        self.animation = self.animation or "stand1"
        self.sprite = scene:addManualAnimatedAseprite(aseprite, self.animation, 1,
            self.x, self.y, self.z,
            0, 1, 1, self.spriteoriginx or 0, self.spriteoriginy or 0)
        local baseDraw = self.sprite.draw
        self.sprite.draw = function(sprite)
            self:drawShadow()
            baseDraw(sprite)
        end
    end
end

function Character:move(dx, dy)
    self.x = self.x + dx * self.speed
    self.y = self.y + dy * self.speed
end

function Character:accelerate(ax, ay)
    self.velx = self.velx + ax
    self.vely = self.vely + ay
end

function Character:accelerateTowardsVel(targetvelx, targetvely, t, e)
    assert(t > 0, "t <= 0")
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
end

function Character:updatePosition()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
end

function Character:fixedupdate()
    if self.hitstun > 0 then
        self.hitstun = self.hitstun - 1
        if self.hitstun > 0 then
            return
        end
    end
    self:runAi()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
    local sprite = self.sprite
    if sprite then
        if sprite.animate then
            sprite:animate(1)
        end
    end
end

function Character:update(dsecs, fixedfrac)
    local sprite = self.sprite
    if sprite then
        sprite.ox = self.spriteoriginx + 2*math.sin(self.hitstun)
        sprite:updateFromUnit(self, fixedfrac)
    end
end

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*pi, 2*pi) - pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*pi, 2*pi) - pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:getBoundsPenetration(bx, by, bw, bh)
    local x, y = self.x, self.y
    local bodyradius = self.bodyradius
    local dx, dy, dw, dh = x - bx, y - by, bw - bodyradius, bh - bodyradius
    local penex, peney
    if dx < bodyradius then
        penex = dx - bodyradius
    elseif dx > dw then
        penex = dx - dw
    end
    if dy < bodyradius then
        peney = dy - bodyradius
    elseif dy > dh then
        peney = dy - dh
    end
    return penex, peney
end

function Character:keepInBounds(bx, by, bw, bh, bounce)
    local penex, peney = self:getBoundsPenetration(bx, by, bw, bh)
    bounce = bounce or 0
    if penex then
        self.x = self.x - penex
        self.velx = bounce * -self.velx
    end
    if peney then
        self.y = self.y - peney
        self.vely = bounce * -self.vely
    end
    return penex, peney
end

function Character:testBodyCollision(other)
    return testcircles(self.x, self.y, self.bodyradius, other.x, other.y, other.bodyradius)
end

function Character:collideWithCharacterBody(other)
    if other.health < 0 then
        return
    end
    local distsq = self:testBodyCollision(other)
    if distsq then
        local radii = self.bodyradius + other.bodyradius
        local dist = math.sqrt(distsq)
        local dx, dy = self.x - other.x, self.y - other.y
        local normx, normy = dx/dist, dy/dist
        self.x = other.x + normx*radii
        self.y = other.y + normy*radii
        return dx, dy
    end
end

function Character:collideWithCharacterAttack(other)
    if self.hitstun > 0 or self.health < 0 then
        return
    end
    local attackangle = other.attackangle
    if not attackangle then
        return
    end
    local dx, dy = self.x - other.x, self.y - other.y
    local distsq = lensq(dx, dy)
    local bodyradius = self.bodyradius
    local radii = bodyradius + other.attackradius
    local radiisq = radii * radii
    if distsq <= radiisq then
        local dist = sqrt(distsq)
        local attackx, attacky = cos(attackangle), sin(attackangle)
        local dotDA = dot(dx, dy, attackx, attacky)
        local attackarc = other.attackarc
        local bodyarc = asin(bodyradius/dist)
        if dotDA >= dist * cos(bodyarc + attackarc/2) then
            local sound = other.hitsound
            if self.health == 0 then
                sound = other.knockoutsound or sound
                if self.knockedai then
                    self:startAi(self.knockedai, attackx, attacky)
                else
                    self:startAi(self.defeatai or "defeat")
                end
            else
                self.health = self.health - other.attackdamage
                self.hitstun = other.attackstun
                if self.health <= 0 then
                    self.health = 0
                    if self.stunai then
                        self:startAi(self.stunai or "stun")
                    else
                        self:startAi(self.defeatai or "defeat")
                    end
                else
                    self:startAi(self.hurtai or "hurt", self.hurtrecoverai)
                end
            end
            Audio.play(sound)
            return true
        end
    end
end

function Character:heal(amount)
    self.health = min(self.health + amount, self.maxhealth)
end

function Character.getDirectionalAnimation_angle(basename, angle, numanimations)
    numanimations = numanimations or 4
    local faceangle = angle + (pi / numanimations)
    local facedir = floor(faceangle * numanimations / pi / 2)
    facedir = ((facedir % numanimations) + numanimations) % numanimations
    return basename..facedir
end

function Character:drawShadow()
    local x, y = self.x, self.y+self.z
    love.graphics.setColor(0,0,0,.25)

    love.graphics.circle("fill", x, y, self.bodyradius)

    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius > 0 and attackangle then
        local attackarc = self.attackarc
        if attackarc > 0 then
            love.graphics.arc("fill", x, y, attackradius, attackangle - attackarc/2, attackangle + attackarc/2)
        else
            love.graphics.line(x, y, x + cos(attackangle), y + sin(attackangle))
        end
    end

    love.graphics.setColor(1,1,1,1)
end

function Character:disappear()
    self.disappeared = true
    if self.sprite then
        self.sprite:markRemove()
    end
end

return Character