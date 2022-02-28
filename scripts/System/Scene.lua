local SceneObject = require "System.SceneObject"
require "System.SceneObject.Tiled"
require "System.SceneObject.Aseprite"
local Color       = require "Data.Color"

local Scene = {}
Scene.__index = Scene

function Scene.new()
    local scene = {
        byid = {},
        animating = {}
    }
    return setmetatable(scene, Scene)
end

function Scene:add(id, sceneobject)
    self.byid[id] = sceneobject
    return sceneobject
end

function Scene:addShapeObject(shapeobject)
    local sceneobject = SceneObject.newShapeObject(shapeobject)
    return self:add(sceneobject.id, sceneobject)
end

function Scene:addChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(id, sceneobject)
end

function Scene:addAnimatedChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newAnimatedChunk(id, chunk, x, y, z, r, sx, sy, ox, oy, kx, ky)
    self.animating[id] = sceneobject
    return self:add(id, sceneobject)
end

function Scene:addTile(id, tile, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newTile(id, tile, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(id, sceneobject)
end

function Scene:addAnimatedTile(id, tile, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = self:addTile(id, tile, x, y, z, r, sx, sy, ox, oy, kx, ky)
    self.animating[id] = sceneobject
    return sceneobject
end

function Scene:addAnimatedAseprite(id, aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newAnimatedAseprite(id, aseprite, tag, tagframe or 1, x, y, z, r, sx, sy, ox, oy, kx, ky)
    self.animating[id] = sceneobject
    return self:add(id, sceneobject)
end

function Scene:addTextObject(textobject)
    local sceneobject = SceneObject.newTextObject(textobject)
    return self:add(sceneobject.id, sceneobject)
end

function Scene:addImage(id, image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newImage(id, image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(id, sceneobject)
end

function Scene:addImageLayer(imagelayer)
    local sceneobject = SceneObject.newImageLayer(imagelayer)
    return self:add(sceneobject.id, sceneobject)
end

function Scene:addTileLayer(tilelayer)
    local tilebatch = tilelayer.tilebatch
    local id = 'l'..tilelayer.id
    local layerx = tilelayer.x
    local layery = tilelayer.y
    local layerz = tilelayer.z
    if tilebatch then
        return {self:addAnimatedChunk(id, tilelayer, layerx, layery, layerz)}
    end
    local chunks = tilelayer.chunks
    if chunks then
        local cellwidth = tilelayer.tilewidth
        local cellheight = tilelayer.tileheight
        local sceneobjects = {}
        for i = 1, #chunks do
            local chunk = chunks[i]
            local chunkid = id .. 'c' .. i
            local w = chunk.width * cellwidth
            local h = chunk.height * cellheight
            local cx = chunk.x * cellwidth
            local cy = chunk.y * cellheight
            sceneobjects[i] = self:addAnimatedChunk(chunkid, chunk, layerx+cx, layery+cy, layerz)
        end
        return sceneobjects
    end
end

function Scene:addTileObject(tileobject)
    local tile = tileobject.tile
    local id = tileobject.id
    local x = tileobject.x
    local y = tileobject.y
    local z = tileobject.z
    local sprite = tileobject.animated == false
        and self:addTile(id, tile, x, y, z, tileobject.rotation, tileobject.scalex, tileobject.scaley)
        or self:addAnimatedTile(id, tile, x, y, z, tileobject.rotation, tileobject.scalex, tileobject.scaley)
    local color = tileobject.color
    if color then
        sprite.red, sprite.green, sprite.blue, sprite.alpha = Color.unpack(color)
    end
    sprite.hidden = not tileobject.visible
    return sprite
end

function Scene:addObject(object)
    local str = object.string
    if str then
        return self:addTextObject(object)
    end
    local tile = object.tile
    if tile then
        return self:addTileObject(object)
    end
    return self:addShapeObject(object)
end

function Scene:addMap(map, layerfilter)
    local function addLayers(layers)
        for i = 1, #layers do
            local layer = layers[i]
            local layertype = layer.type
            if not layerfilter or layerfilter:find(layertype) then
                if layer.type == "group" then
                    addLayers(layer)
                elseif layertype == "tilelayer" then
                    layer.sprites = self:addTileLayer(layer)
                elseif layertype == "objectgroup" then
                    for i = 1, #layer do
                        local object = layer[i]
                        object.sprite = self:addObject(object)
                    end
                elseif layertype == "imagelayer" then
                    layer.sprite = self:addImageLayer(layer)
                end
            end
        end
    end

    addLayers(map.layers)
end

function Scene:addTileParticles(id, tile, z)
    local sceneobject = SceneObject.newTileParticles(id, tile, z)
    self.animating[id] = sceneobject
    return self:add(sceneobject.id, sceneobject)
end

function Scene:addTileParticlesObject(object)
    return self:addTileParticles(object.id, object.tile, object.z)
end

function Scene:get(id)
    return self.byid[id]
end

function Scene:remove(id)
    self.byid[id] = nil
    self.animating[id] = nil
end

function Scene:clear()
    local byid = self.byid
    local animating = self.animating
    for id, _ in pairs(byid) do
        byid[id] = nil
        animating[id] = nil
    end
    for i = #self, 1, -1 do
        self[i] = nil
    end
end

function Scene:updateFromUnit(id, unit, fixedfrac)
    local sceneobject = self.byid[id]
    if sceneobject then
        sceneobject:updateFromUnit(unit, fixedfrac)
    end
end

function Scene:updateFromBody(id, body, fixedfrac)
    local sceneobject = self.byid[id]
    if sceneobject then
        local vx, vy = body:getLinearVelocity()
        local av = body:getAngularVelocity()
        local x, y = body:getPosition()
        local r = body:getAngle()
        sceneobject.x = x + vx * fixedfrac
        sceneobject.y = y + vy * fixedfrac
        sceneobject.r = r + av * fixedfrac
    end
end

function Scene:animate(dt)
    for id, sceneobject in pairs(self.animating) do
        sceneobject:animate(dt)
    end
end

-- local sqrt2 = math.sqrt(2)
function Scene:draw()
    -- local viewr = viewx + vieww
    -- local viewb = viewy + viewh
    local count = 0
    for id, sceneobject in pairs(self.byid) do
        -- local x = sceneobject.x
        -- local y = sceneobject.y
        -- local ox = sceneobject.ox
        -- local oy = sceneobject.oy
        -- local sx = sceneobject.sx
        -- local sy = sceneobject.sy
        -- local sxsqrt2 = sx*sqrt2
        -- local sysqrt2 = sy*sqrt2
        -- local l = x - sxsqrt2*ox
        -- local t = y - sysqrt2*oy
        -- local r = l + sxsqrt2*sceneobject.w
        -- local b = t + sysqrt2*sceneobject.h
        -- l, r = math.min(l, r), math.max(l, r)
        -- t, b = math.min(t, b), math.max(t, b)
        -- if r > viewx and viewr > l and b > viewy and viewb > t then
        if not sceneobject.hidden then
            count = count + 1
            self[count] = sceneobject
        end
        -- end
    end
    for i = #self, count+1, -1 do
        self[i] = nil
    end
    table.sort(self)

    for i = 1, #self do
        self[i]:draw()
    end
end

return Scene
