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
	---@field [string] number|boolean|string|table
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
		drawgraphicstats = false,
        rotation = 0,
		variableupdate = false,
		fixedupdaterate = 60
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
    --drawstats             	Draw basic performance stats
    --drawgraphicstats			Draw detailed graphics performance stats
]]

function Config.clamp(key, min, max)
	local value = config[key]
	if type(value) == "number" then
		config[key] = math.max(min, math.min(value, max))
	end
end

function Config.load(defaultcfg)
	defaultconfig = defaultcfg
	Config.reset()
	if love.filesystem.getInfo(filename) then
		local fileconfig = love.filesystem.load(filename)()
		local fileversion = fileconfig._version or 0
		if fileversion == defaultconfig._version then
			local function fill(t1, t2)
				for k,v2 in pairs(t2) do
					local v1 = t1[k]
					if type(v1) == "table"
					and type(v2) == "table" then
						fill(v1, v2)
					else
						t1[k] = v2
					end
				end
			end
			fill(Config, fileconfig)
		else
			local oldfilename = filename.."."..fileversion
			if Platform.supports("saveconfig") then
				local configtext = "return "..pl_pretty.write(fileconfig)
				love.filesystem.write(oldfilename, configtext)
			end
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

    Config.drawstats = args.drawstats
    Config.drawgraphicstats = args.drawgraphicstats
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

function Config.calcDisplaySize(basew, baseh)
	local deskwidth, deskheight = love.window.getDesktopDimensions(Config.fullscreendevice)
	if Config.fullscreen then
		return deskwidth, deskheight
	end

	if Config.isPortraitRotation() then
		basew, baseh = baseh, basew
	end

	local maxscale = math.min(deskwidth/basew, deskheight/baseh)
	maxscale = math.floor(maxscale)
	return basew*maxscale, baseh*maxscale
end

function Config.initDisplayMode(basew, baseh)
	local w, h = Config.calcDisplaySize(basew, baseh)

	-- Config.clamp("fullscreendevice", 1, love.window.getDisplayCount())
	local flags = {
		fullscreen = Config.fullscreen,
		usedpiscale = Config.usedpiscale,
		vsync = Config.vsync,
		resizable = Config.resizable,
		minwidth = basew,
		minheight = baseh,
	}
	Config.setDisplayModeFlag(flags, "fullscreenexclusive", Config.exclusive)
	Config.setDisplayModeFlag(flags, "fullscreendevice", Config.fullscreendevice)
	love.window.setMode(w, h, flags)
end

function Config.setDisplayModeFlag(flags, configkey, value)
	if configkey == "fullscreenexclusive" then
		flags.fullscreentype = value and "exclusive" or "desktop"
	elseif configkey == "fullscreendevice" then
		flags.display = value
	else
		flags[configkey] = value
	end
	return flags
end

function Config.updateDisplayMode(flags)
	local w, h, currentflags = love.window.getMode()
	w, h = Config.calcDisplaySize(currentflags.minwidth, currentflags.minheight)
	love.window.updateMode(w, h, flags)
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

local apply = {
	fullscreen = function (fullscreen)
		local w, h, flags = love.window.getMode()
		local neww, newh = Config.calcDisplaySize(flags.minwidth, flags.minheight)
		if w ~= neww or h ~= newh then
			love.window.updateMode(neww, newh, {fullscreen = fullscreen})
			love.event.push("resize", neww, newh)
		end
	end,
	fullscreenexclusive = function (exclusive)
		love.window.setFullscreen(Config.fullscreen, exclusive and "exclusive" or "desktop")
	end,
	fullscreendevice = function(device)
		device = math.max(1, math.min(device, love.window.getDisplayCount()))
		local w, h, flags = love.window.getMode()
		local neww, newh = Config.calcDisplaySize(flags.minwidth, flags.minheight)
		love.window.updateMode(neww, newh, { display = device })
		love.event.push("resize", neww, newh)
		return device
	end,
	vsync = function(v)
		love.window.setVSync(v and 1 or 0)
	end,
	rotation = function()
		local w, h, flags = love.window.getMode()
		local neww, newh = Config.calcDisplaySize(flags.minwidth, flags.minheight)
		if w ~= neww or h ~= newh then
			love.window.updateMode(neww, newh)
		end
		love.event.push("resize", neww, newh)
	end,
	musicvolume = function(volume)
		local Audio                = require "System.Audio"
		Audio.setMusicVolume(volume)
	end,
}

function Config.apply(key)
	if apply[key] then
		local value = config[key]
		local newvalue = apply[key](value)
		config[key] = newvalue ~= nil and newvalue or value
	end
end

function Config.setApply(key, action)
	apply[key] = action
	return config[key]
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