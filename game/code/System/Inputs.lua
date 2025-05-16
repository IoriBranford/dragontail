local Platform = require "System.Platform"
local InputParse = require "System.InputParse"
local InputString= require "System.InputString"

local Inputs = {}

local inputs = {} ---@type {[string]: Input}
local actions = {} ---@type {[string]: InputAction}
local gamepadsbyid = {} ---@type {[integer]: love.Joystick} gamepads by id

---@class InputAction
---@field name string
---@field position number
---@field lastposition number
---@field numinputsdown integer
---@field pressed boolean
---@field down boolean
---@field released boolean

---@alias InputType "key"|"keyaxis"|"gamepadbutton"|"gamepadbuttonaxis"|"gamepadaxis"

---@class Input
---@field type InputType
---@field action InputAction

---@class KeyInput:Input
---@field type "key"
---@field key love.KeyConstant

---@class KeyAxisInput:Input
---@field type "keyaxis"
---@field positive love.KeyConstant
---@field negative love.KeyConstant

---@class GamepadButtonInput:Input
---@field type "gamepadbutton"
---@field gamepadid integer
---@field button love.GamepadButton

---@class GamepadButtonAxisInput:Input
---@field type "gamepadbuttonaxis"
---@field gamepadid integer
---@field positive love.GamepadButton
---@field negative love.GamepadButton

---@class GamepadAxisInput:Input
---@field type "gamepadaxis"
---@field gamepadid integer
---@field axis love.GamepadAxis

local InputPosition = {}

---@param input KeyInput
function InputPosition.key(input)
    return love.keyboard.isDown(input.key) and 1 or 0
end

---@param input KeyAxisInput
function InputPosition.keyaxis(input)
    return (love.keyboard.isDown(input.positive) and 1 or 0)
        - (love.keyboard.isDown(input.negative) and 1 or 0)
end

---@param input GamepadAxisInput
function InputPosition.gamepadaxis(input)
    local gamepad = gamepadsbyid[input.gamepadid]
    return gamepad and gamepad:getGamepadAxis(input.axis) or 0
end

---@param input GamepadButtonInput
function InputPosition.gamepadbutton(input)
    local gamepad = gamepadsbyid[input.gamepadid]
    return gamepad and gamepad:isGamepadDown(input.button) and 1 or 0
end

---@param input GamepadButtonAxisInput
function InputPosition.gamepadbuttonaxis(input)
    local gamepad = gamepadsbyid[input.gamepadid]
    return gamepad and
        ((gamepad:isGamepadDown(input.positive) and 1 or 0)
        - (gamepad:isGamepadDown(input.negative) and 1 or 0))
        or 0
end

function InputPosition.get(input)
    return InputPosition[input.type](input)
end

local function isPositionDown(position)
    return math.abs(position) >= .25
end

function Inputs.initGamepads()
    if love.filesystem.getInfo("data/gamecontrollerdb.txt", "file") then
        love.joystick.loadGamepadMappings("data/gamecontrollerdb.txt")
    end
    if love.filesystem.getInfo("gamecontrollerdb.txt", "file") then
        love.joystick.loadGamepadMappings("gamecontrollerdb.txt")
    end
    local joysticks = love.joystick:getJoysticks()
    for i = 1, #joysticks do
        Inputs.joystickadded(joysticks[i])
    end
end

function Inputs.saveGamepadMappings()
    love.joystick.saveGamepadMappings("gamecontrollerdb.txt")
end

function Inputs.joystickadded(joystick)
    local id = joystick:getID()
    gamepadsbyid[id] = joystick

    if not joystick:isGamepad() then
        local DefaultMapping = "%s,%s,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:%s,"

        local os = Platform.OS
        local GCDBOS = {
            ["OS X"] = "Mac OS X"
        }
        os = GCDBOS[os] or os
        local mapping = string.format(DefaultMapping, joystick:getGUID(), joystick:getName(), os)
        love.joystick.loadGamepadMappings(mapping)
    end
end

function Inputs.getAction(name)
    return actions[name]
end

function Inputs.getOrMakeAction(name)
    local action = actions[name]
    if not action then
        action = {
            name = name,
            position = 0,
            lastposition = 0,
            numinputsdown = 0,
            pressed = false,
            down = false,
            released = false
        }
        actions[name] = action
    end
    return action
end

function Inputs.addInputAction(inputstring, actionname)
    local input = InputParse.parse(inputstring)
    if input then
        input.action = Inputs.getOrMakeAction(actionname)
        inputs[inputstring] = input
        return input
    end
end

