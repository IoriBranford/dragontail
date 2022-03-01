local SceneObject = require "System.SceneObject"

local new = SceneObject.new

function SceneObject.setAsepriteAnimation(sceneobject, aseprite, tag, tagframe, onend)
    tagframe = tagframe or 1
    sceneobject.aseprite = aseprite
    sceneobject.animation = tag
    sceneobject.animationframe = tagframe
    sceneobject.animationtime = 0
    sceneobject.onanimationend = onend
    sceneobject.asepriteframe = aseprite:getAnimationFrame(tag, tagframe)
end
local setAsepriteAnimation = SceneObject.setAsepriteAnimation

function SceneObject.changeAsepriteAnimation(sceneobject, tag, tagframe, onend)
    setAsepriteAnimation(sceneobject, sceneobject.aseprite, tag, tagframe, onend)
end

function SceneObject.animateAseprite(sceneobject, dt)
    local animation = sceneobject.animation
    if animation then
        local aframe = sceneobject.animationframe
        local atime = sceneobject.animationtime
        local aseprite = sceneobject.aseprite
        aframe, atime = aseprite:getAnimationUpdate(animation, aframe, atime, dt, sceneobject.onanimationend)
        sceneobject.animationframe = aframe
        sceneobject.animationtime = atime
        sceneobject.asepriteframe = aseprite:getAnimationFrame(animation, aframe)
    end
end
local animateAseprite = SceneObject.animateAseprite

function SceneObject.drawAseprite(sceneobject)
    love.graphics.setColor(sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha)
    sceneobject.aseprite:drawFrame(sceneobject.asepriteframe,
        (sceneobject.x),
        (sceneobject.y),
        sceneobject.r,
        sceneobject.sx, sceneobject.sy,
        sceneobject.ox, sceneobject.oy,
        sceneobject.kx, sceneobject.ky)
end
local drawAseprite = SceneObject.drawAseprite

function SceneObject.setAseprite(sceneobject, aseprite, frame)
    sceneobject.aseprite = aseprite
    sceneobject.asepriteframe = frame or 1
end
local setAseprite = SceneObject.setAseprite

function SceneObject.newAseprite(aseprite, frame, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = new(drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAseprite(sceneobject, aseprite, frame)
    return sceneobject
end

function SceneObject.newAnimatedAseprite(aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = new(drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAsepriteAnimation(sceneobject, aseprite, tag, tagframe)
    return sceneobject
end

return SceneObject