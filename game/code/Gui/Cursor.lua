local GuiObject = require "Gui.GuiObject"
local Audio     = require "System.Audio"

---@class Cursor:GuiObject
local Cursor = class(GuiObject)
Cursor.iscursor = true

function Cursor:spawn()
    GuiObject.spawn(self)
    self.alignx = self.alignx or 0
    self.aligny = self.aligny or 0
end

function Cursor:onSelect(i, item)
end

function Cursor:moveToMenuItem(item)
    local width, height = self.width, self.height
    local itemwidth, itemheight = item.width, item.height
    local offsetx = (width + itemwidth) / 2
    local offsety = (height + itemheight) / 2
    self.x = item.x + itemwidth/2 + offsetx * self.alignx
    self.y = item.y + itemheight/2 + offsety * self.aligny
end

function Cursor:onMoveTo(i, item)
    Audio.play(self.movesound)
end

return Cursor