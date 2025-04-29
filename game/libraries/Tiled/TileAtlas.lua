--- Not yet tested

---@class AtlasTile
---@field image love.Texture
---@field quad love.Quad

---@class AtlasSpace
---@field x number
---@field y number
---@field width number
---@field height number
---@field tile AtlasTile
---@field [integer] AtlasSpace
local AtlasSpace = {}
AtlasSpace.__index = AtlasSpace

local function newSpace(x, y, w, h)
    return setmetatable({x = x, y = y, width = w, height = h}, AtlasSpace)
end

function AtlasSpace:findFreeSub(w, h)
    if w > self.width or h > self.height then
        return
    end
    if not self.tile then
        return self
    end
    for i = 1, #self do
        local subspace = self[i]:findFreeSub(w, h)
        if subspace then
            return subspace
        end
    end
end

function AtlasSpace:split(w, h)
    local rightw = self.width - w
    local downh = self.height - h
    if rightw > 0 then
        self[#self+1] = newSpace(self.x + w, self.y, rightw, h)
    end
    if downh > 0 then
        self[#self+1] = newSpace(self.x, self.y + h, self.width, downh)
    end
end

---@param w integer
---@param h integer
---@param tile AtlasTile
function AtlasSpace:reserve(w, h, tile)
    self.tile = tile
    self:split(w, h)
end

function AtlasSpace:grow(neww, newh)
    local newspace = self
    if self.width < neww then
        newspace = newSpace(0, 0, neww, newh)
        newspace.tile = self.tile
        newspace[#newspace+1] = newSpace(self.width, 0, neww - self.width, self.height)
    else
        neww = self.width
    end
    if self.height < newh then
        if newspace==self then
            newspace = newSpace(0, 0, neww, newh)
            newspace.tile = self.tile
        end
        newspace[#newspace+1] = newSpace(0, self.height, neww, newh - self.height)
    end
    if newspace ~= self then
        newspace[#newspace+1] = self
    end
    return newspace
end

function AtlasSpace:grow2x()
    local width, height = self.width, self.height
    if height > width then
        width = width * 2
    else
        height = height * 2
    end
    return self:grow(width, height)
end

function AtlasSpace:onCanvasResized(canvas)
    local tile = self.tile
    if tile then
        local x, y, w, h = tile.quad:getViewport()
        local iw, ih = canvas:getDimensions()
        tile.image = canvas
        tile.quad:setViewport(x, y, w, h, iw, ih)
    end

    for i = 1, #self do
        self[i]:onCanvasResized(canvas)
    end
end

---@class TileAtlas
---@field width number
---@field height number
---@field space AtlasSpace
---@field newtilespaces AtlasSpace[]
---@field canvas love.Canvas
local TileAtlas = {}
TileAtlas.__index = TileAtlas

local MaxTextureSize

function TileAtlas.New(width, height)
    MaxTextureSize = MaxTextureSize or love.graphics.getSystemLimits().texturesize
    local self = setmetatable({}, TileAtlas)
    width = width or 4096
    height = height or width
    self.width, self.height = width, height
    self.canvas = love.graphics.newCanvas(width, height)
    self.space = newSpace(0, 0, width, height)
    self.space:reserve(4, 4, {
        image = self.canvas,
        quad = love.graphics.newQuad(1, 1, 2, 2, width, height)
    })
    self.newtilespaces = {}
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
---@return AtlasSpace
function TileAtlas:takeSpace(w, h, tile)
    local tilespace = self.space:findFreeSub(w, h)
    while not tilespace and
    (self.width < MaxTextureSize or self.height < MaxTextureSize)
    do
        self.space = self.space:grow2x()
        self.width, self.height = self.space.width, self.space.height
        tilespace = self.space:findFreeSub(w, h)
    end
    if tilespace then
        tilespace:reserve(w, h, tile)
    end
    return tilespace
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
    end

    if #self.newtilespaces > 0 then
        canvas:renderTo(function()
            self:drawNewTilesToCanvas()
        end)
    end

    if resized then
        self.space:onCanvasResized(canvas)
    end
end

function TileAtlas:drawNewTilesToCanvas()
    local canvas = self.canvas
    local width = self.canvas:getWidth()
    local height = self.canvas:getHeight()
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
        assert(tile.width == twidth and tile.height == theigt)

        local tiles = space.tiles
        if tiles then
            for t = 1, #tiles do
                tiles[t].image = canvas
                tiles[t].quad:setViewport(tdestx, tdesty, twidth, theigt, width, height)
            end
        end

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
    end
    for i = #newtilespaces, 1, -1 do
        newtilespaces[i] = nil
    end
end

function TileAtlas:newImageData()
    return self.canvas:newImageData()
end

function TileAtlas:saveCanvas(path)
    self.canvas:newImageData():encode("png", path)
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
    local emptyx, emptyy, emptyww, emptyh = self.space.tile.quad:getViewport()

    for i = 0, tileset.tilecount-1 do
        local tile = tileset[i]
        if tile.image ~= canvas then
            if tile.empty then
                tile.image = canvas
                tile.quad:setViewport(emptyx, emptyy, emptyww, emptyh, width, height)
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