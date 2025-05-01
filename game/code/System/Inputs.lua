
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

---@class KeyInput:Input
---@field type "key"
---@field key love.KeyConstant

---@class KeyAxisInput:Input
---@field type "keyaxis"
---@field positive love.KeyConstant
---@field negative love.KeyConstant

---@class GamepadButtonInput:Input
---@field type "gamepadbutton"
---@field gamepad love.Joystick
---@field button love.GamepadButton

---@class GamepadButtonAxisInput:Input
---@field type "gamepadbuttonaxis"
---@field gamepad love.Joystick
---@field positive love.GamepadButton
---@field negative love.GamepadButton

---@class GamepadAxisInput:Input
---@field type "gamepadaxis"
---@field gamepad love.Joystick
---@field axis love.GamepadAxis

local function getGamepadByID(id)
    local joysticks = love.joystick.getJoysticks() ---@type love.Joystick[]
    for _, joystick in ipairs(joysticks) do
        if id == joystick:getID() then
            return joystick
        end
    end
end

local InputString = {}
local InputParse = {}

function InputString.key(key)
    return string.format("key %s", key)
end

---@return KeyInput?
function InputParse.key(s)
    local key = string.match(s, "^key (%S+)$")
    return {
        type = "key", key = key
    }
end

function InputString.keyaxis(negative, positive)
    return string.format("keyaxis %s %s", negative, positive)
end

---@return KeyAxisInput?
function InputParse.keyaxis(s)
    local negative, positive = string.match(s, "^keyaxis (%S+) (%S+)$")
    return {
        type = "keyaxis", negative = negative, positive = positive
    }
end

function InputString.gamepadaxis(gamepadid, axis)
    return string.format("pad%d axis %s", gamepadid, axis)
end

function InputParse.pad(s)
    local gamepadid, inputtype, values = string.match(s, "^pad(%d+) (%w+) ([%w ]+)$")
    local padparse = InputParse[inputtype]
    return padparse and padparse({
        gamepadid = gamepadid,
        gamepad = getGamepadByID(gamepadid)
    }, values)
end

---@return GamepadAxisInput?
function InputParse.axis(input, axis)
    input.type = "gamepadaxis"
    input.axis = axis
    return input
end

function InputString.gamepadbutton(gamepadid, button)
    return string.format("pad%d button %s", gamepadid, button)
end

---@return GamepadButtonInput?
function InputParse.button(input, button)
    input.type = "gamepadbutton"
    input.button = button
    return input
end

function InputString.gamepadbuttonaxis(gamepadid, negative, positive)
    return string.format("pad%d buttonaxis %s %s", gamepadid, negative, positive)
end

function InputParse.buttonaxis(input, values)
    local negative, positive = string.match(values, "^(%w+) (%w+)$")
    input.type = "gamepadbuttonaxis"
    input.negative = negative
    input.positive = positive
    return input
end

function InputString.get(type, ...)
    return InputString[type](...)
end

function InputParse.parse(s)
    local device = string.match(s, "^(%a+)")
    local parse = InputParse[device]
    if parse then return parse(s) end
end

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
    return input.gamepad:getGamepadAxis(input.axis)
end

---@param input GamepadButtonInput
function InputPosition.gamepadbutton(input)
    return input.gamepad:isGamepadDown(input.button) and 1 or 0
end

---@param input GamepadButtonAxisInput
function InputPosition.gamepadbuttonaxis(input)
    return (input.gamepad:isGamepadDown(input.positive) and 1 or 0)
        - (input.gamepad:isGamepadDown(input.negative) and 1 or 0)
end

function InputPosition.get(input)
    return InputPosition[input.type](input)
end

local Inputs = {}

local inputs = {} ---@type {[Input]: InputAction}
local actions = {} ---@type {[string]: InputAction}

local function isPositionDown(position)
    return math.abs(position) >= .25
end

function Inputs.getAction(name)
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

function Inputs.addMapping(inputstring, actionname)
    local input = InputParse.parse(inputstring)
    if input then
        local action = Inputs.getAction(actionname)
        inputs[input] = action
        return action
    end
end

function Inputs.addMappings(mappings)
    for inputstring, actionname in pairs(mappings) do
        Inputs.addMapping(inputstring, actionname)
    end
end

function Inputs.update()
    for _, action in pairs(actions) do
        action.lastposition = action.position
        action.position = 0
        action.numinputsdown = 0
    end

    for input, action in pairs(inputs) do
        local position = InputPosition.get(input)
        if isPositionDown(position) then
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