local GamePhase = require "Dragontail.GamePhase"
local GuiActions= require "Gui.GuiActions"
local Characters= require "Dragontail.Stage.Characters"

local GameGuiActions = class(GuiActions)

function GameGuiActions.unpauseGame()
    GamePhase.setPaused(false)
end

function GameGuiActions.healPlayers()
    Characters.healPlayers()
end

function GameGuiActions.restartStageCheckpoint()
    love.event.loadphase("Dragontail.GamePhase")
end

function GameGuiActions.restartStage()
    love.event.loadphase("Dragontail.GamePhase", false, false)
end

function GameGuiActions.quit()
    love.event.quit()
end

return GameGuiActions