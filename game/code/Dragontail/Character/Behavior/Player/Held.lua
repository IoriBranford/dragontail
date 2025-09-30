local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Gui          = require "Dragontail.Gui"

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
    local tutor = Gui:get("gameplay.tutor_escapegrab")
    if tutor then
        tutor.visible = true
    end
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

function PlayerHeld:timeout(...)
    local tutor = Gui:get("gameplay.tutor_escapegrab")
    if tutor then
        tutor.visible = false
    end
    return ...
end

function PlayerHeld:interrupt(...)
    local tutor = Gui:get("gameplay.tutor_escapegrab")
    if tutor then
        tutor.visible = false
    end
    return ...
end

return PlayerHeld