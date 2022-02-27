local Tiled = require "Data.Tiled"
local Color = require "Data.Color"

local SceneObject = {}
SceneObject.__index = SceneObject

local temptransform = love.math.newTransform()

function SceneObject.__lt(a, b)
    local az = a.z or 0
    local bz = b.z or 0
    if az < bz then
        return true
    end
    if az == bz then
        local ay = a.y or 0
        local by = b.y or 0
        if ay < by then
            return true
        end
        if ay == by then
            local ax = a.x or 0
            local bx = b.x or 0
            return ax < bx
        end
    end
end

function SceneObject.animateTile(sceneobject, dt)
    local animation = sceneobject.animation
    if animation then
        local aframe = sceneobject.animationframe
        local atime = sceneobject.animationtime
        aframe, atime = Tiled.getAnimationUpdate(animation, aframe, atime + dt)
        sceneobject.animationframe = aframe
        sceneobject.animationtime = atime
        sceneobject.quad = animation[aframe].tile.quad
    end
end
local animateTile = SceneObject.animateTile

function SceneObject.animateParticles(sceneobject, dt)
    sceneobject.particlesystem:update(dt)
end
local animateParticles = SceneObject.animateParticles

function SceneObject.setTile(sceneobject, tile)
    sceneobject.drawable = tile.image
    sceneobject.quad = tile.quad
    sceneobject.width = tile.width
    sceneobject.height = tile.height
    sceneobject.ox = tile.objectoriginx
    sceneobject.oy = tile.objectoriginy
    sceneobject.animation = tile.animation
    sceneobject.animationframe = 1
    sceneobject.animationtime = 0
end

function SceneObject.applyTransform(sceneobject)
    temptransform:setTransformation(
        (sceneobject.x),
        (sceneobject.y),
        sceneobject.r,
        sceneobject.sx, sceneobject.sy,
        sceneobject.ox, sceneobject.oy,
        sceneobject.kx, sceneobject.ky)
    love.graphics.applyTransform(temptransform)
end
local applyTransform = SceneObject.applyTransform

function SceneObject.drawLine(sceneobject)
    love.graphics.push()
    applyTransform(sceneobject)

    love.graphics.setColor(sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha)
    love.graphics.setLineWidth(sceneobject.linewidth or 1)
    love.graphics.line(sceneobject.drawable)

    love.graphics.pop()
end

function SceneObject.drawPolygon(sceneobject)
    love.graphics.push()
    applyTransform(sceneobject)

    local r,g,b,a = sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha
    love.graphics.setColor(r,g,b,a)
    local triangles = sceneobject.drawable
    for i = 6, #triangles, 6 do
        love.graphics.polygon("fill",
            triangles[i-5], triangles[i-4],
            triangles[i-3], triangles[i-2],
            triangles[i-1], triangles[i-0])
    end

    r,g,b,a = sceneobject.linered, sceneobject.linegreen, sceneobject.lineblue, sceneobject.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.setLineWidth(sceneobject.linewidth or 1)
        love.graphics.polygon("line", sceneobject.points)
    end

    love.graphics.pop()
end

function SceneObject.drawRectangle(sceneobject)
    love.graphics.push()
    applyTransform(sceneobject)

    local r,g,b,a = sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha
    love.graphics.setColor(r,g,b,a)
    love.graphics.rectangle("fill", 0, 0, sceneobject.w, sceneobject.h, sceneobject.round or 0)

    r,g,b,a = sceneobject.linered, sceneobject.linegreen, sceneobject.lineblue, sceneobject.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.rectangle("line", 0, 0, sceneobject.w, sceneobject.h, sceneobject.round or 0)
    end

    love.graphics.pop()
end

