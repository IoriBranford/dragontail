local TiledObject = require "Tiled.Object"
local Color       = require "Tiled.Color"
local GuiActions  = require "Gui.GuiActions"
local Config      = require "System.Config"

---@class GuiObject:TiledObject
---@field gui Gui
----@field sprite SceneObject
local GuiObject = class(TiledObject)

function GuiObject:spawn()
    self.x0, self.y0 = self.x, self.y
end

---@param self GuiObject|Menu
function GuiObject:doAction(action)
    if type(action) ~= "function" then
        local ok, actions = pcall(require, self.actionsmodule or "Gui.GuiActions")
        action = ok and actions[action] or GuiActions.playInvalidSound
    end
    action(self.gui, self)
end

function GuiObject:setString(string)
    self.text = string
    self.text0 = nil
end

function GuiObject:setColor(r, g, b, a)
    self.color = Color.asARGBInt(r,g,b,a)
end

function GuiObject:resetPosition()
    self.x, self.y = self.x0, self.y0
end

function GuiObject:reanchor(guiwidth, guiheight, screenwidth, screenheight)
    local anchorx = self.anchorx or 0
    local anchory = self.anchory or 0
    local dx = anchorx * (screenwidth-guiwidth)/2
    local dy = anchory * (screenheight-guiheight)/2
    self:resetPosition()
    self:move(dx, dy)
    for i = 1, #self do
        self[i]:reanchor(guiwidth, guiheight, screenwidth, screenheight)
    end
end

function GuiObject:loadConfigValue()
    local text0 = self.text0 or self.text ---@type string
    if text0 then
        local text = Config.gsub(text0)
        if text ~= text0 then
            self.text0 = text0
            self.text = text
        end
    end
end

return GuiObject