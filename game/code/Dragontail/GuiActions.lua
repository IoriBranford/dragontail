local GamePhase = require "Dragontail.GamePhase"
local GameGuiActions = {}

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