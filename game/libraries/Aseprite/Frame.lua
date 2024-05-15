local class = require "Aseprite.class"

---@class AseCel
---@field x number
---@field y number
---@field quad love.Quad

---@alias Rect {x: number, y: number, w: number, h: number}
---@alias Size {w: number, h: number}

---@class AseFrame
---@field image love.Image
---@field frame Rect
---@field rotated boolean
---@field trimmed boolean
---@field spriteSourceSize Rect
---@field sourceSize Size
---@field duration number
---@field [integer] AseCel
local AseFrame = class()

function AseFrame:_init(image, duration)
    self.image = image
    self.duration = duration or 0
end

function AseFrame:putCel(i, cel)
    local rect = cel.frame
    local pos = cel.spriteSourceSize
    self[i] = {
        x = pos.x,
        y = pos.y,
        quad = love.graphics.newQuad(rect.x, rect.y, rect.w, rect.h,
                self.image:getWidth(), self.image:getHeight())
    }
end

function AseFrame:draw(x, y, r, sx, sy, ox, oy, kx, ky)
    local image = self.image
    for l = 1, #self do
        local cel = self[l]
        if cel then
            love.graphics.draw(image, cel.quad,
                (x or 0) + cel.x, (y or 0) + cel.y,
                r or 0, sx or 1, sy or 1, ox, oy, kx, ky)
        end
    end
end

return AseFrame