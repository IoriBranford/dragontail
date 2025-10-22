local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Combo    = require "Dragontail.Character.Component.Combo"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local Player       = require "Dragontail.Character.Player"
local Mana         = require "Dragontail.Character.Component.Mana"
local StateMachine = require "Dragontail.Character.Component.StateMachine"

---@class PlayerHoldEnemy:Behavior
---@field character Player
local PlayerHoldEnemy = pooledclass(Behavior)
PlayerHoldEnemy._nrec = Behavior._nrec + 3

function PlayerHoldEnemy:start(enemy)
    local player = self.character
    local time = enemy.timetobreakhold
    local isfrombehind = math.dot(math.cos(enemy.faceangle), math.sin(enemy.faceangle),
        math.cos(player.faceangle), math.sin(player.faceangle)) >= 0
    if isfrombehind then
    elseif Guard.isPointInGuardArc(enemy, player.x, player.y) then
        time = 10
    end
    if player.heldopponent ~= enemy then
        Combo.reset(player)
        HoldOpponent.startHolding(player, enemy)
    end
    player:stopAttack()
    local holddirx, holddiry = enemy.x - player.x, enemy.y - player.y
    if holddirx == 0 and holddiry == 0 then
        holddirx = 1
    else
        holddirx, holddiry = math.norm(holddirx, holddiry)
    end
    local holdangle = math.atan2(holddiry, holddirx)
    local holddestangle = holdangle
    player.holdangle = holdangle
    self.time = time
    self.holddestangle = holddestangle
    self.isfrombehind = isfrombehind
end

function PlayerHoldEnemy:fixedupdate()
    local player = self.character
    local enemy = player.heldopponent
    if not enemy then
        return "walk"
    end

    if self.time then
        self.time = self.time - 1
        if self.time <= 0 then
            StateMachine.start(enemy, "breakaway", player)
            return "breakaway", enemy
        end
    end

    local inx, iny = player:getJoystick()
    local normalattackpressed = player:isActionRecentlyPressed("attack")
    local runpressed = player:isActionDownAndRecentlyPressed("sprint")
    local targetvelx, targetvely = 0, 0
    local speed = 2
    if inx ~= 0 or iny ~= 0 then
        inx, iny = math.norm(inx, iny)
        self.holddestangle = math.atan2(iny, inx)
        targetvelx = inx * speed
        targetvely = iny * speed
    end

    player:accelerateTowardsVelXY(targetvelx, targetvely)
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
end

return PlayerHoldEnemy