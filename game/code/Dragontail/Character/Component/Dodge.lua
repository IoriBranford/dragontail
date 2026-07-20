local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Slide      = require "Dragontail.Character.Component.Slide"
local Audio      = require "System.Audio"
local Face       = require "Dragontail.Character.Component.Face"
local Body       = require "Dragontail.Character.Component.Body"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"
local Attacker      = require "Dragontail.Character.Component.Attacker"
local AttackTarget  = require "Dragontail.Character.Component.AttackTarget"

---@class Dodge:Character
---@field dodgespeed number?
---@field dodgewithintime number?
---@field dodgedecel number?
---@field dodgesound string?
local Dodge = {}

function Dodge:getDodgeVector(en)
    local dodgewithintime = self.dodgewithintime or 30
    if not Body.isInTheirWay(self, en, dodgewithintime) then
        return
    end

    local x, y, centz = self.x, self.y, self.z + self.bodyheight/2
    local enx, eny = en.x, en.y
    local envx, envy = en.velx, en.vely
    local envz = en.velz
    local fromy, fromx = y - eny, x - enx
    local fromz = self.z - en.z
    local enspsq = math.lensq(envx, envy, envz)
    local dsq = math.lensq(fromx, fromy, fromz)

    local s = self.dodgespeed
    local d = Slide.GetSlideDistance(s, self.dodgedecel or 1)
    local dodgex, dodgey = 1, 0
    if dsq > 0 then
        dodgex, dodgey = math.norm(fromx, fromy)
    end
    dodgex, dodgey = dodgex * d, dodgey * d
    local rc = Raycast(x, y, centz, dodgex, dodgey, 0, 1, self.bodyradius/2)
    rc.hitslayers = CollisionMask.merge("Object", "Wall", "Camera")

    local dx, dy = rc.dx, rc.dy
    if Characters.castRay3(rc, self) then
        -- Dodge along wall
        dx, dy = math.rot90(rc.hitnx, rc.hitny, 1)
        dx = dx * d
        dy = dy * d
        if math.dot(dodgex, dodgey, dx, dy) < 0 then
            dx, dy = -dx, -dy
        end
        if Characters.castRay3(rc, self) then
            dx, dy = -dx, -dy
        end
    elseif enspsq >= s*s then
        local rot90dir = math.det(envx, envy, fromx, fromy)
        dx, dy = math.rot90(dx, dy, rot90dir)
        if Characters.castRay3(rc, self) then
            dx, dy = -dx, -dy
        end
    end
    return dx, dy
end

function Dodge:findDodgeAngle()
    local dodgespeed = self.dodgespeed
    if not dodgespeed then
        return
    end
    local solids = Characters.getGroup("solids")

    local dodgex, dodgey = 0, 0
    local team = self.team
    local enemyteam = team == "players" and "enemies" or "players"
    for _, solid in ipairs(solids) do
        local solidteam = solid.team
        if solidteam == enemyteam
        or Attacker.isAttacking(solid)
        and AttackTarget.getAttackHitLayers(self, solid.attack) ~= 0 then
            local dx, dy = Dodge.getDodgeVector(self, solid)
            if dx then
                dodgex, dodgey = dodgex + dx, dodgey + dy
            end
        end
    end
    -- for i = 1, #opponents do
    --     local dx, dy = Dodge.getDodgeVector(self, opponents[i])
    --     if dx then
    --         dodgex, dodgey = dodgex + dx, dodgey + dy
    --     end
    -- end
    -- for i = 1, #projectiles do
    --     local dx, dy = Dodge.getDodgeVector(self, projectiles[i])
    --     if dx then
    --         dodgex, dodgey = dodgex + dx, dodgey + dy
    --     end
    -- end

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
    Face.faceVector(self, tooppox, tooppoy)
    Audio.play(self.stopdashsound)
    local speed, decel = self.dodgespeed, self.dodgedecel
    repeat
        speed = Slide.updateSlideSpeed(self, dodgeangle, speed, decel)
        coroutine.yield()
        local newstate, a, b, c, d, e, f = self:duringDodge(opponent)
        if newstate then
            return newstate, a, b, c, d, e, f
        end
    until speed == 0
end

return Dodge