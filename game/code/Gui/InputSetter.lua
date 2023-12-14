local Slider = require "Gui.Slider"
local Button = require "Gui.Button"
local Config = require "System.Config"
local ControllerInputNames = require "ControllerInputNames"

---@class InputSetter:Slider
local InputSetter = class(Slider)

InputSetter.ReservedButtons = {
    start = true,
    back = true,
    guide = true
}

InputSetter.ReservedKeys = {
    ["return"] = true,
    escape = true
}

function InputSetter:spawn()
    Slider.spawn(self)
end

function InputSetter:getValueAsString(value)
    if self.inputdevice == "controller" then
        local names = ControllerInputNames[Config.joy_namingscheme or "XBOX"]
        if names then
            return names[value] or tostring(value)
        end
    end
    return tostring(value):upper()
end

function InputSetter:changeValue(_)
    self:setValue("...")
    self.menu:setActiveInputSetter(self)
end

return InputSetter