local Database      = require "Data.Database"
local Audio       = require "System.Audio"
local Config      = require "System.Config"
local State       = require "Dragontail.Character.State"
local Object      = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Boundaries  = require "Dragontail.Stage.Boundaries"

local pi = math.pi
local floor = math.floor
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local asin = math.asin
local lensq = math.lensq
local dot = math.dot
local min = math.min
local max = math.max
local testcircles = math.testcircles

---@class Character:AsepriteObject
local Character = class(Object)

function Character:init()
    if self.visible == nil then
        self.visible = true
    end
    self.health = self.health or 1
    self.maxhealth = self.maxhealth or self.health
    self.x = self.x or 0
    self.y = self.y or 0
    self.z = self.z or 0
    self.drawz = self.drawz or 0
    self.velx = self.velx or 0
    self.vely = self.vely or 0
    self.velz = self.velz or 0
    self.speed = self.speed or 1
    self.bodyheight = self.bodyheight or 1
    self.bodyradius = self.bodyradius or 1
    self.attackradius = self.attackradius or 0
    -- ch.attackangle = ch.attackangle or 0
    self.attackarc = self.attackarc or 0
    self.attackdamage = self.attackdamage or 1
    self.attackstun = self.attackstun or 1
    self.hitstun = self.hitstun or 0
    self.hurtstun = self.hurtstun or 0
    if self.points then
        local _, rsq = math.farthestpoint(self.points, 0, 0)
        self.bodyradius = math.sqrt(rsq)
        self.points.outward = math.polysignedarea(self.points) < 0
    elseif self.tile then
        self.spriteoriginx = self.spriteoriginx or self.tile.objectoriginx
        self.spriteoriginy = self.spriteoriginy or self.tile.objectoriginy
        local shapes = self.tile.shapes
        if shapes then
            for _, shape in ipairs(shapes) do
                if shape.shape == "polygon" and shape.collidable then
                    self:initPolygonBody(shape.points, shape.x, shape.y)
                    break
                end
            end
        end
    end
end

function Character:initPolygonBody(points, dx, dy)
    dx = dx or 0
    dy = dy or 0
    local _, rsq = math.farthestpoint(points, -dx, -dy)
    self.bodyradius = math.sqrt(rsq)
    self.points = {}
    self.points.outward = math.polysignedarea(points) < 0
    for i = 2, #points, 2 do
        local px, py = points[i-1], points[i]
        self.points[i-1] = px + dx
        self.points[i] = py + dy
    end
end

---@param scene Scene
function Character:addToScene(scene)
    scene:add(self)
    self.originx = self.spriteoriginx
    self.originy = self.spriteoriginy

    local baseDraw = self.draw
    if self.shadowtype then
        self.draw = function(self, fixedfrac)
            self:drawSpriteShadow(fixedfrac)
            baseDraw(self, fixedfrac)
            if Config.drawbodies then
                self:drawBodyShape(fixedfrac)
                self:drawAttackShape(fixedfrac)
            end
        end
    end
end

function Character:makeAfterImage()
    local Characters  = require "Dragontail.Stage.Characters"
    local afterimage = Characters.spawn({
        x = self.x,
        y = self.y,
        asefile = self.asefile,
        animationspeed = 0,
        spriteoriginx = self.spriteoriginx,
        spriteoriginy = self.spriteoriginy,
        script = "Dragontail.Character.Common",
        initialai = "afterimage"
    })
    afterimage:setAseAnimation(self.aseanimation, self.animationframe)
end

function Character:accelerate(ax, ay)
    self.velx = self.velx + ax
    self.vely = self.vely + ay
end

function Character:accelerateTowardsVel(targetvelx, targetvely, t, e)
    assert(t > 0, "t <= 0")
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
end

function Character:updatePosition()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
    self.z = self.z + self.velz
end

function Character:isHitStopOver()
    return self.hitstun <= 0 and self.hurtstun <= 0
end

function Character:fixedupdateHitStop()
    if self.hitstun > 0 then
        self.hitstun = self.hitstun - 1
        if self.hitstun > 0 then
            return false
        end
    end
    if self.hurtstun > 0 then
        self.hurtstun = self.hurtstun - 1
        if self.hurtstun > 0 then
            return false
        end
    end
    return true
end

function Character:fixedupdate()
    if self:fixedupdateHitStop() then
        self:animate(1)
        self:updatePosition()
        State.run(self)
    end
end

function Character:fixedupdateShake(time)
    time = max(0, time - 1)
    self.originx = self.spriteoriginx + 2*math.sin(time)
    return time
