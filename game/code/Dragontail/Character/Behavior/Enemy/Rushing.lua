local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Body     = require "Dragontail.Character.Component.Body"
local Attacker = require "Dragontail.Character.Component.Attacker"

---@class Rushing:Behavior
---@field character Enemy
local Rushing = pooledclass(Behavior)
Rushing._nrec = 2

---@param target Character
function Rushing:start(target, nextstate)
    local enemy = self.character
    if nextstate then
        enemy.nextstate = nextstate
    else
        nextstate = enemy.nextstate
    end
    self.target = target or enemy.opponents[1]
    self.t = 0
end

---@return string? nextstate
---@return any ...
function Rushing:fixedupdate()
    local enemy = self.character
    local target = self.target
    local x, y = enemy.x, enemy.y
    local dsq = math.distsq(x, y, target.x, target.y)
    local speed = enemy.speed or 1
    local nextstate = enemy.statetable[enemy.nextstate]
    local closeenoughdist = math.max(speed,
        nextstate and nextstate.maxtargetdist or 1)
    if dsq <= closeenoughdist*closeenoughdist then
        return self:timeout(enemy.nextstate)
    end

    local faceangle = Face.turnTowardsObject(enemy, target, nil,
        enemy.state.animation, enemy.state.frame1, enemy.state.loopframe)

    local attack = enemy.attack
    if attack then
        Attacker.startAttack(enemy, faceangle)
    else
        Attacker.stopAttack(enemy)
    end

    local velx = math.cos(faceangle) * speed
    local vely = math.sin(faceangle) * speed
    Body.forceTowardsVelXY(enemy, velx, vely, enemy.accel)

    local t = self.t + 1
    enemy:makePeriodicAfterImage(t, enemy.afterimageinterval)
    self.t = t
end

---@return string? nextstate
---@return any ...
function Rushing:interrupt(nextstate, ...)
    local enemy = self.character
    Attacker.stopAttack(enemy)
    return nextstate, ...
end

---@return string? nextstate
---@return any ...
function Rushing:timeout(nextstate, ...)
    local enemy = self.character
    Attacker.stopAttack(enemy)
    return nextstate, ...
end

---@param fixedfrac number
function Rushing:draw(fixedfrac)
end

return Rushing