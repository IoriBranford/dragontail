local TilePacking = require "Tiled.TilePacking"

---@alias AssetGroup {[string]:Tileset}|{[string]:love.Image}|{[string]:love.Font}

local Assets = {
    fontpath = "",
    maps = {}, ---@type {[string]:TiledMap}
    tilesets = {}, ---@type {[string]:Tileset}
    images = {},---@type {[string]:love.Image}
    fonts = {}, ---@type {[string]:love.Font}
    touncache = {}, ---@type {[string]:AssetGroup}
    permanent = {} ---@type {[string]:boolean}
}

function Assets.markAllToUncache()
    Assets.maps = {}
    Assets.tilesets = {}

    local touncache = Assets.touncache
    local permanent = Assets.permanent

    local function markToUncache(file, assetgroup)
        if not permanent[file] then
            touncache[file] = assetgroup
        end
    end

    local images = Assets.images
    for k in pairs(images) do
        markToUncache(k, images)
    end
    local fonts = Assets.fonts
    for k in pairs(fonts) do
        markToUncache(k, fonts)
    end
end

---@param map TiledMap
function Assets.markMapAssetsPermanent(map, ispermanent)
    local touncache = Assets.touncache
    local permanent = Assets.permanent

    local function markPermanent(file)
        permanent[file] = ispermanent
        if ispermanent then
            touncache[file] = nil
        end
    end

    markPermanent(map.file)
    for _, tileset in ipairs(map.tilesets) do
        markPermanent(tileset.imagefile)
    end
    for _, layer in ipairs(map.layers) do
        if layer.type == "imagelayer" then
            ---@cast layer ImageLayer
            markPermanent(layer.imagefile)
        elseif layer.type == "objectgroup" then
            ---@cast layer ObjectGroup
            for _, object in ipairs(layer) do
                if object.shape == "text" then
                    ---@cast object TextObject
                    local fontname = Assets.buildFontNameWithSize(
                        object.fontfamily,
                        object.pixelsize,
                        object.bold,
                        object.italic)
                    markPermanent(fontname)
                end
            end
        end
    end
end

function Assets.uncacheMarked()
    local touncache = Assets.touncache
    for path, assets in pairs(touncache) do
        assets[path] = nil
        touncache[path] = nil
    end
end

function Assets.setFontPath(fontpath)
    Assets.fontpath = fontpath
    if fontpath[-1] ~= "/" then
        fontpath = fontpath.."/"
    end
end

function Assets.loadImage(imagefile)
    Assets.touncache[imagefile] = nil
    local image = Assets.images[imagefile]
    if image then
        return image
    end
    image = love.graphics.newImage(imagefile)
    Assets.images[imagefile] = image
    image:setFilter("nearest", "nearest")
    return image
end

function Assets.buildFontName(fontfamily, bold, italic)
    fontfamily = fontfamily or "default"
    return string.format("%s%s%s", fontfamily,
        bold and " Bold" or "",
        italic and " Italic" or "")
end

function Assets.buildFontNameWithSize(fontfamily, pixelsize, bold, italic)
    fontfamily = fontfamily or "default"
    local fontname = Assets.buildFontName(fontfamily, bold, italic)
    pixelsize = pixelsize or 16
    return string.format("%s %d", fontname, pixelsize)
end

---@param fontformat "ttf"?
function Assets.loadFont(fontfamily, pixelsize, bold, italic, fontformat)
    local fontname = Assets.buildFontName(fontfamily, bold, italic)
    local ttf = Assets.fontpath .. fontname .. ".ttf"
    Assets.touncache[fontname] = nil
    local fnt = Assets.fontpath .. Assets.buildFontNameWithSize(fontfamily, pixelsize, bold, italic) .. ".fnt"
    local font = Assets.fonts[fontname]
        or fontformat ~= "ttf" and love.filesystem.getInfo(fnt) and love.graphics.newFont(fnt)
        or love.filesystem.getInfo(ttf) and love.graphics.newFont(ttf, pixelsize)
        or love.graphics.newFont(pixelsize)
    if not Assets.fonts[fontname] then
        font:setFilter("nearest", "nearest")
        Assets.fonts[fontname] = font
    end
    return font
end

function Assets.getTile(tileset, tileid)
    tileset = Assets.tilesets[tileset]
    return tileset and tileset[tileid]
end

function Assets.packTiles()
    local packimagedata, packimageerr = TilePacking.pack(Assets.tilesets)
    if packimagedata then
        -- for _, tileset in pairs(Assets.tilesets) do
        --     Assets.images[tileset.imagefile] = nil
        -- end
        for _, map in pairs(Assets.maps) do
            map:batchLayerTiles()
        end
        -- TilePacking.save(Assets.tilesets, "packedtiles.lua", "packedtiles.png", packimagedata)
    else
        print(packimageerr)
    end
end

return Assets
