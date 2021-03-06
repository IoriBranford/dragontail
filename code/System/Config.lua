local Config = {}
local pl_pretty = require "pl.pretty"

local filename = "config.lua"

local config = {}

function Config.reset(defaultconfig)
	config = {}
	if defaultconfig then
		for k,v in pairs(defaultconfig) do
			config[k] = v
		end
	end
end

function Config.load(defaultconfig)
	Config.reset(defaultconfig)
	if love.filesystem.getInfo(filename) then
		local fileconfig = love.filesystem.load(filename)()
		if fileconfig._version < defaultconfig._version then
		else
			for k,v in pairs(fileconfig) do
				Config[k] = v
			end
		end
	end
end

function Config.save()
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

function Config.applyDisplayMode()
	local w, h, flags = love.window.getMode()
	local modes = love.window.getFullscreenModes()
	local exclusive = Config.exclusive
	local fullscreen = Config.fullscreen
	local basew, baseh
	if Config.isPortraitRotation() then
		basew = Config.basewindowheight
		baseh = Config.basewindowwidth
	else
		basew = Config.basewindowwidth
		baseh = Config.basewindowheight
	end
	local bestmode
	local maxscale = 1

	if fullscreen and exclusive then
		for i = 1, #modes do
			local mode = modes[i]
			if not bestmode
			or bestmode.width > mode.width
			or bestmode.height > mode.height
			then
				if mode.height >= baseh and mode.width >= basew then
					bestmode = mode
				end
			end
		end
		if bestmode then
			maxscale = math.min(bestmode.width/basew, bestmode.height/baseh)
		end
	else
		local deskwidth, deskheight = love.window.getDesktopDimensions()
		maxscale = math.min(deskwidth/basew, deskheight/baseh)
	end
	maxscale = math.floor(maxscale)
	w = basew*maxscale
	h = baseh*maxscale

	flags.fullscreen = fullscreen
	flags.fullscreentype = exclusive and "exclusive" or "desktop"
	flags.usedpiscale = Config.usedpiscale
	flags.vsync = Config.vsync
	flags.resizable = Config.resizable
	flags.x = nil
	flags.y = nil
	love.window.setMode(w, h, flags)
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