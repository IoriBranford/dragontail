local g3d = require "g3d"

---@class Model3D:AsepriteObject,Body
---@field model g3d.model
local Model3D = {}

local BillboardTL = {
    0, 0, 0,
    0, 0,
    0, -1, 0,
    1, 1, 1, 1
}
local BillboardBL = {
    0, 0, -1,
    0, 1,
    0, -1, 0,
    1, 1, 1, 1
}
local BillboardTR = {
    1, 0, 0,
    1, 0,
    0, -1, 0,
    1, 1, 1, 1
}
local BillboardBR = {
    1, 0, -1,
    1, 1,
    0, -1, 0,
    1, 1, 1, 1
}

local BillboardVerts = {
    BillboardTL, BillboardTR, BillboardBL,
    BillboardTR, BillboardBL, BillboardBR
}

function Model3D:initBillboard()
    local verts, texture, width, height
    if self.aseprite then
        verts = BillboardVerts
        texture = love.graphics.newCanvas(self.aseprite.width, self.aseprite.height)
        width = self.aseprite.width
        height = self.aseprite.height
        Model3D.updateAsepriteBillboardCanvas(self)
    elseif self.tile then
        texture = self.tile.image
        width = self.tile.width
        height = self.tile.height
        verts = {}
        for i, vert in ipairs(BillboardVerts) do
            verts[i] = {table.unpack(vert)}
        end
        Model3D.updateTileBillboardTexCoord(self)
    end
    if verts and texture and width and height then
        self.model = g3d.newModel(verts, texture,
            nil, nil, {width, 1, height})
        Model3D.updatePosition(self, 0)
    end
end

function Model3D:updatePosition(fixedfrac)
    self.model:setTranslation(
        self.x + self.velx*fixedfrac - self.originx,
        -self.y - self.vely*fixedfrac,
        self.z + self.velz*fixedfrac + self.originy)
end

function Model3D:updateAsepriteBillboardCanvas()
    local canvas = self.canvas
    if not canvas then return end
    local animation = self.aseanimation or self.aseprite
    if not animation then return end

    local aframe = self.animationframe or 1
    local frame = animation[aframe]
    if frame then
        canvas:renderTo(function()
            frame:draw()
        end)
    end
end

function Model3D:updateTileBillboardTexCoord()
    local verts = self.model.verts
    local tl, tr = verts[1], verts[2]
    local bl, br = verts[5], verts[6]

    local iw, ih = self.tile.quad:getTextureDimensions()
    local tx, ty, tw, th = self.tile.quad:getViewport()

    bl[4], bl[5] = tx/iw, (ty+th)/ih
    tl[4], tl[5] = tx/iw, ty/ih
    br[4], br[5] = (tx+tw)/iw, (ty+th)/ih
    tr[4], tr[5] = (tx+tw)/iw, ty/ih
end

function Model3D:animateBillboard(dt)
    local oldframe = self.animationframe
    self:animate(dt)
    if oldframe ~= self.animationframe then
        if self.aseprite then
            Model3D.updateAsepriteBillboardCanvas(self)
        elseif self.tile then
            Model3D.updateTileBillboardTexCoord(self)
        end
    end
end

return Model3D