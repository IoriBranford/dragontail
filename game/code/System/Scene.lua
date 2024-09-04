local SceneObject = require "System.SceneObject"

---@class Scene
local Scene = class()

local insert = table.insert
local sort = table.sort

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

function Scene:addImage(image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    local sceneobject = SceneObject.newImage(image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return self:add(sceneobject)
end

local _parentx, _parenty = 0, 0

function Scene:addLayer(layer, layerfilter)
    local layerx, layery = layer.x, layer.y
    local layertype = layer.type
    if layertype == "group" then
        _parentx = _parentx + layerx
        _parenty = _parenty + layery
        self:addLayers(layer, layerfilter)
        _parentx = _parentx - layerx
        _parenty = _parenty - layery
    elseif layertype == "tilelayer" then
        layer.x = _parentx + layerx
        layer.y = _parenty + layery
        self:addAnimating(layer)
    elseif layertype == "objectgroup" then
        layerx = _parentx + layerx
        layery = _parenty + layery
        for i = 1, #layer do
            local object = layer[i]
            object.x = layerx + object.x
            object.y = layery + object.y
            self:addAnimating(object)
        end
    elseif layertype == "imagelayer" then
        layer.x = _parentx + layerx
        layer.y = _parenty + layery
        self:add(layer)
    end
end

function Scene:addLayers(layers, layerfilter)
    _parentx, _parenty = layers.x or 0, layers.y or 0
    for i = 1, #layers do
        local layer = layers[i]
        if not layerfilter or layerfilter:find(layer.type) then
            self:addLayer(layers[i], layerfilter)
        end
    end
    _parentx, _parenty = 0, 0
end

function Scene:addMap(map, layerfilter)
    _parentx, _parenty = map.x or 0, map.y or 0
    self:addLayers(map.layers, layerfilter)
    _parentx, _parenty = 0, 0
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

local function prune(array, cond)
    local n = #array
    for i = n, 1, -1 do
        local so = array[i]
        if cond(so) then
            array[i] = array[n]
            array[n] = nil
            n = n - 1
        end
    end
end

function Scene:prune(cond)
    prune(self, cond)
    prune(self.animating, cond)
end

function Scene:animate(dt)
    local animating = self.animating
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

function Scene:draw(fixedfrac)
    sort(self, zsort)
    for i = 1, #self do
        local sceneobject = self[i]
        if sceneobject.visible then
            self[i]:draw(fixedfrac)
        end
    end
end

return Scene
