local Tiled = require "Tiled"
local Audio = require "System.Audio"
local Config
local Wallpaper             = require "System.Wallpaper"
local Aseprite              = require "Aseprite"
local Platform              = require "System.Platform"
local Assets = require "Tiled.Assets"
local Window = require "System.Window"
local Inputs = require "System.Inputs"
local Time   = require "System.Time"
local pathlite = require "pl.pathlite"
local Canvas   = require "System.Canvas"
local firstphase = "Dragontail.TitlePhase"

local Dragontail = {
    width = 480,
    height = 270,
    cli = [[
    
        --rotation                              (number default -1)	Screen orientation in degrees clockwise
        --drawbodies                            Draw physical bodies
        --drawai                                Draw AI information
        --drawinput                             Draw controller input
        --exhibit                               Exhibit mode - disable options menu and quit
        --buildmegatilesets	(optional string)   Build megatilesets for all maps in the given text file
        --stage (optional string)               Name of stage to start
        --test (optional string)                Name of test to start
        --room (optional string)                Name of room to start the stage at
        --cuecards                              Use title bar as a cue card for video recording
    ]],
    defaultconfig = {
        _version = 6,

        resolution = 1,
        upscale = 4,
        upscaleinteger = false,
        linearfilter = "SCREEN",

        drawinput = false,
        drawbodies = false,
        drawai = false,
        exhibit = false,
        cuecards = false,
        maximize = false,

        keys = {
            ["left right"] = "digitalx",
            ["up down"] = "digitaly",
            z = "attack",
            lshift = "sprint",
            x = "fly",
            lctrl = "grab",
        },

        gamepads = {
            {
                ["dpleft dpright"] = "digitalx",
                ["dpup dpdown"] = "digitaly",
                leftx = "analogx",
                lefty = "analogy",
                x = "attack",
                y = "attack",
                a = "fly",
                b = "fly",
                rightshoulder = "sprint",
                triggerright = "sprint",
                leftshoulder = "grab",
                triggerleft = "grab",
            }
        },

        -- game_rules = "ORIGINAL",
        -- game_difficulty = "NORMAL",
        -- game_dialogue = true,
        -- player_character = "Amy",
        -- player_hitbox = "FOCUSFIRE",
        -- player_burst = 4,
        player_autorevive = true,
        input_invertgrab = true,
        -- practice_lives = 2,
        -- practice_bombs = 1,
        -- practice_wingmen = 0,
        -- practice_powerlevel = 0,
        -- practice_stage = "DEMONREALM",
    
        joy_deadzone = 0.25,
        -- joy_startbackrestart = false,
        -- joy_namingscheme = "XBOX",
    
        -- hud_inner = "AUTO",
        -- hud_outer = true,
    
        -- backgroundstyle = "ART2",
        -- highscores_difficulty = "NORMAL",
        -- highscores_character = "Amy",
        -- highscores_onlineposition = "TOP",
        musicvolume = 0.25,
        -- soundtrack = "Original",
        soundvolume = 0.75,
        variableupdate = true,
    },
    worldcanvas = nil, ---@type Canvas
    screencanvas = nil, ---@type Canvas
}

function Dragontail.load(args)
    Config = require "System.Config"
    local w, h = Dragontail.width, Dragontail.height

    love.graphics.setDefaultFilter("nearest", "nearest")
    local map = args.stage or args.test
    if map then
        local source = pathlite.normpath(love.filesystem.getSource())
        map = string.match(map, source.."/(.+)") or map
        if not love.filesystem.getInfo(map, "file") then
            map = args.stage and string.format("data/stage_%s.lua", map)
                or string.format("data/test_%s.lua", map)
        end
        if love.filesystem.getInfo(map, "file") then
            firstphase = "Dragontail.GamePhase"
        else
            map = nil
        end
    end

    local defaults = Dragontail.defaultconfig
    Platform.overrideConfig(defaults)
    Platform.disableUnsupportedConfig(defaults)

    Config.parseArgs(args)
    Config.exhibit = args.exhibit
    Config.drawinput = args.drawinput
    Config.drawbodies = args.drawbodies
    Config.drawai = args.drawai
    Config.cuecards = args.cuecards

    Config.gamepads = Inputs.configureGamepads(Config.gamepads)
    Config.keys = Inputs.configureKeyboard(Config.keys)
    Inputs.initGamepads(Dragontail.defaultconfig.gamepads[1])

    Config.setApply("resolution", function(res)
        local rc = Dragontail.worldcanvas
        rc:resize(w, h, res)
        Dragontail.resize()
    end)

    Config.setApply("upscale", function(res)
        local sc = Dragontail.screencanvas
        sc:resize(w * res, h * res)
        Dragontail.resize()
    end)

    Config.setApply("linearfilter", function(filter)
        local rc = Dragontail.worldcanvas
        local sc = Dragontail.screencanvas
        rc:setFiltered(filter == "WORLD" or filter == "BOTH")
        sc:setFiltered(filter == "SCREEN" or filter == "BOTH")
    end)

    Window.init(w, h)

    local rres = Config.resolution
    local sres = Config.upscale
    Dragontail.worldcanvas = Canvas(w*rres, h*rres)
    Dragontail.screencanvas = Canvas(w*sres, h*sres)
    Config.apply("resolution")
    Config.apply("upscale")
    Config.apply("linearfilter")

    love.window.setTitle(love.filesystem.getIdentity())
    local iconfile = "appicon/appicon.png"
    if love.filesystem.getInfo(iconfile) then
        love.window.setIcon(love.image.newImageData(iconfile))
    end
    Tiled.animationtimeunit = "fixedupdates"
    Aseprite.animationtimeunit = "fixedupdates"
    Assets.fontpath = "data/fonts"
    love.graphics.setLineStyle("rough")

    -- Wallpaper.reload()

    local firstroom = map and args.room
    love.event.loadphase(firstphase, map, firstroom)
end

function Dragontail.quit()
    Inputs.saveGamepadMappings()
end

function Dragontail.resize(gw, gh)
    if not gw then
        gw, gh = love.graphics.getDimensions()
    end

    local wc = Dragontail.worldcanvas
    local sc = Dragontail.screencanvas
    local rot = math.rad(Config.rotation)
    local int = Config.upscaleinteger
    sc:transformToScreen(gw, gh, rot, int)

    local s = Config.upscale / Config.resolution
    local scw, sch = sc.canvas:getDimensions()
    wc:transformToScreen(scw, sch, 0)
end

function Dragontail.draw(render, ...)
    local wc = Dragontail.worldcanvas
    local sc = Dragontail.screencanvas

    wc:drawOn(render, ...)
    sc:drawOn(wc)
    sc:draw()
end

return Dragontail