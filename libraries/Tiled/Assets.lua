local Assets = {
    fontpath = ""
}

function Assets.clear()
    local tilesets = Assets.tilesets
    if tilesets then
        for _, tileset in pairs(Assets.tilesets) do
            for i = 0, tileset.tilecount - 1 do
                tileset[i].tileset = nil
            end
        end
    end
    Assets.tilesets = {}
    Assets.images = {}
    Assets.fonts = {}
end

Assets.clear()

function Assets.setFontPath(fontpath)
    Assets.fontpath = fontpath
    if fontpath[-1] ~= "/" then
        fontpath = fontpath.."/"
    end
end

function Assets.loadImage(imagefile)
    local image = Assets.images[imagefile] or love.graphics.newImage(imagefile)
    Assets.images[imagefile] = image
    image:setFilter("nearest", "nearest")
    return image
end

function Assets.loadFont(fontfamily, pixelsize, bold, italic)
    fontfamily = fontfamily or "default"
    local fontname = string.format("%s%s%s", fontfamily,
        bold and " Bold" or "",
        italic and " Italic" or "")
    local ttf = Assets.fontpath .. fontname .. ".ttf"
    pixelsize = pixelsize or 16
    fontname = string.format("%s %d", fontname, pixelsize)
    local fnt = Assets.fontpath .. fontname .. ".fnt"
    local font = Assets.fonts[fontname]
        or love.filesystem.getInfo(fnt) and love.graphics.newFont(fnt)
        or love.filesystem.getInfo(ttf) and love.graphics.newFont(ttf, pixelsize)
        or love.graphics.newFont(pixelsize)
    if not Assets.fonts[fontname] then
        font:setFilter("nearest", "nearest")
        Assets.fonts[fontname] = font
    end
    return font
end

function Assets.getTile(tileset, tileid)
    return Assets.tilesets[tileset][tileid]
end

return Assets
