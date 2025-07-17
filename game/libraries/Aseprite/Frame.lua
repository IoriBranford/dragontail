local class = require "Aseprite.class"
local Cel   = require "Aseprite.Cel"
local love_graphics_draw = love.graphics.draw

---@alias Rect {x: number, y: number, w: number, h: number}
---@alias Size {w: number, h: number}

---@class AseFrame
---@field index integer
---@field image love.Texture
---@field frame Rect
---@field rotated boolean
---@field trimmed boolean
---@field spriteSourceSize Rect
---@field sourceSize Size
---@field duration number
---@field [integer] AseCel|false
local AseFrame = class()

function AseFrame:_init(i, image, duration)
    self.index = i
    self.image = image
    self.duration = duration or 0
end

function AseFrame:putCel(i, cel)
    local rect = cel.frame
    local pos = cel.spriteSourceSize
    for h = #self+1, i-1 do
        self[h] = false
    end
    self[i] = Cel(self.image, pos, rect)
end

function AseFrame:drawCels(i, j, x, y)
    x = x or 0
    y = y or 0
    local dl = i > j and -1 or 1
    for l = i, j, dl do
        local cel = self[l]
        if cel then
            love_graphics_draw(cel.image, cel.quad,
                x + cel.x, y + cel.y)
        end
    end
end
local drawCels = AseFrame.drawCels

function AseFrame:draw(x, y)
    drawCels(self, 1, #self, x, y)
end

function AseFrame:drawFrontToBack(x, y)
    drawCels(self, #self, 1, x, y)
end

function AseFrame:updateVertices(verts, offsetx, offsety)
    local celi = 1
    for i = 6, #verts, 6 do
        local tl, tr = verts[i-5], verts[i-4]
        local bl, br = verts[i-1], verts[i]
        local cel = self[celi]
        if cel then
            cel:updateVertices(tl, bl, tr, br, offsetx, offsety)
        else
            tl[1], tl[2] = 0, 0; tr[1], tr[2] = 0, 0
            bl[1], bl[2] = 0, 0; br[1], br[2] = 0, 0
        end
        celi = celi + 1
    end
end

return AseFrame