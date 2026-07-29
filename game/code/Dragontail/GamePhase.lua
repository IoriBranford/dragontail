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
local Characters     = require "Dragontail.Stage.Characters"
local Dragontail     = require "Dragontail"
local Color          = require "Tiled.Color"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local paused
local pauselocked
local stagepath = "data/stage_banditcave.lua"
local playerwon
local pausemenu

local moviemap
local movie ---@type Movie

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
    local map = Assets.maps[stagepath]
    pausemenu = map.pausemenu and Gui:get(map.pausemenu)
        or Gui.gameplay.pausemenu

    moviemap = Tiled.Map.load("data/movies_gameplay.lua")
    moviemap:indexLayersByName()
    moviemap:indexLayerObjectsByName()
    moviemap:bindClasses()

    Tiled.Assets.uncacheMarked()
    Tiled.Assets.packTiles()
    Tiled.Assets.batchAllMapsLayers()

    Stage.init(startroom)

    Gui:showOnlyNamed("gameplay", "wipe", "options")
    Gui.gameplay:showOnlyNamed("hud", "input")
    Gui.options:showOnlyNamed()
    Gui:clearMenuStack()

    playerwon = nil
end

function GamePhase.quitphase()
    Stage.quit()
    Assets.markAllToUncache()
    Database.clear()
    Audio.stop()
    moviemap, movie = nil, nil
end

function GamePhase.setPaused(newpaused, withmenu)
    if pauselocked then
        return
    end
    paused = newpaused
    if paused then
        if withmenu then
            Gui:pushMenu(pausemenu)
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

function keypressed.delete()
    if Characters.isTimeToClearLostEnemies() then
        Characters.clearEnemies()
    end
end

---@param gamepad love.Joystick
function GamePhase.gamepadpressed(gamepad, button)
    if button == "start" then
        GamePhase.setPaused(not paused, true)
    elseif button == "back" then
        if Characters.isTimeToClearLostEnemies() then
            Characters.clearEnemies()
        end
        -- GamePhase.setPaused(not paused, false)
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
    local input = Gui:get("gameplay.input")
    if input then
        ---@cast input ObjectGroup
        input.visible = Config.drawinput
        if not input.visible then
            return
        end

        local x, y = Player.getJoystick()
        local attackbutton = Inputs.getAction("attack")
        local jumpbutton = Inputs.getAction("fly")
        local sprintbutton = Inputs.getAction("sprint")
        if x ~= 0 or y ~= 0 then
            input.joystickdirection.visible = true
            input.joystickdirection.rotation = math.atan2(y, x)
            input.joystickdirection.scalex = math.len(x, y)
        else
            input.joystickdirection.visible = false
        end
        input.attackbuttondown.visible = attackbutton.down
        input.jumpbuttondown.visible = jumpbutton.down
        input.sprintbuttondown.visible = sprintbutton.down
    end
end

function GamePhase.fixedupdate()
    if not paused then
        Stage.fixedupdate()
    end
    if movie then
        local ok, err = movie:play()
        if not ok then print(err) end

        if movie:ended() then
            Gui:pushMenu(Gui.gameplay.victory)
        end
    end
    fixedupdateInputDisplay()
    Stage.fixedupdateGui(Gui)
    Gui:fixedupdate()
end

function GamePhase.setPauseLocked(locked)
    pauselocked = locked
end

function GamePhase.gameOver(won)
    playerwon = won or false
    GamePhase.setPauseLocked(true)
    if won then
        movie = moviemap.layers.victory
        if not movie then
            Gui:pushMenu(Gui.gameplay.victory)
        end
    else
        Gui:pushMenu(Gui.gameplay.gameover)
    end
end

function GamePhase.update(dsecs, fixedfrac)
    Stage.update(dsecs, paused and 0 or fixedfrac)
end

function GamePhase.debug_drawStageUnzoomed(fixedfrac)
    love.graphics.push()
    love.graphics.translate(
        (love.graphics.getWidth()  - Stage.CameraWidth ) / 2,
        (love.graphics.getHeight() - Stage.CameraHeight) / 2)
    Stage.draw(paused and 0 or fixedfrac)
    love.graphics.pop()
end

function GamePhase.lerpdraw(fixedfrac)
    Dragontail.draw(function()
        Stage.draw(paused and 0 or fixedfrac)
        if movie then moviemap:draw() end
        Gui:draw()
    end, fixedfrac)
end

return GamePhase