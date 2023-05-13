local Tileset = require "Tiled.Tileset"
local TileLayer = require "Tiled.TileLayer"
local addIfNew  = require "Tiled.addIfNew"
local ObjectGroup = require "Tiled.ObjectGroup"
local Properties  = require "Tiled.Properties"
local TilePacking = require "Tiled.TilePacking"
local LayerGroup  = require "Tiled.LayerGroup"
local ImageLayer  = require "Tiled.ImageLayer"
local class = require "Tiled.class"

---@class TiledMap
---@field version string The TMX format version. Was “1.0” so far, and will be incremented to match minor Tiled releases.
---@field tiledversion string The Tiled version used to save the file (since Tiled 1.0.1). May be a date (for snapshot builds). (optional)
---@field class string The class of this map (since 1.9, defaults to “”).
---@field orientation string Map orientation. Tiled supports “orthogonal”, “isometric”, “staggered” and “hexagonal” (since 0.11).
---@field renderorder string The order in which tiles on tile layers are rendered. Valid values are right-down (the default), right-up, left-down and left-up. In all cases, the map is drawn row-by-row. (only supported for orthogonal maps at the moment)
---@field compressionlevel integer The compression level to use for tile layer data (defaults to -1, which means to use the algorithm default).
---@field width integer The map width in tiles.
---@field height integer The map height in tiles.
---@field tilewidth integer The width of a tile.
---@field tileheight integer The height of a tile.
---@field hexsidelength integer Only for hexagonal maps. Determines the width or height (depending on the staggered axis) of the tile’s edge, in pixels.
---@field staggeraxis string For staggered and hexagonal maps, determines which axis (“x” or “y”) is staggered. (since 0.11)
---@field staggerindex string For staggered and hexagonal maps, determines whether the “even” or “odd” indexes along the staggered axis are shifted. (since 0.11)
---@field parallaxoriginx number X coordinate of the parallax origin in pixels (defaults to 0). (since 1.8)
---@field parallaxoriginy number Y coordinate of the parallax origin in pixels (defaults to 0). (since 1.8)
---@field backgroundcolor integer[] [r, g, b] (converted to range 0..1) The background color of the map. (optional, may include alpha value since 0.15 in the form #AARRGGBB. Defaults to fully transparent.)
---@field nextlayerid integer Stores the next available ID for new layers. This number is stored to prevent reuse of the same ID after layers have been removed. (since 1.2) (defaults to the highest layer id in the file + 1)
---@field nextobjectid integer Stores the next available ID for new objects. This number is stored to prevent reuse of the same ID after objects have been removed. (since 0.11) (defaults to the highest object id in the file + 1)
---@field infinite boolean Whether this map is infinite. An infinite map has no fixed size and can grow in all directions. Its layer data is stored in chunks. (0 for false, 1 for true, defaults to 0)
---@field tilesets Tileset[] Access by index or tileset name
---@field layers Layer[] Access by index or layer name
---@field directory string Directory path containing the map file
---@field objects TiledObject[] All map objects by their id
---@field tiles Tile[] All tileset tiles by their gid
---@field properties table Moved into map itself
local TiledMap = {}
TiledMap.__index = TiledMap

---@class Layer
---@field type string "tilelayer", "objectgroup", "imagelayer", or "group"
---@field id integer Unique ID of the layer (defaults to 0, with valid IDs being at least 1). Each layer that added to a map gets a unique id. Even if a layer is deleted, no layer ever gets the same ID. Can not be changed in Tiled. (since Tiled 1.2)
---@field name string The name of the image layer. (defaults to “”)
---@field class string The class of the image layer (since 1.9, defaults to “”).
---@field parallaxx number Horizontal parallax factor for this layer. Defaults to 1. (since 1.5)
---@field parallaxy number Vertical parallax factor for this layer. Defaults to 1. (since 1.5)
---@field x number The x position of the image layer in pixels. Copy of offsetx
---@field y number The y position of the image layer in pixels. Copy of offsety
---@field opacity number The opacity of the layer as a value from 0 to 1. (defaults to 1)
---@field visible boolean Whether the layer is shown (1) or hidden (0). (defaults to 1)
---@field tintcolor Color A color that is multiplied with the image drawn by this layer in #AARRGGBB or #RRGGBB format (optional).
---@field z number Drawing order, default depends on layer order, set with layer property "z" (float)

----@field offsetx number Horizontal offset of the image layer in pixels. (defaults to 0) (since 0.15)
----@field offsety number Vertical offset of the image layer in pixels. (defaults to 0) (since 0.15)
----@field properties table Moved into layer itself

local function setLayersZ(layers, z1, dz)
    local layer1 = layers[1]
    if layer1 then
        layer1.z = layer1.properties.z or z1
        layer1.properties.z = nil
    end
    for i = 2, #layers do
        local layer = layers[i]
        layer.z = layer.properties.z or (layers[i-1].z + dz)
        layer.properties.z = nil
    end
end

---@param mapfile string
---@return TiledMap
function TiledMap.load(mapfile)
    local mapf, err = love.filesystem.load(mapfile)
    assert(mapf, err)
    local map = mapf() ---@type TiledMap
    setmetatable(map, TiledMap)

    local directory = string.match(mapfile, "^(.+/)") or ""
    map.directory = directory

    if map.backgroundcolor then
        for i, c in ipairs(map.backgroundcolor) do
            map.backgroundcolor[i] = c / 256
        end
    end

    local maptiles = {}
    map.tiles = maptiles
    local mapobjects = {}
    map.objects = mapobjects

    local function findObjects(layers)
        for i = 1, #layers do
            local layer = layers[i]
            if layer.objects then
                local objects = layer.objects
                for i = 1, #objects do
                    local object = objects[i]
                    mapobjects[object.id] = object
                end
            elseif layer.layers then
                findObjects(layer.layers)
            end
        end
    end

    local tilesets = map.tilesets
    for i = 1, #tilesets do
        local tileset = tilesets[i]
        tileset.image = directory..tileset.image
        Tileset.castinit(tileset)
        for t = 0, tileset.tilecount - 1 do
            maptiles[#maptiles + 1] = tileset[t]
        end
    end

    local packimagedata, packimageerr = TilePacking.pack(map)
    if packimagedata then
        -- TilePacking.save(map, mapfile..".quads", mapfile..".png", packimagedata)
    else
        print(packimageerr)
    end

    local function doLayer(layer, parent)
        local layername = layer.name
        if layername ~= "" then
            addIfNew(parent, layername, layer)
        end
        local layertype = layer.type
        layer.x = layer.offsetx
        layer.y = layer.offsety
        local z = layer.z
        if layertype == "group" then
            LayerGroup.castinit(layer)
            local scalez = (parent.scalez or 1) / #layer
            layer.scalez = scalez
            setLayersZ(layer, z, scalez)
            for i = 1, #layer do
                doLayer(layer[i], layer)
            end
        elseif layertype == "tilelayer" then
            TileLayer.castinit(layer, map)
        elseif layertype == "objectgroup" then
            ObjectGroup.castinit(layer, map)
            for _, object in ipairs(layer) do
                object.z = object.z or z
            end
        elseif layertype == "imagelayer" then
            ImageLayer.castinit(layer, directory)
        end
        Properties.resolveObjectRefs(layer.properties, mapobjects)
        Properties.moveUp(layer)

        class.requirecastinit(layer, layer.class)
    end

    local layers = map.layers
    LayerGroup.cast(layers)
    setLayersZ(layers, 1, 1)
    findObjects(layers)

    for i = 1, #layers do
        local layer = layers[i]
        doLayer(layer, layers)
    end
    Properties.resolveObjectRefs(map.properties, mapobjects)
    Properties.moveUp(map)

    class.requirecastinit(map, map.class)

    return map
end

return TiledMap