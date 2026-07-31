local Tiled = require "Tiled"
local Gui   = require "Gui"

local map = Tiled.Map.load("data/gui.lua")
Tiled.Assets.markMapAssetsPermanent(map, true)

map:indexLayersByName()
map:indexLayerObjectsByName()
map:indexTilesetTilesByName()

local gui = Gui.new(map)
-- gui.options.screen.fullscreendevice.max = love.window.getDisplayCount()
local FS = love.filesystem
if FS.getInfo("version") then
    local v = FS.read("version"):match("%S+")
    local ver = gui:get("gameplay.hud.development ver")
    if ver and ver.text then
        ver.text = string.gsub(ver.text, "0.0.0", v)
    end
end

gui:eventconnect()

return gui