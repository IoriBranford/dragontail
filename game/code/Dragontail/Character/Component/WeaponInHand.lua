local Database = require "Data.Database"
local Assets       = require "Tiled.Assets"
local Color        = require "Tiled.Color"

---@class WeaponInHand:AsepriteObject
---@field weaponposasefile string?
---@field weaponinhand string?
---@field weapontransforms number[]?
local WeaponInHand = {}

---@param imagedata love.ImageData
---@param cel AseCel
local function getHandMarkers(imagedata, cel)
    local palmx, palmy, thumbx, thumby, fingersx, fingersy
    local x0, y0, w, h = cel.quad:getViewport()
    local x1, y1 = x0 + w - 1, y0 + h - 1
    for y = y0, y1 do
        for x = x0, x1 do
            local r, g, b, a = imagedata:getPixel(x, y)
            local color = Color.asARGBInt(r, g, b, a)
            if color == Color.Red then
                thumbx, thumby = x, y
                if palmx and palmy and fingersx and fingersy then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            elseif color == Color.Green then
                fingersx, fingersy = x, y
                if palmx and palmy and thumbx and thumby then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            elseif color == Color.Blue then
                palmx, palmy = x, y
                if fingersx and fingersy and thumbx and thumby then
                    return palmx, palmy, thumbx, thumby, fingersx, fingersy
                end
            end
        end
    end
end

---@param imagedata love.ImageData
---@param cel AseCel
local function readWeaponTransform(imagedata, cel)
    local palmx, palmy, thumbx, thumby, fingersx, fingersy
        = getHandMarkers(imagedata, cel)
    if not palmx then return end

    local x0, y0 = cel.quad:getViewport()
    local x = palmx - x0 + cel.x
    local y = palmy - y0 + cel.y
    return x, y, math.atan2(thumby-palmy, thumbx-palmx),
        math.det(thumbx-palmx, thumby-palmy, fingersx-palmx, fingersy-palmy) < 0 and -1 or 1
end

function WeaponInHand:loadHandPositions()
    local weaponposasefile = self.weaponposasefile
    local weaponposase = weaponposasefile and
        Assets.load(weaponposasefile, true)
    if not weaponposase then return end

    ---@cast weaponposase Aseprite
    Assets.uncache(weaponposase.imagefile)
    Assets.uncache(weaponposasefile)
    local imagedata = weaponposase.imagedata
    if not imagedata then return end

    ---@type number[]
    local weapontransforms = {}
    self.weapontransforms = weapontransforms

    for i = 1, #weaponposase do
        local frame = weaponposase[i]
        local cel = frame and frame[1]
        local x, y, r, sy
        if cel then
            x, y, r, sy = readWeaponTransform(imagedata, cel)
        end
        if not x then
            x, y, r, sy = 0, 0, 0, 0
        end
        weapontransforms[#weapontransforms+1] = x
        weapontransforms[#weapontransforms+1] = y
        weapontransforms[#weapontransforms+1] = r
        weapontransforms[#weapontransforms+1] = sy
    end
end

function WeaponInHand:getHandPosition(frame)
    local weapontransforms = self.weapontransforms
    if not weapontransforms then return end

    local i = frame.index*4
    local weaponx, weapony, weaponr, weaponsy =
        weapontransforms[i-3], weapontransforms[i-2], weapontransforms[i-1], weapontransforms[i]
    if weaponsy then
        return weaponx, weapony, weaponr, weaponsy
    end
end

function WeaponInHand:draw(frame, x, y)
    local weaponhandlayer = self.aseprite.layers["weaponhand"]
    if not weaponhandlayer then return end

    local weapontype = Database.get(self.weaponinhand)
    if not weapontype then return end

    local weaponx, weapony, weaponr, weaponsy = WeaponInHand.getHandPosition(self, frame)
    if not weaponx or not weapony or not weaponr or not weaponsy then
        return
    end

    local weaponase = Assets.get(weapontype.asefile)
    ---@cast weaponase Aseprite
    if weaponase then
        local weaponanim = weaponase.animations["inhand"]
        local weaponframe = weaponanim and weaponanim[1]
        if not weaponframe then return end

        love.graphics.push()
        love.graphics.translate(x + weaponx, y + weapony)
        love.graphics.rotate(weaponr)
        love.graphics.scale(1, weaponsy)
        local originx, originy = weaponframe:getSliceOrigin("origin")
        if not originx or not originy then
            originx, originy = weaponase[1]:getSliceOrigin("origin")
        end
        love.graphics.translate(-(originx or 0), -(originy or 0))
        weaponframe:draw()
        love.graphics.pop()
    else
        local weapontile = Assets.getTile(weapontype.tileset, weapontype.tileid)
        if not weapontile then
            return
        end

        love.graphics.draw(weapontile.image,
            weapontile.quad,
            x + weaponx, y + weapony,
            weaponr,
            1, weaponsy,
            weapontile.objectoriginx, weapontile.objectoriginy)
    end

    if weaponhandlayer then
        frame:drawCels(weaponhandlayer, weaponhandlayer, x, y)
    end
end

return WeaponInHand