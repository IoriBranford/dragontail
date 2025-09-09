local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Movement = require "Component.Movement"

---@class Approach:Behavior
---@field character Enemy
local Approach = pooledclass(Behavior)
Approach._nrec = Behavior._nrec + 3

function Approach:start(nextattacktype)
    local enemy = self.character
    local opponent = enemy.opponents[1] ---@type Player
    self.nextattacktype = nextattacktype
    self.attackerslot = enemy:findAttackerSlot(opponent, nextattacktype)
    self.reached = false
end

function Approach:fixedupdate()
    local enemy = self.character
    local attackerslot = self.attackerslot
    local opponent = attackerslot and attackerslot.target
    local destx, desty
    if attackerslot then
        destx, desty = enemy:getAttackerSlotPosition(attackerslot, self.nextattacktype)
    end

    local speed = enemy.speed or 2
    self.reached = not (destx and desty)
        or math.distsq(enemy.x, enemy.y, destx, desty) < speed
    if self.reached then
        return self:timeout()
    end

    if math.distsq(enemy.x, enemy.y, opponent.x, opponent.y) > 320*320 then
        speed = speed * 1.5
    end

    destx, desty = enemy:navigateAroundSolid(destx, desty)
    Face.faceObject(enemy, opponent, enemy.state.animation, enemy.animationframe)
    local state, a, b, c, d, e, f = enemy:duringApproach(opponent)
    if state then
        return state, a, b, c, d, e, f
    end
    enemy.velx, enemy.vely = Movement.getVelocity_speed(enemy.x, enemy.y, destx, desty, speed)
end

function Approach:timeout()
    local enemy = self.character
    local opponent = enemy.opponents[1] ---@type Player
    if enemy:couldAttackOpponent(opponent, self.nextattacktype) then
        opponent.attacker = enemy
        Face.facePosition(enemy, opponent.x, opponent.y)
        return self.nextattacktype
    end
    -- enemy:debugPrint_couldAttackOpponent(opponent, nextattacktype)

    if self.reached then
        return "stand", 10
    end
    return "stand", 0
end

return Approach