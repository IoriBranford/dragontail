local Behavior = require "Dragontail.Character.Behavior"
local Body     = require "Dragontail.Character.Component.Body"
local Player   = require "Dragontail.Character.Player"
local Mana     = require "Dragontail.Character.Component.Mana"
local Face     = require "Dragontail.Character.Component.Face"

---@class Recovering:Behavior
---@field character Player
local Recovering = pooledclass(Behavior)
Recovering._nrec = Behavior._nrec + 3

local ChargeAttacks = Player.ChargeAttacks

function Recovering:start()
    self.flypressed = false
    self.sprintpressed = false
end

function Recovering:fixedupdate()
    local player = self.character

    player:turnTowardsJoystick()
    Body.accelerateTowardsVel(player, 0, 0, player.mass or 1)

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return "catchProjectile", caughtprojectile
    end

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return chargedattack, player.facedestangle
    end

    if player.flybutton.pressed then
        self.flypressed = true
    end

    if player.sprintbutton.pressed then
        self.sprintpressed = true
    end
end

function Recovering:timeout(nextstate, a, b, c, d, e, f, g)
    local player = self.character
    local inair = player.gravity == 0

    local inx, iny = player:getJoystick()

    if player.flybutton.down then
        if self.flypressed then
            if self.canfly then
                return inair and "flyEnd" or "flyStart"
            end
        end
    end

    if player.sprintbutton.down then
        if self.sprintpressed then
            Face.faceVector(player, inx, iny)
            return "run"
        end
    end

    if nextstate then
        return nextstate, a, b, c, d, e, f, g
    end

    return "walk"
end

return Recovering