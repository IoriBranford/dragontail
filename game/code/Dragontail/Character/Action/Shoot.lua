local Database = require "Data.Database"
local Characters = require "Dragontail.Stage.Characters"

---@class Shoot:Body
---@field projectilelaunchheight number?
---@field projectiletargetheightpct number? 0 = bottom; 1 = top
local Shoot = {}

function Shoot:getProjectileLaunchPosition(projectiletype, dirx, diry)
    if type(projectiletype) == "string" then
        projectiletype = Database.get(projectiletype)
    end
    local projectileradius = projectiletype and projectiletype.bodyradius or 0

    local projectileheight = self.projectilelaunchheight
        or dirx == 0 and diry == 0 and self.bodyheight
        or (self.bodyheight / 2)
    local x, y, z = self.x, self.y, self.z
    local radius = self.bodyradius + projectileradius
    return x + radius * dirx,
        y + radius * diry,
        z + projectileheight
end

function Shoot:getProjectileLaunchPositionTowardsTarget(projectiletype, targetx, targety)
    if type(projectiletype) == "string" then
        projectiletype = Database.get(projectiletype)
    end
    if not projectiletype then return end

    local x, y = self.x, self.y
    local dirx, diry = targetx - x, targety - y
    if dirx ~= 0 or diry ~= 0 then
        dirx, diry = math.norm(dirx, diry)
    end

    return Shoot.getProjectileLaunchPosition(self, projectiletype, dirx, diry)
end

function Shoot:getProjectileLaunchVelocityTowardsTarget(projectiletype, targetx, targety, targetz)
    if type(projectiletype) == "string" then
        projectiletype = Database.get(projectiletype)
    end
    if not projectiletype then return end

    local gravity = projectiletype.gravity or 0
    local speed = projectiletype.speed or 1
    if speed == 0 then
        speed = 1
    end

    local x, y, z = Shoot.getProjectileLaunchPositionTowardsTarget(self, projectiletype, targetx, targety)
    local distx, disty, distz = targetx - x, targety - y, targetz - z
    if distx == 0 and disty == 0 then
        local velz = distz <= 0 and -speed
            or math.sqrt(2*gravity*distz)
        return 0, 0, velz
    end

    local dstxy = math.len(distx, disty)
    local dirx, diry = distx/dstxy, disty/dstxy

    local time = dstxy / speed

    local velx = dirx * speed
    local vely = diry * speed

    -- z = v0*t + z0 - gravity*t^2/2
    -- dz = v0*t - gravity*t^2/2
    -- dz/t = v0 - gravity*t/2
    -- v0 = dz/t + gravity*t/2
    local velz = distz/time + gravity * time * .5

    return velx, vely, velz
end

function Shoot:calculateTrajectoryTowardsTarget(projectile, targetx, targety, targetz, trajectory)
    if type(projectile) == "string" then
        projectile = Database.get(projectile)
    end
    if not projectile then return end

    local distx, disty, distz = targetx - self.x, targety - self.y, targetz - self.z
    if distx == 0 and disty == 0 and distz == 0 then
        distz = 1
    end

    local dst = math.len(distx, disty, distz)
    local dirx, diry = distx/dst, disty/dst
    local x, y, z = Shoot.getProjectileLaunchPosition(self, projectile, dirx, diry)
    local velx, vely, velz = Shoot.getProjectileLaunchVelocityTowardsTarget(self, projectile, targetx, targety, targetz)
    return Shoot.calculateTrajectory(self, projectile, x, y, z, velx, vely, velz, trajectory)
end

function Shoot:calculateTrajectory(projectile, x, y, z, velx, vely, velz, trajectory)
    if type(projectile) == "string" then
        projectile = Database.get(projectile)
    end
    if not projectile then return end

    local gravity = projectile.gravity or 0
    trajectory = trajectory or {}
    trajectory[#trajectory+1] = x
    trajectory[#trajectory+1] = y
    trajectory[#trajectory+1] = z
    local radius = projectile.bodyradius
    local height = projectile.bodyheight
    local boundspenex, boundspeney, boundspenez
    local lifetime = projectile.lifetime or 300
    repeat
        trajectory[#trajectory+1] = x
        trajectory[#trajectory+1] = y
        trajectory[#trajectory+1] = z
        velz = velz - gravity
        x = x + velx
        y = y + vely
        z = z + velz
        x, y, z, boundspenex, boundspeney, boundspenez = Characters.keepCylinderIn(x, y, z, radius, height, projectile)
        lifetime = lifetime - 1
    until lifetime <= 0 or boundspenex or boundspeney or boundspenez
    return trajectory
end

function Shoot:getTargetObjectPosition(object)
    local x, y, z = object.x, object.y, object.z
    local targetheightpct = self.projectiletargetheightpct or .5
    return x, y, z + object.bodyheight*targetheightpct
end

function Shoot:launchProjectileAtObject(type, object, attackid)
    local targetx, targety, targetz = Shoot.getTargetObjectPosition(self, object)
    return Shoot.launchProjectileAtPosition(self, type, targetx, targety, targetz, attackid)
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

    local x, y, z = self.x, self.y, self.z
    local bodyradius, bodyheight = self.bodyradius or 0, self.bodyheight or 0
    local speed = projectiledata.speed or 1
    local projectileheight = self.projectilelaunchheight or (bodyheight / 2)
    local angle = dirx == 0 and diry == 0 and 0 or math.atan2(diry, dirx)
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