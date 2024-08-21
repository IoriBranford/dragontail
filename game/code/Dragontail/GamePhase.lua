local Canvas= require "System.Canvas"
local Stage = require "Dragontail.Stage"
local Tiled = require "Tiled"
local Database= require "Data.Database"
local Assets= require "Tiled.Assets"
local Audio = require "System.Audio"
local Gui = require "Gui"
local Config = require "System.Config"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local paused
local gui
local stagecanvas

function GamePhase.loadphase()
    paused = false
    local unifont = Assets.get("fonts/Unifont 16.fnt")
    love.graphics.setFont(unifont)
    Assets.load("music/retro-chiptune-guitar.ogg", "stream")

    Database.load("data/db_characters.csv")
    Database.load("data/db_charactersprites.csv")
    Database.load("data/db_charactersounds.csv")
    Database.load("data/db_characterstates.csv")
    Database.load("data/db_attacks.csv")
    Database.load("data/db_vfx.csv")
    Database.forEach(function(_, properties)
        for k,v in pairs(properties) do
            if isAsset(v) then
                getAsset(v)
            end
        end
    end)

    Stage.init("data/stage_jam.lua")

    gui = Gui.new("data/gui_gameplay.lua")
    Tiled.Assets.uncacheMarked()
    Tiled.Assets.packTiles()
    Tiled.Assets.setFilter("nearest", "nearest")

    GamePhase.resize(love.graphics.getWidth(), love.graphics.getHeight())

end

function GamePhase.resize(screenwidth, screenheight)
    stagecanvas = Canvas(Stage.CameraWidth, Stage.CameraHeight)
    stagecanvas:transformToScreen(screenwidth, screenheight, math.rad(Config.rotation), Config.canvasscaleint)
    stagecanvas:setFiltered(Config.canvasscalesoft)
    gui:resize(screenwidth, screenheight)
end

function GamePhase.quitphase()
    Stage.quit()
    Assets.markAllToUncache()
    Database.clear()
    gui = nil
end

local keypressed = {}
function keypressed.f2()
    love.event.loadphase("Dragontail.GamePhase")
end

function keypressed.p()
    paused = not paused
end

function keypressed.s()
    if love.keyboard.isDown("lctrl") then
        local filename = os.date("screenshot-%Y%m%d-%H%M%S.png")
        local i = 1
        while love.filesystem.getInfo(filename) do
            filename = os.date("screenshot-%Y%m%d-%H%M%S-"..i..".png")
        end
        love.graphics.captureScreenshot(filename)
    end
end

function GamePhase.gamepadpressed(gamepad, button)
    if paused then
        if button == "back" then
            love.event.loadphase("Dragontail.GamePhase")
        end
        paused = false
        return
    elseif button == "start" then
        paused = true
    end
end

function GamePhase.keypressed(key)
    if paused then
        paused = false
        return
    end
    local kp = keypressed[key]
    if kp then kp() end
end

function GamePhase.fixedupdate()
    if not paused then
        Stage.fixedupdate()
        Stage.fixedupdateGui(gui)
    end
    gui:fixedupdate()
end

function GamePhase.update(dsecs, fixedfrac)
    Stage.update(dsecs, paused and 0 or fixedfrac)
    Audio.update(dsecs)
end

function GamePhase.draw(fixedfrac)
    love.graphics.clear(.25, .25, .25)
    stagecanvas:drawOn(function()
        Stage.draw(fixedfrac)
        if paused then
            love.graphics.printf("PAUSE\n\nPress any key to resume", 0, 128, 640, "center")
        end
    end)
    stagecanvas:draw()
    gui:draw()
end

return GamePhase