local SceneObject = require "System.SceneObject"
local Tiled       = require "Data.Tiled"
local Color = require "Data.Color"

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

local setTile = SceneObject.setTile
local drawLine = SceneObject.drawLine
local drawPolygon = SceneObject.drawPolygon
local drawRectangle = SceneObject.drawRectangle
local drawEllipse = SceneObject.drawEllipse
local drawQuad = SceneObject.drawQuad
local drawString = SceneObject.drawString
local drawGeneric = SceneObject.drawGeneric

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

function SceneObject.animateParticles(sceneobject, dt)
    sceneobject.particlesystem:update(dt)
end
local animateParticles = SceneObject.animateParticles

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

return SceneObject