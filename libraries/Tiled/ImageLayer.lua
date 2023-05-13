local class = require "Tiled.class"
local Assets = require "Tiled.Assets"

---@class ImageLayer:Layer
---@field type string "imagelayer"
---@field repeatx boolean Whether the image drawn by this layer is repeated along the X axis. (since Tiled 1.8)
---@field repeaty boolean Whether the image drawn by this layer is repeated along the Y axis. (since Tiled 1.8)
---@field image string|love.Image
local ImageLayer = class()

function ImageLayer:_init(directory)
    if directory then
        self.image = directory..self.image
    end
    self.image = Assets.loadImage(self.image)
end

function ImageLayer:draw()
    love.graphics.draw(self.image,
        (self.x), (self.y),
        self.rotation or 0,
        self.scalex or 1, self.scaley or 1,
        self.originx or 0, self.originy or 0,
        self.skewx or 0, self.skewy or 0)
end

return ImageLayer