end

function Character:update(dsecs, fixedfrac)
    local s = min(4, self.hurtstun) * sin(self.hurtstun)
    self.scalex = 1 + s/8
    self.scaley = 1 - s/32
    self.originy = (self.spriteoriginy or 0) + self.z
end

function Character:moveTo(destx, desty, speed, timelimit)
    timelimit = timelimit or math.huge
    coroutine.waitfor(function()
        local x, y = self.x, self.y
        timelimit = timelimit - 1
        if timelimit <= 0 or x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)
    return self.x == destx and self.y == desty
end

function Character:startAttack(attackangle)
    self.attackangle = attackangle
end

function Character:stopAttack()
    self.attackangle = nil
    local opponents = self.opponents
    if opponents then
        for i = 1, #opponents do
            local opponent = opponents[i]
            if opponent.attacker == self then
                opponent.attacker = nil
            end
        end
    end
end

function Character:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Character:stopGuarding()
    self.guardangle = nil
end

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*pi, 2*pi) - pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*pi, 2*pi) - pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:keepInBounds()
    local x, y, z, r, h = self.x, self.y, self.z, self.bodyradius, self.bodyheight
    local totalpenex, totalpeney, totalpenez
    self.x, self.y, self.z, totalpenex, totalpeney, totalpenez = Boundaries.keepCylinderIn(x, y, z, r, h)
    return totalpenex, totalpeney, totalpenez
end

local function testBodyCollision_polygonAndCircle(polygon, circle)
    local points = polygon.points
    local otherx, othery = circle.x - polygon.x, circle.y - polygon.y
    if math.pointinpolygon(points, otherx, othery) then
        return true
    end
    local nearestx, nearesty = math.nearestpolygonpoint(points, otherx, othery)
    return math.distsq(otherx, othery, nearestx, nearesty) <= circle.bodyradius
end

function Character:testBodyCollision(other)
    if self ~= other
        and self.z <= other.z + other.bodyheight
        and other.z <= self.z + self.bodyheight
        and testcircles(self.x, self.y, self.bodyradius, other.x, other.y, other.bodyradius)
    then
        if self.points and not other.points then
            return testBodyCollision_polygonAndCircle(self, other)
        elseif other.points then
            return testBodyCollision_polygonAndCircle(other, self)
        end
        return true
    end
end

function Character:getCirclePenetration(x, y, r)
    local distsq = testcircles(self.x, self.y, self.bodyradius, x, y, r)
    if not distsq then
        return
    end

    local points = self.points
    if not points then
        local radii = self.bodyradius + r
        local dist = sqrt(distsq)
        local pene = radii - dist
        local dx, dy = self.x - x, self.y - y
        local nx, ny = dx/dist, dy/dist
        return nx*pene, ny*pene
    end

    -- get if point in polygon
    x, y = x - self.x, y - self.y
    local inside = math.pointinpolygon(points, x, y)
    if not points.outward then
        inside = not inside
    end
    -- get nearest point on polygon
    local nearestx, nearesty, nearesti, nearestj = math.nearestpolygonpoint(points, x, y)
    local nearestdsq = math.distsq(x, y, nearestx, nearesty)
    -- if not in polygon, and nearest point farther than radius, then no collision
    if not inside and nearestdsq > r*r then
        return
    end

    -- move circle out of polygon in direction of nearest point
    local dist = sqrt(nearestdsq)
    local nx, ny
    if dist == 0 then
        local x1, y1 = points[nearesti-1], points[nearesti]
        local x2, y2 = points[nearestj-1], points[nearestj]
        nx, ny = math.norm(math.rot90(x2-x1, y2-y1, 1))
    else
        nx, ny = (nearestx - x)/dist, (nearesty - y)/dist
    end
    local pene = (inside and -r or r) - dist
    return nx * pene, ny * pene

    -- TODO if needed, collision vs concave corners
end

