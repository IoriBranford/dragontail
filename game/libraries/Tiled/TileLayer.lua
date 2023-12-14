local class = require "Tiled.class"
local Gid = require "Tiled.Gid"
local Graphics = require "Tiled.Graphics"
local Color    = require "Tiled.Color"
local Layer    = require "Tiled.Layer"

local parseGid = Gid.parse

---@class Chunk
---@field x integer The x coordinate of the chunk in tiles.
---@field y integer The y coordinate of the chunk in tiles.
---@field width integer The width of the chunk in tiles.
---@field height integer The height of the chunk in tiles.
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
local TileLayer = class(Layer)

---@param f fun(x:number, y: number, tile:Tile, flipx:number, flipy:number): any
---@param data integer[]
---@param cols number
---@param rows number
---@param maptiles Tile[]
---@param x0 number? origin
---@param y0 number? origin
---@param dx number?
---@param dy number?
local function forCells(f, data, cols, rows, maptiles, x0, y0, dx, dy)
    local i = 1
    local y = y0 or 0
    x0 = x0 or 0
    dx = dx or 1
    dy = dy or 1
    for _ = 1, rows do
        local x = x0
        for _ = 1, cols do
            local gid, sx, sy = parseGid(data[i])
            local tile = maptiles[gid]
            f(x, y, tile, sx, sy)
            i = i + 1
            x = x + dx
        end
        y = y + dy
    end
end

local function newTileBatch(maptiles, data, cellwidth, cellheight, cols, rows)
    local tile1
    for i = 1, #data do
        tile1 = maptiles[data[i]]
        if tile1 then
            break
        end
    end
    if not tile1 then
        return
    end

    local tilebatch = love.graphics.newSpriteBatch(tile1.image, cols * rows)
    local batchanimations = {}
    local i = 1
    forCells(function(x, y, tile, sx, sy)
        if tile then
            local hw, hh = tile.width / 2, tile.height / 2
            x, y = x + hw + tile.offsetx, y - hh + tile.offsety
            tilebatch:add(tile.quad, x, y, 0, sx, sy, hw, hh)
            batchanimations[i] = tile.animation
        else
            tilebatch:add(x, y, 0, 0, 0)
        end
    end, data, cols, rows, maptiles, 0, cellheight, cellwidth, cellheight)

    return tilebatch, batchanimations
end

---@param map TiledMap
function TileLayer:_init(map)
    self.maptiles = map.tiles
    local cellwidth = map.tilewidth
    local cellheight = map.tileheight
    self.mapcols = map.width
    self.maprows = map.height

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
        end
    else
        local gids = Gid.decode(self.data, encoding, compression)
        self.data = gids
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

---@param f fun(left:number, bottom: number, tile:Tile, flipx:number, flipy:number): any
function TileLayer:forCells(f)
    local maptiles = self.maptiles
    local chunks = self.chunks
    local cellwidth, cellheight = self.tilewidth, self.tileheight
    local x, y = self.x, self.y + cellheight
    if chunks then
        for _, chunk in ipairs(self.chunks) do
            forCells(f, chunk.data, chunk.width, chunk.height, maptiles,
                x + chunk.x*cellwidth, y + chunk.y*cellheight,
                cellwidth, cellheight)
        end
    else
        forCells(f, self.data, self.mapcols, self.maprows, maptiles,
            x, y, cellwidth, cellheight)
    end
end

function TileLayer:batchTiles()
    local maptiles = self.maptiles
    local cellwidth = self.tilewidth
    local cellheight = self.tileheight

    local chunks = self.chunks
    if chunks then
        for i = 1, #chunks do
            local chunk = chunks[i]
            -- local chunkcol, chunkrow = chunk.x, chunk.y
            -- chunk.columns = chunk.width
            -- chunk.rows = chunk.height
            -- chunk[chunkcol..','..chunkrow] = chunk
            local gids = chunk.data
            chunk.tilebatch, chunk.batchanimations = newTileBatch(maptiles, gids,
                cellwidth, cellheight, chunk.width, chunk.height)
        end
    else
        local cols = self.mapcols
        local rows = self.maprows
        local gids = self.data
        self.tilebatch, self.batchanimations = newTileBatch(maptiles, gids,
            cellwidth, cellheight, cols, rows)
    end
end

---@param self TileLayer|Chunk
local function animate(self, animationtime, tilewidth, tileheight)
    local batchanimations = self.batchanimations
    if not batchanimations then
        return
    end

    local width = self.width
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
        x, y = x + hw + tile.offsetx, y - hh + tile.offsety
        tilebatch:set(i, tile.quad, x, y, 0, sx, sy, hw, hh)
    end
end

function TileLayer:animate(dt)
    local time = self.animationtime + dt
    self.animationtime = time

    local chunks = self.chunks
    local tilewidth, tileheight = self.tilewidth, self.tileheight
    if chunks then
        for _, chunk in ipairs(chunks) do
            animate(chunk, time, tilewidth, tileheight)
        end
    else
        animate(self, time, tilewidth, tileheight)
    end
end

local pushTransform = Graphics.pushTransform

function TileLayer:draw()
    local tintcolor = self.tintcolor
    if tintcolor then
        love.graphics.setColor(Color.unpack(tintcolor))
    else
        love.graphics.setColor(1,1,1)
    end

    local chunks = self.chunks
    if chunks then
        pushTransform(self)
        local tilewidth = self.tilewidth
        local tileheight = self.tileheight
        local maptiles = self.maptiles
        for _, chunk in ipairs(chunks) do
            if not chunk.tilebatch then
                local gids = chunk.data
                chunk.tilebatch, chunk.batchanimations = newTileBatch(maptiles, gids,
                    tilewidth, tileheight, chunk.width, chunk.height)
            end
            love.graphics.draw(chunk.tilebatch, chunk.x*tilewidth, chunk.y*tileheight)
        end
        love.graphics.pop()
    else
        local batch = self.tilebatch
        if not batch then
            local maptiles = self.maptiles
            local tilewidth = self.tilewidth
            local tileheight = self.tileheight
            local cols = self.mapcols
            local rows = self.maprows

            batch, self.batchanimations = newTileBatch(maptiles, self.data,
                tilewidth, tileheight, cols, rows)
            self.tilebatch = batch
        end

        love.graphics.draw(batch,
            (self.x), (self.y),
            self.rotation or 0,
            self.scalex or 1, self.scaley or 1,
            self.originx or 0, self.originy or 0,
            self.skewx or 0, self.skewy or 0)
    end
    if tintcolor then
        love.graphics.setColor(1,1,1)
    end
end

return TileLayer