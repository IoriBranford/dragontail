class = require "class"
pooledclass = require "pooledclass"
require "Math"
require "math123".goGlobal()
require "Coroutine"

require "love.eventconnect"
love.event.addSelfLoveEvents("%s_s")
love.event.newEvents("newphase", "loadphase", "quitphase", "fixedupdate", "lerpdraw", "fixedupdate_s", "lerpdraw_s")

local Audio = require "System.Audio"
local Config = require "System.Config"
local Platform = require "System.Platform"
local Time   = require "System.Time"
local cute = require "cute"
local haslldebugger, lldebugger = pcall(require, "lldebugger")
local Account                   = require("System.Account")
local Inputs                    = require("System.Inputs")
local fixedupdate               = require("fixedupdate")
if not haslldebugger then
    lldebugger = nil
end

local profile
local game
local fixedfrac = 0

function love.event.newphase(name, ...)
    love.event.push("newphase", name, ...)
end

function love.newphase(name, ...)
    local nextphase = require(name)
    love.event.send("quitphase")

    love.currentphase = nextphase
    love.event.resetConnections()
    love.event.connectAll(nextphase)
    love.event.send("loadphase", ...)
    collectgarbage()
    if love.timer then
        love.timer.step()
        fixedfrac = 0
    end
end

function love.keypressed(...)
    cute.keypressed(...)
end

function love.joystickadded(...)
    Inputs.joystickadded(...)
end

-- love.resize not triggered when quickly resizing a window
-- https://github.com/love2d/love/issues/2188
function love.resize(w, h)
    return "args", love.graphics.getDimensions()
end

function love.quit()
    love.event.send("quitphase")
    if game.quit then
        game.quit()
    end
    Audio.stop()
    Config.save()
    Account.quit()
	if profile then
        profile.stop()
	end
end

local SystemFont

function love.load(args)
    require("pl.strict").module("_G", _G)
    cute.go(args)

    Config.load(game.defaultconfig)

    local cli = love.filesystem.getIdentity()..[[

    --console               Output to a console window
    --version               Print LOVE version
    --fused                 Force running in fused mode
    --debug                 Debug with tomblind.local-lua-debugger-vscode
    --cute                  Run Cute unit tests
    --profile               Profile code performance
    --os (optional string)  Fake a certain OS for testing
]]..Config.cli

    if not love.filesystem.isFused() then
        cli = cli .. [[
    <game> (string)         Game assets location
]]
    end
    if game.cli then
        cli = cli..game.cli
    end

	local lapp = require "pl.lapp"
	lapp.slack = true
	local args = lapp (cli)

    Platform.setOS(args.os)

	if args.profile then
        jit.off()
        profile = require("jit.p")
        local filename = love.filesystem.getSaveDirectory().."/"..os.date("profile_%Y-%m-%d_%H-%M-%S")..".txt"
		profile.start("Fli1", filename)
	end

    Config.debug = args.debug
	if args.debug and lldebugger then
		lldebugger.start()
		-- lldebugger.off()
	end

    if game.load then
        game.load(args)
    end
    collectgarbage()

    Account.init()

    SystemFont = love.graphics.newFont(12)
end

local statsreport = {}

function love.update(dsecs)
    Account.update()

    Audio.update(dsecs)

    local fixedrate = Config.fixedupdaterate
    fixedfrac = fixedupdate(fixedrate, fixedfrac, dsecs,
    function()
        Inputs.update()
        love.event.send("fixedupdate")
    end)
end

function love.draw()
    local variableupdate = Config.variableupdate
    -- coroutine.yield("args", variableupdate and fixedfrac or 0)
    love.event.send("lerpdraw", variableupdate and fixedfrac or 0)

    love.graphics.setFont(SystemFont)
    cute.draw()

    if Config.drawstats then
        statsreport[#statsreport+1] = tostring(love.timer.getFPS()).." fps"
        statsreport[#statsreport+1] = tostring(math.floor(collectgarbage("count"))).." kb"
    end

    if Config.drawgraphicstats then
        local gfxstats = love.graphics.getStats()
        statsreport[#statsreport+1] = tostring(gfxstats.images).." images"
        statsreport[#statsreport+1] = tostring(gfxstats.canvases).." canvases"
        statsreport[#statsreport+1] = tostring(gfxstats.fonts).." fonts"
        statsreport[#statsreport+1] = tostring(gfxstats.texturememory).." bytes vram"
        statsreport[#statsreport+1] = tostring(gfxstats.drawcalls).." draw calls"
        statsreport[#statsreport+1] = tostring(gfxstats.drawcallsbatched).." draw calls batched"
        statsreport[#statsreport+1] = tostring(gfxstats.shaderswitches).." shader switches"
        statsreport[#statsreport+1] = tostring(gfxstats.canvasswitches).." canvas switches"
    end

    local y = 0
    for i = 1, #statsreport do
        love.graphics.setColor(1,1,1)
        love.graphics.printf(statsreport[i], 0, y, love.graphics.getWidth(), "right")
        y = y + SystemFont:getHeight()
    end
    for i = #statsreport, 1, -1 do
        statsreport[i] = nil
    end
end

return function(gamename)
    game = require(gamename)
end