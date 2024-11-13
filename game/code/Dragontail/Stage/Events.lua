local Characters = require "Dragontail.Stage.Characters"
local State      = require "Dragontail.Character.State"

---@module 'Dragontail.Stage.Events'
local Events = {}

function Events.introBanditStage()
    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("open")
    coroutine.waitfor(function() return wipe:isDone() end)
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        State.start(player, "control")
    end
end

function Events.playerExitToNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    local players = Characters.getGroup("players")
    ---@cast players Player[]
    local warpentrance = room.playerwarpentrance
    local TimeLimit = 120
    for _, player in ipairs(players) do
        State.start(player, "eventWalkTo", warpentrance.x, warpentrance.y, TimeLimit)
    end
    coroutine.waitfor(function()
        for _, player in ipairs(players) do
            if not State.isRunning(player)
            or math.distsq(player.x, player.y, warpentrance.x, warpentrance.y) <= 64*64 then
                return true
            end
        end
    end)

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("close")
    coroutine.waitfor(function()
        for _, player in ipairs(players) do
            if State.isRunning(player) then
                return false
            end
        end
        return wipe:isDone()
    end)
end

function Events.playerEnterNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    local players = Characters.getGroup("players")

    local camerawarp = room.camerawarp
    Stage.warpCamera(camerawarp.x, camerawarp.y)

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("open")
    coroutine.waitfor(function() return wipe:isDone() end)

    for _, player in ipairs(players) do
        State.start(player, "control")
    end
end

return Events