local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Component.Guard"
local Combo    = require "Dragontail.Character.Component.Combo"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local Player       = require "Dragontail.Character.Player"
local Mana         = require "Dragontail.Character.Component.Mana"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Body         = require "Dragontail.Character.Component.Body"

---@class PlayerHoldEnemy:Behavior
---@field character Player
local PlayerHoldEnemy = pooledclass(Behavior)
PlayerHoldEnemy._nrec = Behavior._nrec + 2

function PlayerHoldEnemy:start(enemy)
    local player = self.character
    enemy = enemy or player.heldopponent
    local isfrombehind = false

    if enemy then
        isfrombehind = math.dot(math.cos(enemy.faceangle), math.sin(enemy.faceangle),
            math.cos(player.faceangle), math.sin(player.faceangle)) >= 0
        if isfrombehind then
        elseif Guard.isPointInGuardArc(enemy, player.x, player.y) then
        end
        if player.heldopponent ~= enemy then
            HoldOpponent.startHolding(player, enemy, player.holdangle)
        end
    end

    player:stopAttack() ; player:unassignSelfAsAttacker()
    self.holddestangle = player.holdangle
    self.isfrombehind = isfrombehind
end

function PlayerHoldEnemy:fixedupdate()
    local player = self.character
    local enemy = player.heldopponent
    if not enemy or not HoldOpponent.isHolding(player, enemy) then
        return "brokenaway", enemy
    end

    local inx, iny = player:getJoystick()
    local normalattackpressed = player:isActionRecentlyPressed("attack")
    local runpressed = player:isActionDownAndRecentlyPressed("sprint")
    local targetvelx, targetvely = 0, 0
    local speed = player.speed or 2
    if inx ~= 0 or iny ~= 0 then
        inx, iny = math.norm(inx, iny)
        self.holddestangle = math.atan2(iny, inx)
        targetvelx = inx * speed
        targetvely = iny * speed
    end

    Body.forceTowardsVelXY(player, targetvelx, targetvely, player.accel)
    local velx, vely = player.velx, player.vely

    local holdturnspeed = player.faceturnspeed or (math.pi/64)
    local holdangle = math.rotangletowards(player.holdangle, self.holddestangle, holdturnspeed)
    player.holdangle = holdangle
    HoldOpponent.updateVelocities(player)
    enemy.velz = 0

    local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
    Face.faceAngle(player, holdangle, holdanimation)

    local enemyfaceangle = self.isfrombehind and player.faceangle or (player.faceangle + math.pi)
    Face.faceAngle(enemy, enemyfaceangle, "Hurt")

    -- player.runenergy = math.min(player.runenergymax, player.runenergy + 1)
    if runpressed then --and player.runenergy >= player.runenergycost then
        Combo.reset(player)
        return "running-with-enemy", enemy, true
    end
    local chargedattackstate = not player.attackbutton.down and player:getChargedAttack(Player.ChargeAttackStates)
    if chargedattackstate then
        Mana.releaseCharge(player)
        HoldOpponent.stopHolding(player, enemy)
        return chargedattackstate, holdangle
    end
    -- if fireattackpressed then
    --     if Mana.canAffordAttack(self, "flaming-spinning-throw") then
    --         Combo.reset(self)
    --         return "flaming-spinning-throw", holdangle, enemy
    --     end
    -- end
    if normalattackpressed and (inx ~= 0 or iny ~= 0) then
        Combo.reset(player)
        return "spinning-throw", holdangle, enemy
    end
    if normalattackpressed then
        return player:doComboAttack(holdangle, enemy, inx ~= 0 or iny ~= 0)
    end

    if player:consumeActionDownAndRecentlyPressed("fly") then
        return "holdJump", true
    end
end

return PlayerHoldEnemy