local TilePacking = require "Tiled.TilePacking"
local hasAseprite, Aseprite = pcall(require, "Aseprite")

---@alias AssetGroup {[string]:Tileset}|{[string]:love.Image}|{[string]:love.Font}

local Assets = {
    loaders = {},---@type {[string]:function}
    rootpath = "",
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
    local permanent = Assets.permanent
    for m, map in pairs(Assets.maps) do
        if not permanent[m] then
            Assets.maps[m] = nil
            Assets.all[m] = nil

            for ts in pairs(map.tilesets) do
                Assets.tilesets[ts] = nil
            end
        end
    end

    local touncache = Assets.touncache

    for _, assetgroup in pairs(Assets.bytype) do
        for file in pairs(assetgroup) do
            if not permanent[file] then
                touncache[file] = assetgroup
            end
        end
    end
end

function Assets.uncache(path)
    if Assets.permanent[path] then
        return
    end
    local ext = path:match("%.(%w-)$")
    local assetgroup = Assets.bytype[ext]
    if assetgroup then
        assetgroup[path] = nil
        Assets.touncache[path] = nil
        Assets.all[path] = nil
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
    local function markLayersPermanent(layers)
        for _, layer in ipairs(layers) do
            if layer.type == "group" then
                markLayersPermanent(layer)
            elseif layer.type == "imagelayer" then
                ---@cast layer ImageLayer
                markPermanent(layer.imagefile)
            elseif layer.type == "objectgroup" then
                ---@cast layer ObjectGroup
                for _, object in ipairs(layer) do
                    ---@cast object TextObject
                    local fontfamily = object.fontfamily
                    if fontfamily then
                        local pixelsize, bold, italic
                            = object.pixelsize, object.bold, object.italic
                        local fnt = Assets.fontpath
                            .. Assets.buildFontNameWithSize(fontfamily, pixelsize, bold, italic)
                            .. ".fnt"
                        local ttf = Assets.fontpath
                            .. Assets.buildFontName(fontfamily, bold, italic)
                            .. ".ttf"
                        markPermanent(fnt)
                        markPermanent(ttf)
                    end
                end
            end
        end
    end
    markLayersPermanent(map.layers)
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

function Assets.fileInfo(path)
    return love.filesystem.getInfo(Assets.rootpath..path)
end

function Assets.load(path, ...)
    if type(path) ~= "string" then
        return
    end
    local ext = path:match("%.(%w-)$")
    local loader = Assets.loaders[ext] or love.filesystem.read
    local asset = loader(Assets.rootpath..path, ...)
    Assets.put(path, asset)
    return asset
end

function Assets.put(path, asset)
    local ext = path:match("%.(%w-)$")
    Assets.all[path] = asset
    local bytype = Assets.bytype[ext] or {}
    Assets.bytype[ext] = bytype
    bytype[path] = asset
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
    return string.format("%s %d", fontname, pixelsize or 16)
end

---@param fontformat "ttf"?
function Assets.getFont(fontfamily, pixelsize, bold, italic, fontformat)
    pixelsize = pixelsize or 16
    local font
    if fontformat ~= "ttf" then
        local fnt = Assets.fontpath .. Assets.buildFontNameWithSize(fontfamily, pixelsize, bold, italic) .. ".fnt"
        font = Assets.fileInfo(fnt) and Assets.get(fnt)
    end
    if not font then
        local ttf = Assets.fontpath .. Assets.buildFontName(fontfamily, bold, italic) .. ".ttf"
        font = Assets.fileInfo(ttf) and Assets.get(ttf, pixelsize)
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
        local _, tileset1 = next(Assets.tilesets)
        Assets.put("packedtiles.png", tileset1.image)
        -- TilePacking.save(Assets.tilesets, "packedtiles.lua", "packedtiles.png", packimagedata)
    else
        print(packimageerr)
    end
end

function Assets.batchAllMapsLayers()
    for _, map in pairs(Assets.maps) do
        map:batchLayerTiles()
    end
end

function Assets.setFilter(min, mag, aniso)
    for i = 1, 3 do
        local assets = select(i,
            Assets.bytype.png,
            Assets.bytype.fnt,
            Assets.bytype.ttf)
        if assets then
            for _, asset in pairs(assets) do
                asset:setFilter(min, mag, aniso)
            end
        end
    end
end

function Assets.listGroup(list, assetgroup)
    for src, asset in pairs(assetgroup) do
        list[#list+1] = src..":"..tostring(asset)
    end
    return list
end

Assets.addLoaders {
    png = love.graphics.newImage,
    fnt = love.graphics.newFont,
    ttf = love.graphics.newFont,
    defaultfont = function(path)
        local size = tonumber(path:match("(%d+).defaultfont"))
        return size and love.graphics.newFont(size)
    end,
    jase = hasAseprite and function(path)
        local ase = Aseprite.load(path)
        local directory = string.match(path, "^(.+/)") or ""
        Assets.put(directory..ase.imagefile, ase.image)
        return ase
    end
}

return Assets
