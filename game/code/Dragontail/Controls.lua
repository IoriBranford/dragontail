local Config = require "System.Config"

---@class GameControls:Controls
local Controls = require "System.Controls"
Controls.usesgamepads = true

local buttonspressed = {}

function Controls.getDirectionInput()
	local numinputs = 0
	local x, y = 0, 0
	local deadzonesq = 1/16

	local joysticks = love.joystick:getJoysticks()
	for i = 1, #joysticks do
		local joystick = joysticks[i]
		local jx = joystick:getGamepadAxis("leftx")
		local jy = joystick:getGamepadAxis("lefty")
		local hl = joystick:isGamepadDown("dpleft")
		local hr = joystick:isGamepadDown("dpright")
		local hu = joystick:isGamepadDown("dpup")
		local hd = joystick:isGamepadDown("dpdown")
		if jx*jx + jy*jy > deadzonesq then
			numinputs = numinputs + 1
			x = x + jx
			y = y + jy
		end
		if hl or hr or hu or hd then numinputs = numinputs + 1 end
		if hl then x = x - 1 end
		if hr then x = x + 1 end
		if hu then y = y - 1 end
		if hd then y = y + 1 end
	end

	local kl = love.keyboard.isDown(Config.key_left)
	local kr = love.keyboard.isDown(Config.key_right)
	local ku = love.keyboard.isDown(Config.key_up)
	local kd = love.keyboard.isDown(Config.key_down)
	if kl or kr or ku or kd then numinputs = numinputs + 1 end
	if kl then x = x - 1 end
	if kr then x = x + 1 end
	if ku then y = y - 1 end
	if kd then y = y + 1 end

	if numinputs > 1 then
		x = x / numinputs
		y = y / numinputs
	end
	return x, y
end

function Controls.getButtonsDown()
	local fire = love.keyboard.isDown(Config.key_fire)
	local focus = love.keyboard.isDown(Config.key_focus)
	local bomb = love.keyboard.isDown(Config.key_bomb)

	local joysticks = love.joystick:getJoysticks()
	for i = 1, #joysticks do
		local joystick = joysticks[i]
		fire  = fire  or joystick:isGamepadDown(Config.joy_fire)
		focus = focus or joystick:isGamepadDown(Config.joy_focus)
		bomb  = bomb  or joystick:isGamepadDown(Config.joy_bomb)
	end
	return fire, focus, bomb
end

function Controls.getButtonsPressed()
	return buttonspressed.fire, buttonspressed.focus, buttonspressed.bomb, buttonspressed.pause
end

function Controls.keypressed(key)
	if key == Config.key_fire then
		buttonspressed.fire = true
	elseif key == Config.key_focus then
		buttonspressed.focus = true
	elseif key == Config.key_bomb then
		buttonspressed.bomb = true
	elseif key == Config.key_pausemenu then
		buttonspressed.pause = true
	end
end

function Controls.gamepadpressed(joystick, button)
	if button == Config.joy_fire then
		buttonspressed.fire = true
	elseif button == Config.joy_focus then
		buttonspressed.focus = true
	elseif button == Config.joy_bomb then
		buttonspressed.bomb = true
	elseif button == Config.joy_pausemenu then
		buttonspressed.pause = true
	end
end

function Controls.clearButtonsPressed()
	for k,v in pairs(buttonspressed) do
		buttonspressed[k] = nil
	end
end

function Controls.updateDialogueState(dialoguestate)
	if not Config.game_dialogue or dialoguestate == "skip" then
		return "skip"
	end
	local fire, focus, bomb, pause = Controls.getButtonsPressed()
	if pause then
		return "skip"
	end
	if fire or focus or bomb then
		return "advance"
	end
end

return Controls