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
local playingscene ---@type MovieScene
local ambientsound ---@type love.Source

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
    local menu = assert(Gui.title.mainmenus.normal)
    playingscene = scenemap.layers.fg
    playingscene:start(playingscene, scenemap)
    local menuname = "normal"
    if Config.exhibit then
        menuname = "exhibit"
    end
    Gui.title.mainmenus:setVisible(true)
    Gui.title.mainmenus:showOnlyNamed()
    if ambientsound then
        ambientsound:stop()
    end
    Audio.playMusic("data/music/Block Island Sound loop.ogg", nil, true)
end

function TitlePhase.quitphase()
    Audio.stop()
    Assets.markAllToUncache()
    Gui:clearMenuStack()
    scenemap = nil
    playingscene = nil
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
    if playingscene then
        local menu = assert(Gui.title.mainmenus.normal)
        local status, err = playingscene:play()
        if not status then
            print(err)
        end
        if not status or status == "dead" then
            if Gui.activemenu ~= menu then
                Gui:pushMenu(menu)
            end
            playingscene = nil
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