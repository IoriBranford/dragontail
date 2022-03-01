local Canvas= require "System.Canvas"
local Config= require "System.Config"
local Stage = require "Dragontail.Stage"
local Sheets= require "Data.Sheets"
local Assets= require "System.Assets"
local GamePhase = {}

function GamePhase.loadphase()
    Canvas.init(Config.basewindowwidth, Config.basewindowheight)

    Sheets.load("data/jam_characters.csv")
    Sheets.forEach(function(_, properties)
        local asepritefile = properties.asepritefile
        if asepritefile then Assets.get(asepritefile) end
    end)
    Sheets.load("data/jam_animations.csv")

    Stage.init("data/jam_village.lua")
end

function GamePhase.quitphase()
    Stage.quit()
    Sheets.clear()
    Assets.clear()
end

function GamePhase.fixedupdate()
    Stage.fixedupdate()
end

function GamePhase.update(dsecs, fixedfrac)
    Stage.update(dsecs, fixedfrac)
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