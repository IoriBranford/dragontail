local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Component.Guard"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Mana         = require "Dragontail.Character.Component.Mana"

---@class PlayerHeld:Behavior
---@field character Player
local PlayerHeld = pooledclass(Behavior)
PlayerHeld._nrec = Behavior._nrec + 1

function PlayerHeld:start(holder)
    local player = self.character
    if not HoldOpponent.isHolding(holder, player) then
        HoldOpponent.startHolding(holder, player)
    end

    player:stopAttack() ; player:unassignSelfAsAttacker()
    Guard.stopGuarding(player)
    player.velx, player.vely = 0, 0
end

function PlayerHeld:fixedupdate()
    local player = self.character
    local holder = player.heldby

    if player.weaponinhand then
        if player:consumeActionRecentlyPressed("attack") then
            local attackangle = math2.topolar(holder.x - player.x,
                holder.y - player.y)
            player.faceangle = attackangle
            player.facedestangle = attackangle
            StateMachine.start(holder, "breakaway", player)
            return "throwWeapon", attackangle, 1
        end
    end

    local chargedattack, attackangle
    chargedattack, attackangle = player:getActivatedChargeAttackTowardsJoystick()
    if chargedattack then
        StateMachine.start(holder, "breakaway", player)
        Mana.releaseCharge(player)
        return chargedattack, attackangle
    end

    if not holder or not HoldOpponent.isHolding(holder, player) then
        return "walk"
    end

    local struggle = 0
    local strugglex, struggley = player:getParryVector()
    local holddirx, holddiry = math.cos(holder.holdangle), math.sin(holder.holdangle)
    if strugglex and struggley then
        local strugglestrength = player.strugglestrength or 3
        struggle = strugglestrength * math.abs(math.dot(strugglex, struggley, holddirx, holddiry))
        player.struggleoffset = struggle
    else
        struggle = -1
        player.struggleoffset = 0
    end

    if struggle > 0 then
        player.animationframe = 1
        player.animationtime = 0
    end

    local holdstrength = HoldOpponent.weakenHold(holder, struggle)
    if holdstrength <= 0 then
        StateMachine.start(holder, "brokenaway", player)
        love.event.send("playerunheld")
        return "breakaway", holder
    end

    love.event.send("playerheld", player, holder)
end

function PlayerHeld:timeout(...)
    love.event.send("playerunheld")
    return ...
end

function PlayerHeld:interrupt(...)
    love.event.send("playerunheld")
    return ...
end

return PlayerHeld