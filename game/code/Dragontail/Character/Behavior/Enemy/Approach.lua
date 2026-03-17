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
        return self:timeout(enemy.nextstate)
    end

    destx, desty = enemy:navigateAroundSolid(destx, desty)
    self.destx, self.desty = destx, desty
    Face.faceObject(enemy, target, enemy.state.animation, enemy.animationframe)
    local state, a, b, c, d, e, f = enemy:duringApproach(target)
    if state then
        return state, a, b, c, d, e, f
    end
    enemy.velx, enemy.vely = Movement.getVelocity_speed(enemy.x, enemy.y, destx, desty, speed)
end

function Approach:timeout(nextstate, ...)
    local enemy = self.character

    local targetx, targety
    local target = self.target
    local result = self.result
    if target then
        targetx = target
        Face.faceObject(enemy, target)
        if result == "reached" then
            if enemy:canDoToTarget(target, nextstate) then
                local nextstatedata = enemy.statetable[nextstate]
                if nextstatedata and nextstatedata.attack then
                    target.attacker = enemy
                end
            else
                -- result = "canceled"
                nextstate = enemy.recoverai or "stand"
            end
            -- enemy:debugPrint_canDoToTarget(target, nextstate)
        end
    else
        targetx, targety = self.targetx, self.targety
        Face.facePosition(enemy, targetx, targety)
    end

    if result ~= "reached" then
        return "approach", targetx, targety, nextstate
    end
    if nextstate then
        return nextstate, ...
    end
    return "stand", 10
end

function Approach:debugdraw()
    local enemy = self.character
    local destx, desty = self.destx, self.desty
    local z = enemy.z
    local x1, y1 = enemy.x, enemy.y - z
    local attackerslot = self.attackerslot
    if attackerslot then
        love.graphics.setColor(1,0,0,1)
        local x2, y2, z2 = attackerslot:getPosition(attackerslot.hitdist or attackerslot.length)
        love.graphics.line(attackerslot.x, attackerslot.y - z, x2, y2-z)
    end
    love.graphics.setColor(1,1,1,1)
    if destx and desty then
        local x2, y2 = destx, desty - z
        love.graphics.line(x1, y1, x2, y2)
        love.graphics.circle("fill", x2, y2, 2)
        love.graphics.printf(tostring(math.dist(x1, y1, x2, y2)), x1, y1, love.graphics.getWidth(), "center")
    end
end

return Approach