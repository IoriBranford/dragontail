local Gui = require "Dragontail.Gui"
local GuiActions = require "Dragontail.GuiActions"
-- local Wallpaper = require "System.Wallpaper"
local Assets    = require "Tiled.Assets"
local Config = require "System.Config"
local Stage  = require "Dragontail.Stage"
local Canvas = require "System.Canvas"
local TitlePhase = {}

function TitlePhase.loadphase()
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
    local menuname = "normal"
    if Config.exhibit then
        menuname = "exhibit"
    end
    Gui.title.title.illust:changeAnimation("attack", 1, 0)
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
    Gui:fixedupdate()
end

function TitlePhase.update(dsecs, fixedfrac)
end

function TitlePhase.draw(fixedfrac)
    -- Wallpaper.draw()
    Gui:drawOnOwnCanvas()
    Gui.canvas:draw()
end

return TitlePhase