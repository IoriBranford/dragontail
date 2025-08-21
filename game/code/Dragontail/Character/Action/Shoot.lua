local Database = require "Data.Database"
local Characters = require "Dragontail.Stage.Characters"

---@class Shoot:Body
---@field projectilelaunchheight number?
local Shoot = {}

function Shoot:getProjectileLaunchPosition(projectiletype, dirx, diry)
    if type(projectiletype) == "string" then
        projectiletype = Database.get(projectiletype)
    end
    if not projectiletype then return end

    local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    local x, y, z = self.x, self.y, self.z
    local bodyradius = self.bodyradius
    return x + (bodyradius+projectiletype.bodyradius) * dirx,
        y + (bodyradius+projectiletype.bodyradius) * diry,
        z + projectileheight
end

function Shoot:getProjectileLaunchVelocityTowardsTarget(projectiletype, targetx, targety, targetz)
    if type(projectiletype) == "string" then
        projectiletype = Database.get(projectiletype)
    end
    if not projectiletype then return end

    local x, y, z = self.x, self.y, self.z
    local distx, disty, distz = targetx - x, targety - y, targetz - z
    if distx == 0 and disty == 0 and distz == 0 then
        distz = 1
    end

    local dst = math.len(distx, disty, distz)
    local dirx, diry = distx/dst, disty/dst

    local gravity = projectiletype.gravity or 0
    local speed = projectiletype.speed or 1
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

    return velx, vely, velz
end

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

    projectile.x,
    projectile.y,
    projectile.z = Shoot.getProjectileLaunchPosition(self, projectile, dirx, diry)
    projectile.velx,
    projectile.vely,
    projectile.velz = Shoot.getProjectileLaunchVelocityTowardsTarget(self, projectile, targetx, targety, targetz)
    local angle = dirx == 0 and diry == 0 and 0 or math.atan2(diry, dirx)
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

    local speed = projectiledata.speed or 1
    local angle = dirx == 0 and diry == 0 and 0 or math.atan2(diry, dirx)
    local projectile = {
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
    projectile.x,
    projectile.y,
    projectile.z = Shoot.getProjectileLaunchPosition(self, projectile, dirx, diry)
    return Characters.spawn(projectile)
end

return Shoot