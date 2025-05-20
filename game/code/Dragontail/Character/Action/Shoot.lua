local Database = require "Data.Database"
local Characters = require "Dragontail.Stage.Characters"

---@class Shoot:Character
---@field projectilelaunchheight number?
local Shoot = {}

function Shoot:launchProjectileAtObject(type, object, attackid)
    return Shoot.launchProjectileAtPosition(self, type, object.x, object.y, object.z, attackid)
end

function Shoot:launchProjectileAtPosition(projectile, targetx, targety, targetz, attackid)
    if type(projectile) == "string" then
        projectile = { type = projectile }
    end
    local projectiledata = Database.get(projectile.type)
    Database.fillBlanks(projectile, projectiledata)

    local x, y, z = self.x, self.y, self.z
    local distx, disty, distz = targetx - x, targety - y, targetz - z
    if distx == 0 and disty == 0 and distz == 0 then
        distz = 1
    end

    local dst = math.len(distx, disty, distz)
    local dirx, diry = distx/dst, disty/dst

    local gravity = projectile.gravity or 0
    local speed = projectile.speed or 1
    if speed == 0 then
        speed = 1
    end
    local time = dst / speed

    local velx = dirx * speed
    local vely = diry * speed

    -- z = gravity*t^2/2 + v0*t + z0
    -- dz = gravity*t^2/2 + v0*t
    -- dz/t = gravity*t/2 + v0
    -- v0 = dz/t - gravity*t/2
    local velz = distz/time + gravity * time * .5
    local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    projectile.x = x
    projectile.y = y
    projectile.z = z + projectileheight
    projectile.velx = velx
    projectile.vely = vely
    projectile.velz = velz
    local angle = math.atan2(diry, dirx)
    projectile.faceangle = angle
    projectile.attackangle = angle
    projectile.thrower = self
    projectile.initialai = attackid
    projectile.opponents = self.opponents
    return Characters.spawn(projectile)
end

function Shoot:launchProjectile(type, dirx, diry, dirz, attackid)
    local projectiledata = Database.get(type)
    if not projectiledata then
        return
    end

    local x, y, z = self.x, self.y, self.z
    local bodyradius, bodyheight = self.bodyradius or 0, self.bodyheight or 0
    local speed = projectiledata.speed or 1
    local projectileheight = self.projectilelaunchheight or (bodyheight / 2)
    local angle = math.atan2(diry, dirx)
    local projectile = {
        x = x + bodyradius*dirx,
        y = y + bodyradius*diry,
        z = z + projectileheight,
        velx = speed*dirx,
        vely = speed*diry,
        velz = speed*dirz,
        type = type,
        faceangle = angle,
        attackangle = angle,
        thrower = self,
        opponents = self.opponents,
        initialai = attackid
    }
    return Characters.spawn(projectile)
end

return Shoot