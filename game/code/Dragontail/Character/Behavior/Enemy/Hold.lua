local Combo = require "Dragontail.Character.Component.Combo"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Behavior     = require "Dragontail.Character.Behavior"
local Guard        = require "Dragontail.Character.Component.Guard"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Component.Body"

---@class EnemyHold:Behavior
---@field character Enemy
local EnemyHold = pooledclass(Behavior)
EnemyHold._nrec = Behavior._nrec + 2

function EnemyHold:start(held)
    local enemy = self.character
    local holddirx, holddiry = held.x - enemy.x, held.y - enemy.y
    if holddirx == 0 and holddiry == 0 then
        holddirx, holddiry = math.cos(enemy.faceangle), math.sin(enemy.faceangle)
    else
        holddirx, holddiry = math.norm(holddirx, holddiry)
    end

    enemy:stopAttack()
    Guard.stopGuarding(enemy)
    if enemy.heldopponent ~= held then
        Combo.reset(enemy)
        HoldOpponent.startHolding(enemy, held, math.atan2(holddiry, holddirx))
    end

    if held.team == "players" then
        enemy.statetime = enemy.statetime * 3
    end
    self.holddestangle = DirectionalAnimation.SnapAngle(enemy.holdangle, enemy.animationdirections)
    if held.faceangle then
        self.isfrombehind = math.dot(holddirx, holddiry,
            math.cos(held.faceangle), math.sin(held.faceangle)) >= 0
    end
end

function EnemyHold:fixedupdate()
    local enemy = self.character
    local held = enemy.heldopponent
    if not held or not HoldOpponent.isHolding(enemy, held) then
        return enemy.recoverai or enemy.initialai
    end

    local holdangle = enemy.holdangle

    --- TODO each enemy's movement and turning while holding
    local targetvelx, targetvely = 0, 0
    -- local inx, iny = 0, 0
    -- local speed = 2
    -- if inx ~= 0 or iny ~= 0 then
    --     inx, iny = math.norm(inx, iny)
    --     self.holddestangle = math.atan2(iny, inx)
    --     targetvelx = inx * speed
    --     targetvely = iny * speed
    -- end

    local opponent = enemy.opponents[1]
    if opponent ~= held then
        local dx, dy = opponent.x - enemy.x, opponent.y - enemy.y
        if dx ~= 0 or dy ~= 0 then
            self.holddestangle = DirectionalAnimation.SnapAngle(
                math.atan2(dy, dx), enemy.numdirections or 4)
        end
    end

    local faceangle = Face.turnTowardsAngle(enemy, self.holddestangle, nil,
        enemy.state.animation, enemy.animationframe, enemy.state.loopframe)
    enemy.holdangle = faceangle

    Body.forceTowardsVelXY(enemy, targetvelx, targetvely, enemy.accel)
    HoldOpponent.updateVelocities(enemy)

    local velx, vely = enemy.velx, enemy.vely
    local holdanimation = enemy.state.animation or
        (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
    Face.faceAngle(enemy, holdangle, holdanimation)

    if held.faceangle then
        local heldfacedestangle = holdangle
        if not self.isfrombehind then
            heldfacedestangle =  (heldfacedestangle + math.pi)
        end
        Face.faceAngle(held, heldfacedestangle, held.state.animation or "Hurt")
    end

    enemy:updateFlash(enemy.statetime)
end

function EnemyHold:interrupt(...)
    local enemy = self.character
    enemy:resetFlash()
    return ...
end

function EnemyHold:timeout(...)
    local enemy = self.character
    enemy:resetFlash()
    return ...
end

return EnemyHold