local Gui = require "Dragontail.Gui"
local GuiActions = require "Dragontail.GuiActions"
-- local Wallpaper = require "System.Wallpaper"
local Assets    = require "Tiled.Assets"
local Config = require "System.Config"
local Stage  = require "Dragontail.Stage"
local Canvas = require "System.Canvas"
local Tiled  = require "Tiled"
local Path   = require "Object.Path"
local TitlePhase = {}

local scenemap ---@type TiledMap
local sceneco ---@type function

local function sceneAnimation()
    local layers = scenemap.layers
    local fg = layers.fg
    local directions = layers.directions
    layers.logo.visible = false
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup
    local path = directions.path
    ---@cast path Path
    Path.cast(path)
    path:calcLengths()
    local i, pos = 2, 0
    repeat
        i, pos = path:updatePosition1d(i, pos, 50)
        local x, y = path:getPosition2d(i, pos)
        fg.x = x + path.x
        fg.y = y + path.y
        coroutine.yield()
    until i > #path.points
    return true
end

function TitlePhase.loadphase()
    scenemap = Tiled.Map.load("data/title_scene.lua")
    scenemap:indexLayersByName()
    scenemap:indexLayerObjectsByName()
    Assets.uncacheMarked()
    Assets.packTiles()
    Assets.batchAllMapsLayers()
    Gui:showOnlyNamed("title", "options")
    Gui:clearMenuStack()
    Gui.title:showOnlyNamed("title")
    Gui.options:showOnlyNamed()
    Gui:pushMenu(Gui.title.pressstart)
    -- Wallpaper.reload()
end

function TitlePhase.pushMainMenu()
    sceneco = coroutine.wrap(sceneAnimation)
    local menuname = "normal"
    if Config.exhibit then
        menuname = "exhibit"
    end
    Gui.title.mainmenus:setVisible(true)
    Gui.title.mainmenus:showOnlyNamed()
    Gui:pushMenu(Gui.title.mainmenus[menuname])
end

function TitlePhase.resize(screenwidth, screenheight)
    local camerawidth, cameraheight = Stage.CameraWidth, Stage.CameraHeight
    local inputscale = math.ceil(math.min(screenwidth/camerawidth, screenheight/cameraheight))
    Gui.canvas = Canvas(camerawidth, cameraheight, inputscale)
    Gui.canvas:transformToScreen(screenwidth, screenheight, math.rad(Config.rotation), Config.canvasscaleint)
    Gui.canvas:setFiltered(Config.canvasscalesoft)
    -- Wallpaper.reload()
end

function TitlePhase.quitphase()
    Assets.markAllToUncache()
    Gui:clearMenuStack()
    scenemap = nil
    sceneco = nil
end

function TitlePhase.keypressed(key)
    -- if Config.exhibit and key == "f1" then
    --     GuiActions.openOptions(Gui)
    --     return
    -- end
    Gui:keypressed(key)
end

function TitlePhase.gamepadpressed(gamepad, button)
    Gui:gamepadpressed(gamepad, button)
end

function TitlePhase.fixedupdate()
    scenemap:animate(1)
    if sceneco then
        if sceneco() then
            sceneco = nil
        end
    end
    Gui:fixedupdate()
end

function TitlePhase.update(dsecs, fixedfrac)
end

function TitlePhase.draw(fixedfrac)
    -- Wallpaper.draw()
    Gui.canvas:drawOn(function()
        scenemap:draw()
        Gui:draw()
    end)
    Gui.canvas:draw()
end

return TitlePhase