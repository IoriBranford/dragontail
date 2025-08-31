local GuiObject    = require "Gui.GuiObject"
local GuiActions   = require "Gui.GuiActions"
local Graphics     = require "Tiled.Graphics"
local Color        = require "Tiled.Color"

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
        self:onDeselect()
        self:doAction(self.action)
    end
end

function Button:onSelect()
end

function Button:onDeselect()
end

return Button