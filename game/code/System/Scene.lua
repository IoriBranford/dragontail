local SceneObject = require "System.SceneObject"
local AsepriteSceneObject = require "System.SceneObject.Aseprite"

---@class Scene
local Scene = class()

local insert = table.insert

function Scene:_init()
    self.animating = {}
end

---@deprecated
function Scene.new()
    return Scene()
end

function Scene:add(sceneobject)
    insert(self, sceneobject)
    return sceneobject
end

function Scene:addAnimating(sceneobject)
    insert(self, sceneobject)
    insert(self.animating, sceneobject)
    return sceneobject
end

function Scene:addAseprite(aseprite, frame, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = AsepriteSceneObject.newAseprite(aseprite, frame or 1, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(sceneobject)
end

function Scene:addManualAnimatedAseprite(aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = AsepriteSceneObject.newAnimatedAseprite(aseprite, tag, tagframe or 1, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(sceneobject)
end

local addManualAnimatedAseprite = Scene.addManualAnimatedAseprite

function Scene:addAnimatedAseprite(aseprite, tag, tagframe, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = addManualAnimatedAseprite(aseprite, tag, tagframe or 1, x, y, z, r, sx, sy, ox, oy, kx, ky)
    insert(self.animating, sceneobject)
    return sceneobject
end

function Scene:addImage(image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newImage(image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(sceneobject)
end

function Scene:addLayer(layer, layerfilter)
    local layertype = layer.type
    if layertype == "group" then
        self:addLayers(layer, layerfilter)
    elseif layertype == "tilelayer" then
        self:addAnimating(layer)
    elseif layertype == "objectgroup" then
        for i = 1, #layer do
            local object = layer[i]
            self:addAnimating(object)
        end
    elseif layertype == "imagelayer" then
        self:add(layer)
    end
end

function Scene:addLayers(layers, layerfilter)
    for i = 1, #layers do
        local layer = layers[i]
        if not layerfilter or layerfilter:find(layer.type) then
            self:addLayer(layers[i], layerfilter)
        end
    end
end

function Scene:addMap(map, layerfilter)
    self:addLayers(map.layers, layerfilter)
end

function Scene:addCustom(draw, drawable, quad, w, h, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(SceneObject(draw, drawable, quad, w, h, x, y, z, r, sx, sy, ox, oy, kx, ky))
end

function Scene:clear()
    local animating = self.animating
    for i = #animating, 1, -1 do
        animating[i] = nil
    end
    for i = #self, 1, -1 do
        self[i] = nil
    end
end

local sortAndPrune = SceneObject.sortAndPruneObjects

local function sortAnimated(a, b)
    return a.z ~= math.huge and b.z == math.huge
end

function Scene:animate(dt)
    local animating = self.animating
    sortAndPrune(animating, sortAnimated)
    for i = 1, #animating do
        animating[i]:animate(dt)
    end
end

local function zsort(a, b)
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

function Scene:draw()
    sortAndPrune(self, zsort)
    for i = 1, #self do
        local sceneobject = self[i]
        if sceneobject.visible then
            if not sceneobject.draw then
                print(sceneobject.name, sceneobject.type)
            end
            sceneobject:draw()
        end
    end
end

return Scene
