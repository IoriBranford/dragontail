local Tiled = require "Tiled"
local Comic = require "Dragontail.Comic"
local Stage = require "Dragontail.Stage"
local Canvas= require "System.Canvas"
local Config= require "System.Config"

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

function ComicPhase.resize(screenwidth, screenheight)
    local camerawidth, cameraheight = Stage.CameraWidth, Stage.CameraHeight
    local inputscale = math.ceil(math.min(screenwidth/camerawidth, screenheight/cameraheight))
    stagecanvas = Canvas(camerawidth, cameraheight, inputscale)
    stagecanvas:transformToScreen(screenwidth, screenheight, math.rad(Config.rotation), Config.canvasscaleint)
    stagecanvas:setFiltered(Config.canvasscalesoft)
end

function ComicPhase.keypressed()
    comic:advance()
end

function ComicPhase.draw()
    love.graphics.clear(.25, .25, .25)
    stagecanvas:drawOn(function()
        love.graphics.clear()
        comic:draw()
    end)
    stagecanvas:draw()
end

return ComicPhase