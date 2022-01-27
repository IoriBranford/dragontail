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
    self.x = self.x + dx
    self.y = self.y + dy
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

return Character