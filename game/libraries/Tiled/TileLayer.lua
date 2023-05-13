local class = require "Tiled.class"
local Gid = require "Tiled.Gid"

---@class Chunk
---@field x integer The x coordinate of the chunk in tiles.
---@field y integer The y coordinate of the chunk in tiles.
---@field width integer The width of the chunk in tiles.
---@field height integer The height of the chunk in tiles.
---@field tilewidth integer Copy of map.tilewidth
---@field tileheight integer Copy of map.tileheight
---@field data integer[]|string
---@field tilebatch love.SpriteBatch?
---@field batchanimations Animation[]? Indices in the data which have animated tiles

---@class TileLayer:Layer
---@field type string "tilelayer"
---@field encoding string? The encoding used to encode the tile layer data. When used, it can be “base64” and “csv” at the moment. (optional)
---@field compression string? The compression used to compress the tile layer data. Tiled supports “gzip”, “zlib” and (as a compile-time option since Tiled 1.3) “zstd”.
---@field data integer[]|string? In finite maps
---@field chunks Chunk[]? In infinite maps
---@field tilewidth integer Copy of map.tilewidth
---@field tileheight integer Copy of map.tileheight
---@field tilebatch love.SpriteBatch? In finite maps
---@field batchanimations Animation[]? Indices in the data which have animated tiles
local TileLayer = class()

local function newTileBatch(tiles, gids, cellwidth, cellheight, cols, rows)
    local tile
    for i = 1, #gids do
        tile = tiles[gids[i]]
        if tile then
            break
        end
    end
    if not tile then
        return
    end

    local tilebatch = love.graphics.newSpriteBatch(tile.image, cols * rows)
    local batchanimations = {}
    local i = 1
    local y = cellheight
    for r = 1, rows do
        local x = 0
        for c = 1, cols do
            local gid, sx, sy = Gid.parse(gids[i])
            local tile = tiles[gid]
            if tile then
                local hw, hh = tile.width / 2, tile.height / 2
                tilebatch:add(tile.quad, x + hw - tile.originx, y - hh - tile.originy, 0, sx, sy, hw, hh)
                batchanimations[i] = tile.animation
            else
                tilebatch:add(x, y, 0, 0, 0)
            end
            i = i + 1
            x = x + cellwidth
        end
        y = y + cellheight
    end

    return tilebatch, batchanimations
end

---@param map TiledMap
function TileLayer:_init(map)
    local maptiles = map.tiles
    local cellwidth = map.tilewidth
    local cellheight = map.tileheight
    local cols = map.width
    local rows = map.height

    local chunks = self.chunks
    local encoding = self.encoding
    local compression = self.compression
    self.tilewidth = cellwidth
    self.tileheight = cellheight
    if chunks then
        for i = 1, #chunks do
            local chunk = chunks[i]
            -- local chunkcol, chunkrow = chunk.x, chunk.y
            -- chunk.columns = chunk.width
            -- chunk.rows = chunk.height
            -- chunk[chunkcol..','..chunkrow] = chunk
            local gids = Gid.decode(chunk.data, encoding, compression)
            chunk.data = gids
            chunk.tilewidth = cellwidth
            chunk.tileheight = cellheight
            chunk.tilebatch, chunk.batchanimations = newTileBatch(maptiles, gids, cellwidth, cellheight, chunk.width,
                                  chunk.height)
        end
    else
        local gids = Gid.decode(self.data, encoding, compression)
        self.data = gids
        self.tilebatch, self.batchanimations = newTileBatch(maptiles, gids, cellwidth, cellheight, cols, rows)
    end
    local tintcolor = self.tintcolor
    if type(tintcolor) == "table" then
        for i, c in ipairs(tintcolor) do
            tintcolor[i] = c/256
        end
    end
    self.animationtime = 0
    return self
end

---@param self TileLayer|Chunk
local function animate(self, animationtime)
    local batchanimations = self.batchanimations
    if not batchanimations then
        return
    end

    local width = self.width
    local tilewidth = self.tilewidth
    local tileheight = self.tileheight
    local gids = self.data
    local tilebatch = self.tilebatch
    for i, animation in pairs(batchanimations) do
        local _, sx, sy = Gid.parse(gids[i])
        local nframes = #animation
        local _, progress = math.modf(animationtime / animation.duration)
        local frameindex = math.floor(nframes * progress) + 1
        local tile = animation[frameindex].tile
        local r = math.floor((i-1) / width) + 1
        local c =           ((i-1) % width)
        local x = c*tilewidth
        local y = r*tileheight
        local hw, hh = tile.width / 2, tile.height / 2
        tilebatch:set(i, tile.quad, x + hw - tile.originx, y - hh - tile.originy, 0, sx, sy, hw, hh)
    end
end

function TileLayer:animate(dt)
    local time = self.animationtime + dt
    self.animationtime = time

    local chunks = self.chunks
    if chunks then
        for _, chunk in ipairs(chunks) do
            animate(chunk, time)
        end
    else
        animate(self, time)
    end
end

local _transform = love.math.newTransform()

function TileLayer:draw()
    local tintcolor = self.tintcolor
    if tintcolor then
        love.graphics.setColor(tintcolor[1], tintcolor[2], tintcolor[3], tintcolor[4] or 1)
    end

    local chunks = self.chunks
    if chunks then
        _transform:setTransformation((self.x), (self.y),
                self.rotation or 0,
                self.scalex or 1, self.scaley or 1,
                self.originx or 0, self.originy or 0,
                self.skewx or 0, self.skewy or 0)
        love.graphics.push()
        local tilewidth = self.tilewidth
        local tileheight = self.tileheight
        for _, chunk in ipairs(chunks) do
            if chunk.tilebatch then
                love.graphics.draw(chunk.tilebatch, chunk.x*tilewidth, chunk.y*tileheight)
            else
                -- draw chunk tiles that are in view
            end
        end
        love.graphics.pop()
    else
        local batch = self.tilebatch
        if batch then
            love.graphics.draw(batch,
                (self.x), (self.y),
                self.rotation or 0,
                self.scalex or 1, self.scaley or 1,
                self.originx or 0, self.originy or 0,
                self.skewx or 0, self.skewy or 0)
        else
            -- draw individual layer tiles that are in view
        end
    end
    if tintcolor then
        love.graphics.setColor(1,1,1)
    end
end

return TileLayer