---@return number? penex x penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? peney y penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? penez z penetration. Non-0 = penetrating; 0 = touching; nil = no contact
function Character:getCylinderPenetration(x, y, z, r, h)
    local selfz, selfh = self.z, self.bodyheight
    local penex, peney, penez
    local points = self.points
    if not points then
        -- I am a cylinder
        if z + h >= selfz and selfz + selfh >= z then
            local iz, iz2 = max(z, selfz), min(z+h, selfz+selfh)
            penez = iz == z and iz - iz2 or iz2 - iz
            penex, peney = self:getCirclePenetration(x, y, r)
            if penex and peney and math.lensq(penex, peney) <= penez*penez then
                penez = nil
            else
                penex, peney = nil, nil
            end
        end
    elseif points.outward then
        -- I am an outward polygon
        if z + h >= selfz and selfz + selfh >= z then
            local nearestx, nearesty = math.nearestpolygonpoint(points, x - self.x, y - self.y)
            if math.pointinpolygon(points, x - self.x, y - self.y)
            or math.distsq(nearestx, nearesty, x - self.x, y - self.y) <= r*r then
                local iz, iz2 = max(z, selfz), min(z+h, selfz+selfh)
                penez = iz == z and iz - iz2 or iz2 - iz
                penex, peney = self:getCirclePenetration(x, y, r)
                if penex and peney and math.lensq(penex, peney) <= penez*penez then
                    penez = nil
                else
                    penex, peney = nil, nil
                end
            end
        end
    else
        -- I am an inward polygon
        if z <= selfz then
            penez = z - selfz
        elseif z + h >= selfz + selfh then
            penez = (z + h) - (selfz + selfh)
        end
        penex, peney = self:getCirclePenetration(x, y, r)
    end
    return penex, peney, penez
end

---@param other Character
function Character:collideWithCharacterBody(other)
    if not other.bodysolid then
        return
    end
    local penex, peney, penez = other:getCylinderPenetration(self.x, self.y, self.z, self.bodyradius, self.bodyheight)
    self.x = self.x - (penex or 0)
    self.y = self.y - (peney or 0)
    self.z = self.z - (penez or 0)
    return penex, peney, penez
end

function Character:checkAttackCollision(attacker)
    if self == attacker or self == attacker.thrower or self.thrower == attacker then
        return
    end
    local attackangle = attacker.attackangle
    if not attackangle then
        return
    end
    if self.z + self.bodyheight < attacker.z
    or self.z > attacker.z + attacker.bodyheight then
        return
    end
    local fromattackerx, fromattackery = self.x - attacker.x, self.y - attacker.y
    local distsq = lensq(fromattackerx, fromattackery)
    local bodyradius = self.bodyradius
    if distsq <= bodyradius * bodyradius then
        return true
    end
    local radii = bodyradius + attacker.attackradius
    local radiisq = radii * radii
    if distsq <= radiisq then
        local attackarc = attacker.attackarc
        if attackarc >= pi then
            return true
        end
        local dist = sqrt(distsq)
        local attackx, attacky = cos(attackangle), sin(attackangle)
        local dotDA = dot(fromattackerx, fromattackery, attackx, attacky)
        local bodyarc = asin(bodyradius/dist)
        return dotDA >= dist * cos(bodyarc + attackarc)
    end
end

function Character:collideWithCharacterAttack(attacker)
    if self.hurtstun > 0 or not self.canbeattacked then
        return
    end
    if self:checkAttackCollision(attacker) then
        local guardhitai = self.guardai or "guardHit"
        local hurtai = self.hurtai or "hurt"
        local hitai = attacker.attackhitai
        if self.guardangle then
            State.start(self, guardhitai, attacker)
            hitai = attacker.attackguardedai or hitai
        else
            State.start(self, hurtai, attacker)
            if attacker.hitstun <= 0 then
                attacker.hitstun = attacker.attackstunself or 3
            end
            hitai = attacker.attackhitopponentai or hitai
            attacker.numopponentshit = (attacker.numopponentshit or 0) + 1
        end
        if hitai then
            State.start(attacker, hitai, self)
        end
        return true
    end
end

