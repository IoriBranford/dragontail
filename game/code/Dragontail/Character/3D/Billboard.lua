local g3d = require "g3d"
local Model = require "Dragontail.Character.3D.Model"

---@class Billboard:Model,AsepriteObject
local Billboard = {}

function Billboard:init()
    local texture, width, height
    if self.aseprite then
        texture = self.aseprite.image
        width = self.aseprite.width
        height = self.aseprite.height
    elseif self.tile then
        texture = self.tile.image
        width = self.tile.width
        height = self.tile.height
    end
    if texture and width and height then
        local tl = {
            0, 0, 0,
            0, 0,
            0, -1, 0,
            1, 1, 1, 1
        }
        local bl = {
            0, 0, -1,
            0, 1,
            0, -1, 0,
            1, 1, 1, 1
        }
        local tr = {
            1, 0, 0,
            1, 0,
            0, -1, 0,
            1, 1, 1, 1
        }
        local br = {
            1, 0, -1,
            1, 1,
            0, -1, 0,
            1, 1, 1, 1
        }
        local verts = {tl, tr, bl, tr, bl, br}
        self.model = g3d.newModel(verts, texture,
            nil, nil, {width, 1, height})
        Model.updatePosition(self, 0)
        Billboard.updateVerts(self)
    end
end

function Billboard:updateVertTexCoords(quad)
    local verts = self.model.verts
    local tl, tr = verts[1], verts[2]
    local bl, br = verts[5], verts[6]

    local iw, ih = quad:getTextureDimensions()
    local tx, ty, tw, th = quad:getViewport()
    local u0, v0 = tx/iw, ty/ih
    local u1, v1 = (tx+tw)/iw, (ty+th)/ih

    tl[4], tl[5] = u0, v0
    bl[4], bl[5] = u0, v1
    tr[4], tr[5] = u1, v0
    br[4], br[5] = u1, v1
end

function Billboard:updateVertPositionsAndTexCoords(quad)
    local verts = self.model.verts
    local tl, tr = verts[1], verts[2]
    local bl, br = verts[5], verts[6]

    local iw, ih = quad:getTextureDimensions()
    local tx, ty, tw, th = quad:getViewport()
    local u0, v0 = tx/iw, ty/ih
    local u1, v1 = (tx+tw)/iw, (ty+th)/ih

    tl[4], tl[5] = u0, v0
    tl[1], tl[3] = u0, -v0

    bl[4], bl[5] = u0, v1
    bl[1], bl[3] = u0, -v1

    tr[4], tr[5] = u1, v0
    tr[1], tr[3] = u1, -v0

    br[4], br[5] = u1, v1
    br[1], br[3] = u1, -v1
end

function Billboard:updateVerts()
    local frame = self:getAnimationFrame()
    if not frame then return end

    if self.aseprite then
        ---@cast frame AseFrame
        if #self.aseprite.layers > 1 then
            local texture = self.model.texture
            ---@cast texture love.Canvas
            assert(texture:typeOf("Canvas"),
                "Multi-layer aseprite billboard requires canvas texture")
            texture:renderTo(function()
                frame:draw()
            end)
        else
            Billboard.updateVertPositionsAndTexCoords(self, frame[1].quad)
        end
    elseif self.tile then
        ---@cast frame AnimationFrame
        Billboard.updateVertTexCoords(self, frame.tile.quad)
    end
end

function Billboard:animate(dt)
    local oldframe = self.animationframe
    self:animate(dt)
    if oldframe ~= self.animationframe then
        Billboard.updateVerts(self)
    end
end

return Billboard