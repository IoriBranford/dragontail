local Behavior = require "Dragontail.Character.Behavior"
local Mana     = require "Dragontail.Character.Component.Mana"
local Slide    = require "Dragontail.Character.Action.Slide"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Face     = require "Dragontail.Character.Component.Face"
local Body     = require "Dragontail.Character.Component.Body"
local Combo    = require "Dragontail.Character.Component.Combo"
local Attacker = require "Dragontail.Character.Component.Attacker"

local PlayerSpinAttack = pooledclass(Behavior)
PlayerSpinAttack._nrec = Behavior._nrec + 3

function PlayerSpinAttack:start(attackangle)
    local player = self.character
    player.numopponentshit = 0

    local lungespeed = player.attack.lungespeed
    if lungespeed then
        Slide.updateSlideSpeed(player, attackangle, lungespeed)
    end
    self.lungespeed = lungespeed
    Mana.store(player, -(player.attack.manacost or 0))

    local spintime = player.attack.hittingduration or 1
    player.statetime = player.statetime or spintime
    self.originalattackangle = attackangle

    Attacker.startAttack(player, attackangle)
    Face.faceAngle(player, attackangle, player.state and player.state.animation)
end

function PlayerSpinAttack:fixedupdate()
    local player = self.character

    local attackangle = player.attackangle
    local projectile = player.attack.projectiletype
    if projectile then
        local projectileangle = attackangle + math.pi
        local cosangle, sinangle = math.cos(projectileangle), math.sin(projectileangle)
        Shoot.launchProjectile(player, "spark-spit-fireball", cosangle, sinangle, 0)
        Shoot.launchProjectile(player, projectile, cosangle, sinangle, 0)
    end

    local inx, iny = player:getJoystick()
    local targetvelx, targetvely = 0, 0
    local speed = 2
    if inx ~= 0 or iny ~= 0 then
        inx, iny = math.norm(inx, iny)
        targetvelx = inx * speed
        targetvely = iny * speed
    end

    if self.lungespeed then
        if math.abs(self.lungespeed - math.len(player.velx, player.vely)) >= 1 then
            self.lungespeed = nil
        end
    end
    if self.lungespeed then
        self.lungespeed = Slide.updateSlideSpeed(player, self.originalattackangle, self.lungespeed)
    else
        Body.accelerateTowardsVel(player, targetvelx, targetvely, player.mass or 8)
    end

    local spinvel = player.attack.spinspeed or 0
    attackangle = attackangle + spinvel
    Attacker.startAttack(player, attackangle)
    Face.faceAngle(player, attackangle, player.state and player.state.animation)
end

function PlayerSpinAttack:interrupt(...)
    local player = self.character
    Attacker.stopAttack(player)
    Combo.reset(player)
    return ...
end

function PlayerSpinAttack:timeout(nextstate, a, b, c, d, e, f, g)
    local player = self.character
    if player.numopponentshit <= 0 then
        Combo.reset(player)
    end

    Attacker.stopAttack(player)
    player.faceangle = self.originalattackangle

    if nextstate then
        return nextstate, a, b, c, d, e, f, g
    end

    return player.gravity == 0 and "hover" or "walk"
end

return PlayerSpinAttack