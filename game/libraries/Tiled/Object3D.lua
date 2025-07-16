local drawModel = require "Tiled.drawModel"

---@class Object3D:TiledObject
---@field model g3d.model
local Object3D = {}

---@param tile Tile?
function Object3D:initTile(tile)
    if tile then
        self:initTile(tile)
    end
    tile = self.tile
    if not tile then return end

    self.model = tile:newModel()
    self.animate = Object3D.animate3DTile
    self.draw = drawModel
end

---@param self Object3D
function Object3D:animateTile(dt)
    self:animateTile(dt)
    local newtile = self.tile.animation[self.animationframe].tile
    newtile:updateModel(self.model)
end

function Object3D:initAseprite()
    local aseprite = self.aseprite
    if not aseprite then return end
    self.model = self.aseprite:newModel()
    self.animate = Object3D.animateAseprite
    self.draw = drawModel
end

---@param self Object3D
function Object3D:animateAseprite(dt)
    self:animateAseprite(dt)
    self.aseprite:updateModel(self.model,
        self.aseanimation[self.animationframe])
end

return Object3D