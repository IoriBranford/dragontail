local Canvas= require "System.Canvas"
local Config= require "System.Config"
local Stage = require "Dragontail.Stage"
local GamePhase = {}

function GamePhase.loadphase()
    Canvas.init(Config.basewindowwidth, Config.basewindowheight)
    Stage.init()
end

function GamePhase.quitphase()
    Stage.quit()
end

function GamePhase.fixedupdate()
    Stage.fixedupdate()
end

function GamePhase.resize(w, h)
    Canvas.init(Config.basewindowwidth, Config.basewindowheight)
end

function GamePhase.draw()
    Canvas.drawOnCanvas(function()
        love.graphics.clear(.25, .25, .25)
        Stage.draw()
    end)
    Canvas.drawCanvas()
end

return GamePhase