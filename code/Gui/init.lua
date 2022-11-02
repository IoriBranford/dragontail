local Scene = require "System.Scene"
local Tiled = require "Data.Tiled"
local GuiObject = require "Gui.GuiObject"
local class     = require "pl.class"

---@class Gui
local Gui = class()

---@param map string|table Tiled map exported to Lua, either table or filename
---@return Gui
function Gui.new(map)
    if type(map) == "string" then
        map = Tiled.load(map)
    end
    local self = map.layers
    self.width = map.width*map.tilewidth
    self.height = map.height*map.tileheight
    self.class = "Gui"
    local scene = Scene.new()
    scene:addLayers(self)
    self.scene = scene

    local function init(element)
        for i = 1, #element do
            init(element[i])
        end

        local ok
        local class = element.class
        if class ~= "" then
            ok, class = pcall(require, class)
            if not ok then
                print(class)
            end
        end
        if not ok then
            class = GuiObject
        end
        class.init(element)
    end

    init(self)
    return self
end

function Gui:init()
    Gui:cast(self)
end

function Gui:fixedupdate()
    self.scene:animate(1)
end

function Gui:draw()
    self.scene:draw()
end

return Gui