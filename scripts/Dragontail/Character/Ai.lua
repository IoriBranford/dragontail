local Character = require "Dragontail.Character"
local Movement  = require "Object.Movement"
local Audio     = require "System.Audio"
local Sheets    = require "Data.Sheets"
local Controls  = require "System.Controls"
local co_create = coroutine.create
local yield = coroutine.yield
local resume = coroutine.resume
local status = coroutine.status
local wait = coroutine.wait
local waitfor = coroutine.waitfor
local norm = math.norm
local distsq = math.distsq
local pi = math.pi
local floor = math.floor
local atan2 = math.atan2
local random = love.math.random
local cos = math.cos
local sin = math.sin
local dot = math.dot
local len = math.len
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

function Ai:playerControl()
    while true do
        local targetvelx, targetvely = Controls.getDirectionInput()
        local b1, b2 = Controls.getButtonsDown()
        local speed = b2 and 4 or 8
        if targetvelx ~= 0 or targetvely ~= 0 then
            targetvelx, targetvely = norm(targetvelx, targetvely)
            targetvelx = targetvelx * speed
            targetvely = targetvely * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, b2 and 8 or 16)

        local velx, vely = self.velx, self.vely
        local veldot = dot(velx, vely, targetvelx, targetvely)
        if (targetvelx ~= 0 or targetvely ~= 0)
        and veldot <= len(velx, vely) * speed * cos(pi/4) then
            self.attackangle = atan2(-targetvely, -targetvelx)
        else
            self.attackangle = nil
        end
        if velx ~= 0 or vely ~= 0 then
            self.sprite:changeAsepriteAnimation("run2")
        else
            self.sprite:changeAsepriteAnimation("stand2")
        end
        yield()
    end
end

function Ai:stand(duration)
    duration = duration or 60
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

    local attackname = "attack" -- TODO decide between multiple
    Sheets.fill(self, self.type.."-"..attackname)
    local attackradius = (self.attackradius or 32) + opponent.bodyradius
    if distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        return "attack"
    end
    return "approach"
end

function Ai:approach()
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local bodyradius = self.bodyradius
    local bounds = self.bounds
    local minx, miny = bounds.x + bodyradius, bounds.y + bodyradius
    local maxx, maxy = bounds.x + bounds.width - bodyradius, bounds.y + bounds.height - bodyradius

    -- choose dest
    local destanglefromoppo = random(4)*pi/2
    local attackradius = (self.attackradius or 32) + opponent.bodyradius
    local destx, desty
    repeat
        destx = oppox + cos(destanglefromoppo) * attackradius
        desty = oppoy + sin(destanglefromoppo) * attackradius
        destanglefromoppo = destanglefromoppo + pi/2
    until minx <= destx and destx <= maxx and miny <= desty and desty <= maxy and destanglefromoppo <= pi*4

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
    Audio.play(self.windupsound)

    local animation = self.getDirectionalAnimation_angle(attackname.."A", tooppoangle)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
    wait(24)

    Audio.play(self.swingsound)
    self.attackangle = floor((tooppoangle + (pi/4)) / (pi/2)) * pi/2

    animation = self.getDirectionalAnimation_angle(attackname.."B", tooppoangle)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
    wait(24)

    self.attackangle = nil

    return "stand", 20
end

function Ai:hurt(recoverai)
    self.attackangle = nil
    Audio.play(self.hurtsound)
    yield()
    return recoverai
end

function Ai:stun(duration)
    self.attackangle = nil
    self.velx, self.vely = 0, 0
    self.sprite:changeAsepriteAnimation("collapseA", 1, "stop")
    Audio.play(self.stunsound)
    duration = duration or 120
    wait(duration)
    return "defeat", "collapseB"
end

function Ai:spin(dirx, diry)
    self.health = -1
    self.sprite:changeAsepriteAnimation("spin")
    local knockedspeed = self.knockedspeed or 8
    self.velx, self.vely = dirx*knockedspeed, diry*knockedspeed
    self.attackangle = nil
    local bounds = self.bounds
    waitfor(function()
        local oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        return oobx or ooby
    end)
    Audio.play(self.bodyslamsound)
    self.hitstun = self.wallslamstun or 20
    yield()
    return "defeat"
end

function Ai:defeat(defeatanimation)
    self.health = -1
    self.attackangle = nil
    self.velx, self.vely = 0, 0
    self.sprite:changeAsepriteAnimation(defeatanimation or "collapse", 1, "stop")
    Audio.play(self.defeatsound)
    wait(12)
    Audio.play(self.bodydropsound)
    wait(60)
    self:disappear()
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