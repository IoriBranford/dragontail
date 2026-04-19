local GuiActions= require "Gui.GuiActions"
local Characters= require "Dragontail.Stage.Characters"
local Audio     = require "System.Audio"
local Config    = require "System.Config"

local GameGuiActions = class(GuiActions)

function GameGuiActions.playSelectedMusic()
    local music = Audio.playMusic("data/music/"..Config.soundtrack..".ogg")
    if music then
        music:setLooping(true)
    end
end

function GameGuiActions.unpauseGame()
    local GamePhase = require "Dragontail.GamePhase"
    GamePhase.setPaused(false)
end

function GameGuiActions.refillPlayers()
    Characters.refillPlayers()
end

function GameGuiActions.restartStageCheckpoint()
    love.event.loadphase("Dragontail.GamePhase")
end

function GameGuiActions.restartStage(gui, element)
    love.event.loadphase("Dragontail.GamePhase", false, element.checkpoint or false)
end

function GameGuiActions.quit()
    love.event.quit()
end

return GameGuiActions