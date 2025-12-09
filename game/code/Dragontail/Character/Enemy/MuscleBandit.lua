local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Component.Guard"
local Characters   = require "Dragontail.Stage.Characters"
local Catcher      = require "Dragontail.Character.Component.Catcher"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Component.Body"
local CollisionMask        = require "Dragontail.Character.Component.Body.CollisionMask"
local Face                 = require "Dragontail.Character.Component.Face"

---@class MuscleBandit:Enemy
local MuscleBandit = class(Enemy)

-- function MuscleBandit:findApproachSlot(target, nextstate)
--     local bodyradius = self.bodyradius
--     local state = self.statetable[nextstate]
--     local attackrange = (state and state.maxtargetdist or 1) + target.bodyradius
--     return AttackTarget.findClosestSlot(target, attackrange + bodyradius, "melee", self.x, self.y)
--         or AttackTarget.findClosestSlot(target, attackrange + bodyradius, "missile", self.x, self.y)
-- end

function MuscleBandit:duringStand()
    local opponent = self.opponents[1]
    return self:duringApproach(opponent)
end

function MuscleBandit:duringApproach(opponent)
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    if self.weaponinhand then return end

    local nextstate, nextstatearg
    local time = 10
    local sightarc = self.sightarc or (math.pi/4)
    local function isComing(them)
        if Face.isObjectInSight(self, them, sightarc)
        and Body.isInTheirWay(self, them, time) then
            Face.faceObject(self, them)
            nextstate = "catchReady"
            return "break"
        end
    end
    local function isThrownEnemyComing(them)
        if them.thrower
        and them.thrower.team == "players"
        and Face.isObjectInSight(self, them, sightarc)
        and Body.isInTheirWay(self, them, time) then
            Face.faceObject(self, them)
            nextstate = "catchReady"
            return "break"
        end
    end
    local function isCloseEnoughToGrab(them)
        if them.health < 1 then return end

        local cx, cy, cz, cr, ch =
            them.x,them.y,them.z,
            them.bodyradius,them.bodyheight

        local radii = self.bodyradius + cr
        if math.distsq(self.x, self.y, cx, cy) <= radii*radii then
            if cz <= self.z + self.bodyheight and cz + ch >= self.z then
                nextstate = "hold"
                nextstatearg = them
                return "break"
            end
        end
    end

    Characters.search("projectiles", isComing)
    if nextstate then return nextstate, nextstatearg end
    Characters.search("enemies", isThrownEnemyComing)
    if nextstate then return nextstate, nextstatearg end
    Characters.search("container", isThrownEnemyComing)
    if nextstate then return nextstate, nextstatearg end
    Characters.search("container", isCloseEnoughToGrab)
    if nextstate then return nextstate, nextstatearg end
end

function MuscleBandit:decideNextAttack()
    if self.weaponinhand then
        return "throwBackProjectile"
    end
    return Enemy.decideNextAttack(self)
end

function MuscleBandit:duringPrepareAttack(target)
    local dirx, diry = math.cos(self.faceangle), math.sin(self.faceangle)
    local projectiles = Characters.getGroup("projectiles")
    local caught = Catcher.findCharacterToCatch(self, projectiles, dirx, diry)
    if caught then
        caught:stopAttack()
        return "catchProjectile", caught
    end

    if self.attack.opponentstateonhit == "held" then
        local guardangle = DirectionalAnimation.SnapAngle(self.faceangle, self.animationdirections)
        Guard.startGuarding(self, guardangle)
    end
    Enemy.duringPrepareAttack(self, target)
end

function MuscleBandit:duringAttackSwing(target)
    if self.attack.opponentstateonhit == "held" then
        Guard.startGuarding(self, self.attackangle)
    else
        Guard.stopGuarding(self)
    end
end

return MuscleBandit