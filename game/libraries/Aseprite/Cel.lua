---@class AseCel
---@field x number
---@field y number
---@field width number
---@field height number
---@field image love.Texture
---@field imagetype "image"|"canvas"
---@field quad love.Quad
local Cel = class()

function Cel:_init(image, srcrect, destpos)
    self.x = srcrect.x
    self.y = srcrect.y
    self.width = srcrect.w
    self.height = srcrect.h
    self.image = image
    self.quad = love.graphics.newQuad(destpos.x, destpos.y, destpos.w, destpos.h, image:getWidth(), image:getHeight())
end

function Cel:draw(offsetx, offsety, r, sx, sy, ox, oy, kx, ky)
    love.graphics.draw(self.image, self.quad,
        (offsetx or 0) + self.x, (offsety or 0) + self.y,
        r or 0, sx or 1, sy or 1, ox, oy, kx, ky)
end

function Cel:getTextureCoords()
    local quad = self.quad
    local iw, ih = quad:getTextureDimensions()
    local tx, ty, tw, th = quad:getViewport()
    local u0, v0 = tx/iw, ty/ih
    local u1, v1 = (tx+tw)/iw, (ty+th)/ih
    return u0, v0, u1, v1
end

---@param tl g3d.vertex
---@param bl g3d.vertex
---@param tr g3d.vertex
---@param br g3d.vertex
---@param offsetx number?
---@param offsety number?
function Cel:updateVertices(tl, bl, tr, br, offsetx, offsety)
    local u0, v0, u1, v1 = self:getTextureCoords()
    local x0 = (offsetx or 0) + self.x
    local y0 = (offsety and -offsety or 0) - self.y
    local x1, y1 = x0 + self.width, y0 - self.height

    tl[1], tl[2] = x0, y0 ; tr[1], tr[2] = x1, y0
    tl[4], tl[5] = u0, v0 ; tr[4], tr[5] = u1, v0

    bl[1], bl[2] = x0, y1 ; br[1], br[2] = x1, y1
    bl[4], bl[5] = u0, v1 ; br[4], br[5] = u1, v1
end

return Cel