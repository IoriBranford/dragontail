local Color = require "Tiled.Color"

---@class Shadow:AsepriteObject
local Shadow = {}

function Shadow:drawShape(fixedfrac)
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(0,0,0,.25)

    love.graphics.circle("fill", x, y, self.bodyradius)

    local attackangle = self.attackangle
    local attackradius = self.attack.radius
    if attackradius > 0 and attackangle then
        local attackarc = self.attack.arc
        if attackarc > 0 then
            love.graphics.arc("fill", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
        else
            love.graphics.line(x, y, x + attackradius*math.cos(attackangle), y + attackradius*math.sin(attackangle))
        end
    end
end

function Shadow:drawSprite(fixedfrac)
    local red, green, blue, alpha = Color.unpack(self.shadowcolor or 0xFF000000)
    if alpha <= 0 then
        return
    end
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(red, green, blue, alpha)
    local Characters = require "Dragontail.Stage.Characters"
    local floorz = Characters.getCylinderFloorZ(x, y, self.z, self.bodyradius, self.bodyheight, self.bodyhitslayers) or 0
    love.graphics.push()
    love.graphics.translate(x, y - floorz)
    love.graphics.rotate(self.rotation or 0)
    love.graphics.scale(self.scalex or 1, (self.scaley or 1) / 2)

    local aseframe =
        self.aseanimation and self.aseanimation[self.animationframe or 1] or
        self.aseprite and self.aseprite[self.animationframe or 1]
    local tile = self.tile

    if aseframe then
        love.graphics.translate(-(self.spriteoriginx or 0), -(self.spriteoriginy or 0))
        aseframe:draw()
    elseif tile then
        love.graphics.translate(-(tile.objectoriginx or 0), -(tile.objectoriginy or 0))
        love.graphics.draw(tile.image, self.animationquad or tile.quad)
    end
    love.graphics.pop()
end

return Shadow