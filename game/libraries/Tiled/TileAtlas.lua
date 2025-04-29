---@class AtlasTile
---@field image love.Texture
---@field quad love.Quad

---@class AtlasSpace
---@field x number
---@field y number
---@field width number
---@field height number
---@field tile AtlasTile
local AtlasSpace = {}
AtlasSpace.__index = AtlasSpace

function AtlasSpace.__lt(a, b)
    return a.width * a.height > b.width * b.height
end

local function newSpace(x, y, w, h)
    return setmetatable({x = x, y = y, width = w, height = h}, AtlasSpace)
end

function AtlasSpace:fits(w, h)
    return self.width >= w and self.height >= h
end

function AtlasSpace:split(w, h)
    local tilevertical = h >= w
    local rightw = self.width - w
    local downh = self.height - h
    local bigsplit, smallsplit
    if tilevertical then
        if rightw > 0 then
            smallsplit = newSpace(self.x + w, self.y, rightw, h)
        end
        if downh > 0 then
            bigsplit = newSpace(self.x, self.y + h, self.width, downh)
        end
    else
        if downh > 0 then
            smallsplit = newSpace(self.x, self.y + h, w, downh)
        end
        if rightw > 0 then
            bigsplit = newSpace(self.x + w, self.y, rightw, self.height)
        end
    end
    if smallsplit then
        if not bigsplit or bigsplit < smallsplit then
            return smallsplit, bigsplit
        end
    end
    return bigsplit, smallsplit
end

---@class TileAtlas
---@field width number
---@field height number
---@field freespaces AtlasSpace[]
---@field newtilespaces AtlasSpace[]
---@field tiles AtlasTile[]
---@field canvas love.Canvas
local TileAtlas = {}
TileAtlas.__index = TileAtlas

local MaxTextureSize

function TileAtlas.New(width, height)
    MaxTextureSize = MaxTextureSize or love.graphics.getSystemLimits().texturesize
    local self = setmetatable({}, TileAtlas)
    width = width or 2048
    height = height or width
    self.width, self.height = width, height
    self.canvas = love.graphics.newCanvas(width, height)
    local emptytile = {
        image = self.canvas,
        quad = love.graphics.newQuad(1, 1, 2, 2, width, height)
    }
    self.freespaces = {newSpace(0, 0, width, height)}
    self:takeSpace(4, 4, emptytile)
    self.newtilespaces = {}
    self.tiles = {emptytile}
    return self
end

