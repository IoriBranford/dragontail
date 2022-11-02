local Canvas= require "System.Canvas"
local Stage = require "Dragontail.Stage"
local Database= require "Data.Database"
local Assets= require "System.Assets"
local Audio = require "System.Audio"
local Gui = require "Gui"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local paused
local gui

function GamePhase.loadphase()
    paused = false
    local unifont = Assets.get("fonts/Unifont 16.fnt")
    love.graphics.setFont(unifont)
    Canvas.init(640, 360)
    Assets.load("music/retro-chiptune-guitar.ogg", "stream")

    Database.load("data/db_characters.csv")
    Database.load("data/db_charactersprites.csv")
    Database.load("data/db_charactersounds.csv")
    Database.load("data/db_attacks.csv")
    Database.load("data/db_vfx.csv")
    Database.forEach(function(_, properties)
        for k,v in pairs(properties) do
            if isAsset(v) then
                getAsset(v)
            end
        end
    end)

    gui = Gui.new("data/gui_gameplay.lua")
    Stage.init("data/stage_jam.lua")
end

local keypressed = {}
function keypressed.f2()
    love.event.loadphase("Dragontail.GamePhase")
end

function keypressed.p()
    paused = not paused
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

function GamePhase.quitphase()
    Stage.quit()
    Database.clear()
    Assets.clear()
    gui = nil
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

function GamePhase.resize(w, h)
    Canvas.init(640, 360)
end

function GamePhase.draw(fixedfrac)
    love.graphics.clear(.25, .25, .25)
    Canvas.drawOnCanvas(function()
        Stage.draw(fixedfrac)
        gui:draw()
        if paused then
            love.graphics.printf("PAUSE\n\nPress any key to resume", 0, 128, 640, "center")
        end
    end)
    Canvas.drawCanvas()
end

return GamePhase