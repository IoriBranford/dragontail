local GuiObject = require "Gui.GuiObject"
local TiledObject    = require "Tiled.Object"

local Gauge = class(GuiObject)

function Gauge:_init()
    GuiObject._init(self)
    self.gaugedirection = self.gaugedirection or "right"
    self:setPercent(self.gaugepercent or 1)
    self.baseDraw = self.draw
    self.draw = Gauge.draw
end

function Gauge:draw()
    local w, h = self.gaugewidth, self.gaugeheight
    -- if w <= 0 or h <= 0 then
    --     return
    -- end
    love.graphics.setScissor(self.gaugex, self.gaugey, w, h)
    self:baseDraw()
    love.graphics.setScissor()
end

function Gauge:setPercent(percent)
    self.gaugepercent = percent
    self.gaugex = self.x
    self.gaugey = self.y
    local tile = self.tile
    if tile then
        self.gaugex = self.gaugex - self.tile.objectoriginx
        self.gaugey = self.gaugey - self.tile.objectoriginy
    end
    self.gaugewidth = self.width
    self.gaugeheight = self.height
    if self.gaugedirection == "right" or self.gaugedirection == "left" then
        self.gaugewidth = self.gaugewidth*percent
    elseif self.gaugedirection == "down" or self.gaugedirection == "up" then
        self.gaugeheight = self.gaugeheight*percent
    end
    if self.gaugedirection == "up" then
        self.gaugey = self.gaugey + self.height - self.gaugeheight
    elseif self.gaugedirection == "left" then
        self.gaugex = self.gaugex + self.width - self.gaugewidth
    end
end

return Gauge