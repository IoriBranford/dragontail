local Behavior = require "Dragontail.Character.Behavior"
local StateMachine       = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent       = require "Dragontail.Character.Component.HoldOpponent"
local Guard              = require "Dragontail.Character.Component.Guard"
local Face               = require "Dragontail.Character.Component.Face"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Invulnerability      = require "Dragontail.Character.Component.Invulnerability"

local CatchAttack = pooledclass(Behavior)
CatchAttack._nrec = Behavior._nrec + 2

---@param hit AttackHit
function CatchAttack:start(hit)
    local player = self.character
    local attacker = hit.attacker

    Face.faceObject(player, attacker,
        player.state.animation, player.animationframe, player.state.loopframe)
    player:makeImpactSpark(hit.attacker, "spark-parry")

    if attacker.team == "enemies"
    or attacker.team == "container" then
        attacker.thrower = nil
        HoldOpponent.startHolding(player, attacker)
    elseif attacker.team == "projectiles" then
        attacker:stopAttack() ; attacker:unassignSelfAsAttacker()
        if player:tryToGiveWeapon(attacker.type) then
            attacker:disappear()
        else
            StateMachine.start(attacker, "projectileBounce", player)
        end
    end
    Guard.stopGuarding(player)

    self.attacker = not attacker.disappeared and attacker
    self.attackerteam = attacker.team
end


function CatchAttack:fixedupdate()
    local player = self.character
    local attacker = self.attacker

    if attacker then
        local tooppox, tooppoy = attacker.x - player.x, attacker.y - player.y
        if tooppox ~= 0 or tooppoy ~= 0 then
            local targetangle = math.atan2(tooppoy, tooppox)
            local faceangle = Face.turnTowardsAngle(player, targetangle, nil,
                player.state.animation, player.animationframe, player.state.loopframe)
            Face.turnTowardsAngle(attacker, targetangle, 1,
                attacker.state.animation, attacker.animationframe, attacker.state.loopframe)
            if player.holdangle then
                player.holdangle = faceangle
            end
        end
    end

    player:decelerateXYto0()
    HoldOpponent.updateVelocities(player)

    local attackerteam = self.attackerteam
    if attackerteam == "enemies"
    or attackerteam == "container" then
        if not HoldOpponent.isHolding(player, attacker) then
            return "brokenaway", attacker
        end
    end
end

function CatchAttack:interrupt(...)
    local player = self.character
    local attacker = self.attacker
    if attacker
    and HoldOpponent.isHolding(player, attacker) then
        HoldOpponent.stopHolding(player, attacker)
    end
    Invulnerability.giveInvuln(player, player.guardinvulntime or 90)
    return ...
end

function CatchAttack:timeout()
    local player = self.character
    local attacker = self.attacker

    -- if player.weaponinhand then
    --     return "throwBackProjectile"
    -- end

    Invulnerability.giveInvuln(player, player.guardinvulntime or 90)

    if attacker
    and (attacker.team == "enemies"
        or attacker.team == "container")
    and HoldOpponent.isHolding(player, attacker)
    then
        Face.faceAngle(attacker, player.faceangle)
        return "grab", attacker
    end
    return "walk"
end

return CatchAttack