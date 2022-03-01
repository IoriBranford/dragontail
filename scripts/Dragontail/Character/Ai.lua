local Character = require "Dragontail.Character"
local Movement  = require "Object.Movement"
local co_create = coroutine.create
local yield = coroutine.yield
local resume = coroutine.resume
local status = coroutine.status
local wait = coroutine.wait
local waitfor = coroutine.waitfor
local pi = math.pi
local Ai = {}

function Ai:stand(duration)
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local i = 1
    waitfor(function()
        local opponent = self.opponent
        local destx, desty = opponent.x, opponent.y
        local faceangle = math.atan2(desty - y, destx - x) + (pi / 4)
        local facedir = math.floor(faceangle * 2 / pi)
        facedir = (facedir + 4) % 4
        local standanimation = "stand"..facedir
        self.sprite:changeAsepriteAnimation(standanimation)
        i = i + 1
        return i > duration
    end)
    return "approach"
end

function Ai:approach()
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    local tooppoangle = math.atan2(tooppoy, tooppox)
    local destanglefromoppo = tooppoangle + love.math.random(-1, 1)*pi/2
    local attackradius = (self.attackradius or 32) + opponent.bodyradius
    local destx = oppox + math.cos(destanglefromoppo) * attackradius
    local desty = oppoy + math.sin(destanglefromoppo) * attackradius
    local speed = self.speed or 2
    local faceangle = math.atan2(desty - y, destx - x) + (pi / 4)
    local facedir = math.floor(faceangle * 2 / pi)
    facedir = (facedir + 4) % 4
    local walkanimation = "walk"..facedir
    self.sprite:changeAsepriteAnimation(walkanimation)
    coroutine.waitfor(function()
        x, y = self.x, self.y
        if x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)

    -- oppox, oppoy = opponent.x, opponent.y
    -- tooppox, tooppoy = oppox - x, oppoy - y
    -- if math.distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
    --     return "attack"
    -- end
    return "stand", 60
end

function Ai:attack()
    -- throw attack
    -- return to walk
end

function Ai:hurt()
    while self.hitstun > 0 do
        yield()
    end
    if self.health <= 0 then
        return "dizzy", 300
    else
        return "stand", 60
    end
end

function Ai:dizzy(duration)
    wait(duration)
    return "defeat"
end

function Ai:spin()
end

function Ai:defeat()
    -- remove self
end

function Character:startAi(ainame, ...)
    local f = Ai[ainame]
    if not f then
        error("No AI function "..ainame)
    end
    local ai = co_create(f)
    self.ai = ai
    resume(ai, self, ...)
end

function Character:runAi()
    local ai = self.ai
    if not ai then
        return
    end
    local ok, nextainame, a, b, c, d, e = resume(ai, self)
    assert(ok, nextainame)
    if nextainame then
        self:startAi(nextainame, a, b, c, d, e)
    elseif status(ai) == "dead" then
        self.ai = nil
    end
end

return Character