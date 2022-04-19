local Assets = require "System.Assets"
local Tiled  = require "Data.Tiled"
local Body   = require "Demonizer.Character.Body"
local getTile = Tiled.getTile

local Sprite = {}

function Sprite:newAseprite(scene)
    local asepritefile = self.asepritefile
    local ase = asepritefile and Assets.get(asepritefile)
    if not ase then
        return
    end

    local frameortag, tagframe, x, y, ox, oy
        = self.animation or 1, 1,
        self.x, self.y,
        self.spriteoriginx or 0, self.spriteoriginy or 0
    local z, r, sx, sy = self.z, self.rotation, self.scalex, self.scaley

    if type(frameortag) == "string" then
        return scene:addAnimatedAseprite(ase, frameortag, tagframe,
            x, y, z, r, sx, sy, ox, oy)
    else
        return scene:addAseprite(ase, frameortag,
            x, y, z, r, sx, sy, ox, oy)
    end
end
local newAseprite = Sprite.newAseprite

function Sprite:newTileSprite(scene)
    local tile = self.tile
    if not tile then
        local tileset = self.tileset
        local tileid = self.tileid
        tile = tileset and tileid and getTile(tileset, tileid)
    end
    if tile then
        return scene:addTileObject(self)
    end
end
local newTileSprite = Sprite.newTileSprite

function Sprite:addToScene(scene, key)
    local sprite = newTileSprite(self, scene) or newAseprite(self, scene)
    self[key] = sprite
    return sprite
end

function Sprite:setHidden(spritename, hidden)
    local sprite = self[spritename]
    if sprite then
        sprite.hidden = hidden
    end
end

function Sprite:update(sprite, fixedfrac)
    if sprite then
        local vx, vy = Body.getVelocity(self)
        local vz = self.velz or 0
        local x, y = Body.getPosition(self)
        local z = self.z
        local angle = Body.getRotation(self) or 0
        sprite.x = x + vx * fixedfrac
        sprite.y = y + vy * fixedfrac
        sprite.z = z + vz * fixedfrac
        sprite.r = angle
        -- sprite.oy = (self.spriteoriginy or 0) + z
    end
end

function Sprite.getDirectionalTileId_angle(basetileid, numdirections, angle)
    local dirarc = 2 * math.pi / numdirections
    local dirindex = math.floor(angle / dirarc + .5) % numdirections
    return basetileid..dirindex
end

function Sprite.getDirectionalTileId_vector(basetileid, numdirections, vecx, vecy)
    local angle = math.atan2(vecy, vecx)
    if angle ~= angle then
        angle = 0
    end
    return Sprite.getDirectionalTileId_angle(basetileid, numdirections, angle)
end

function Sprite.setDirectionalTile_vector(sprite, basetileid, numdirections, vecx, vecy)
    if sprite then
        sprite:changeTile(Sprite.getDirectionalTileId_vector(basetileid, numdirections, vecx, vecy))
    end
end

function Sprite:remove(key)
    local sprite = self[key]
    if sprite then
        sprite:markRemove()
        self[key] = nil
    end
end

return Sprite