local GuiObject    = require "Gui.GuiObject"

---@class Button:GuiObject
---@field label GuiObject?
local Button = class(GuiObject)
Button.ismenuitem = true

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
    self:onDeselect()
    self:doAction(self.action)
end

function Button:onSelect()
end

function Button:onDeselect()
end

return Button