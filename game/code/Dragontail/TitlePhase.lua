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
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"
local coFade         = require "Dragontail.Movie.coFade"
local Color          = require "Tiled.Color"
local multitask      = require "multitask"
local TitlePhase = {}

local scenemap ---@type TiledMap
local sceneco ---@type function
local ambientsound ---@type love.Source

local wrap = coroutine.wrap
local yield = coroutine.yield

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
    coRelativePath(path, fg, 50)
    if ambientsound and Audio.getMusicVolume() > 0 then
        ambientsound:stop()
    end

    local menu = assert(Gui.title.mainmenus.normal)
    menu:setVisible(true)

    local function coDrift(obj, a, s, t)
        local dx, dy = math2.frompolar(a)
        local ds = s/t
        for _ = 1, t do
            yield()
            obj.x = obj.x + dx*s
            obj.y = obj.y + dy*s
            s = s - ds
        end
        return true
    end

    local rose = fg.Rose
    local swing = fg.swing
    local enemy = fg.enemy
    local hit = fg.hit
    local tasks = {
        function() return coDrift(rose, math.rad(210), .5, 60) end,
        function() return coDrift(swing, math.rad(210), .5, 60) end,
        function() return coDrift(enemy, math.rad(210), 2, 60) end,
        function() return coDrift(hit, math.rad(210), 1, 60) end,
        function() return coFade(hit, 0x00ffffff, Color.White, 60) end,
        function() return coFade(swing, 0x00ffffff, Color.White, 60) end,
        function() return coHitShake(menu, 100, 50, 150, 60) end,
    }

    local mt = multitask.new()
    for i = 1, #tasks do
        mt:push(wrap(tasks[i]))
    end
    repeat
        mt:runAll()
        yield()
    until mt:allDone()

    Gui:pushMenu(menu)
    return true
end

function TitlePhase.loadphase(startwithmainmenu)
    scenemap = Tiled.Map.load("data/title_scene.lua")
    scenemap:indexLayersByName()
    scenemap:indexLayerObjectsByName()
    scenemap:bindClasses()
    scenemap.layers:showOnlyNamed("bg", "logo")

    Assets.uncacheMarked()
    Assets.packTiles()
    Assets.batchAllMapsLayers()

    Gui:showOnlyNamed("title", "options", "wipe")
    Gui:clearMenuStack()
    Gui.title:showOnlyNamed("title")
    Gui.options:showOnlyNamed()
    -- Wallpaper.reload()
    Assets.get("ccdata/music/Block Island Sound loop.ogg")

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
    sceneco()
    scenemap.layers:showOnlyNamed("bg", "fg")
    local menuname = "normal"
    if Config.exhibit then
        menuname = "exhibit"
    end
    Gui.title.mainmenus:setVisible(true)
    Gui.title.mainmenus:showOnlyNamed()
    Audio.playMusic("ccdata/music/Block Island Sound loop.ogg", nil, true)
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

    if love.keyboard.isDown("lctrl") and key == 's' then
        local filename = os.date("screenshot-%Y%m%d-%H%M%S.png")
        local i = 1
        while love.filesystem.getInfo(filename) do
            filename = os.date("screenshot-%Y%m%d-%H%M%S-"..i..".png")
        end
        love.graphics.captureScreenshot(filename)
    end
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