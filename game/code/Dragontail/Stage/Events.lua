local Characters = require "Dragontail.Stage.Characters"
local State      = require "Dragontail.Character.State"

---@module 'Dragontail.Stage.Events'
local Events = {}

function Events.playerEnterNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    local players = Characters.getGroup("players")
    ---@cast players Player[]
    local warpentrance = room.playerwarpentrance
    for _, player in ipairs(players) do
        State.start(player, "eventWalkTo", warpentrance.x, warpentrance.y)
    end
    local t = 0
    coroutine.waitfor(function()
        t = t + 1
        if t >= 600 then
            return true
        end
        for _, player in ipairs(players) do
            if player.x ~= warpentrance.x or player.y ~= warpentrance.y then
                return false
            end
        end
        return true
    end)
    for _, player in ipairs(players) do
        State.start(player, "control")
    end
end

return Events