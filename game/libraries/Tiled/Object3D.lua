local drawModel = require "Tiled.drawModel"
local Object    = require "Tiled.Object"

---@class Object3D:AsepriteObject
---@field model g3d.model
local Object3D = {}

---@param tile Tile?
function Object3D:initTile(tile)
    if tile then
        Object.initTile(self, tile)
    end

    local frame = self:getAnimationFrame()
    ---@cast frame AnimationFrame
    tile = frame and frame.tile or self.tile
    if not tile then return end

    self.model = tile:newModel(self.originx and -self.originx, self.originy and -self.originy)
    self.animate = Object3D.animate3DTile
    self.setTile = Object3D.setTile
    self.draw = drawModel
end

function Object3D:updateTileModel()
    local frame = self:getAnimationFrame()
    ---@cast frame AnimationFrame
    local tile = frame and frame.tile or self.tile
    if tile then
        tile:updateModel(self.model, self.originx and -self.originx, self.originy and -self.originy)
    end
end

function Object3D:setTile(tile, frame1, loopframe)
    Object.setTile(self, tile, frame1, loopframe)
    Object3D.updateTileModel(self)
end

---@param self Object3D
function Object3D:animateTile(dt)
    Object.animateTile(self, dt)
    Object3D.updateTileModel(self)
end

function Object3D:initAseprite()
    local aseprite = self.aseprite
    if not aseprite then return end

    local frame = self:getAnimationFrame()
    ---@cast frame AseFrame
    self.model = self.aseprite:newModel(frame, self.originx and -self.originx, self.originy and -self.originy)
    self.animate = Object3D.animateAseprite
    self.setAseAnimation = Object3D.setAseAnimation
    self.draw = drawModel
end

function Object3D:updateAsepriteModel()
    local frame = self:getAnimationFrame()
    ---@cast frame AseFrame
    self.aseprite:updateModel(self.model, frame, self.originx and -self.originx, self.originy and -self.originy)
end

---@param self Object3D
function Object3D:animateAseprite(dt)
    Object.animateAseprite(self, dt)
    Object3D.updateAsepriteModel(self)
end

function Object3D:setAseAnimation(animation, frame1, loopframe)
    Object.setAseAnimation(self, animation, frame1, loopframe)
    Object3D.updateAsepriteModel(self)
end

function Object3D:setOrigin(originx, originy)
    self.originx = originx
    self.originy = originy
    local offsetx = originx and -originx
    local offsety = originy and -originy
    local frame = self:getAnimationFrame()
    if self.aseprite then
        ---@cast frame AseFrame
        self.aseprite:updateModel(self.model, frame, offsetx, offsety)
    else
        ---@cast frame AnimationFrame
        local tile = frame and frame.tile or self.tile
        if tile then
            tile:updateModel(self.model, offsetx, offsety)
        end
    end
end

return Object3D