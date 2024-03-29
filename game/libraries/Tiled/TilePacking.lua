local function newSpace(x, y, w, h)
	return {
		x = x, y = y, w = w, h = h
	}
end

local function findSubspace(space, w, h)
	for i = 1, #space do
		local subspace = findSubspace(space[i], w, h)
		if subspace then
			return subspace
		end
	end
	return w <= space.w and h <= space.h and not space.tile and space
end

local function splitSpace(space, w, h)
	local rightw = space.w - w
	local downh = space.h - h
	if rightw > 0 then
		space[#space+1] = newSpace(space.x + w, space.y, rightw, h)
	end
	if downh > 0 then
		space[#space+1] = newSpace(space.x, space.y + h, space.w, downh)
	end
end

local function growSpace(space, neww, newh)
	local newspace = space
	if space.w < neww then
		newspace = newSpace(0, 0, neww, newh)
		newspace[#newspace+1] = newSpace(space.w, 0, neww - space.w, space.h)
	else
		neww = space.w
	end
	if space.h < newh then
		if newspace==space then
			newspace = newSpace(0, 0, neww, newh)
		end
		newspace[#newspace+1] = newSpace(0, space.h, neww, newh - space.h)
	end
	if newspace ~= space then
		newspace[#newspace+1] = space
	end
	return newspace
end

---@class TilePacking
local TilePacking = {}

--- Pack all tiles in a list of tilesets into one image.
--- Do not use with gamma-correct rendering - tiles will be darkened.
--- @param tilesets {[integer|string]:Tileset}
--- @return love.ImageData? imagedata packed image data for saving
--- @return string? error if no imagedata, what went wrong
function TilePacking.pack(tilesets)
    if not love.graphics then
        return nil, "Megatileset requires love.graphics"
    end

    local packarea = 0
    local maxtilewidth = 0
    local maxtileheight = 0
    for _, tileset in pairs(tilesets) do
        local tilewidth = tileset.tilewidth
        local tileheight = tileset.tileheight
        if maxtilewidth < tilewidth then
            maxtilewidth = tilewidth
        end
        if maxtileheight < tileheight then
            maxtileheight = tileheight
        end
        local tilearea = tilewidth*tileheight
        packarea = packarea + tilearea*tileset.tilecount
    end

    local packwidth = 1
    local packheight = 1

    while packarea > packwidth*packheight do
        if packheight < packwidth then
            packheight = packheight*2
        else
            packwidth = packwidth*2
        end
    end

    local sizesortedtiles = {}
    for _, tileset in pairs(tilesets) do
        for t = 0, tileset.tilecount-1 do
            sizesortedtiles[#sizesortedtiles+1] = tileset[t]
        end
    end
    table.sort(sizesortedtiles, function(a, b)
        return a.width*a.height > b.width*b.height
    end)

    local allspace = newSpace(0, 0, packwidth, packheight)

    for i = 1, #sizesortedtiles do
        local tile = sizesortedtiles[i]
        local width = tile.width + 2
        local height = tile.height + 2
        local subspace = findSubspace(allspace, width, height)
        while not subspace do
            if packheight < packwidth then
                packheight = packheight*2
            else
                packwidth = packwidth*2
            end
            allspace = growSpace(allspace, packwidth, packheight)
            subspace = findSubspace(allspace, width, height)
        end
        subspace.tile = tile
        splitSpace(subspace, width, height)
    end

    local limits = love.graphics.getSystemLimits()
    if packwidth > limits.texturesize
    or packheight > limits.texturesize then
        return nil, string.format("Megatileset exceeds texture size limit of %dpx", limits.texturesize)
    end

    local drawSpace_quad = love.graphics.newQuad(0, 0, 1, 1, 1, 1)
    local function drawSpace(space)
        local quad = drawSpace_quad
        local tile = space.tile
        if tile then
            local tw, th = tile.width, tile.height
            local dx0, dy0 = space.x, space.y
            local dx1, dy1 = dx0+1, dy0+1
            local dx2, dy2 = dx1+tw, dy1+th
            local qx, qy, qw, qh = tile.quad:getViewport()
            local qx2 = qx + qw - 1
            local qy2 = qy + qh - 1
            local drawrects = {
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
            local image = tile.image
            local iw, ih = image:getDimensions()
            for i = 6, #drawrects, 6 do
                local destx = drawrects[i-5]
                local desty = drawrects[i-4]
                local ex = drawrects[i-3]
                local ey = drawrects[i-2]
                local ew = drawrects[i-1]
                local eh = drawrects[i-0]
                quad:setViewport(ex, ey, ew, eh, iw, ih)
                love.graphics.draw(image, quad, destx, desty)
            end
            tile.quad:setViewport(dx1, dy1, tw, th,
                packwidth, packheight)
        end
        --DEBUG
        --love.graphics.rectangle("line", space.x, space.y, space.w, space.h)
        for i = 1, #space do
            drawSpace(space[i])
        end
    end

    local canvas = love.graphics.newCanvas(packwidth, packheight)
    love.graphics.setCanvas(canvas)
    love.graphics.setLineStyle("rough")
    drawSpace(allspace)
    love.graphics.setCanvas()

    local imagedata = canvas:newImageData()
    local image = love.graphics.newImage(imagedata)
    image:setFilter("nearest", "nearest")
    for _, tileset in pairs(tilesets) do
        tileset.image = image
        -- local firstgid = tileset.firstgid
        -- for t = 0, #tileset-1 do
        --     local tile = tileset[t]
        --     if tile.animation then
        --         for f, frame in ipairs(tile.animation) do
        --             local ftile = frame.tile
        --             print(ftile, tileset[frame.tileid], maptiles[firstgid + frame.tileid])
        --         end
        --     end
        -- end
        for i = 0, tileset.tilecount-1 do
            tileset[i].image = image
        end
    end

    return imagedata
end

--- Save the packed tiles as an image and a table of quads
---@param tilesets {[integer|string]:Tileset} dict of packed tiles
---@param quadspath string quad table file path
---@param imagepath string image file path
---@param imagedata love.ImageData image data returned from packing
function TilePacking.save(tilesets, quadspath, imagepath, imagedata)
    imagedata:encode("png", imagepath)

    local quadscode = { "return {" }
    for _, tileset in pairs(tilesets) do
        quadscode[#quadscode+1] = tileset.name.."={"
        for i = 0, tileset.tilecount-1 do
            local x, y, w, h = tileset[i].quad:getViewport()
            quadscode[#quadscode+1] = string.format("%d,%d,%d,%d,", x, y, w, h)
        end
        quadscode[#quadscode+1] = "},"
    end
    quadscode[#quadscode+1] = "}"
    love.filesystem.write(quadspath, table.concat(quadscode))
end

--- Load packed tiles into map
---@deprecated
---@param tilesets {[integer|string]:Tileset} map whose packed tiles were saved
---@param quadspath string quad table file path
---@param imagepath string image file path
---@return boolean success
---@return string? err
function TilePacking.load(tilesets, quadspath, imagepath)
    local quadsfunction, err = love.filesystem.load(quadspath)
    if not quadsfunction then
        return false, err
    end

    local tilesetquads = quadsfunction()

    -- if type(imagepath) == "string" then
    local image = love.graphics.newImage(imagepath)
    image:setFilter("nearest", "nearest")

    local iw, ih = image:getDimensions()
    for _, tileset in pairs(tilesets) do
        tileset.image = image
        local quads = tilesetquads[tileset.name]
        local qi = 4
        for i = 0, tileset.tilecount-1 do
            local tile = tileset[i]
            tile.image = image
            tile.quad:setViewport(quads[qi-3], quads[qi-2], quads[qi-1], quads[qi], iw, ih)
            qi = qi + 4
        end
    end
    -- elseif not megaimage.typeOf or not megaimage:typeOf("Image") then
    --     megaimage = tilesets[1].image
    -- end

    return true
end

return TilePacking