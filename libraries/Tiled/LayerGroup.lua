local class = require "Tiled.class"
local Graphics = require "Tiled.Graphics"

---@class LayerGroup:Layer
---@field layers Layer[] Copied to layer's array part
---@field [integer] Layer Copied from layers
---@field [string] Layer Layers in group by name
local LayerGroup = class()

local _transform = love.math.newTransform()

function LayerGroup:_init()
    local grouplayers = self.layers
    for i = 1, #grouplayers do
        self[i] = grouplayers[i]
    end
    self.layers = nil
end

function LayerGroup:animate(dt)
    for _, object in ipairs(self) do
        if object.animate then
            object:animate(dt)
        end
    end
end

local pushTransform = Graphics.pushTransform

function LayerGroup:draw()
    pushTransform(self)
    for _, layer in ipairs(self) do
        if layer.visible then
            layer:draw()
        end
    end
    love.graphics.pop()
end

return LayerGroup