local Characters = require "Dragontail.Stage.Characters"
local StateMachine      = require "Dragontail.Character.Component.StateMachine"
local Body              = require "Dragontail.Character.Component.Body"

---@module 'Dragontail.Stage.Sequences'
local Sequences = {}

function Sequences.introBanditStage()
    Sequences.playerEnterArea()
end

function Sequences.playerExitToNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    assert(room.donewhenenemiesleft < 0, "This sequence depends on the room not ending when cleared of enemies. Set room's donewhenenemiesleft to a negative value to use this sequence.")
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        StateMachine.start(player, "sequenceWalkTo", player.x, player.y)--, TimeLimit)
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

function Sequences.playerEnterArea()
    local players = Characters.getGroup("players")

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("open")
    coroutine.waitfor(function() return wipe:isDone() end)

    for _, player in ipairs(players) do
        StateMachine.start(player, "walk")
    end
end

function Sequences.playerBreakIntoNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    if room.donewhenenemiesleft >= 0 then
        room.donewhenenemiesleft = -1
    end
    local exit = room.exit
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        StateMachine.start(player, "sequenceWalkTo", room.exit)--, TimeLimit)
    end

    local exitdoor = exit and exit.door

    local playeratdest = coroutine.waitfor(function()
        for _, player in ipairs(players) do
            if not exit or exitdoor and Body.collideWith(player, exitdoor)
            or player.x == exit.x or player.y == exit.y then
                return player
            end
        end
    end)

    if exitdoor then
        StateMachine.start(exitdoor, exitdoor.defeatai or "containerBreak")
    end

    if playeratdest then
        StateMachine.start(playeratdest, "sequenceTailSwing")
        coroutine.waitfor(function()
            return not playeratdest.state or playeratdest.state.state ~= "sequenceTailSwing"
        end)
    end

    local Gui        = require "Dragontail.Gui"
    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    -- Characters.clearEnemies()
    wipe:start("close")
    coroutine.waitfor(function() return wipe:isDone() end)

    local camerawarp = room.camerawarpwhendone
    Stage.warpCamera(camerawarp.x, camerawarp.y)
    Stage.openNextRoom()
end

function Sequences.unlockDoorToNextArea()
    local Stage = require "Dragontail.Stage"
    local room = Stage.getCurrentRoom()
    local door = room.exitdoor
    StateMachine.start(door, "furnitureToBreak")
end

return Sequences