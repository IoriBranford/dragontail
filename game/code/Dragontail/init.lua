local Tiled = require "Tiled"
local Audio = require "System.Audio"
local Config = require "System.Config"
local Wallpaper             = require "System.Wallpaper"
local Aseprite              = require "Aseprite"
local Platform              = require "System.Platform"
local Assets = require "Tiled.Assets"
local Window = require "System.Window"
local Stage  = require "Dragontail.Stage"
local firstphase = "Dragontail.GamePhase"
local firstmap = "data/stage_demonrealm.lua"

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

return {
    controls = require "Dragontail.Controls",
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
        _version = 2,

        canvasscaleint = false,
        canvasscalesoft = true,

        drawbodies = false,
        drawai = false,
        exhibit = false,
        maximize = Platform.supports("maximize"),
    
        key_left = "left",
        key_right = "right",
        key_up = "up",
        key_down = "down",
        key_fire = "z",
        key_focus = "x",
        key_bomb = "lshift",
        key_pause = "pause",
        key_pausemenu = "escape",
        key_restart = "none",
    
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
    
        joy_deadzone = 0.25,
        joy_move1 = "left",
        joy_move2 = "dp",
        joy_startbackrestart = false,
        joy_fire = "x",
        joy_focus = "rightshoulder",
        joy_bomb = "leftshoulder",
        joy_pause = "back",
        joy_pausemenu = "start",
        joy_namingscheme = "XBOX",
    
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