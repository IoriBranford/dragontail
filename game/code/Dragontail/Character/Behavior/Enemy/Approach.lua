local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Movement = require "Component.Movement"

---@class Approach:Behavior
---@field character Enemy
local Approach = pooledclass(Behavior)
Approach._nrec = Behavior._nrec + 3

---@param targetx number|Character
---@param targety number?
function Approach:start(targetx, targety, nextstate)
    local enemy = self.character
    if nextstate then
        enemy.nextstate = nextstate
    else
        nextstate = enemy.nextstate
    end
    if type(targetx) == "table" then
        local target = targetx
        self.target = target
        self.attackerslot = enemy:findApproachSlot(target, nextstate)
    else
        self.targetx = targetx
        self.targety = targety
    end
    self.result = nil
end

function Approach:fixedupdate()
    local enemy = self.character
    enemy:stayOnCameraOnceEntered()

    local destx, desty
    local targetx, targety
    local target = self.target
    if target then
        targetx, targety = target.x, target.y
        local attackerslot = self.attackerslot
        if attackerslot then
            destx, desty = enemy:getAttackerSlotPosition(attackerslot, enemy.nextstate)
        end
    else
        targetx, targety = self.targetx, self.targety
        destx, desty = targetx, targety
    end

    local speed = enemy.speed or 2
    self.result = not (destx and desty) and "canceled"
        or math.distsq(enemy.x, enemy.y, destx, desty) < speed and "reached"
    if self.result then
        return self:timeout()
    end

    if math.distsq(enemy.x, enemy.y, targetx, targety) > 320*320 then
        speed = speed * 1.5
    end

    destx, desty = enemy:navigateAroundSolid(destx, desty)
    Face.faceObject(enemy, target, enemy.state.animation, enemy.animationframe)
    local state, a, b, c, d, e, f = enemy:duringApproach(target)
    if state then
        return state, a, b, c, d, e, f
    end
    enemy.velx, enemy.vely = Movement.getVelocity_speed(enemy.x, enemy.y, destx, desty, speed)
end

function Approach:timeout(nextstate, ...)
    local enemy = self.character
    -- local opponent = enemy.opponents[1] ---@type Player
    -- if enemy:couldAttackOpponent(opponent, self.nextaction) then
    --     opponent.attacker = enemy
    --     Face.facePosition(enemy, opponent.x, opponent.y)
    --     return enemy.nextstate
    -- end
    -- enemy:debugPrint_couldAttackOpponent(opponent, nextattacktype)

    local targetx, targety
    local target = self.target
    if target then
        targetx = target
        Face.faceObject(enemy, target)
    else
        targetx, targety = self.targetx, self.targety
        Face.facePosition(enemy, targetx, targety)
    end

    if self.result ~= "reached" then
        return "approach", targetx, targety, enemy.nextstate
    end
    if nextstate then
        return nextstate, ...
    end
    return "stand", 10
end

return Approach