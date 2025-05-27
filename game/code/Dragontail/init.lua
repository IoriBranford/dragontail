local Tiled = require "Tiled"
local Audio = require "System.Audio"
local Config = require "System.Config"
local Wallpaper             = require "System.Wallpaper"
local Aseprite              = require "Aseprite"
local Platform              = require "System.Platform"
local Assets = require "Tiled.Assets"
local Window = require "System.Window"
local Stage  = require "Dragontail.Stage"
local Inputs = require "System.Inputs"
local firstphase = "Dragontail.GamePhase"
local firstmap = "data/stage_demonrealm.lua"

local defaultgamepadconfig =  {
    ["dpleft dpright"] = "movex",
    ["dpup dpdown"] = "movey",
    leftx = "movex",
    lefty = "movey",
    x = "attack",
    triggerright = "sprint",
}

function love.load(args)
    Assets.rootpath = "data/"
    local mapname = args.stage or args.test
    if mapname then
        local map = args.stage and string.format("data/stage_%s.lua", mapname)
            or string.format("data/test_%s.lua", mapname)
        if love.filesystem.getInfo(map, "file") then
            firstphase = "Dragontail.GamePhase"
            firstmap = map
        end
    end

    Config.parseArgs(args)
    Config.exhibit = args.exhibit
    Config.drawbodies = args.drawbodies
    Config.drawstats = args.drawstats
    Config.drawai = args.drawai

    Config.gamepads = Inputs.configureGamepads(Config.gamepads)
    Config.keys = Inputs.configureKeyboard(Config.keys)
    Inputs.initGamepads(defaultgamepadconfig)

    Window.init(Stage.CameraWidth, Stage.CameraHeight)
    love.window.setTitle(love.filesystem.getIdentity())
    local iconfile = "appicon/appicon.png"
    if love.filesystem.getInfo(iconfile) then
        love.window.setIcon(love.image.newImageData(iconfile))
    end
    Tiled.animationtimeunit = "fixedupdates"
    Aseprite.animationtimeunit = "fixedupdates"
    Assets.setFontPath("fonts/")
    love.graphics.setLineStyle("rough")

    -- Wallpaper.reload()

    require "Dragontail.Gui"

    local startpoint = args.startpoint
    love.event.loadphase(firstphase, firstmap, startpoint)
end

function love.quit()
    Inputs.saveGamepadMappings()
end

return {
    cli = [[
        --rotation                              (number default -1)	Screen orientation in degrees clockwise
        --drawbodies                            Draw physical bodies
        --drawai                                Draw AI information
        --exhibit                               Exhibit mode - disable options menu and quit
        --buildmegatilesets	(optional string)   Build megatilesets for all maps in the given text file
        --stage (optional string)               Name of stage to start
        --test (optional string)                Name of test to start
        --stagestart (optional string)          Name of stage start point
    ]],
    defaultconfig = Platform.overrideConfig {
        _version = 3,

        canvasscaleint = false,
        canvasscalesoft = true,

        drawbodies = false,
        drawai = false,
        exhibit = false,
        maximize = Platform.supports("maximize"),

        keys = {
            ["left right"] = "movex",
            ["up down"] = "movey",
            z = "attack",
            x = "attack2",
            lshift = "sprint"
        },

        gamepads = {
            [0] = defaultgamepadconfig,
            [1] = defaultgamepadconfig
        },

        -- inputs = {
        --     ["keyaxis left right"] = "movex",
        --     ["keyaxis up down"] = "movey",
        --     ["key z"] = "attack",
        --     ["key x"] = "attack2",
        --     ["key lshift"] = "sprint",
        --     ["pad0 axis leftx"] = "movex",
        --     ["pad0 axis lefty"] = "movey",
        --     ["pad0 buttonaxis dpleft dpright"] = "movex",
        --     ["pad0 buttonaxis dpup dpdown"] = "movey",
        --     ["pad0 button x"] = "attack",
        --     ["pad0 button y"] = "attack2",
        --     ["pad0 button a"] = "sprint",
        --     ["pad1 axis leftx"] = "movex",
        --     ["pad1 axis lefty"] = "movey",
        --     ["pad1 buttonaxis dpleft dpright"] = "movex",
        --     ["pad1 buttonaxis dpup dpdown"] = "movey",
        --     ["pad1 button x"] = "attack",
        --     ["pad1 button y"] = "attack2",
        --     ["pad1 button a"] = "sprint",
        -- },

        -- key_left = "left",
        -- key_right = "right",
        -- key_up = "up",
        -- key_down = "down",
        -- key_fire = "z",
        -- key_focus = "x",
        -- key_bomb = "lshift",
        -- key_pause = "pause",
        -- key_pausemenu = "escape",
        -- key_restart = "none",
    
        -- game_rules = "ORIGINAL",
        -- game_difficulty = "NORMAL",
        -- game_dialogue = true,
        -- player_character = "Amy",
        -- player_hitbox = "FOCUSFIRE",
        -- player_burst = 4,
        -- practice_lives = 2,
        -- practice_bombs = 1,
        -- practice_wingmen = 0,
        -- practice_powerlevel = 0,
        -- practice_stage = "DEMONREALM",
    
        -- joy_deadzone = 0.25,
        -- joy_move1 = "left",
        -- joy_move2 = "dp",
        -- joy_startbackrestart = false,
        -- joy_fire = "x",
        -- joy_focus = "rightshoulder",
        -- joy_bomb = "leftshoulder",
        -- joy_pause = "back",
        -- joy_pausemenu = "start",
        -- joy_namingscheme = "XBOX",
    
        -- hud_inner = "AUTO",
        -- hud_outer = true,
    
        -- backgroundstyle = "ART2",
        -- highscores_difficulty = "NORMAL",
        -- highscores_character = "Amy",
        -- highscores_onlineposition = "TOP",
        musicvolume = 0.25,
        soundvolume = 0.75,
    }
}