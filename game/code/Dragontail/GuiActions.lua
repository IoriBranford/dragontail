local GuiActions= require "Gui.GuiActions"
local Characters= require "Dragontail.Stage.Characters"
local Audio     = require "System.Audio"
local Config    = require "System.Config"

local GameGuiActions = class(GuiActions)

function GameGuiActions.openTitleMainMenu()
    local TitlePhase= require "Dragontail.TitlePhase"
    TitlePhase:pushMainMenu()
end

function GameGuiActions.playSelectedMusic()
    local music = Audio.playMusic("ccdata/music/"..Config.soundtrack..".ogg")
    if music then
        music:setLooping(true)
    end
end

function GameGuiActions.unpauseGame()
    local GamePhase = require "Dragontail.GamePhase"
    GamePhase:setPaused(false)
end

function GameGuiActions.refillPlayers()
    Characters.refillPlayers()
end

function GameGuiActions.clearEnemies()
    Characters.clearEnemies()
end

function GameGuiActions.resetTraining()
    GameGuiActions.unpauseGame()
    Characters.resetTraining()
end

function GameGuiActions.restartStageCheckpoint()
    love.event.newphase("Dragontail.GamePhase")
end

function GameGuiActions.restartStage(gui, element)
    love.event.newphase("Dragontail.GamePhase", "data/stage_banditcave.lua", element.checkpoint or false)
end

function GameGuiActions.startTraining(gui, element)
    love.event.newphase("Dragontail.GamePhase", "data/stage_training.lua")
end

function GameGuiActions.returnToTitle()
    love.event.newphase("Dragontail.TitlePhase", true)
end

function GameGuiActions.quit()
    love.event.quit()
end

return GameGuiActions