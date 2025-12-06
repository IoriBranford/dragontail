local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Component.Guard"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Audio        = require "System.Audio"
local Body         = require "Dragontail.Character.Component.Body"
local Slide        = require "Dragontail.Character.Component.Slide"

---@class TakingHit:Behavior
---@field character Fighter
local TakingHit = pooledclass(Behavior)
TakingHit._nrec = Behavior._nrec + 5

---@param hit AttackHit
function TakingHit:start(hit)
    local fighter = self.character
    local attacker, attack, attackangle = hit.attacker, hit.attack, hit.angle
    local hurtangle
    if attacker.y == fighter.y and attacker.x == fighter.x then
        hurtangle = 0
    else
        hurtangle = math.atan2(attacker.y - fighter.y, attacker.x - fighter.x)
    end
    fighter.hurtangle = hurtangle
    fighter.hurtparticle = attack.hurtparticle
    fighter.hurtcolorcycle = attack.hurtcolorcycle
    fighter:makeImpactSpark(attacker, attack.hitspark)
    fighter.health = fighter.health - (attack.damage or 0)
    fighter.velx, fighter.vely = 0, 0
    fighter:stopAttack()
    Guard.stopGuarding(fighter)
    HoldOpponent.stopHolding(fighter, fighter.heldopponent)

    local pushbackspeed = attack.pushbackspeed or 0
    if pushbackspeed == "attackerspeed" then
        pushbackspeed = math.ceil(math.len(attacker.velx, attacker.vely))
    end
    fighter.hurtstun = (attack.opponentstun or 3) - math.abs(pushbackspeed)

    if attacker.storeMana then
        local mana = attack.gainmanaonhit
            or math.max(1, math.floor((attack.damage or 0)/4))
        attacker:storeMana(mana)
    end

    local hitsound = attack.hitsound
    if fighter.health <= 0 then
        hitsound = attack.finalhitsound or hitsound
    end
    Audio.play(hitsound)

    self.attacker = attacker
    self.attack = attack
    self.attackangle = attackangle
    self.pushbackspeed = Slide.updateSlideSpeed(fighter, attackangle, pushbackspeed)
    if fighter.floorz and fighter.z > fighter.floorz then
        fighter.velz = attack.launchspeedz or 4
        self.inair = true
    end
end

function TakingHit:fixedupdate()
    local fighter = self.character
    local attacker, attack = self.attacker, self.attack
    local attackangle = self.attackangle
    fighter:dropWeaponInHand()

    local defeateffect = attack.opponentstateonfinalhit
    local hiteffect = attack.opponentstateonhit
    if fighter.health <= 0 then
        HoldOpponent.stopHolding(fighter.heldby, fighter)
        defeateffect = defeateffect or fighter.defeatai or "defeat"
        return defeateffect, attacker, attackangle
    elseif hiteffect then
        HoldOpponent.stopHolding(fighter.heldby, fighter)
        return hiteffect, attacker, attackangle
    end
    if fighter.heldby then
        if HoldOpponent.isHolding(fighter.heldby, fighter) then
            return "held", fighter.heldby
        end
        fighter.heldby = nil
    end

    fighter:duringHurt()

    local pushbackspeed = self.pushbackspeed
    if fighter.z <= fighter.floorz then
        if pushbackspeed <= 0 then
            return self:timeout()
        end
        self.pushbackspeed = Slide.updateSlideSpeed(fighter, attackangle, pushbackspeed)
        if self.inair then
            fighter:changeAnimation("FallRiseFromKnees", 1, 0)
        end
    end
end

function TakingHit:timeout()
    local fighter = self.character
    local attacker = self.attacker
    fighter.velx, fighter.vely, fighter.velz = 0, 0, 0
    local recoverai = fighter.aiafterhurt or fighter.recoverai
    if not recoverai then
        print("No aiafterhurt or recoverai for "..fighter.type)
        HoldOpponent.stopHolding(fighter.heldby, fighter)
        return "defeat", attacker
    end
    return recoverai
end

return TakingHit