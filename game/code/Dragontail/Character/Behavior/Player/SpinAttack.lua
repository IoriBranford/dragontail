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

function PlayerSpinAttack:start(faceangle)
    local player = self.character
    player.numopponentshit = 0

    local lungespeed = player.attack.lungespeed
    if lungespeed then
        Slide.updateSlideSpeed(player, faceangle, lungespeed)
    end
    self.lungespeed = lungespeed
    Mana.store(player, -(player.attack.manacost or 0))

    local spintime = player.attack.hittingduration or 1
    player.statetime = player.statetime or spintime
    self.originalfaceangle = faceangle

    local faceangleoffset = player.attack.faceangleoffset or 0
    faceangle = faceangle + faceangleoffset
    local offsetfromfaceangle = player.attack.offsetfromfaceangle or 0
    local attackangle = faceangle + offsetfromfaceangle
    Attacker.startAttack(player, attackangle)
    Face.faceAngle(player, faceangle, player.state and player.state.animation)
end

function PlayerSpinAttack:fixedupdate()
    local player = self.character

    local faceangle = player.faceangle
    local offsetfromfaceangle = player.attack.offsetfromfaceangle or 0
    local attackangle = faceangle + offsetfromfaceangle

    local projectile = player.attack.projectiletype
    if projectile then
        local cosangle, sinangle = math.cos(attackangle), math.sin(attackangle)
        Shoot.launchProjectile(player, "spark-spit-fireball", cosangle, sinangle, 0)
        Shoot.launchProjectile(player, projectile, cosangle, sinangle, 0)
    end


    if self.lungespeed then
        if math.abs(self.lungespeed - math.len(player.velx, player.vely)) >= 1 then
            self.lungespeed = nil
        end
    end
    if self.lungespeed then
        self.lungespeed = Slide.updateSlideSpeed(player, self.originalfaceangle, self.lungespeed)
    end

    local spinvel = player.attack.spinspeed or 0
    faceangle = faceangle + spinvel
    attackangle = faceangle + offsetfromfaceangle
    Attacker.startAttack(player, attackangle)
    Face.faceAngle(player, faceangle, player.state and player.state.animation)
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
    player.faceangle = self.originalfaceangle

    if nextstate then
        return nextstate, a, b, c, d, e, f, g
    end

    return "walk"
end

return PlayerSpinAttack