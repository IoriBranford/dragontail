local Character = require "Dragontail.Character"
local Movement  = require "Object.Movement"
local Audio     = require "System.Audio"
local Sheets    = require "Data.Sheets"
local co_create = coroutine.create
local yield = coroutine.yield
local resume = coroutine.resume
local status = coroutine.status
local wait = coroutine.wait
local waitfor = coroutine.waitfor
local distsq = math.distsq
local pi = math.pi
local floor = math.floor
local atan2 = math.atan2
local random = love.math.random
local cos = math.cos
local sin = math.sin
local Ai = {}

local function moveTo(self, destx, desty, speed)
    waitfor(function()
        local x, y = self.x, self.y
        if x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)
end

function Ai:stand(duration)
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local i = 1
    local opponent = self.opponent
    local oppox, oppoy
    waitfor(function()
        oppox, oppoy = opponent.x, opponent.y
        local faceangle = atan2(oppoy - y, oppox - x)
        local standanimation = self.getDirectionalAnimation_angle("stand", faceangle)
        self.sprite:changeAsepriteAnimation(standanimation)
        i = i + 1
        return i > duration
    end)

    local attackradius = (self.attackradius or 32) + opponent.bodyradius
    if math.distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        return "attack"
    end
    return "approach"
end

function Ai:approach()
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y

    -- choose dest
    local destanglefromoppo = random(4)*pi/2
    local attackradius = (self.attackradius or 32) + opponent.bodyradius
    local destx = oppox + cos(destanglefromoppo) * attackradius
    local desty = oppoy + sin(destanglefromoppo) * attackradius

    -- choose animation
    local todestangle = atan2(desty - y, destx - x)
    local walkanimation = self.getDirectionalAnimation_angle("walk", todestangle)
    self.sprite:changeAsepriteAnimation(walkanimation)

    local speed = self.speed or 2
    if distsq(x, y, oppox, oppoy) > 320*320 then
        speed = speed * 1.5
    end
    moveTo(self, destx, desty, speed)
    return "stand", 10
end

function Ai:attack(attackname)
    attackname = attackname or "attack"
    self.velx, self.vely = 0, 0

    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    local tooppoangle = atan2(tooppoy, tooppox)
    local attackproperties = Sheets.get(self.type.."-"..attackname)
    if attackproperties then
        Audio.play(attackproperties.windupsound)
    end

    local animation = self.getDirectionalAnimation_angle(attackname.."A", tooppoangle)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
    wait(24)

    if attackproperties then
        Audio.play(attackproperties.swingsound)
    end
    self.attackangle = floor((tooppoangle + (pi/4)) / (pi/2)) * pi/2

    animation = self.getDirectionalAnimation_angle(attackname.."B", tooppoangle)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
    wait(24)

    self.attackangle = nil

    return "stand", 20
end

function Ai:hurt()
    waitfor(function()
        return self.hitstun <= 0
    end)
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
    local ok, msg = resume(ai, self, ...)
    assert(ok, msg)
    if status(ai) == "dead" then
        ai = nil
    end
    self.ai = ai
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