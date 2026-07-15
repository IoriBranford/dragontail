local Tiled = require "Tiled"
local Comic = require "Dragontail.Comic"
local Stage = require "Dragontail.Stage"
local Canvas= require "System.Canvas"
local Config= require "System.Config"
local Dragontail = require "Dragontail"

local ComicPhase = {}

local comic
local stagecanvas

function ComicPhase.loadphase(comicfile)
    ComicPhase.resize(love.graphics.getWidth(), love.graphics.getHeight())
    comic = Tiled.Map.load(comicfile)
    Tiled.Assets.uncacheMarked()
    -- Tiled.Assets.packTiles()
    Tiled.Assets.setFilter("nearest", "nearest")
    Tiled.Assets.batchAllMapsLayers()
    Comic.cast(comic)
    ---@cast comic Comic
    comic:start()
end

function ComicPhase.keypressed()
    comic:advance()
end

function ComicPhase.draw()
    Dragontail.draw(function()
        comic:draw()
    end)
end

return ComicPhase