---@param raycast Raycast
function Character:collideWithRaycast(raycast, rx, ry)
    local canhitside = raycast.canhitside
    local selfx, selfy, selfr = self.x, self.y, self.bodyradius
    local rdx, rdy = raycast.dx, raycast.dy
    local rx2, ry2 = rx + rdx, ry + rdy

    local projx, projy = math.projpointsegment(selfx, selfy, rx, ry, rx2, ry2)
    local projdsq = math.distsq(projx, projy, selfx, selfy)
    if projdsq > selfr*selfr then
        return
    end

    local points = self.points
    if not points then
        -- hypot is circle center to intersection point
        -- one side is circle center to proj point
        -- other side is proj point to intersection point
        local rnx, rny = math.norm(rdx, rdy)
        local projtohitdist = sqrt(selfr*selfr - projdsq)
        if canhitside < 0 then
            -- hitx,hity is the far intersection
            -- hitwall is a tangent line
            raycast.hitx = projx + rnx * projtohitdist
            raycast.hity = projy + rny * projtohitdist
            raycast.hitside = -1
        else
            -- hitx,hity is the near intersection
            raycast.hitx = projx - rnx * projtohitdist
            raycast.hity = projy - rny * projtohitdist
            raycast.hitside = 1
        end
        raycast.hitdist = math.dist(rx, ry, raycast.hitx, raycast.hity)
        local d = math.det(selfx - rx, selfy - ry, rdx, rdy)
        raycast.hitwallx, raycast.hitwally = math.rot90(raycast.hitx - selfx, raycast.hity - selfy, d)
        raycast.hitwallx2, raycast.hitwally2 = math.rot90(raycast.hitx - selfx, raycast.hity - selfy, -d)
        raycast.hitwallx = raycast.hitwallx + raycast.hitx
        raycast.hitwally = raycast.hitwally + raycast.hity
        raycast.hitwallx2 = raycast.hitwallx2 + raycast.hitx
        raycast.hitwally2 = raycast.hitwally2 + raycast.hity
        return true
    end

    rx, ry = rx - selfx, ry - selfy
    rx2, ry2 = rx2 - selfx, ry2 - selfy
    local hitdsq = raycast.hitdist
    hitdsq = hitdsq and hitdsq*hitdsq or 0x10000000
    local hitx, hity, hitwallx, hitwally, hitwallx2, hitwally2, hitside
    local ax, ay = points[#points-1], points[#points]
    for i = 2, #points, 2 do
        local bx, by = points[i-1], points[i]
        local walldir = math.det(rdx, rdy, bx-ax, by-ay)
        if walldir * canhitside >= 0 then
            local hx, hy, hx2, hy2 = math.intersectsegments(rx, ry, rx2, ry2, ax, ay, bx, by)
            if hx and hy then
                if hx2 and hy2 and dot(rdx, rdy, hx2, hy2) < dot(rdx, rdy, hx, hy) then
                    hx, hy = hx2, hy2
                end
                local dsq = math.distsq(rx, ry, hx, hy)
                if dsq < hitdsq then
                    hitdsq = dsq
                    hitx, hity = hx, hy
                    hitwallx, hitwally = ax, ay
                    hitwallx2, hitwally2 = bx, by
                    hitside = walldir
                end
            end
        end
        ax, ay = bx, by
    end

    if hitx then
        raycast.hitdist = sqrt(hitdsq)
        raycast.hitx = hitx + selfx
        raycast.hity = hity + selfy
        raycast.hitwallx = hitwallx + selfx
        raycast.hitwally = hitwally + selfy
        raycast.hitwallx2 = hitwallx2 + selfx
        raycast.hitwally2 = hitwally2 + selfy
        raycast.hitside = hitside
        return true
    end
end

function Character:getCylinderFloorZ(x, y, z, r, h)
    local floorz = self.z
    local points = self.points
    if not points or points.outward then
        floorz = floorz + self.bodyheight
    end
    if z < floorz then
        -- underneath
        return
    end

    if not self:getCirclePenetration(x, y, r) then
        -- off edge
        return
    end
    return floorz
end

function Character:heal(amount)
    self.health = min(self.health + amount, self.maxhealth)
end

function Character.getDirectionalAnimation_angle(basename, angle, numanimations)
    numanimations = numanimations or 1
    if numanimations < 2 then
        return basename
    end
    if angle ~= angle then
        return basename..0
    end
    local faceangle = angle + (pi / numanimations)
    local facedir = floor(faceangle * numanimations / pi / 2)
    facedir = ((facedir % numanimations) + numanimations) % numanimations
    return basename..facedir
end

function Character:setDirectionalAnimation(basename, angle, frame1, loopframe)
    local animation = self.getDirectionalAnimation_angle(basename, angle, self.animationdirections)
    self:changeAseAnimation(animation, frame1, loopframe)
end

function Character:setEmote(emotename)
    local emote = self.emote
    if emote then
        if emotename then
            emote.visible = true
            emote:changeAsepriteAnimation(emotename)
        else
            emote.visible = false
        end
    end
end

function Character:drawShapeShadow(fixedfrac)
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(0,0,0,.25)

    love.graphics.circle("fill", x, y, self.bodyradius)

    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius > 0 and attackangle then
        local attackarc = self.attackarc
        if attackarc > 0 then
            love.graphics.arc("fill", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
        else
            love.graphics.line(x, y, x + attackradius*cos(attackangle), y + attackradius*sin(attackangle))
        end
    end
end

function Character:drawSpriteShadow(fixedfrac)
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(0,0,0)

    local aseframe =
        self.aseanimation and self.aseanimation[self.animationframe or 1] or
        self.aseprite and self.aseprite[self.animationframe or 1]

    if aseframe then
        local floorz = Boundaries.getCylinderFloorZ(x, y, self.z, self.bodyradius, self.bodyheight) or 0
        love.graphics.push()
        love.graphics.translate(x, y - floorz)
        love.graphics.rotate(self.rotation or 0)
        love.graphics.scale(self.scalex or 1, (self.scaley or 1) / 2)
        love.graphics.translate(-self.spriteoriginx or 0, -self.spriteoriginy or 0)
        aseframe:draw()
        love.graphics.pop()
        return
    end

    local tile = self.tile
    if tile then
        love.graphics.draw(tile.image, self.animationquad or tile.quad,
            x, y,
            self.rotation or 0,
            self.scalex or 1, (self.scaley or 1) / 2,
            self.originx or tile.objectoriginx, self.originy or tile.objectoriginy,
            self.skewx or 0, self.skewy or 0)
        return
    end
end

function Character:drawBodyShape(fixedfrac)
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(.5, .5, 1)
    local bodyradius, bodyheight = self.bodyradius, self.bodyheight
    local screeny = y - self.z
    love.graphics.circle("line", x, screeny, bodyradius)
    love.graphics.circle("line", x, screeny - bodyheight, bodyradius)
    love.graphics.line(x - bodyradius, screeny, x - bodyradius, screeny - bodyheight)
    love.graphics.line(x + bodyradius, screeny, x + bodyradius, screeny - bodyheight)
    local points = self.points
    if points then
        local spriteoriginx, spriteoriginy = self.spriteoriginx or 0, self.spriteoriginy or 0
        love.graphics.push()
        love.graphics.translate(spriteoriginx, spriteoriginy)
        self:drawPolygon()
        love.graphics.translate(0, -bodyheight)
        self:drawPolygon()
        love.graphics.translate(self.x - spriteoriginx, self.y - spriteoriginy)
        for i = 2, #points, 2 do
            local px, py = points[i-1], points[i]
            love.graphics.line(px, py, px, py + bodyheight)
        end
        love.graphics.pop()
    end
end

function Character:drawAttackShape(fixedfrac)
    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius <= 0 or not attackangle then
        return
    end

    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    local bodyheight = self.bodyheight
    local screeny = y - self.z
    local attackarc = self.attackarc
    love.graphics.setColor(1, .5, .5)
    if attackarc > 0 then
        love.graphics.arc("line", x, screeny, attackradius, attackangle - attackarc, attackangle + attackarc)
        love.graphics.arc("line", x, screeny - bodyheight, attackradius, attackangle - attackarc, attackangle + attackarc)
        local c1, s1 = attackradius*cos(attackangle-attackarc), attackradius*sin(attackangle-attackarc)
        local c2, s2 = attackradius*cos(attackangle+attackarc), attackradius*sin(attackangle+attackarc)
        love.graphics.line(x + c1, screeny + s1, x + c1, screeny + s1 - bodyheight)
        love.graphics.line(x + c2, screeny + s2, x + c2, screeny + s2 - bodyheight)
        local c = cos(attackangle)
        local d = cos(attackarc)
        if c > d then
            love.graphics.line(x + attackradius, screeny, x + attackradius, screeny - bodyheight)
        elseif c < -d then
            love.graphics.line(x - attackradius, screeny, x - attackradius, screeny - bodyheight)
        end
    else
        local c, s = attackradius*cos(attackangle), attackradius*sin(attackangle)
        love.graphics.line(x, screeny,
            x + c, screeny + s,
            x + c, screeny + s - bodyheight,
            x, screeny - bodyheight)
    end
end

function Character:isOnCamera(cx, cy, cw, ch)
    local ox, oy = self.originx, self.originy
    local w, h = 0, 0
    if self.aseprite then
        w, h = self.aseprite.width, self.aseprite.height
        ox = ox or 0
        oy = oy or 0
    elseif self.tile then
        w, h = self.tile.width, self.tile.height
        ox = ox or self.tile.objectoriginx
        oy = oy or self.tile.objectoriginy
    end
    local x, y = self.x - (self.originx or 0), self.y - self.z - (self.originy or 0)
    return math.testrects(x, y, w, h, cx, cy, cw, ch)
end

function Character:disappear()
    self.disappeared = true
end

function Character:hasDisappeared()
    return self.disappeared
end

return Character