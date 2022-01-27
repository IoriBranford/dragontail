local Character = {}

Character.metatable = {
    __index = Character
}
local Metatable = Character.metatable

function Character.new(chprefab)
    local ch = {}
    if chprefab then
        for k,v in pairs(chprefab) do
            if ch[k] == nil then
                ch[k] = v
            end
        end
    end
    ch.health = ch.health or 1
    ch.x = ch.x or 0
    ch.y = ch.y or 0
    ch.z = ch.z or 0
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

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*math.pi, 2*math.pi) - math.pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*math.pi, 2*math.pi) - math.pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:separateColliding(other)
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

function Character:takeHit(other)
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
        if dot >= dist then
            self.health = self.health - other.attackdamage
            self.hitstun = other.attackstun
        end
    end
end

function Character:draw()
    love.graphics.setColor(.5, .5, 1, .5)
    love.graphics.circle("fill", self.x, self.y, self.bodyradius)
    if self.attackradius > 0 and self.attackarc > 0 then
        love.graphics.setColor(1, .5, .5, .5)
        love.graphics.arc("fill", self.x, self.y, self.attackradius, self.attackangle - self.attackarc/2, self.attackangle + self.attackarc/2)
    end
    love.graphics.setColor(1,1,1)
end

return Character