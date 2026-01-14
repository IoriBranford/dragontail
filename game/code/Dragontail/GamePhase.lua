local Canvas= require "System.Canvas"
local Stage = require "Dragontail.Stage"
local Tiled = require "Tiled"
local Database= require "Data.Database"
local Assets= require "Tiled.Assets"
local Audio = require "System.Audio"
local Gui = require "Dragontail.Gui"
local Config = require "System.Config"
local Inputs = require "System.Inputs"
local Player = require "Dragontail.Character.Player"
local GameGuiActions = require "Dragontail.GuiActions"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local paused
local pauselocked
local stagecanvas
local stagepath = "data/stage_banditcave.lua"

function GamePhase.loadphase(stagepath_, startroom)
    stagepath = stagepath_ or stagepath
    paused = false
    pauselocked = false
    local unifont = Assets.getFont("Unifont", 16)
    love.graphics.setFont(unifont)

    Database.load("data/database/vfx-properties.csv")
    Database.load("data/database/items-properties.csv")
    Database.load("data/database/projectiles-properties.csv")
    Database.load("data/database/objects-properties.csv")
    Database.load("data/database/ui-properties.csv")
    Stage.load(stagepath)

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

    Tiled.Assets.uncacheMarked()
    Tiled.Assets.packTiles()
    Tiled.Assets.batchAllMapsLayers()

    Stage.init(startroom)
    GamePhase.resize(love.graphics.getWidth(), love.graphics.getHeight())

    GameGuiActions.playSelectedMusic()

    Gui:showOnlyNamed("gameplay", "wipe", "options")
    Gui.gameplay:showOnlyNamed("hud", "input")
    Gui.options:showOnlyNamed()
    Gui:clearMenuStack()
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

function GamePhase.setPaused(newpaused, withmenu)
    if pauselocked then
        return
    end
    paused = newpaused
    if paused then
        if withmenu then
            Gui:pushMenu(Gui.gameplay.pausemenu)
        end
    else
        Gui:clearMenuStack()
    end
end

local keypressed = {}
function keypressed.f2()
    love.event.loadphase("Dragontail.GamePhase")
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
    if button == "start" then
        GamePhase.setPaused(not paused, true)
    elseif button == "back" then
        GamePhase.setPaused(not paused, false)
    else
        Gui:gamepadpressed(gamepad, button)
    end
end

function GamePhase.keypressed(key)
    local kp = keypressed[key]
    if kp then
        kp()
        return
    end

    if key == "escape" then
        if not paused then
            GamePhase.setPaused(true, true)
            return
        end
    end

    Gui:keypressed(key)
end

local function fixedupdateInputDisplay()
    local input = Gui.gameplay.input
    if input then
        ---@cast input ObjectGroup
        input.visible = Config.drawinput
        if not input.visible then
            return
        end

        local x, y = Player.getJoystick()
        local attackbutton = Inputs.getAction("attack")
        local sprintbutton = Inputs.getAction("sprint")
        if x ~= 0 or y ~= 0 then
            input.joystickdirection.visible = true
            input.joystickdirection.rotation = math.atan2(y, x)
            input.joystickdirection.scalex = math.len(x, y)
        else
            input.joystickdirection.visible = false
        end
        input.attackbuttondown.visible = attackbutton.down
        input.sprintbuttondown.visible = sprintbutton.down
    end
end

function GamePhase.fixedupdate()
    if not paused then
        Stage.fixedupdate()
        fixedupdateInputDisplay()
    end
    Stage.fixedupdateGui(Gui)
    Gui:fixedupdate()
end

function GamePhase.setPauseLocked(locked)
    pauselocked = locked
end

function GamePhase.gameOver()
    GamePhase.setPauseLocked(true)
    Gui:pushMenu(Gui.gameplay.gameover)
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