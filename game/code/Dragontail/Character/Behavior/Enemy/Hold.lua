local Combo = require "Dragontail.Character.Component.Combo"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Behavior     = require "Dragontail.Character.Behavior"

---@class EnemyHold:Behavior
---@field character Enemy
local EnemyHold = pooledclass(Behavior)
EnemyHold._nrec = Behavior._nrec + 2

function EnemyHold:start(player)
    local enemy = self.character
    local holddirx, holddiry = player.x - enemy.x, player.y - enemy.y
    if holddirx == 0 and holddiry == 0 then
        holddirx, holddiry = math.cos(enemy.faceangle), math.sin(enemy.faceangle)
    else
        holddirx, holddiry = math.norm(holddirx, holddiry)
    end

    enemy.holdangle = math.atan2(holddiry, holddirx)
    local animationdirections = enemy.animationdirections or 4
    local holdangleinterval = 2*math.pi/animationdirections
    self.holddestangle = math.floor(enemy.holdangle/holdangleinterval) * holdangleinterval
    self.isfrombehind = math.dot(holddirx, holddiry,
        math.cos(player.faceangle), math.sin(player.faceangle)) >= 0

    enemy:stopAttack()
    if enemy.heldopponent ~= player then
        Combo.reset(enemy)
        HoldOpponent.startHolding(enemy, player)
    end

    self.holdtime = 0
end

function EnemyHold:fixedupdate()
    local enemy = self.character
    local player = enemy.heldopponent
    if not player or not HoldOpponent.isHolding(enemy, player) then
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

    --- TODO enemy's decision to attack
    self.holdtime = self.holdtime + 1
    local normalattackpressed = self.holdtime >= 100
    if normalattackpressed then
        HoldOpponent.stopHolding(enemy, player)
        return "shield-bash2"
    end

    --- TODO enemy's decision to run with player
    local runpressed = false
    if runpressed then
        Combo.reset(enemy)
        return "running-with-enemy", player, true
    end

    holdangle = math.rotangletowards(holdangle, self.holddestangle,
        enemy.faceturnspeed or (math.pi/64))
    enemy.holdangle = holdangle

    enemy:accelerateTowardsVel(targetvelx, targetvely)
    HoldOpponent.updateVelocities(enemy)
    player.velz = 0

    local velx, vely = enemy.velx, enemy.vely
    local holdanimation = enemy.state.animation or
        (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
    Face.faceAngle(enemy, holdangle, holdanimation)

    local opponentfaceangle = holdangle
    if not self.isfrombehind then
        opponentfaceangle =  (opponentfaceangle + math.pi)
    end
    Face.faceAngle(player, opponentfaceangle, player.state.animation or "Hurt")
end

function EnemyHold:timeout()
    local enemy = self.character
    local player = enemy.heldopponent
    if player then
        StateMachine.start(player, "breakaway", enemy)
    end
    return "breakaway", player
end

return EnemyHold