function SceneObject.drawEllipse(sceneobject)
    love.graphics.push()
    applyTransform(sceneobject)

    local hw, hh = sceneobject.w/2, sceneobject.h/2

    local r,g,b,a = sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha
    love.graphics.setColor(r,g,b,a)
    love.graphics.ellipse("fill", hw, hh, hw, hh)

    r,g,b,a = sceneobject.linered, sceneobject.linegreen, sceneobject.lineblue, sceneobject.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.ellipse("line", hw, hh, hw, hh)
    end

    love.graphics.pop()
end

function SceneObject.drawQuad(sceneobject)
    love.graphics.setColor(sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha)
    love.graphics.draw(sceneobject.drawable, sceneobject.quad,
        (sceneobject.x),
        (sceneobject.y),
        sceneobject.r,
        sceneobject.sx, sceneobject.sy,
        sceneobject.ox, sceneobject.oy,
        sceneobject.kx, sceneobject.ky)
end

function SceneObject.drawString(sceneobject)
    love.graphics.setColor(sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha)
    local font = sceneobject.font
    if font then
        love.graphics.printf(sceneobject.string, font,
            (sceneobject.x),
            (sceneobject.y),
            sceneobject.w, sceneobject.halign,
            sceneobject.r,
            sceneobject.sx, sceneobject.sy,
            sceneobject.ox, sceneobject.oy,
            sceneobject.kx, sceneobject.ky)
    else
        love.graphics.printf(sceneobject.string,
            (sceneobject.x),
            (sceneobject.y),
            sceneobject.w, sceneobject.halign,
            sceneobject.r,
            sceneobject.sx, sceneobject.sy,
            sceneobject.ox, sceneobject.oy,
            sceneobject.kx, sceneobject.ky)
    end
end

function SceneObject.drawGeneric(sceneobject)
    love.graphics.setColor(sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha)
    love.graphics.draw(sceneobject.drawable,
        (sceneobject.x),
        (sceneobject.y),
        sceneobject.r,
        sceneobject.sx, sceneobject.sy,
        sceneobject.ox, sceneobject.oy,
        sceneobject.kx, sceneobject.ky)
end

function SceneObject.updateGeneric(sceneobject, unit, fixedfrac)
    local vx, vy, vz = unit.velx, unit.vely, unit.velz or 0
    local av = unit.avel
    local x, y, z = unit.x, unit.y, unit.z
    local r = unit.rotation
    sceneobject.x = x + vx * fixedfrac
    sceneobject.y = y + vy * fixedfrac
    sceneobject.z = z + vz * fixedfrac
    sceneobject.r = r + av * fixedfrac
end

local drawString = SceneObject.drawString
local drawGeneric = SceneObject.drawGeneric
local updateGeneric = SceneObject.updateGeneric

local function updateParticleSystem(sceneobject, unit, fixedfrac)
    local vx, vy, vz = unit.velx, unit.vely, unit.velz or 0
    local av = unit.avel
    local x, y, z = unit.x, unit.y, unit.z
    x = x + vx * fixedfrac
    y = y + vy * fixedfrac
    sceneobject.z = z + vz * fixedfrac
    local r = unit.rotation + av * fixedfrac
    local particlesystem = sceneobject.particlesystem
    particlesystem:moveTo(x, y)
    particlesystem:setDirection(r)
end

