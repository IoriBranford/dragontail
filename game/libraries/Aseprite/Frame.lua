local class = require "Aseprite.class"
local love_graphics_draw = love.graphics.draw

---@class AseCel
---@field x number
---@field y number
---@field width number
---@field height number
---@field image love.Image
---@field quad love.Quad

---@alias Rect {x: number, y: number, w: number, h: number}
---@alias Size {w: number, h: number}

---@class AseFrame
---@field index integer
---@field image love.Image
---@field frame Rect
---@field rotated boolean
---@field trimmed boolean
---@field spriteSourceSize Rect
---@field sourceSize Size
---@field duration number
---@field [integer] AseCel|boolean
local AseFrame = class()

function AseFrame:_init(i, image, duration)
    self.index = i
    self.image = image
    self.duration = duration or 0
end

local function drawCel(cel, x, y, r, sx, sy, ox, oy, kx, ky)
    love_graphics_draw(cel.image, cel.quad,
        (x or 0) + cel.x, (y or 0) + cel.y,
        r or 0, sx or 1, sy or 1, ox, oy, kx, ky)
end

function AseFrame:putCel(i, cel)
    local rect = cel.frame
    local pos = cel.spriteSourceSize
    for h = #self+1, i-1 do
        self[h] = false
    end
    self[i] = {
        x = pos.x,
        y = pos.y,
        width = pos.w,
        height = pos.h,
        image = self.image,
        quad = love.graphics.newQuad(rect.x, rect.y, rect.w, rect.h,
                self.image:getWidth(), self.image:getHeight()),
        draw = drawCel
    }
end

function AseFrame:drawCels(i, j, x, y, r, sx, sy, ox, oy, kx, ky)
    local image = self.image
    for l = i, j do
        local cel = self[l]
        if cel then
            love_graphics_draw(image, cel.quad,
                (x or 0) + cel.x, (y or 0) + cel.y,
                r or 0, sx or 1, sy or 1, ox, oy, kx, ky)
        end
    end
end
local drawCels = AseFrame.drawCels

function AseFrame:draw(x, y, r, sx, sy, ox, oy, kx, ky)
    drawCels(self, 1, #self, x, y, r, sx, sy, ox, oy, kx, ky)
end

return AseFrame