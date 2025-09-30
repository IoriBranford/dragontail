local Behavior = require "Dragontail.Character.Behavior"
local Mana     = require "Dragontail.Character.Component.Mana"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Audio        = require "System.Audio"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local Body         = require "Dragontail.Character.Component.Body"
local Attacker     = require "Dragontail.Character.Component.Attacker"

local SpinAndKickEnemy = pooledclass(Behavior)
SpinAndKickEnemy._nrec = Behavior._nrec + 1

function SpinAndKickEnemy:start()
    local player = self.character
    local enemy = player.heldopponent
    Mana.store(player, -(player.attack.manacost or 0))
    StateMachine.start(enemy, player.attack.heldopponentstate or "human-in-spinning-throw", player)
    local holdangle = player.holdangle
    self.throwangle = self:updateThrowAngle() or holdangle
end

function SpinAndKickEnemy:updateThrowAngle()
    local player = self.character
    local inx, iny = player:getJoystick()
    if inx ~= 0 or iny ~= 0 then
        self.throwangle = math.atan2(iny, inx)
    end
    return self.throwangle
end

function SpinAndKickEnemy:fixedupdate()
    local player = self.character
    local enemy = player.heldopponent
    local holdangle = player.holdangle

    if holdangle == self.throwangle then
        Attacker.stopAttack(enemy)
        HoldOpponent.stopHolding(player, enemy)
        enemy.canbeattacked = true
        -- if player.attack.damage then
        --     enemy.health = enemy.health - player.attack.damage
        -- end
        -- StateMachine.start(enemy, enemy.thrownai or "thrown", player, atan2(throwy, throwx))
        return "holding-kick", holdangle
    end

    if ((enemy.penex or 0) ~= 0) or ((enemy.peney or 0) ~= 0) then
        Attacker.stopAttack(enemy)
        HoldOpponent.stopHolding(player, enemy)
        StateMachine.start(enemy, "wallSlammed", player, enemy.penex, enemy.peney)
        return "swingEnemyIntoWall"
    end

    -- if math.ceil(spunmag / 2 / math.pi) < math.ceil((spunmag+spinmag) / 2 / math.pi) then
    --     Audio.play(player.state.sound)
    -- end

    -- local speed = self.speed or 2
    -- local targetvelx, targetvely = inx*speed, iny*speed
    -- Body.accelerateTowardsVelXY(player, targetvelx, targetvely, self.mass or 4)
    player:decelerateXYto0()

    local throwangle = self:updateThrowAngle()

    local spinvel = player.attack.spinspeed or 0
    local spinmag = math.abs(spinvel)
    local throwx, throwy = math.cos(throwangle), math.sin(throwangle)
    local holddirx, holddiry = math.cos(holdangle), math.sin(holdangle)
    if math.dot(throwx, throwy, holddirx, holddiry) >= math.cos(spinmag) then
        holdangle = throwangle
    else
        holdangle = holdangle + spinvel
    end

    Attacker.startAttack(enemy, holdangle)
    Face.faceAngle(player, holdangle, player.state.animation)

    player.holdangle = holdangle
    HoldOpponent.updateVelocities(player)
end

return SpinAndKickEnemy