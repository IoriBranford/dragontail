local Characters = require "Dragontail.Stage.Characters"
local State      = require "Dragontail.Character.State"

---@module 'Dragontail.Stage.Events'
local Events = {}

function Events.introBanditStage()
    Events.playerEnterArea()
end

function Events.playerExitToNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    assert(room.donewhenenemiesleft < 0, "This event depends on the room not ending when cleared of enemies. Set room's donewhenenemiesleft to a negative value to use this event.")
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        State.start(player, "eventWalkTo", player.x, player.y)--, TimeLimit)
    end

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    Characters.clearEnemies()
    wipe:start("close")
    coroutine.waitfor(function() return wipe:isDone() end)

    local camerawarp = room.camerawarpwhendone
    Stage.warpCamera(camerawarp.x, camerawarp.y)
    Stage.openNextRoom()
end

function Events.playerEnterArea()
    local players = Characters.getGroup("players")

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("open")
    coroutine.waitfor(function() return wipe:isDone() end)

    for _, player in ipairs(players) do
        State.start(player, "control")
    end
end

return Events