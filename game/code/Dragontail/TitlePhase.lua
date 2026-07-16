local Gui = require "Dragontail.Gui"
local GuiActions = require "Dragontail.GuiActions"
-- local Wallpaper = require "System.Wallpaper"
local Assets    = require "Tiled.Assets"
local Config = require "System.Config"
local Canvas = require "System.Canvas"
local Tiled  = require "Tiled"
local Path   = require "Object.Path"
local Audio  = require "System.Audio"
local Dragontail = require "Dragontail"
local TitlePhase = {}

local scenemap ---@type TiledMap
local sceneco ---@type function
local ambientsound ---@type love.Source

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
    if ambientsound and Audio.getMusicVolume() > 0 then
        ambientsound:stop()
    end

    local menu = assert(Gui.title.mainmenus.normal)
    local menux, menuy = menu.x, menu.y
    menu:setVisible(true)
    local shake = 50
    local dirx, diry = math2.frompolar(100)
    while shake > 0 do
        shake = shake - 1
        local d = math.cos(love.timer.getTime()*100)*shake
        menu.x = menux + d*dirx
        menu.y = menuy + d*diry
        coroutine.yield()
    end
    Gui:pushMenu(menu)
    return true
end

function TitlePhase.loadphase(startwithmainmenu)
    scenemap = Tiled.Map.load("data/title_scene.lua")
    scenemap:indexLayersByName()
    scenemap:indexLayerObjectsByName()
    Assets.uncacheMarked()
    Assets.packTiles()
    Assets.batchAllMapsLayers()

    Gui:showOnlyNamed("title", "options", "wipe")
    Gui:clearMenuStack()
    Gui.title:showOnlyNamed("title")
    Gui.options:showOnlyNamed()
    -- Wallpaper.reload()
    Assets.get("data/music/Block Island Sound loop.ogg")

    local wipe = Gui.wipe.diagonalCurtains ---@cast wipe Wipe
    wipe:start("open")
    if startwithmainmenu then
        TitlePhase.pushMainMenu()
    else
        Gui:pushMenu(Gui.title.pressstart)
        ambientsound = Audio.play("data/sounds/ambient/seaside.ogg")
        if ambientsound then ambientsound:setLooping(true) end
    end
end

function TitlePhase.pushMainMenu()
    Gui.title.pressstart:setVisible(false)
    sceneco = coroutine.wrap(sceneAnimation)
    local menuname = "normal"
    if Config.exhibit then
        menuname = "exhibit"
    end
    Gui.title.mainmenus:setVisible(true)
    Gui.title.mainmenus:showOnlyNamed()
    Audio.playMusic("data/music/Block Island Sound loop.ogg", nil, true)
end

function TitlePhase.quitphase()
    Audio.stop()
    Assets.markAllToUncache()
    Gui:clearMenuStack()
    scenemap = nil
    sceneco = nil
    ambientsound = nil
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
    Dragontail.draw(function()
        scenemap:draw()
        Gui:draw()
    end, fixedfrac)
end

return TitlePhase