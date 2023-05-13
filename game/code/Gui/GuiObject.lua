local TiledObject = require "Tiled.Object"
local Color       = require "Data.Color"

---@class GuiObject
---@field gui Gui
----@field sprite SceneObject
local GuiObject = class(TiledObject)

function GuiObject:_init()
    local points = self.points
    if points then
        local x1, y1, x2, y2 = math.huge, math.huge, -math.huge, -math.huge
        for i = 2, #points, 2 do
            local x, y = points[i-1], points[i]
            x1 = math.min(x1, x)
            y1 = math.min(y1, y)
            x2 = math.max(x2, x)
            y2 = math.max(y2, y)
        end
        self.leftx = self.x + x1
        self.topy = self.y + y1
        self.width = x2-x1
        self.height = y2-y1
    elseif self.tile then
        self.leftx = self.x - self.tile.objectoriginx
        self.topy = self.y - self.tile.objectoriginy
    else
        self.leftx, self.topy = self.x, self.y
    end
    self.x0, self.y0 = self.x, self.y
end

function GuiObject:doAction(action)
    if type(action) ~= "function" then
        action = self[action]
    end
    if type(action) == "function" then
        action(self)
    end
end

function GuiObject:setString(string)
    self.text = string
end

function GuiObject:setColor(r, g, b, a)
    self.color = Color.asARGBInt(r,g,b,a)
end

function GuiObject:resetPosition()
    self:setPosition(self.x0, self.y0)
end

function GuiObject:translate(dx, dy)
    local x = self.x + dx
    local y = self.y + dy
    self.x, self.y = x, y
    self.leftx = self.leftx + dx
    self.topy = self.topy + dy
    for i = 1, #self do
        self[i]:translate(dx, dy)
    end
end

function GuiObject:setPosition(x, y)
    self:translate(x - self.x, y - self.y)
end

function GuiObject:setVisible(visible)
    self.visible = visible
end

function GuiObject:hideChildrenIf(condition)
    if not condition then
        return
    end
    for _, child in ipairs(self) do
        child:setVisible(condition(child))
    end
end

function GuiObject:showOnlyChildren(...)
    local n = select("#", ...)
    if n < 1 then
        return
    end

    for _, child in ipairs(self) do
        local name = child.name or ""
        local visible = false
        if name ~= "" then
            for arg = 1, n do
                if name == select(arg, ...) then
                    visible = true
                    break
                end
            end
        end
        child:setVisible(visible)
    end
end

function GuiObject:reanchor(guiwidth, guiheight, screenwidth, screenheight)
    local anchorx = self.anchorx or 0
    local anchory = self.anchory or 0
    local dx = anchorx * (screenwidth-guiwidth)/2
    local dy = anchory * (screenheight-guiheight)/2
    self:resetPosition()
    self:translate(dx, dy)
    for i = 1, #self do
        self[i]:reanchor(guiwidth, guiheight, screenwidth, screenheight)
    end
end

return GuiObject