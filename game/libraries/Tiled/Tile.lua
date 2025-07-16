local class = require "Tiled.class"
local ObjectGroup = require "Tiled.ObjectGroup"
local Properties  = require "Tiled.Properties"
local Animation   = require "Tiled.Animation"
local hasg3d, g3d = pcall(require, "g3d") ---@type boolean,g3d

---@class Tile:Class
---@field id integer The local tile ID within its tileset.
---@field name string?
---@field type string The class of the tile. Is inherited by tile objects. (since 1.0, defaults to “”, was saved as class in 1.9)
---@field class string? The class of the object when saved/exported in Tiled 1.9. (defaults to “”)
---@field probability number A percentage indicating the probability that this tile is chosen when it competes with others while editing with the terrain tool. (defaults to 0)
---@field x number? The X position of the sub-rectangle representing this tile (default: 0)
---@field y number? The Y position of the sub-rectangle representing this tile (default: 0)
---@field width number? The width of the sub-rectangle representing this tile (defaults to the image width)
---@field height number? The height of the sub-rectangle representing this tile (defaults to the image height)
---@field image love.Texture|Aseprite
---@field imagetype "image"|"canvas"|"aseprite"
---@field quad love.Quad? only for normal image tileset
---@field offsetx number Copy of tileset's tile offset x
---@field offsety number Copy of tileset's tile offset y
---@field objectoriginx number originx adjusted by object alignment
---@field objectoriginy number originy adjusted by object alignment
---@field empty boolean Contains only transparent pixels
---@field tileset Tileset
---@field shapes ObjectGroup? Collision shapes copied from objectGroup and offset by (-originx, -originy). Can access shapes by name after calling Map:indexTileShapesByName.
---@field animation Animation?
---@field loopframe integer? Initial value of animation's loopframe if applicable
---@field objectGroup ObjectGroup? Original name of shapes
---@field properties table These get moved into tile itself
local Tile = class()

function Tile:_init(tiledata)
    local tileid = tiledata.id
    local objectox, objectoy = self.objectoriginx, self.objectoriginy
    local shapes = tiledata.objectGroup
    if shapes then
        ObjectGroup.from(shapes)
        for _, shape in ipairs(shapes) do
            shape.x = shape.x - objectox
            shape.y = shape.y - objectoy
        end
        self.shapes = shapes
    end

    self.id = tileid
    self.type = tiledata.class or tiledata.type
    local animation = tiledata.animation
    if animation then
        animation = Animation.from(animation, self.tileset) ---@type Animation
        local properties = tiledata.properties
        local loopframe = properties and properties.loopframe
        if loopframe then
            animation:setLoopFrame(loopframe)
        end
        self.animation = animation
    end

    Properties.moveUp(tiledata, self)
end

---@param key string|integer
function Tile:getShape(key)
    local shapes = self.shapes
    return shapes and shapes[key]
end

function Tile:getTextureCoords()
    local iw, ih = self.quad:getTextureDimensions()
    local tx, ty, tw, th = self.quad:getViewport()
    local u0, v0 = tx/iw, ty/ih
    local u1, v1 = (tx+tw)/iw, (ty+th)/ih
    return u0, v0, u1, v1
end

---@param x number?
---@param y number?
---@param flipx number?
---@param flipy number?
---@return g3d.vertex tl
---@return g3d.vertex bl
---@return g3d.vertex tr
---@return g3d.vertex br
function Tile:newVertices(x, y, flipx, flipy)
    x = x or 0
    y = y or 0
    local x2, y2 = x + self.width, y + self.height

    local tl = {
        x, -y, 0,
        0, 0,
        0, 0, 1,
        1, 1, 1, 1
    }

    local bl = {
        x, -y2, 0,
        0, 0,
        0, 0, 1,
        1, 1, 1, 1
    }

    local tr = {
        x2, -y, 0,
        0, 0,
        0, 0, 1,
        1, 1, 1, 1
    }

    local br = {
        x2, -y2, 0,
        0, 0,
        0, 0, 1,
        1, 1, 1, 1
    }

    self:updateVertices(tl, bl, tr, br, flipx, flipy)

    return tl, bl, tr, br
end

---@param tl g3d.vertex
---@param bl g3d.vertex
---@param tr g3d.vertex
---@param br g3d.vertex
---@param flipx number?
---@param flipy number?
function Tile:updateVertices(tl, bl, tr, br, flipx, flipy)
    local u0, v0, u1, v1 = self:getTextureCoords()
    if (flipx or 1) < 0 then
        u0, u1 = u1, u0
    end
    if (flipy or 1) < 0 then
        v0, v1 = v1, v0
    end
    tl[4], tl[5] = u0, v0
    bl[4], bl[5] = u0, v1
    tr[4], tr[5] = u1, v0
    br[4], br[5] = u1, v1
end

---@return g3d.model
function Tile:newModel()
    local tl, bl, tr, br = self:newVertices()
    local verts = {tl, tr, bl, tr, bl, br}
    return g3d.newModel(verts, self.image)
end

---@param model g3d.model
function Tile:updateModel(model)
    local verts = model.verts
    self:updateVertices(verts[1], verts[5], verts[2], verts[6])
end

return Tile