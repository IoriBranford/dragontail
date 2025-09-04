local Behavior = require "Dragontail.Character.Behavior"
local Body     = require "Dragontail.Character.Component.Body"
local Player   = require "Dragontail.Character.Player"
local Mana     = require "Dragontail.Character.Component.Mana"
local Face     = require "Dragontail.Character.Component.Face"

local Recovering = pooledclass(Behavior)
Recovering._nrec = Behavior._nrec + 3

local ChargeAttacks = Player.ChargeAttacks
local GroundStates = Player.GroundStates
local GroundToAirStates = Player.GroundToAirStates

function Recovering:start()
    local player = self.character
    player.joysticklog:clear()
    self.flypressed = false
    self.sprintpressed = false
end

function Recovering:fixedupdate()
    local player = self.character
    local inair = player.gravity == 0
    local nextstates = inair and GroundToAirStates or GroundStates

    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)
    player:turnTowardsJoystick()
    Body.accelerateTowardsVel(player, 0, 0, player.mass or 1)

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return nextstates.catchProjectile, caughtprojectile
    end

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return nextstates[chargedattack], player.facedestangle
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
    local nextstates = inair and GroundToAirStates or GroundStates

    local inx, iny = player:getJoystick()

    if player.flybutton.down then
        if self.flypressed then
            if self.canfly then
                return nextstates.toggleFlying
            end
        end
    end

    if player.sprintbutton.down then
        if self.sprintpressed then
            Face.faceVector(player, inx, iny)
            return nextstates.run
        end
    end

    if nextstate then
        return nextstate, a, b, c, d, e, f, g
    end

    return nextstates.walk
end

return Recovering