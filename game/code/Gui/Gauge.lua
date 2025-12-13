local GuiObject = require "Gui.GuiObject"

---@class Gauge:GuiObject
---@field gaugedirection "right"|"down"|"left"|"up"
---@field roundmode "up"|"down"
local Gauge = class(GuiObject)

function Gauge:spawn()
    GuiObject.spawn(self)
    self.gaugedirection = self.gaugedirection or "right"
    self:setPercent(self.gaugepercent or 1)
    self.baseDraw = self.draw
    self.draw = Gauge.draw
end

function Gauge:draw()
    local w, h = self.gaugewidth, self.gaugeheight
    if w <= 0 or h <= 0 then
        return
    end
    local x, y = self.gaugex, self.gaugey
    local x2, y2 = love.graphics.transformPoint(x+w, y+h)
    x, y = love.graphics.transformPoint(x, y)
    love.graphics.setScissor(x, y, x2-x, y2-y)
    self:baseDraw()
    love.graphics.setScissor()
end

function Gauge:setPercent(percent)
    self.gaugepercent = percent
    self.gaugex = self.x
    self.gaugey = self.y
    local tile = self.tile
    if tile then
        self.gaugex = self.gaugex - tile.objectoriginx
        self.gaugey = self.gaugey - tile.objectoriginy
    end
    self.gaugewidth = self.width
    self.gaugeheight = self.height

    local round = self.roundmode == "up" and math.ceil or math.floor
    if self.gaugedirection == "right" or self.gaugedirection == "left" then
        self.gaugewidth = round(self.gaugewidth*percent)
    elseif self.gaugedirection == "down" or self.gaugedirection == "up" then
        self.gaugeheight = round(self.gaugeheight*percent)
    end
    if self.gaugedirection == "up" then
        self.gaugey = self.gaugey + self.height - self.gaugeheight
    elseif self.gaugedirection == "left" then
        self.gaugex = self.gaugex + self.width - self.gaugewidth
    end
end

return Gauge