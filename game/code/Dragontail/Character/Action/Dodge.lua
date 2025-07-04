local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Slide      = require "Dragontail.Character.Action.Slide"
local Audio      = require "System.Audio"
local Face       = require "Dragontail.Character.Action.Face"
local Body       = require "Dragontail.Character.Body"
local CollisionMask = require "Dragontail.Character.Body.CollisionMask"

---@class Dodge:Character
---@field dodgespeed number?
---@field dodgewithintime number?
---@field dodgedecel number?
---@field dodgesound string?
local Dodge = {}

function Dodge:getDodgeVector(incoming)
    local oppox, oppoy, oppovelx, oppovely
    oppox, oppoy = incoming.x, incoming.y
    oppovelx, oppovely = incoming.velx, incoming.vely
    local fromoppoy, fromoppox = self.y - oppoy, self.x - oppox
    local oppospeedsq = math.lensq(oppovelx, oppovely)
    local dsq = math.lensq(fromoppox, fromoppoy)
    local dodgewithintime = self.dodgewithintime or 60
    if dsq > oppospeedsq * dodgewithintime * dodgewithintime then
        return
    end
    local vdotd = math.dot(oppovelx, oppovely, fromoppox, fromoppoy)
    if vdotd <= math.sqrt(dsq)*math.sqrt(oppospeedsq)/2 then
        return
    end

    local dodgespeed = self.dodgespeed
    local dodgedist = Slide.GetSlideDistance(dodgespeed, self.dodgedecel or 1)
    local dodgedirx, dodgediry = 1, 0
    if dsq > 0 then
        dodgedirx, dodgediry = math.norm(fromoppox, fromoppoy)
    end
    local dodgespacex, dodgespacey = dodgedirx * dodgedist, dodgediry * dodgedist
    local raycast = Raycast(dodgespacex, dodgespacey, 0, 1, self.bodyradius/2)
    raycast.hitslayers = CollisionMask.merge("Solid", "Camera")

    if Characters.castRay(raycast, self.x, self.y) then
        -- Dodge along wall
        local ax, ay = raycast.hitwallx, raycast.hitwally
        local bx, by = raycast.hitwallx2, raycast.hitwally2

        raycast.dx, raycast.dy = math.norm(bx - ax, by - ay)
        raycast.dx = raycast.dx * dodgedist
        raycast.dy = raycast.dy * dodgedist
        if math.dot(dodgedirx, dodgediry, raycast.dx, raycast.dy) < 0 then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
        if Characters.castRay(raycast, self.x, self.y) then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
    elseif oppospeedsq >= dodgespeed*dodgespeed then
        local rot90dir = math.det(oppovelx, oppovely, fromoppox, fromoppoy)
        raycast.dx, raycast.dy = math.rot90(raycast.dx, raycast.dy, rot90dir)
        if Characters.castRay(raycast, self.x, self.y) then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
    end
    return raycast.dx, raycast.dy
end

function Dodge:findDodgeAngle()
    local dodgespeed = self.dodgespeed
    if not dodgespeed then
        return
    end
    local opponents = self.opponents
    local projectiles = Characters.getGroup("projectiles")

    local dodgex, dodgey = 0, 0
    for i = 1, #opponents do
        local dx, dy = Dodge.getDodgeVector(self, opponents[i])
        if dx then
            dodgex, dodgey = dodgex + dx, dodgey + dy
        end
    end
    for i = 1, #projectiles do
        local dx, dy = Dodge.getDodgeVector(self, projectiles[i])
        if dx then
            dodgex, dodgey = dodgex + dx, dodgey + dy
        end
    end

    if dodgex == 0 and dodgey == 0 then
        return
    end

    return math.atan2(dodgey, dodgex)
end

---@param opponent Character
---@param dodgeangle number
function Dodge:dodge(opponent, dodgeangle)
    local x, y, oppox, oppoy = self.x, self.y, opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    if tooppox == 0 and tooppoy == 0 then
        tooppox = 1
    end
    tooppox, tooppoy = math.norm(tooppox, tooppoy)
    Face.faceVector(self, tooppox, tooppoy, "Walk")
    Audio.play(self.stopdashsound)
    local speed, decel = self.dodgespeed, self.dodgedecel
    repeat
        speed = Slide.updateSlideSpeed(self, dodgeangle, speed, decel)
        coroutine.yield()
        Body.keepInBounds(self)
        local newstate, a, b, c, d, e, f = self:duringDodge(opponent)
        if newstate then
            return newstate, a, b, c, d, e, f
        end
    until speed == 0
end

return Dodge