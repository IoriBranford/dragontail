local Audio     = require "System.Audio"
local Button    = require "Gui.Button"
local Config    = require "System.Config"

---@class Slider:Button
---@field increment number
---@field max number
---@field min number
---@field units "percent"?
---@field valuedescription GuiObject?
---@field valuesetaction string?
---@field refreshaction string?
local Slider = class(Button)
Slider.ismenuitem = true

function Slider:spawn()
    Button.spawn(self)
    local valuestrings
    if type(self.valuestrings) == "string" then
        valuestrings = {}
        for valuestring in self.valuestrings:gmatch("[^\n^$]+") do
            valuestrings[#valuestrings+1] = valuestring
        end
        self.valuestrings = valuestrings
    elseif not self.valuestrings then
        valuestrings = {}
        for i = 1, 16 do
            local valuestr = self["valuestr"..i]
            if not valuestr then
                break
            end
            valuestrings = valuestrings or {}
            valuestrings[i] = valuestr
        end
        self.valuestrings = valuestrings
    end
end

function Slider:getValueAsString(value)
    local typ = type(value)
    if typ == "number" then
        local units = self.units
        if units == "percent" then
            return tostring(math.floor(value*100))
        end
    elseif typ == "boolean" then
        return value and "ON" or "OFF"
    end
    return tostring(value)
end

function Slider:setValue(value)
    self.value = value
    self:setString(self:getValueAsString(value))
    self:doAction(self.valuesetaction)
end

function Slider:changeValue(dir)
    if self.action == "bindInput" then
        return
    end
    dir = dir / math.abs(dir)
    local value = self.value
    local valuetype = type(value)
    if valuetype == "number" then
        local increment = self.increment
            or self.percent and 1/16
            or 1
        value = value + (increment * dir)
        local min = self.min
        local max = self.max
        if value > max then
            value = min
        elseif value < min then
            value = max
        end
    elseif valuetype == "boolean" then
        value = not value
    elseif valuetype == "string" then
        local newvalue
        for i = 1, #self.valuestrings do
            if value == self.valuestrings[i] then
                local j = i + dir
                if j > #self.valuestrings then
                    j = 1
                elseif j < 1 then
                    j = #self.valuestrings
                end
                newvalue = self.valuestrings[j]
                break
            end
        end
        if not newvalue then
            local valuestrdefault = self.valuestrdefault or 1
            newvalue = self.valuestrings[valuestrdefault]
        end
        if newvalue == "true" then newvalue = true end
        if newvalue == "false" then newvalue = false end
        value = newvalue or value
    end
    Audio.play(self.changesound)
    Config[self.configkey] = value
    self.menu:loadConfigValues()
    self:doAction(self.refreshaction)
end

Slider.action = "incSlider"

function Slider:loadConfigValue()
    self:setValue(Config[self.configkey])
end

function Slider:storeConfigValue()
    Config[self.configkey] = self.value
end

function Slider:setValueDescription(text)
    local valuedescription = self.valuedescription
    if valuedescription then
        valuedescription:setString(text)
    end
end

return Slider