function Inputs.addKeyInputAction(keyinput, actionname)
    local key1, key2 = string.match(keyinput, "^(%S+) *(%S*)$")
    local input

    if (key2 or "") ~= "" then
        ---@type KeyAxisInput
        input = {
            type = "keyaxis",
            action = Inputs.getOrMakeAction(actionname),
            negative = key1,
            positive = key2,
        }
        print(key1, key2)
    elseif key1 then
        ---@type KeyInput
        input = {
            type = "key",
            action = Inputs.getOrMakeAction(actionname),
            key = key1,
        }
    end

    if input then
        inputs[InputString.get(input.type, key1, key2)] = input
        return input
    end
end

function Inputs.addKeyboardInputActions(keyinputs)
    for keyinput, actionname in pairs(keyinputs) do
        Inputs.addKeyInputAction(keyinput, actionname)
    end
end

local GamepadInputTypes = {
    leftx = "axis",
    lefty = "axis",
    rightx = "axis",
    righty = "axis",
    triggerleft = "axis",
    triggerright = "axis",
    a = "button",
    b = "button",
    x = "button",
    y = "button",
    leftstick = "button",
    rightstick = "button",
    leftshoulder = "button",
    rightshoulder = "button",
    back = "button",
    start = "button",
    dpup = "button",
    dpdown = "button",
    dpleft = "button",
    dpright = "button",
    guide = "button",
    touchpad = "button",
    paddle1 = "button",
    paddle2 = "button",
    paddle3 = "button",
    paddle4 = "button",
    misc1 = "button"
}

function Inputs.addGamepadInputAction(gamepadid, gamepadinput, actionname)
    local input1, input2 = string.match(gamepadinput, "^(%S+) *(%S*)$")
    local input
    if (input2 or "") ~= "" then
        input = {
            type = "gamepadbuttonaxis",
            action = Inputs.getOrMakeAction(actionname),
            gamepadid = gamepadid,
            negative = input1,
            positive = input2,
        }
    elseif input1 then
        local inputtype = GamepadInputTypes[input1]
        if inputtype then
            input = {
                type = "gamepad"..inputtype,
                action = Inputs.getOrMakeAction(actionname),
                gamepadid = gamepadid,
                [inputtype] = input1
            }
        end
    end

    if input then
        inputs[InputString.get(input.type, gamepadid, input1, input2)] = input
        return input
    end
end

function Inputs.addGamepadInputActions(gamepadid, inputactions)
    for gamepadinputs, actionname in pairs(inputactions) do
        Inputs.addGamepadInputAction(gamepadid, gamepadinputs, actionname)
    end
end

function Inputs.addGamepadsInputActions(inputactions)
    for gamepadid, gamepadinputs in ipairs(inputactions) do
        Inputs.addGamepadInputActions(gamepadid, gamepadinputs)
    end
end

function Inputs.addInputActions(inputactions)
    for inputstring, actionname in pairs(inputactions) do
        Inputs.addInputAction(inputstring, actionname)
    end
end

local InputTypePatterns = {}
for _, inputtype in pairs({"key", "keyaxis", "gamepadbutton", "gamepadaxis", "gamepadbuttonaxis"}) do
    InputTypePatterns[inputtype] = "^%f[%g]"..inputtype.."%f[%G]"
end

function Inputs.getActionsInputs(inputtypes)
    local actionsinputs = {} ---@type {[InputAction]:Input[]}
    for input, action in pairs(inputs) do
        if not inputtypes or inputtypes:find(InputTypePatterns[input.type]) then
            local actioninputs = actionsinputs[action] or {}
            actionsinputs[action] = actioninputs
            actioninputs[#actioninputs+1] = input
        end
    end

    return actionsinputs
end

function Inputs.removeInput(input)
    inputs[input] = nil
end

function Inputs.update()
    for _, action in pairs(actions) do
        action.lastposition = action.position
        action.position = 0
        action.numinputsdown = 0
    end

    for _, input in pairs(inputs) do
        local position = InputPosition.get(input)
        if isPositionDown(position) then
            local action = input.action
            action.position = action.position + position
            action.numinputsdown = action.numinputsdown + 1
        end
    end

    for _, action in pairs(actions) do
        if action.numinputsdown > 1 then
            action.position = action.position / action.numinputsdown
        end

        local wasdown = isPositionDown(action.lastposition)
        if isPositionDown(action.position) then
            action.down = true
            action.pressed = not wasdown
            action.released = false
        else
            action.down = false
            action.pressed = false
            action.released = wasdown
        end
    end
end

return Inputs