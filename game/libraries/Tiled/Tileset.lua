local class = require "Tiled.class"
local Assets = require "Tiled.Assets"
local Properties = require "Tiled.Properties"
local Tile       = require "Tiled.Tile"

---@class Tileset:Class
---@field firstgid integer The first global tile ID of this tileset (this global ID maps to the first tile in this tileset).
---@field source string? If this tileset is stored in an external TSX (Tile Set XML) file, this attribute refers to that file. That TSX file has the same structure as the <tileset> element described here. (There is the firstgid attribute missing and this source attribute is also not there. These two attributes are kept in the TMX map, since they are map specific.)
---@field name string The name of this tileset.
---@field class string The class of this tileset (since 1.9, defaults to “”).
---@field tilewidth integer The (maximum) width of the tiles in this tileset. Irrelevant for image collection tilesets, but stores the maximum tile width.
---@field tileheight integer The (maximum) height of the tiles in this tileset. Irrelevant for image collection tilesets, but stores the maximum tile height.
---@field spacing integer The spacing in pixels between the tiles in this tileset (applies to the tileset image, defaults to 0). Irrelevant for image collection tilesets.
---@field margin integer The margin around the tiles in this tileset (applies to the tileset image, defaults to 0). Irrelevant for image collection tilesets.
---@field tilecount integer The number of tiles in this tileset (since 0.13). Note that there can be tiles with a higher ID than the tile count, in case the tileset is an image collection from which tiles have been removed.
---@field columns integer The number of tile columns in the tileset. For image collection tilesets it is editable and is used when displaying the tileset. (since 0.15)
---@field objectalignment string Controls the alignment for tile objects. Valid values are unspecified, topleft, top, topright, left, center, right, bottomleft, bottom and bottomright. The default value is unspecified, for compatibility reasons. When unspecified, tile objects use bottomleft in orthogonal mode and bottom in isometric mode. (since 1.4)
---@field numempty integer Number of tiles whose pixels are all fully transparent (alpha = 0)
---@field tiles Tile[] Moved to array part of tileset
---@field image love.Image
---@field imagefile string
---@field tileoffset {x: number, y: number}
---@field [integer] Tile All tiles including ones that have no special properties (0-based)
---@field [string] Tile All tiles with string property called "name", after calling Map:indexTilesetTilesByName
----@field properties table Moved into tileset itself
local Tileset = class()

local ImageLoadSettings = {
    asimagedata = true
}

function Tileset:_init()
    -- assert(tileset.objectalignment == "topleft", "Unsupported objectalignment "..tileset.objectalignment)
    assert(not self.source,
        "External tilesets unsupported. Please export with 'Embed Tilesets' enabled in export options.")

    local imagefile = self.image
    self.imagefile = imagefile
    local imagedata = Assets.get(imagefile, ImageLoadSettings)
    ---@cast imagedata love.ImageData
    local image = love.graphics.newImage(imagedata)
    Assets.put(imagefile, image)
    self.image = image
    local columns = self.columns
    local n = self.tilecount
    local tw = self.tilewidth
    local th = self.tileheight

    local ObjectAlignments = {
        topleft     = {0.0, 0.0},
        top         = {0.5, 0.0},
        topright    = {1.0, 0.0},
        left        = {0.0, 0.5},
        center      = {0.5, 0.5},
        right       = {1.0, 0.5},
        bottomleft  = {0.0, 1.0},
        bottom      = {0.5, 1.0},
        bottomright = {1.0, 1.0},
        unspecified  = {0.0, 1.0},
    }
    local alignment = ObjectAlignments[self.objectalignment or "bottomleft"]
    local objectox, objectoy = alignment[1]*tw, alignment[2]*th
    local offsetx, offsety = 0, 0
    if self.tileoffset then
        offsetx = self.tileoffset.x
        offsety = self.tileoffset.y
        objectox = objectox - offsetx
        objectoy = objectoy - offsety
    end

    local iw, ih = image:getDimensions()
    local numempty = n
    for id = 0, n - 1 do
        local c = id % columns
        local r = math.floor(id / columns)
        local tx = c * tw
        local ty = r * th

        local empty = true
        for y = ty, ty+th-1 do
            for x = tx, tx+tw-1 do
                local _, _, _, alpha = imagedata:getPixel(x, y)
                if alpha ~= 0 then
                    empty = false
                    numempty = numempty - 1
                    break
                end
            end
            if not empty then
                break
            end
        end

        local tile = Tile.cast {
            id = id,
            tileset = self,
            image = image,
            empty = empty,
            quad = love.graphics.newQuad(tx, ty, tw, th, iw, ih),
            width = tw,
            height = th,
            offsetx = offsetx,
            offsety = offsety,
            objectoriginx = objectox,
            objectoriginy = objectoy
        }
        self[id] = tile
    end
    self.numempty = numempty

    local tilesdata = self.tiles
    if tilesdata then
        for i = 1, #tilesdata do
            local tiledata = tilesdata[i]
            local tileid = tiledata.id
            Tile.from(self[tileid], tiledata)
        end
    end

    Properties.moveUp(self)
end

return Tileset