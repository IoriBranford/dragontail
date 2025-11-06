local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Action.Guard"
local Characters   = require "Dragontail.Stage.Characters"
local Catcher      = require "Dragontail.Character.Component.Catcher"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"

---@class MuscleBandit:Enemy
local MuscleBandit = class(Enemy)

-- function MuscleBandit:findAttackerSlot(opponent, attacktype)
--     local bodyradius = self.bodyradius
--     local attackdata = self.attacktable[attacktype]
--     local attackrange = (attackdata and attackdata.bestdist or 1) + opponent.bodyradius
--     return AttackTarget.findClosestSlot(opponent, attackrange + bodyradius, "melee", self.x, self.y)
--         or AttackTarget.findClosestSlot(opponent, attackrange + bodyradius, "missile", self.x, self.y)
-- end

function MuscleBandit:duringStand()
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    local opponent = self.opponents[1]
    local fromoppox, fromoppoy = self.x - opponent.x, self.y - opponent.y
    local oppovelx, oppovely = opponent.velx, opponent.vely
    local oppospeed = math.len(oppovelx, oppovely)
    local dot = math.dot(fromoppox, fromoppoy, oppovelx, oppovely)
    if 0 < dot and dot <= oppospeed*60 then
        return "muscle-grab"
    end

    local dirx, diry = math.cos(self.faceangle), math.sin(self.faceangle)
    local projectiles = Characters.getGroup("projectiles")
    local caught = Catcher.findCharacterToCatch(self, projectiles, dirx, diry)
    if caught then
        caught:stopAttack()
        return "catchProjectile", caught
    end
end

function MuscleBandit:duringApproach(opponent)
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    local fromoppox, fromoppoy = self.x - opponent.x, self.y - opponent.y
    local oppovelx, oppovely = opponent.velx, opponent.vely
    local oppospeed = math.len(oppovelx, oppovely)
    local dot = math.dot(fromoppox, fromoppoy, oppovelx, oppovely)
    if 0 < dot and dot <= oppospeed*60 then
        return "muscle-grab"
    end

    local dirx, diry = math.cos(self.faceangle), math.sin(self.faceangle)
    local projectiles = Characters.getGroup("projectiles")
    local caught = Catcher.findCharacterToCatch(self, projectiles, dirx, diry)
    if caught then
        caught:stopAttack()
        return "catchProjectile", caught
    end
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