local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Component.Guard"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Gui          = require "Dragontail.Gui"
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

    player:stopAttack()
    Guard.stopGuarding(player)
    player.velx, player.vely = 0, 0
end

function PlayerHeld:fixedupdate()
    local player = self.character
    local holder = player.heldby

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
        local strugglestrength = player.strugglestrength or 2
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
        StateMachine.start(holder, "breakaway", player)
        return "breakaway", holder
    end

    local ui = Gui:get("gameplay.hud_breakgrab")
    if ui then
        ui.visible = true
        local axis = math.abs(holddirx) < math.abs(holddiry) and "y" or "x"

        local camera = player.camera
        local promptover = holder--axis == "y" and holddiry > 0 and holder or player
        ui.x = promptover.x - camera.x
        ui.y = promptover.y - promptover.z - promptover.bodyheight - camera.y

        local prompt = ui.prompt
        if prompt then
            prompt:changeAnimation(axis)

            local x1, y1, x2, y2 = prompt:getExtents()
            if ui.x + x1 < 0 then
                ui.x = - x1
            end
            if ui.y + y1 < 0 then
                ui.y = - y1
            end
            if ui.x + x2 > camera.width then
                ui.x = camera.width - x2
            end
            if ui.y + y2 > camera.height then
                ui.y = camera.height - y2
            end
        end

        local initholdstrength = assert(holder.initialholdstrength)
        local progress = 1 - holdstrength/initholdstrength
        local gaugel, gauger, gaugeu, gauged, gaugex, gaugey =
            ui.gaugel, ui.gauger, ui.gaugeu, ui.gauged, ui.gaugex, ui.gaugey
        if gaugel then
            gaugel:setPercent(progress)
            gaugel.visible = axis == "x"
        end
        if gauger then
            gauger:setPercent(progress)
            gauger.visible = axis == "x"
        end
        if gaugeu then
            gaugeu:setPercent(progress)
            gaugeu.visible = axis == "y"
        end
        if gauged then
            gauged:setPercent(progress)
            gauged.visible = axis == "y"
        end
        if gaugex then gaugex.visible = axis == "x" end
        if gaugey then gaugey.visible = axis == "y" end
    end
end

function PlayerHeld:timeout(...)
    local ui = Gui:get("gameplay.hud_breakgrab")
    if ui then
        ui.visible = false
    end
    return ...
end

function PlayerHeld:interrupt(...)
    local ui = Gui:get("gameplay.hud_breakgrab")
    if ui then
        ui.visible = false
    end
    return ...
end

return PlayerHeld