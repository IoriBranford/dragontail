local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"

---@class PlayerHeld:Behavior
---@field character Player
local PlayerHeld = pooledclass(Behavior)
PlayerHeld._nrec = Behavior._nrec + 1

function PlayerHeld:start(holder)
    local player = self.character
    player:stopAttack()
    Guard.stopGuarding(player)
    player.velx, player.vely = 0, 0
    self.holdtime = holder.holdstrength or player.timetobreakhold or 120
end

function PlayerHeld:fixedupdate()
    local player = self.character
    local holder = player.heldby

    if not holder or not HoldOpponent.isHolding(holder, player) then
        return "walk"
    end

    local strugglex, struggley = player:getParryVector()
    if strugglex and struggley then
        self.holdtime = self.holdtime - 1
        player.velx = player.velx + strugglex*4
        player.vely = player.vely + struggley*4
    end
    if player:consumeActionRecentlyPressed("attack") then
        self.holdtime = self.holdtime - 1
        player.velz = player.velz + 2
    end
    if player:consumeActionRecentlyPressed("sprint") then
        self.holdtime = self.holdtime - 1
        player.velz = player.velz + 2
    end
    if player:consumeActionRecentlyPressed("fly") then
        self.holdtime = self.holdtime - 1
        player.velz = player.velz + 2
    end

    self.holdtime = self.holdtime - 1
    if self.holdtime <= 0 then
        return "breakaway", holder
    end
end

return PlayerHeld