local Platform = require "System.Platform"

---@class Controls
local Controls = {}
Controls.usesgamepads = false

function Controls.init()
    if Controls.usesgamepads then
        if love.filesystem.getInfo("data/gamecontrollerdb.txt", "file") then
            love.joystick.loadGamepadMappings("data/gamecontrollerdb.txt")
        end
        if love.filesystem.getInfo("gamecontrollerdb.txt", "file") then
            love.joystick.loadGamepadMappings("gamecontrollerdb.txt")
        end
        local joysticks = love.joystick:getJoysticks()
        for i = 1, #joysticks do
            local joystick = joysticks[i]
            Controls.ensureGamepadMapping(joystick)
        end
    end
end

function Controls.quit()
    if Controls.usesgamepads then
        love.joystick.saveGamepadMappings("gamecontrollerdb.txt")
    end
end

function Controls.joystickadded(joystick)
    if Controls.usesgamepads then
	    Controls.ensureGamepadMapping(joystick)
    end
end

function Controls.keypressed(key)
end

function Controls.gamepadpressed(joystick, button)
end

function Controls.getButtonsPressed()
end

function Controls.clearButtonsPressed()
end

local DefaultMapping = "%s,%s,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:%s,"

function Controls.ensureGamepadMapping(joystick)
	if not joystick:isGamepad() then
		local os = Platform.OS
		local GCDBOS = {
			["OS X"] = "Mac OS X"
		}
		os = GCDBOS[os] or os
		local mapping = string.format(DefaultMapping, joystick:getGUID(), joystick:getName(), os)
		love.joystick.loadGamepadMappings(mapping)
	end
end

return Controls