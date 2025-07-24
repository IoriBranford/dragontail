local class = require "Tiled.class"
local Assets = require "Tiled.Assets"
local Color  = require "Tiled.Color"
local Layer  = require "Tiled.Layer"
local pathlite = require "Tiled.pathlite"
local drawModel= require "Tiled.drawModel"

---@class ImageLayer:Layer
---@field type string "imagelayer"
---@field repeatx boolean Whether the image drawn by this layer is repeated along the X axis. (since Tiled 1.8)
---@field repeaty boolean Whether the image drawn by this layer is repeated along the Y axis. (since Tiled 1.8)
---@field imagefile string
---@field image love.Image|string
---@field shader love.Shader?
---@field rotationdegrees number?
local ImageLayer = class(Layer)

function ImageLayer:_init(directory)
    local imagefile = self.image
    if directory ~= "" then
        imagefile = pathlite.normjoin(directory, imagefile)
    end
    self.imagefile = imagefile
    self.image = Assets.get(self.imagefile)
    if self.rotationdegrees then
        self.rotation = math.rad(self.rotationdegrees)
    end
end

function ImageLayer:draw()
    local r,g,b,a = Color.unpack(self.tintcolor)
    love.graphics.setColor(r,g,b,a)
    love.graphics.draw(self.image,
        (self.x), (self.y),
        self.rotation or 0,
        self.scalex or 1, self.scaley or 1,
        self.originx or 0, self.originy or 0,
        self.skewx or 0, self.skewy or 0)
end

function ImageLayer:make3D()
    local g3d = require "g3d" ---@type g3d
    local image = self.image
    local w, h = image:getDimensions()
    local x1 = -(self.originx or 0)
    local y1 = -(self.originy or 0)
    local x2 = x1 + w
    local y2 = y1 + h
    local u0, v0 = 0, 0
    local u1, v1 = 1, 1
    local repeats = 128
    if self.repeatx then
        u1 = repeats*2
        x1 = x1 - repeats*w
        x2 = x2 + (repeats-1)*w
    end
    if self.repeaty then
        v1 = repeats*2
        y1 = y1 - repeats*h
        y2 = y2 + (repeats-1)*h
    end
    local tl = { x1,-y1,0, u0,v0, 0,0,1, 1,1,1,1 }
    local bl = { x1,-y2,0, u0,v1, 0,0,1, 1,1,1,1 }
    local tr = { x2,-y1,0, u1,v0, 0,0,1, 1,1,1,1 }
    local br = { x2,-y2,0, u1,v1, 0,0,1, 1,1,1,1 }
    local verts = {tl, tr, bl, tr, bl, br}
    self.model = g3d.newModel(verts, self.image)
    self.draw = drawModel
end

return ImageLayer