function SceneObject.new(id, draw, drawable, quad, w, h, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = setmetatable({}, SceneObject)
    sceneobject.id = id
    sceneobject.draw = draw
    sceneobject.drawable = drawable
    if type(drawable) == "string" then
        sceneobject.string = drawable
    elseif drawable and drawable.type then
        sceneobject[drawable:type():lower()] = drawable
    end
    sceneobject.quad = quad
    sceneobject.w = w or math.huge
    sceneobject.h = h or math.huge
    sceneobject.x = x or 0
    sceneobject.y = y or 0
    sceneobject.z = z or 0
    sceneobject.r = r or 0
    sceneobject.sx = sx or 1
    sceneobject.sy = sy or sx or 1
    sceneobject.ox = ox or 0
    sceneobject.oy = oy or 0
    sceneobject.kx = kx or 0
    sceneobject.ky = ky or 0
    sceneobject.hidden = nil
    sceneobject.red = sceneobject.red or 1
    sceneobject.green = sceneobject.green or 1
    sceneobject.blue = sceneobject.blue or 1
    sceneobject.alpha = sceneobject.alpha or 1
    sceneobject.updateFromUnit = updateGeneric
    return sceneobject
end

local setTile = SceneObject.setTile
local drawLine = SceneObject.drawLine
local drawPolygon = SceneObject.drawPolygon
local drawRectangle = SceneObject.drawRectangle
local drawEllipse = SceneObject.drawEllipse
local drawQuad = SceneObject.drawQuad

function SceneObject.newShapeObject(shapeobject)
    local w, h, x, y, z, r, sx, sy
        = shapeobject.width, shapeobject.height,
        shapeobject.x, shapeobject.y, shapeobject.z,
        shapeobject.rotation, shapeobject.scalex, shapeobject.scaley

    local sceneobject
    local shape = shapeobject.shape
    local id = shapeobject.id
    if shape == "rectangle" then
        sceneobject = SceneObject.new(id, drawRectangle, nil, nil, w, h, x, y, z, r, sx, sy)
    elseif shape == "ellipse" then
        sceneobject = SceneObject.new(id, drawEllipse, nil, nil, w, h, x, y, z, r, sx, sy)
    elseif shape == "polyline" then
        sceneobject = SceneObject.new(id, drawLine, shapeobject.points, nil, w, h, x, y, z, r, sx, sy)
    elseif shape == "polygon" then
        local triangles = shapeobject.triangles
        if triangles then
            sceneobject = SceneObject.new(id, drawPolygon, triangles, nil, w, h, x, y, z, r, sx, sy)
            sceneobject.points = shapeobject.points -- for drawing outline
        else
            sceneobject = SceneObject.new(id, drawLine, shapeobject.points, nil, w, h, x, y, z, r, sx, sy)
        end
    end

    if not sceneobject then
        return
    end

    local color = shapeobject.color
    if color then
        sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha = Color.unpack(color)
    end

    local linecolor = shapeobject.linecolor
    if linecolor then
        sceneobject.linered, sceneobject.linegreen, sceneobject.lineblue, sceneobject.linealpha
            = Color.unpack(linecolor)
    end

    sceneobject.linewidth = shapeobject.linewidth
    return sceneobject
end

function SceneObject.newChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local w = chunk.width * chunk.tilewidth
    local h = chunk.height * chunk.tileheight
    local sceneobject = SceneObject.new(id, drawGeneric, chunk.tilebatch, nil, w, h, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return sceneobject
end

function SceneObject.newAnimatedChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.batchanimations = chunk.batchanimations
    sceneobject.animationtime = 0
    sceneobject.animate = Tiled.animateChunk
    sceneobject.width = chunk.width
    sceneobject.tilewidth = chunk.tilewidth
    sceneobject.tileheight = chunk.tileheight
    sceneobject.data = chunk.data
    return sceneobject
end

function SceneObject.newTile(id, tile, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.new(id, drawQuad, tile.image, nil, nil, nil, x, y, z, r, sx, sy, nil, nil, kx, ky)
    sceneobject.animate = animateTile
    setTile(sceneobject, tile)
    if ox then
        sceneobject.ox = ox
    end
    if oy then
        sceneobject.oy = oy
    end
    return sceneobject
end

function SceneObject.newTextObject(textobject)
    local sceneobject = SceneObject.new(textobject.id, drawString, textobject.string, nil,
        textobject.width, textobject.height, textobject.x, textobject.y, textobject.z,
        textobject.rotation, textobject.scalex, textobject.scaley,
        textobject.originx, textobject.originy,
        textobject.skewx, textobject.skewy)
    sceneobject.font = textobject.font
    sceneobject.halign = textobject.halign or "left"
    sceneobject.valign = textobject.valign or "top"
    local color = textobject.color
    if color then
        sceneobject.red, sceneobject.green, sceneobject.blue = color[1], color[2], color[3]
    end
    return sceneobject
end

function SceneObject.newImage(id, image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return SceneObject.new(id, drawGeneric, image, nil, image:getWidth(), image:getHeight(), x, y, z, r, sx, sy, ox, oy, kx, ky)
end

function SceneObject.newImageLayer(imagelayer)
    local image = imagelayer.image
    local sceneobject = SceneObject.newImage('l'..imagelayer.id, image, imagelayer.x, imagelayer.y, imagelayer.z)
    sceneobject.alpha = imagelayer.opacity
    return sceneobject
end

function SceneObject.newTileObject(tileobject)
    local tile = tileobject.tile
    local id = tileobject.id
    local x = tileobject.x
    local y = tileobject.y
    local z = tileobject.z
    local sceneobject = SceneObject.newTile(id, tile, x, y, z, tileobject.rotation, tileobject.scalex, tileobject.scaley)
    local color = tileobject.color
    if color then
        sceneobject.red, sceneobject.green, sceneobject.blue, sceneobject.alpha = Color.unpack(color)
    end
    if not tileobject.visible then
        sceneobject.hidden = true
    end
    return sceneobject
end

local addTileParticles_quads = {}
function SceneObject.newTileParticles(id, tile, z)
    local particlesystem = love.graphics.newParticleSystem(tile.image)
    local animation = tile.animation
    if animation then
        for i = #addTileParticles_quads, #animation+1, -1 do
            addTileParticles_quads[i] = nil
        end
        for i = 1, #animation do
            addTileParticles_quads[i] = animation[i].tile.quad
        end
        particlesystem:setQuads(addTileParticles_quads)
        local duration = animation.duration
        particlesystem:setParticleLifetime(duration)
    else
        particlesystem:setQuads(tile.quad)
        particlesystem:setParticleLifetime(60)
    end
    particlesystem:setOffset(tile.objectoriginx, tile.objectoriginy)

    local sceneobject = SceneObject.new(id, drawGeneric, particlesystem, nil, nil, nil, 0, 0, z)
    sceneobject.animate = animateParticles
    sceneobject.updateFromUnit = updateParticleSystem
    return sceneobject
end

function SceneObject.setAseprite(sceneobject, aseprite, frame)
    sceneobject.aseprite = aseprite
    sceneobject.asepriteframe = frame or 1
end
local setAseprite = SceneObject.setAseprite

function SceneObject.setAsepriteAnimated(sceneobject, aseprite, tag, tagframe)
    tagframe = tagframe or 1
    sceneobject.aseprite = aseprite
    sceneobject.animation = tag
    sceneobject.animationframe = tagframe
    sceneobject.animationtime = 0
    sceneobject.asepriteframe = aseprite:getAnimationFrame(tag, tagframe)
end
local setAsepriteAnimated = SceneObject.setAsepriteAnimated

function SceneObject.animateAseprite(sceneobject, dt)
    local animation = sceneobject.animation
    if animation then
        local aframe = sceneobject.animationframe
        local atime = sceneobject.animationtime
        local aseprite = sceneobject.aseprite
        aframe, atime = aseprite:getAnimationUpdate(animation, aframe, atime, dt)
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

function SceneObject.newAseprite(id, aseprite, frame, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.new(id, drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAseprite(sceneobject, aseprite, frame)
    return sceneobject
end

function SceneObject.newAnimatedAseprite(id, aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.new(id, drawAseprite, nil, nil, aseprite.width, aseprite.height,
                                        x, y, z, r, sx, sy, ox, oy, kx, ky)
    sceneobject.animate = animateAseprite
    setAsepriteAnimated(sceneobject, aseprite, tag, tagframe)
    return sceneobject
end

return SceneObject