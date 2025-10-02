local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Gui          = require "Dragontail.Gui"
local StateMachine = require "Dragontail.Character.Component.StateMachine"

---@class PlayerHeld:Behavior
---@field character Player
local PlayerHeld = pooledclass(Behavior)
PlayerHeld._nrec = Behavior._nrec + 1

local BreakawayStrength = 4

function PlayerHeld:start(holder)
    local player = self.character
    player:stopAttack()
    Guard.stopGuarding(player)
    player.velx, player.vely = 0, 0
    self.holdtime = holder.holdstrength or player.timetobreakhold or 120
    local prompt = Gui:get("gameplay.hud.breakgrabprompt")
    if prompt then
        prompt.visible = true
    end
end

function PlayerHeld:fixedupdate()
    local player = self.character
    local holder = player.heldby

    if not holder or not HoldOpponent.isHolding(holder, player) then
        return "walk"
    end

    local holdtime = self.holdtime
    local strugglex, struggley = player:getParryVector()
    local holddirx, holddiry = player.x - holder.x, player.y - holder.y
    if strugglex and struggley then
        if holddirx == 0 and holddiry == 0 then
            holddiry = 1
        else
            holddirx, holddiry = math.norm(holddirx, holddiry)
        end
        local struggle = BreakawayStrength * math.abs(math.dot(strugglex, struggley, holddirx, holddiry)) + 1
        holdtime = holdtime - struggle
        player.struggleoffset = struggle
    else
        player.struggleoffset = 0
    end

    if self.holdtime ~= holdtime then
        player.animationframe = 1
        player.animationtime = 0
    end

    holdtime = holdtime - 1
    if holdtime <= 0 then
        StateMachine.start(holder, "breakaway", player)
        return "breakaway", holder
    end
    self.holdtime = holdtime

    local prompt = Gui:get("gameplay.hud.breakgrabprompt")
    if prompt then
        local animation = math.abs(holddirx) < math.abs(holddiry) and "y" or "x"
        prompt:changeAnimation(animation)

        local camera = player.camera
        local promptover = animation == "y" and holddiry > 0 and holder or player
        prompt.x = promptover.x - camera.x
        prompt.y = promptover.y - promptover.z - promptover.bodyheight - camera.y
        local x1, y1, x2, y2 = prompt:getExtents()
        if x1 < 0 then
            prompt.x = prompt.x - x1
        end
        if y1 < 0 then
            prompt.y = prompt.y - y1
        end
        if x2 > camera.width then
            prompt.x = prompt.x + camera.width - x2
        end
        if y2 > camera.height then
            prompt.y = prompt.y + camera.height - y2
        end
    end
end

function PlayerHeld:timeout(...)
    local prompt = Gui:get("gameplay.hud.breakgrabprompt")
    if prompt then
        prompt.visible = false
    end
    return ...
end

function PlayerHeld:interrupt(...)
    local prompt = Gui:get("gameplay.hud.breakgrabprompt")
    if prompt then
        prompt.visible = false
    end
    return ...
end

return PlayerHeld