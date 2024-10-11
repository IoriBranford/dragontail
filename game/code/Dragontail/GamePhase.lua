local Canvas= require "System.Canvas"
local Stage = require "Dragontail.Stage"
local Tiled = require "Tiled"
local Database= require "Data.Database"
local Assets= require "Tiled.Assets"
local Audio = require "System.Audio"
local Gui = require "Dragontail.Gui"
local Config = require "System.Config"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local paused
local stagecanvas

function GamePhase.loadphase()
    paused = false
    local unifont = Assets.get("fonts/Unifont 16.fnt")
    love.graphics.setFont(unifont)
    Assets.get("music/retro-chiptune-guitar.ogg", "stream")

    Database.load("data/db_characters.csv")
    Database.load("data/db_charactersprites.csv")
    Database.load("data/db_charactersounds.csv")
    Database.load("data/db_characterstates.csv")
    Database.load("data/db_attacks.csv")
    Database.load("data/db_vfx.csv")
    Database.load("data/db_ui.csv")
    Database.forEach(function(_, properties)
        for k,v in pairs(properties) do
            if isAsset(v) then
                getAsset(v)
            elseif k == "attackchoices" then
                local choices = {}
                for attackid in v:gmatch("%S+") do
                    choices[#choices+1] = attackid
                end
                properties[k] = choices
            end
        end
    end)

    Stage.init("data/stage_banditcave.lua")

    Tiled.Assets.uncacheMarked()
    Tiled.Assets.packTiles()
    Tiled.Assets.setFilter("nearest", "nearest")
    Tiled.Assets.batchAllMapsLayers()

    GamePhase.resize(love.graphics.getWidth(), love.graphics.getHeight())

    local music = Audio.playMusic("music/retro-chiptune-guitar.ogg")
    if music then
        music:setLooping(true)
    end

    Gui:showOnlyNamed("gameplay")
    Gui.gameplay:showOnlyNamed("hud")
end

function GamePhase.resize(screenwidth, screenheight)
    local camerawidth, cameraheight = Stage.CameraWidth, Stage.CameraHeight
    local inputscale = math.ceil(math.min(screenwidth/camerawidth, screenheight/cameraheight))
    stagecanvas = Canvas(camerawidth, cameraheight, inputscale)
    stagecanvas:transformToScreen(screenwidth, screenheight, math.rad(Config.rotation), Config.canvasscaleint)
    stagecanvas:setFiltered(Config.canvasscalesoft)
    Gui.canvas = stagecanvas
end

function GamePhase.quitphase()
    Stage.quit()
    Assets.markAllToUncache()
    Database.clear()
end

function GamePhase.setPaused(newpaused)
    paused = newpaused
    Gui.gameplay.pausemenu.visible = paused
end

local keypressed = {}
function keypressed.f2()
    love.event.loadphase("Dragontail.GamePhase")
end

function keypressed.p()
    GamePhase.setPaused(not paused)
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

---@param gamepad love.Joystick
function GamePhase.gamepadpressed(gamepad, button)
    if button == "back" then
        if gamepad:isGamepadDown("start") then
            love.event.loadphase("Dragontail.GamePhase")
        end
    elseif button == "start" then
        GamePhase.setPaused(not paused)
    end
end

function GamePhase.keypressed(key)
    if paused then
        GamePhase.setPaused(false)
        return
    end
    local kp = keypressed[key]
    if kp then kp() end
end

function GamePhase.fixedupdate()
    if not paused then
        Stage.fixedupdate()
        Stage.fixedupdateGui(Gui)
    end
    Gui:fixedupdate()
end

function GamePhase.update(dsecs, fixedfrac)
    Stage.update(dsecs, paused and 0 or fixedfrac)
    Audio.update(dsecs)
end

function GamePhase.debug_drawStageUnzoomed(fixedfrac)
    love.graphics.push()
    love.graphics.translate(
        (love.graphics.getWidth()  - Stage.CameraWidth ) / 2,
        (love.graphics.getHeight() - Stage.CameraHeight) / 2)
    Stage.draw(paused and 0 or fixedfrac)
    love.graphics.pop()
end

function GamePhase.draw(fixedfrac)
    love.graphics.clear(.25, .25, .25)
    stagecanvas:drawOn(function()
        Stage.draw(paused and 0 or fixedfrac)
    end)
    Gui:drawOnCanvas(stagecanvas)
    stagecanvas:draw()
end

return GamePhase