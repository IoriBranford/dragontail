local SceneObject = require "System.SceneObject"

---@class AsepriteSceneObject:SceneObject
local AsepriteSceneObject = class(SceneObject)

function AsepriteSceneObject:setAsepriteAnimation(aseprite, tag, tagframe, onend)
    tagframe = tagframe or 1
    aseprite = aseprite or self.aseprite
    self.aseprite = aseprite
    self.animation = tag
    self.animationframe = tagframe
    self.animationtime = 0
    self.onanimationend = onend
    self.asepriteframe = aseprite:getAnimationFrame(tag, tagframe)
end
local setAsepriteAnimation = AsepriteSceneObject.setAsepriteAnimation

function AsepriteSceneObject:changeAsepriteAnimation(tag, tagframe, onend)
    if tag ~= self.animation then
        setAsepriteAnimation(self, self.aseprite, tag, tagframe, onend)
    end
end

function AsepriteSceneObject:animateAseprite(dt)
    local animation = self.animation
    if animation then
        local aframe = self.animationframe
        local atime = self.animationtime
        local aseprite = self.aseprite
        aframe, atime = aseprite:getAnimationUpdate(animation, aframe, atime, dt, self.onanimationend)
        self.animationframe = aframe
        self.animationtime = atime
        self.asepriteframe = aseprite:getAnimationFrame(animation, aframe)
    end
end
local animateAseprite = AsepriteSceneObject.animateAseprite

function AsepriteSceneObject:drawAseprite()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    self.aseprite:drawFrame(self.asepriteframe,
        (self.x),
        (self.y),
        self.rotation,
        self.scalex, self.scaley,
        self.originx, self.originy,
        self.skewx, self.skewy)
end
local drawAseprite = AsepriteSceneObject.drawAseprite

function AsepriteSceneObject:setAseprite(aseprite, frame)
    self.aseprite = aseprite
    self.asepriteframe = frame or 1
end
local setAseprite = AsepriteSceneObject.setAseprite

function AsepriteSceneObject.newAseprite(aseprite, frame, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = AsepriteSceneObject(drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAseprite(sceneobject, aseprite, frame)
    return sceneobject
end

function AsepriteSceneObject.newAnimatedAseprite(aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = AsepriteSceneObject(drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAsepriteAnimation(sceneobject, aseprite, tag, tagframe)
    return sceneobject
end

return AsepriteSceneObject