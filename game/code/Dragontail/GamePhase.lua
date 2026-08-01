local Canvas= require "System.Canvas"
local Stage = require "Dragontail.Stage"
local Tiled = require "Tiled"
local Database= require "Data.Database"
local Assets= require "Tiled.Assets"
local Audio = require "System.Audio"
local Gui = require "Gui"
local Config = require "System.Config"
local Inputs = require "System.Inputs"
local Player = require "Dragontail.Character.Player"
local GameGuiActions = require "Dragontail.GuiActions"
local Characters     = require "Dragontail.Stage.Characters"
local Dragontail     = require "Dragontail"
local Color          = require "Tiled.Color"
local fixedupdate    = require "fixedupdate"
local End            = require "Dragontail.Movie.End"
local pathlite       = require "pathlite"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

local pauselocked
local stagepath = "data/stage_banditcave.lua"
local playerwon
local pausemap ---@type Gui
local hudmap ---@type Gui
local wipemap ---@type Gui

local movie

function GamePhase:loadphase(stagepath_, startroom)
    stagepath = stagepath_ or stagepath
    pauselocked = false
    local unifont = Assets.getFont("Unifont", 16)
    love.graphics.setFont(unifont)

    Database.load("data/database/vfx-properties.csv")
    Database.load("data/database/items-properties.csv")
    Database.load("data/database/projectiles-properties.csv")
    Database.load("data/database/objects-properties.csv")
    Database.load("data/database/ui-properties.csv")
    Stage:load(stagepath)

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
    local pausemapfile = map.pausemenumap
    if pausemapfile then
        pausemapfile = pathlite.normjoin(map.directory, pausemapfile)
    end
    pausemap = Gui.new(pausemapfile or "data/gui/menu_pause_combat.lua")
    pausemap:clearMenuStack()

    Tiled.Assets.uncacheMarked()
    Tiled.Assets.packTiles()
    Tiled.Assets.batchAllMapsLayers()

    Stage:init(startroom)

    hudmap = Gui.new("data/gui/hud_combat.lua")
    hudmap:clearMenuStack()
    hudmap:showOnlyNamed("hud")

    wipemap = Gui.new("data/gui/wipe_diagonalcurtains.lua")
    local wipe = wipemap.wipe ---@cast wipe Wipe
    wipe:start("open")

    love.event.connect(Stage)
    love.event.connect(hudmap)
    love.event.connect(wipemap)

    playerwon = nil
end

function GamePhase:quitphase()
    Stage:quit()
    Assets.markAllToUncache()
    Database.clear()
    Audio.stop()

    pausemap = nil
    hudmap = nil
    wipemap = nil
    movie = nil
end

function GamePhase:setPaused(newpaused, withmenu)
    if pauselocked then
        return
    end
    Stage:pause(newpaused)
    if Stage:paused() then
        if withmenu then
            pausemap:showOnlyNamed("pausemenu")
            pausemap:pushMenu(pausemap.pausemenu)
            love.event.connect(pausemap)
        end
    else
        pausemap:clearMenuStack()
        love.event.disconnect(pausemap)
    end
end

local keypressed = {}
function keypressed.f2()
    love.event.newphase("Dragontail.GamePhase")
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
function GamePhase:gamepadpressed(gamepad, button)
    if button == "start" then
        GamePhase:setPaused(not Stage:paused(), true)
        return "stop"
    elseif button == "back" then
        if Characters.isTimeToClearLostEnemies() then
            Characters.clearEnemies()
        end
        -- GamePhase:setPaused(not Stage:paused(), false)
        return "stop"
    end
end

function GamePhase:keypressed(key)
    local kp = keypressed[key]
    if kp then
        kp()
        return "stop"
    end

    if key == "escape" then
        if not Stage:paused() then
            GamePhase:setPaused(true, true)
            return "stop"
        end
    end
end

local function fixedupdateInputDisplay()
    local input = hudmap:get("input")
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

function GamePhase:fixedupdate()
    if movie then
        if movie() then
            movie = nil
        end
    end
    fixedupdateInputDisplay()
    Stage:fixedupdateHud(hudmap)
end

function GamePhase:setPauseLocked(locked)
    pauselocked = locked
end

function GamePhase:gameOver(won)
    playerwon = won or false
    GamePhase:setPauseLocked(true)
    if won then
        local victorymap = Gui.new("data/gui/menu_stage_clear.lua")
        love.event.connect(victorymap)

        movie = coroutine.wrap(function()
            local menu = victorymap.menu
            menu.visible = false
            local shaking = victorymap.movie.shaking
            local RoseUppercut = coroutine.wrap(End)
            local ok, status = pcall(RoseUppercut, victorymap.movie)
            while ok and status ~= true do
                coroutine.yield()
                ok, status = pcall(RoseUppercut)
                if status == "hit" then
                    menu.visible = true
                end
                menu.x, menu.y = shaking.x, shaking.y
            end
            if not ok then print(status) end
            victorymap:pushMenu(menu)
            return true
        end)
        movie()
    else
        local gameovermap = Gui.new("data/gui/menu_game_over.lua")
        gameovermap:pushMenu(gameovermap.menu)
        love.event.connect(gameovermap)
    end
end

local fixedfrac = 0

function GamePhase:update(dsecs)
    local fixedrate = Config.fixedupdaterate
    fixedfrac = fixedupdate(fixedrate, fixedfrac, dsecs,
    function()
        Inputs.update()
        love.event.send("fixedupdate")
    end)
end

function GamePhase:draw()
    return "args", fixedfrac
end

return GamePhase