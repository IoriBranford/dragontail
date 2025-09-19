local GamePhase = require "Dragontail.GamePhase"
local GuiActions= require "Gui.GuiActions"
local GameGuiActions = class(GuiActions)

function GameGuiActions.unpauseGame()
    GamePhase.setPaused(false)
end

function GameGuiActions.restartStage()
    love.event.loadphase("Dragontail.GamePhase")
end

function GameGuiActions.quit()
    love.event.quit()
end

return GameGuiActions