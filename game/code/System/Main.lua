class = require "class"
require "Math"
require "Coroutine"
local Audio = require "System.Audio"
local Config = require "System.Config"
local Platform = require "System.Platform"
local Time   = require "System.Time"
local cute = require "cute"
local haslldebugger, lldebugger = pcall(require, "lldebugger")
local Account                   = require("System.Account")
local Inputs                    = require("System.Inputs")
if not haslldebugger then
    lldebugger = nil
end

local profile
local game
local dsecs = 0
local dfixed = 0
local numfixed = 0
local fixedfrac = 0
local fixedrate = Time.FixedUpdateRate
local fixedlimit = 1
local variableupdate = true

local blankphase = {}
function blankphase.loadphase() end
function blankphase.fixedupdate() end
function blankphase.update(dsecs, fixedfrac) end
function blankphase.draw(fixedfrac) end
function blankphase.quitphase() end

function blankphase.displayrotated(index, orientation) end
function blankphase.directorydropped(path) end
function blankphase.filedropped(file) end
function blankphase.focus(focus) end
function blankphase.mousefocus(focus) end
function blankphase.resize(w, h) end
function blankphase.visible(visible) end

function blankphase.keypressed(key, scancode, isrepeat) end
function blankphase.keyreleased(key, scancode) end
function blankphase.textedited(text, start, length) end
function blankphase.textinput(text) end

function blankphase.mousemoved(x, y, dx, dy, istouch) end
function blankphase.mousepressed(x, y, button, istouch, presses) end
function blankphase.mousereleased(x, y, button, istouch, presses) end
function blankphase.wheelmoved(x, y) end

function blankphase.joystickadded(joystick) end
function blankphase.joystickremoved(joystick) end
function blankphase.gamepadaxis(joystick, axis, value) end
function blankphase.gamepadpressed(joystick, button) end
function blankphase.gamepadreleased(joystick, button) end

function blankphase.touchmoved(id, x, y, dx, dy, pressure) end
function blankphase.touchpressed(id, x, y, dx, dy, pressure) end
function blankphase.touchreleased(id, x, y, dx, dy, pressure) end

function love.event.loadphase(name, ...)
    love.event.push("loadphase", name, ...)
end

function love.handlers.loadphase(name, ...)
    local nextphase = require(name)
    if love.quitphase then
        love.quitphase()
    end
    love.currentphase = nextphase
    for k, v in pairs(blankphase) do
        love[k] = nextphase[k] or v
    end
    if love.loadphase then
        love.loadphase(...)
    end
    collectgarbage()
    if love.timer then
        love.timer.step()
        fixedfrac = 0
    end
end

local keypressedhandler = love.handlers.keypressed
function love.handlers.keypressed(...)
    keypressedhandler(...)
    cute.keypressed(...)
end

local joystickaddedhandler = love.handlers.joystickadded
function love.handlers.joystickadded(...)
    Inputs.joystickadded(...)
    joystickaddedhandler(...)
end

-- love.resize not triggered when quickly resizing a window
-- https://github.com/love2d/love/issues/2188
local resizehandler = love.handlers.resize
function love.handlers.resize(_, _)
    resizehandler(love.graphics.getDimensions())
end

local function OnQuit()
    if love.quitphase then
        love.quitphase()
    end
    Audio.stop()
    Config.save()
    Account.quit()
	if profile then
        profile.stop()
	end
end

function love.run()
    require("pl.strict").module("_G", _G)
    cute.go(love.arg.parseGameArguments(arg))

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
        profile = require("jit.p")
        local filename = love.filesystem.getSaveDirectory().."/"..os.date("profile_%Y-%m-%d_%H-%M-%S")..".txt"
		profile.start("Fli1", filename)
	end

    Config.debug = args.debug
	if args.debug and lldebugger then
		lldebugger.start()
		-- lldebugger.off()
	end

    if love.load then
        love.load(args)--love.arg.parseGameArguments(arg), arg)
    end
    collectgarbage()

    Account.init()

    local SystemFont = love.graphics.newFont(12)

    -- We don't want the first frame's dsecs to include time taken by love.load.
    if love.timer then
        love.timer.step()
    end

    local mainloop = function()
        -- Process events.
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        OnQuit()
                        return a or 0
                    end
                else
                    love.handlers[name](a, b, c, d, e, f)
                end
            end
        end

        Account.update()

        -- Update dsecs, as we'll be passing it to update
        if love.timer then
            dsecs = love.timer.step()
        end

        variableupdate = Config.variableupdate

        -- Call update and draw
        if love.fixedupdate then
            dfixed = dsecs * fixedrate
            fixedfrac = fixedfrac + dfixed
            numfixed, fixedfrac = math.modf(fixedfrac)
            numfixed = math.min(numfixed, fixedlimit)
            for i = 1, numfixed do
                Inputs.update()
                love.fixedupdate()
            end
        end

        if love.update then
            if variableupdate then
                love.update(dsecs, fixedfrac)
            elseif numfixed > 0 then
                love.update(numfixed / fixedrate, 0)
            end
        end -- will pass 0 if love.timer is disabled

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then
                love.draw(variableupdate and fixedfrac or 0)
            end

            love.graphics.setFont(SystemFont)
            cute.draw()

            if Config.drawstats then
                love.graphics.setColor(1,1,1)
                love.graphics.printf(tostring(love.timer.getFPS()).." fps", 0, 0, love.graphics.getWidth(), "right")
                love.graphics.printf(tostring(math.floor(collectgarbage("count"))).." kb", 0, 16, love.graphics.getWidth(), "right")
            end

            love.graphics.present()
        end

        collectgarbage("step", 1)
        if love.timer then
            love.timer.sleep(0.001)
        end
    end

    return mainloop
end

return function(gamename)
    game = require(gamename)
end