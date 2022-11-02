local class = require "pl.class"
local GuiObject = require "Gui.GuiObject"
local Color     = require "Data.Color"

local Gauge = class(GuiObject)

function Gauge:init()
    Gauge:cast(self)
    self.gaugedirection = self.gaugedirection or "right"
    self:setPercent(self.gaugepercent or 1)

    local basedraw = self.sprite.draw
    self.sprite.draw = function(sprite)
        love.graphics.setScissor(self.gaugex, self.gaugey, self.gaugewidth, self.gaugeheight)
        basedraw(sprite)
        love.graphics.setScissor()
    end
end

function Gauge:setPercent(percent)
    self.gaugepercent = percent
    self.gaugex = self.sprite.x - self.sprite.ox
    self.gaugey = self.sprite.y - self.sprite.oy
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