---@param tile AtlasTile
function TileAtlas:addTile(tile)
    if not tile or tile.image == self.canvas then
        return
    end
    local quad = tile.quad
    local _, _, w, h = quad:getViewport()
    local tilespace = self:takeSpace(w + 2, h + 2, tile)
    self.newtilespaces[#self.newtilespaces+1] = tilespace
end

---@param tiles AtlasTile[]
function TileAtlas:addTiles(tiles)
    for i = 1, #tiles do
        self:addTile(tiles[i])
    end
end

---@param w integer
---@param h integer
---@param tile AtlasTile
---@return AtlasSpace?
function TileAtlas:takeSpace(w, h, tile)
    local freespaces = self.freespaces

    repeat
        for i = #freespaces, 1, -1 do
            local space = freespaces[i]
            if space:fits(w, h) then
                local bigsplit, smallsplit = space:split(w, h)
                freespaces[i] = freespaces[#freespaces]
                freespaces[#freespaces] = bigsplit
                freespaces[#freespaces+1] = smallsplit
                table.sort(freespaces)
                space.tile = tile
                return space
            end
        end
    until not self:grow2x()
end

function TileAtlas:grow2x()
    if self.width >= MaxTextureSize and self.height >= MaxTextureSize then
        return false
    end

    local newfreespace
    if self.width <= self.height then
        newfreespace = newSpace(self.width, 0, self.width, self.height)
        self.width = self.width * 2
    else
        newfreespace = newSpace(0, self.height, self.width, self.height)
        self.height = self.height * 2
    end

    local freespaces = self.freespaces
    for i = #freespaces, 1, -1 do
        freespaces[i+1] = freespaces[i]
    end
    freespaces[1] = newfreespace
    return true
end

function TileAtlas:updateCanvas()
    local canvas = self.canvas
    local width = self.width
    local height = self.height
    local resized = canvas:getWidth() < width
        or canvas:getHeight() < height
    if resized then
        local newcanvas = love.graphics.newCanvas(width, height)
        newcanvas:renderTo(function()
            love.graphics.draw(canvas, 0, 0)
        end)
        canvas = newcanvas
        self.canvas = newcanvas

        local tiles = self.tiles
        for i = 1, #tiles do
            local tile = tiles[i]
            local x, y, w, h = tile.quad:getViewport()
            tile.image = canvas
            tile.quad:setViewport(x, y, w, h, width, height)
        end
    end

    if #self.newtilespaces > 0 then
        canvas:renderTo(function()
            self:drawNewTilesToCanvas()
        end)
    end
end

function TileAtlas:drawNewTilesToCanvas()
    local canvas = self.canvas
    local width = self.width
    local height = self.height
    local tiles = self.tiles
    local newtilespaces = self.newtilespaces
    local quad = love.graphics.newQuad(0, 0, 1, 1, 1, 1)
    for s = 1, #newtilespaces do
        local space = newtilespaces[s]
        local tile = space.tile
        local srcimage = tile.image
        local tquad = tile.quad
        local tsorcx, tsorcy, twidth, theigt = tquad:getViewport()
        local tdstx0, tdsty0 = space.x, space.y
        local tdestx, tdesty = tdstx0 + 1, tdsty0 + 1
        local tdstx1, tdsty1 = tdestx + twidth, tdesty + theigt

        tile.image = canvas
        tquad:setViewport(tdestx, tdesty, twidth, theigt, width, height)

        local tsrcx2 = tsorcx + twidth - 1
        local tsrcy2 = tsorcy + theigt - 1
        local srciw, srcih = srcimage:getDimensions()
        local rects = {
            -- tile
            tdestx, tdesty, tsorcx, tsorcy, twidth, theigt,

            -- edges
            tdestx, tdsty0, tsorcx, tsorcy, twidth,      1,
            tdstx0, tdesty, tsorcx, tsorcy,      1, theigt,
            tdstx1, tdesty, tsrcx2, tsorcy,      1, theigt,
            tdestx, tdsty1, tsorcx, tsrcy2, twidth,      1,

            -- corners
            tdstx0, tdsty0, tsorcx, tsorcy,      1,      1,
            tdstx1, tdsty0, tsrcx2, tsorcy,      1,      1,
            tdstx0, tdsty1, tsorcx, tsrcy2,      1,      1,
            tdstx1, tdsty1, tsrcx2, tsrcy2,      1,      1
        }
        for i = 6, #rects, 6 do
            local destx = rects[i-5]
            local desty = rects[i-4]
            local srcx = rects[i-3]
            local srcy = rects[i-2]
            local srctw = rects[i-1]
            local srcth = rects[i-0]
            quad:setViewport(srcx, srcy, srctw, srcth, srciw, srcih)
            love.graphics.draw(srcimage, quad, destx, desty)
        end

        -- love.graphics.rectangle("line", space.x, space.y, space.width, space.height)

        tiles[#tiles+1] = tile
    end
    for i = #newtilespaces, 1, -1 do
        newtilespaces[i] = nil
    end
end

function TileAtlas:newImageData()
    return self.canvas:newImageData()
end

function TileAtlas:save(path)
    self.canvas:newImageData():encode("png", string.format("%s.png", path))
end

---@param tileset Tileset
function TileAtlas:addTileset(tileset)
    local tilewidth = tileset.tilewidth
    local tileheight = tileset.tileheight
    local extrudedtilewidth = tilewidth + 2
    local extrudedtileheight = tileheight + 2
    local canvas = self.canvas
    local width = self.width
    local height = self.height

    for i = 0, tileset.tilecount-1 do
        local tile = tileset[i]
        if tile.image ~= canvas then
            if tile.empty then
                tile.image = canvas
                tile.quad:setViewport(1, 1, 2, 2, width, height)
            else
                local tilespace = self:takeSpace(extrudedtilewidth, extrudedtileheight, tile)
                self.newtilespaces[#self.newtilespaces+1] = tilespace
            end
        end
    end
end

function TileAtlas:addAseFrame(frame)
    if not frame then
        return
    end
    for i = 1, #frame do
        local cel = frame[i]
        if cel then
            self:addTile(cel)
        end
    end
end

setmetatable(TileAtlas, {__call = TileAtlas.New})
return TileAtlas