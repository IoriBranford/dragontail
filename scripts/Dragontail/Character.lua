local SceneObject = require "System.SceneObject"
local Character = {}

Character.metatable = {
    __index = Character,
    __lt = SceneObject.__lt
}
local Metatable = Character.metatable

function Character.new(chprefab)
    local ch = {}
    if chprefab then
        for k,v in pairs(chprefab) do
            ch[k] = v
        end
    end
    ch.health = ch.health or 1
    ch.x = ch.x or 0
    ch.y = ch.y or 0
    ch.z = ch.z or 0
    ch.velx = ch.velx or 0
    ch.vely = ch.vely or 0
    ch.velz = ch.velz or 0
    ch.speed = ch.speed or 1
    ch.bodyradius = ch.bodyradius or 1
    ch.attackradius = ch.attackradius or 0
    ch.attackangle = ch.attackangle or 0
    ch.attackarc = ch.attackarc or 0
    ch.attackdamage = ch.attackdamage or 1
    ch.attackstun = ch.attackstun or 1
    ch.hitstun = ch.hitstun or 0
    return setmetatable(ch, Metatable)
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
        return
    end
    self.x = self.x + self.velx
    self.y = self.y + self.vely
end

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*math.pi, 2*math.pi) - math.pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*math.pi, 2*math.pi) - math.pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:keepInBounds(bx, by, bw, bh, bounce)
    bounce = bounce or 0
    local x, y = self.x, self.y
    local bodyradius = self.bodyradius
    local dx, dy, dw, dh = x - bx, y - by, bw - bodyradius, bh - bodyradius
    if dx < bodyradius then
        self.x = bx + bodyradius
        self.velx = bounce * -self.velx
    elseif dx > dw then
        self.x = bx + dw
        self.velx = bounce * -self.velx
    end
    if dy < bodyradius then
        self.y = by + bodyradius
        self.vely = bounce * -self.vely
    elseif dy > dh then
        self.y = by + dh
        self.vely = bounce * -self.vely
    end
end

function Character:collideWithCharacterBody(other)
    local dx, dy = self.x - other.x, self.y - other.y
    local distsq = math.lensq(dx, dy)
    local radii = self.bodyradius + other.bodyradius
    local radiisq = radii * radii
    if distsq < radiisq then
        local dist = math.sqrt(distsq)
        local normx, normy = dx/dist, dy/dist
        self.x = other.x + normx*radii
        self.y = other.y + normy*radii
    end
end

function Character:collideWithCharacterAttack(other)
    if self.hitstun > 0 then
        return
    end
    local dx, dy = self.x - other.x, self.y - other.y
    local distsq = math.lensq(dx, dy)
    local radii = self.bodyradius + other.attackradius
    local radiisq = radii * radii
    if distsq < radiisq then
        local dist = math.sqrt(distsq)
        local attackx, attacky = math.cos(other.attackangle), math.sin(other.attackangle)
        local dot = math.dot(dx, dy, attackx, attacky)
        if dot >= dist * math.cos(other.attackarc/2) then
            self.health = self.health - other.attackdamage
            self.hitstun = other.attackstun
            return true
        end
    end
end

function Character:draw()
    love.graphics.setColor(.5, .5, 1, self.hitstun > 0 and .25 or .5)
    love.graphics.circle("fill", self.x, self.y, self.bodyradius)
    if self.attackradius > 0 and self.attackarc > 0 then
        love.graphics.setColor(1, .5, .5, .5)
        love.graphics.arc("fill", self.x, self.y, self.attackradius, self.attackangle - self.attackarc/2, self.attackangle + self.attackarc/2)
    end
    love.graphics.setColor(1,1,1)
end

return Character