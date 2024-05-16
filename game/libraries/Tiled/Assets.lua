local TilePacking = require "Tiled.TilePacking"
local hasAseprite, Aseprite = pcall(require, "Aseprite")

---@alias AssetGroup {[string]:Tileset}|{[string]:love.Image}|{[string]:love.Font}

local Assets = {
    loaders = {},---@type {[string]:function}
    prefix = "",
    fontpath = "",
    all = {},
    bytype = {}, ---@type {[string]:AssetGroup}
    maps = {}, ---@type {[string]:TiledMap}
    tilesets = {}, ---@type {[string]:Tileset}
    touncache = {}, ---@type {[string]:AssetGroup}
    permanent = {} ---@type {[string]:boolean}
}

function Assets.addLoaders(loaders)
    for ext, loader in pairs(loaders) do
        Assets.loaders[ext] = loader
    end
end

function Assets.markAllToUncache()
    for k in pairs(Assets.maps) do
        Assets.maps[k] = nil
        Assets.all[k] = nil
    end
    for k in pairs(Assets.tilesets) do
        Assets.tilesets[k] = nil
        Assets.all[k] = nil
    end

    local touncache = Assets.touncache
    local permanent = Assets.permanent

    for _, assetgroup in pairs(Assets.bytype) do
        for file in pairs(assetgroup) do
            if not permanent[file] then
                touncache[file] = assetgroup
            end
        end
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
    local all = Assets.all
    for path, assetgroup in pairs(touncache) do
        assetgroup[path] = nil
        touncache[path] = nil
        all[path] = nil
    end
end

function Assets.setFontPath(fontpath)
    Assets.fontpath = fontpath
    if fontpath[-1] ~= "/" then
        fontpath = fontpath.."/"
    end
end

function Assets.isAsset(path)
    if type(path) ~= "string" then
        return
    end
    local ext = path:match("%.(%w-)$")
    return ext and Assets.loaders[ext] ~= nil
end

function Assets.load(path, ...)
    if type(path) ~= "string" then
        return
    end
    local ext = path:match("%.(%w-)$")
    local loader = Assets.loaders[ext] or love.filesystem.read
    local asset = loader(Assets.prefix..path, ...)
    Assets.all[path] = asset
    local bytype = Assets.bytype[ext] or {}
    Assets.bytype[ext] = bytype
    bytype[path] = asset
    return asset
end

function Assets.get(path, ...)
    if path then
        Assets.touncache[path] = nil
        return Assets.all[path] or Assets.load(path, ...)
    end
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
function Assets.getFont(fontfamily, pixelsize, bold, italic, fontformat)
    local font
    if fontformat ~= "ttf" then
        local fnt = Assets.fontpath .. Assets.buildFontNameWithSize(fontfamily, pixelsize, bold, italic) .. ".fnt"
        font = love.filesystem.getInfo(fnt) and Assets.get(fnt)
    end
    if not font then
        local ttf = Assets.fontpath .. Assets.buildFontName(fontfamily, bold, italic) .. ".ttf"
        font = love.filesystem.getInfo(ttf) and Assets.get(ttf, pixelsize)
    end
    if not font then
        font = Assets.get(pixelsize..".defaultfont")
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

Assets.addLoaders {
    png = love.graphics.newImage,
    fnt = love.graphics.newFont,
    ttf = love.graphics.newFont,
    defaultfont = function(path)
        local size = tonumber(path:match("(%d+).defaultfont"))
        return size and love.graphics.newFont(size)
    end,
    jase = hasAseprite and Aseprite.load
}

return Assets
