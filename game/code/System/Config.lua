---@class Config:BaseConfig
local Config = {}
local pl_pretty = require "pl.pretty"
local Platform  = require "System.Platform"
local ControllerInputNames = require "ControllerInputNames"

local filename = "config.lua"

local config
local defaultconfig

function Config.reset()
	---@class BaseConfig
	---@field [string] number|boolean|string
	config = {
        debug = false,
        fullscreen = false,
		maximize = true,
        fullscreenexclusive = false,
        fullscreendevice = 1,
        vsync = false,
        usedpiscale = false,
        canvasscaleint = true,
        canvasscalesoft = false,
        musicvolume = 0.5,
        soundvolume = 0.5,
        resizable = true,
        drawstats = false,
        rotation = 0,
		variableupdate = false
	}
	if defaultconfig then
		for k,v in pairs(defaultconfig) do
			config[k] = v
		end
	end
end
Config.reset()

Config.cli = [[
    --fullscreen            	Start in fullscreen mode
    --borderless             	Non-exclusive fullscreen
    --exclusive             	Exclusive fullscreen
    --display (optional number)	Number of the display to use in fullscreen
    --windowed              	Start in windowed mode
    --drawstats             	Draw performance stats
]]

function Config.clamp(key, min, max)
	local value = Config[key]
	if type(value) == "number" then
		Config[key] = math.max(min, math.min(value, max))
	end
end

function Config.load(defaultcfg)
	defaultconfig = defaultcfg
	Config.reset()
	if love.filesystem.getInfo(filename) then
		local fileconfig = love.filesystem.load(filename)()
		for k,v in pairs(fileconfig) do
			Config[k] = v
		end
	end
	Config.clamp("fullscreendevice", 1, love.window.getDisplayCount())
end

function Config.parseArgs(args)
	if args.exclusive then
    	Config.fullscreenexclusive = true
	end
	if args.borderless then
    	Config.fullscreenexclusive = false
	end
	if args.display then
	    Config.fullscreendevice = math.floor(args.display)
		Config.clamp("fullscreendevice", 1, love.window.getDisplayCount())
	end
    if args.rotation ~= -1 then
        Config.rotation = args.rotation
    end
    if args.fullscreen then
        Config.fullscreen = true
    elseif args.windowed then
        Config.fullscreen = false
    end
end

function Config.save()
	if not Platform.supports("saveconfig") then
		return
	end
	local configtext = "return "..pl_pretty.write(config)
	love.filesystem.write(filename, configtext)
end

function Config.isPortraitRotation()
	local rotation = math.rad(Config.rotation)
	return math.abs(math.sin(rotation)) > math.sqrt(2)/2
end

function Config.isPortraitDimensions()
	local w, h, flags = love.window.getMode()
	return w < h
end

function Config.isVertical()
    local portraitrotation = Config.isPortraitRotation()
    local portraitdimensions = Config.isPortraitDimensions()
    return portraitrotation and not portraitdimensions
    	or portraitdimensions and not portraitrotation
end

function Config.applyDisplayMode(basew, baseh, winmaxscale)
	local w, h, flags = love.window.getMode()
	local exclusive = Config.fullscreenexclusive
	local fullscreen = Config.fullscreen
	if Config.isPortraitRotation() then
		basew, baseh = baseh, basew
	end
	-- local bestmode
	local maxscale = winmaxscale or 1

	if fullscreen then --and exclusive then
		w, h = 0, 0
		-- local modes = love.window.getFullscreenModes()
		-- for i = 1, #modes do
		-- 	local mode = modes[i]
		-- 	if not bestmode
		-- 	or bestmode.width > mode.width
		-- 	or bestmode.height > mode.height
		-- 	then
		-- 		if mode.height >= baseh and mode.width >= basew then
		-- 			bestmode = mode
		-- 		end
		-- 	end
		-- end
		-- if bestmode then
		-- 	maxscale = math.min(bestmode.width/basew, bestmode.height/baseh)
		-- end
	else
		if config.maximize then
			local deskwidth, deskheight = love.window.getDesktopDimensions()
			maxscale = math.min(deskwidth/basew, deskheight/baseh)
		end
		maxscale = math.floor(maxscale)
		w = basew*maxscale
		h = baseh*maxscale
	end

	Config.clamp("fullscreendevice", 1, love.window.getDisplayCount())
	flags.fullscreen = fullscreen
	flags.fullscreentype = exclusive and "exclusive" or "desktop"
	flags.display = Config.fullscreendevice
	flags.usedpiscale = Config.usedpiscale
	flags.vsync = Config.vsync
	flags.resizable = Config.resizable
	flags.x = nil
	flags.y = nil
	flags.minwidth = basew
	flags.minheight = baseh
	love.window.setMode(w, h, flags)
	w, h, flags = love.window.getMode()
end

local function getConfigValueOrInputName(key)
	local value = config[key]
	local inputnames = ControllerInputNames[config.joy_namingscheme or "XBOX"]
	local inputname = inputnames[value] or inputnames[key]
	return inputname or value
end

function Config.gsub(s)
	return s:gsub("${([_%w]+)}", getConfigValueOrInputName)
end

setmetatable(Config, {
	__index = function(_, k)
		return config[k]
	end,
	__newindex = function(_, k, v)
		if config[k] == nil then
			print("W: Ignoring unknown config variable "..k)
		else
			config[k] = v
		end
	end
})

return Config