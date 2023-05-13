local class = require "Tiled.class"
local Object = require "Tiled.Object"
local addIfNew = require "Tiled.addIfNew"
local Graphics = require "Tiled.Graphics"

---@class ObjectGroup:Layer
---@field type string "objectgroup"
---@field color Color? The color used to display the objects in this group. (optional)
---@field draworder string Whether the objects are drawn according to the order of appearance (“index”) or sorted by their y-coordinate (“topdown”). (defaults to “topdown”)
---@field [integer] TiledObject Copied from objects
---@field [string] TiledObject Objects with names
----@field objects TiledObject[] Copied to layer's array part
local ObjectGroup = class()

function ObjectGroup:_init(map)
    local objects = self.objects
    for i = 1, #objects do
        local object = Object.castinit(objects[i], map)
        local objectclass = object.class or object.type or ""
        class.requirecastinit(object, objectclass, map)
        self[i] = object
        local objectname = object.name
        if objectname ~= "" then
            addIfNew(self, objectname, object)
        end
    end
    self.objects = nil
    return self
end

function ObjectGroup:animate(dt)
    for _, object in ipairs(self) do
        object:animate(dt)
    end
end

local pushTransform = Graphics.pushTransform

function ObjectGroup:draw()
    pushTransform(self)
    for _, object in ipairs(self) do
        if object.visible then
            object:draw()
        end
    end
    love.graphics.pop()
end

return ObjectGroup