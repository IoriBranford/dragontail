local GuiObject    = require "Gui.GuiObject"
local GuiActions   = require "Gui.GuiActions"
local Graphics     = require "Tiled.Graphics"
local Color        = require "Tiled.Color"
local Audio        = require "System.Audio"

---@class Button:GuiObject
---@field action string
---@field label GuiObject?
---@field disabled boolean
---@field disabledcolor Color?
local Button = class(GuiObject)
Button.ismenuitem = true

function Button:spawn()
    self.color0 = self.color
end

function Button:setDisabled(disabled)
    self.disabled = disabled
    local disabledcolor = self.disabledcolor or Color.Grey
    self.color = disabled and disabledcolor or self.color0
end

function Button:setVisible(visible)
    GuiObject.setVisible(self, visible)
    if self.label then
        self.label:setVisible(visible)
    end
end

function Button:setLabelString(string)
    if self.label then
        self.label:setString(string)
    end
end

function Button:press()
    if self.disabled then
        GuiActions.playInvalidSound(self.gui, self)
    else
        Audio.play(self.presssound)
        self:onDeselect()
        self:doAction(self.action)
    end
end

function Button:onSelect()
    self.animate = self[self.selectanimation]
    self.color = self.color1 or self.color
end

function Button:onDeselect()
    self.animate = self[self.deselectanimation]
    self.color = self.color1 or self.color
end

function Button:colorCycle()
    local t = love.timer.getTime()

    local f = math.max(1, self.frequency or 1)
    local c = (math.cos(t*f) + 1)/2

    local color1 = self.color1 or self.color or Color.White
    self.color1 = color1
    local color2 = self.color2 or Color.Yellow

    local r1, g1, b1, a1 = Color.unpack(color1)
    local r2, g2, b2, a2 = Color.unpack(color2)
    self.color = Color.asARGBInt(
        math1.lerp(c, r1, r2),
        math1.lerp(c, g1, g2),
        math1.lerp(c, b1, b2),
        math1.lerp(c, a1, a2)
    )
end

return Button