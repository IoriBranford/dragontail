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
    for i = 1, #self do
        local subspace = self[i]:findFreeSub(w, h)
        if subspace then
            return subspace
        end
    end
    if w <= self.width and h <= self.height and not self.tile then
        return self
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
        newspace[#newspace+1] = newSpace(self.width, 0, neww - self.width, self.height)
    else
        neww = self.width
    end
    if self.height < newh then
        if newspace==self then
            newspace = newSpace(0, 0, neww, newh)
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
---@field canvas love.Canvas
local TileAtlas = {}
TileAtlas.__index = TileAtlas

local EmptyTileSize = 4

function TileAtlas:growSpace2x()
    self.space = self.space:grow2x()
    self.width, self.height = self.space.width, self.space.height
end

function TileAtlas:drawOnCanvas(draw, ...)
    local prevdrawcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(self.canvas)
    draw(...)
    love.graphics.setCanvas(prevdrawcanvas)
end

function TileAtlas:resizeCanvas(width, height)
    local oldcanvas = self.canvas
    local newcanvas = love.graphics.newCanvas(width, height)
    if oldcanvas then
        local prevcanvas = love.graphics.getCanvas()
        love.graphics.setCanvas(newcanvas)
        love.graphics.draw(oldcanvas, 0, 0)
        love.graphics.setCanvas(prevcanvas)
        self.space:onCanvasResized(newcanvas)
    end
    self.canvas = newcanvas
end

local drawExtrudedQuad_srcquad = love.graphics.newQuad(0, 0, 1, 1, 1, 1)

local function drawExtrudedQuad(image, quad, space)
    local qx, qy, qw, qh = quad:getViewport()
    local dx0, dy0 = space.x, space.y
    local dx1, dy1 = dx0+1, dy0+1
    local dx2, dy2 = dx1+qw, dy1+qh
    local qx2 = qx + qw - 1
    local qy2 = qy + qh - 1
    local rects = {
        dx0, dy0, qx, qy, 1, 1,
        dx1, dy0, qx, qy, qw, 1,
        dx2, dy0, qx2, qy, 1, 1,
        dx0, dy1, qx, qy, 1, qh,
        dx1, dy1, qx, qy, qw, qh,
        dx2, dy1, qx2, qy, 1, qh,
        dx0, dy2, qx, qy2, 1, 1,
        dx1, dy2, qx, qy2, qw, 1,
        dx2, dy2, qx2, qy2, 1, 1
    }
    local outquad = drawExtrudedQuad_srcquad
    local iw, ih = image:getDimensions()
    for i = 6, #rects, 6 do
        local destx = rects[i-5]
        local desty = rects[i-4]
        local srcx = rects[i-3]
        local srcy = rects[i-2]
        local srcw = rects[i-1]
        local srch = rects[i-0]
        outquad:setViewport(srcx, srcy, srcw, srch, iw, ih)
        love.graphics.draw(image, outquad, destx, desty)
    end
end

---@param tiles AtlasTile[]
function TileAtlas:drawTilesToCanvas(tiles, tilespaces)
    local canvas = self.canvas
    local atlaswidth = self.width
    local atlasheight = self.height
    for i = 1, #tiles do
        local tile = tiles[i]
        if tile then
            local quad = tile.quad
            local space = tilespaces[i]
            local x, y, tw, th = 1, 1, 2, 2
            if space then
                local image = tile.image
                drawExtrudedQuad(image, quad, space)
                x, y, tw, th = quad:getViewport()
            end
            tile.image = canvas
            quad:setViewport(x, y, tw, th, atlaswidth, atlasheight)
        end
    end
end

function TileAtlas:reserveSpace(w, h, tile)
    local subspace = self.space:findFreeSub(w, h)
    while not subspace do
        self:growSpace2x()
        subspace = self.space:findFreeSub(w, h)
    end
    subspace:reserve(w, h, tile)
    return subspace
end

---@param tiles AtlasTile[]
function TileAtlas:addTiles(tiles)
    local quadspaces = {}
    for i = 1, #tiles do
        local imagequad = tiles[i]
        local image, quad
        if imagequad then
            image, quad = imagequad.image, imagequad.quad
        end
        if image and quad then
            local _, _, w, h = quad:getViewport()
            quadspaces[i] = self:reserveSpace(w+2, h+2, quad)
        else
            quadspaces[i] = false
        end
    end

    local canvas = self.canvas
    local atlaswidth = self.width
    local atlasheight = self.height
    if canvas:getWidth() < atlaswidth
    or canvas:getHeight() < atlasheight then
        self:resizeCanvas(atlaswidth, atlasheight)
    end

    self:drawOnCanvas(self.drawTilesToCanvas, self, tiles, quadspaces)
end

---@param tileset Tileset
function TileAtlas:addTileset(tileset)
    if tileset.atlas == self then
        return
    end
    tileset.atlas = self
    local tilewidth = tileset.tilewidth
    local tileheight = tileset.tileheight
    local extrudedtilewidth = tilewidth + 2
    local extrudedtileheight = tileheight + 2

    local tilespaces = {}
    for i = 0, tileset.tilecount-1 do
        local tile = tileset[i]
        if tile.empty then
            tilespaces[#tilespaces+1] = false
        else
            tilespaces[#tilespaces+1] = self:reserveSpace(extrudedtilewidth, extrudedtileheight, tile.quad)
        end
    end

    local canvas = self.canvas
    local atlaswidth = self.width
    local atlasheight = self.height
    if canvas:getWidth() < atlaswidth
    or canvas:getHeight() < atlasheight then
        self:resizeCanvas(atlaswidth, atlasheight)
    end

    self:drawOnCanvas(self.drawTilesToCanvas, self, tileset, tilespaces)
end

---@param aseprite Aseprite
function TileAtlas:addAseprite(aseprite)
    if aseprite.atlas == self then
        return
    end
    aseprite.atlas = self
    local celsbysrcpos = aseprite:mapCelsBySourcePositions()

    local posspaces = {}
    for pos, cels in pairs(celsbysrcpos) do
        posspaces[pos] = self:reserveSpace(cels[1])
    end

    local canvas = self.canvas
    local atlaswidth = self.width
    local atlasheight = self.height
    if canvas:getWidth() < atlaswidth
    or canvas:getHeight() < atlasheight then
        self:resizeCanvas(atlaswidth, atlasheight)
    end

    self:drawOnCanvas(self.drawAseCelsToCanvas, self, celsbysrcpos, posspaces)
end

function TileAtlas:drawAseCelsToCanvas(celsbysrcpos, posspaces)
    local canvas = self.canvas
    local atlaswidth = self.width
    local atlasheight = self.height
    for pos, cels in pairs(celsbysrcpos) do
        local cel1 = cels[1]
        local space = posspaces[pos]
        local x, y, tw, th = 1, 1, 2, 2
        if space then
            local image = cel1.image
            local quad = cel1.quad
            drawExtrudedQuad(image, quad, space)
            x, y, tw, th = quad:getViewport()
        end
        for i = 1, #cels do
            cels[i].image = canvas
            cels[i].quad:setViewport(x, y, tw, th, atlaswidth, atlasheight)
        end
    end
end

function TileAtlas.EstimateTextureSize(area)
    local texturewidth = EmptyTileSize
    local textureheight = EmptyTileSize

    while area > texturewidth*textureheight do
        if textureheight < texturewidth then
            textureheight = textureheight*2
        else
            texturewidth = texturewidth*2
        end
    end
    return texturewidth, textureheight
end

---@param tilesets {[string]:Tileset}
function TileAtlas:estimateTilesArea(tilesets)
    if not tilesets then return end
    local area = 0
    for _, tileset in pairs(tilesets) do
        local tilewidth = tileset.tilewidth+2
        local tileheight = tileset.tileheight+2
        local tilearea = tilewidth*tileheight
        local n = tileset.tilecount - tileset.numempty
        area = area + tilearea*n
    end
    return area
end

---@param aseprites {[string]:Aseprite}
function TileAtlas:estimateAsepritesArea(aseprites)
    if not aseprites then return end
    local area = 0
    for _, aseprite in pairs(aseprites) do
        local celsbysrcpos = aseprite:mapCelsBySourcePositions()
        for _, cels in pairs(celsbysrcpos) do
            local cel = cels[1]
            local celwidth = cel.width + 2
            local celheight = cel.height + 2
            local celarea = celwidth*celheight
            area = area + celarea
        end
    end
    return area
end

return function(tilesets, aseprites)
    local self = setmetatable({}, TileAtlas)
    local area = EmptyTileSize*EmptyTileSize
        + self:estimateTilesArea(tilesets)
        + self:estimateAsepritesArea(aseprites)

    local width, height = TileAtlas.EstimateTextureSize(area)
    self.width, self.height = width, height
    self.space = newSpace(0, 0, width, height)
    self:resizeCanvas(width, height)

    self.space:reserve(EmptyTileSize, EmptyTileSize, {
        image = self.canvas,
        quad = love.graphics.newQuad(1, 1, 2, 2, width, height)
    })
    return self
end