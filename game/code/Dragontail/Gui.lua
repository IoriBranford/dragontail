local Tiled = require "Tiled"
local Gui   = require "Gui"

local map = Tiled.Map.load("data/gui.lua")
Tiled.Assets.markMapAssetsPermanent(map, true)

map:indexLayersByName()
map:indexLayerObjectsByName()
map:indexTilesetTilesByName()

local gui = Gui.new(map)
-- gui.options.screen.fullscreendevice.max = love.window.getDisplayCount()

return gui