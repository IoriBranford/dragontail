local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Audio    = require "System.Audio"
local PlayerJumping = pooledclass(Behavior)

function PlayerJumping:start()
    local player = self.character
    local inx, iny = player:getJoystick()
    if inx ~= 0 or iny ~= 0 then
        inx, iny = math.norm(inx, iny)
    end
    local speed = player.speed
    player.velx = inx * speed
    player.vely = iny * speed
    player.velz = player.gravity*15
    Face.faceVector(player, player.velx, player.vely)
end

function PlayerJumping:fixedupdate()
    local player = self.character
    if player.z <= player.floorz then
        Audio.play(player.jumplandsound)
        return "walk"
    end
    local animation = player.velz >= 1 and "JumpUp"
        or player.velz >= -1 and "JumpPeak"
        or "JumpDown"
    Face.faceAngle(player, player.faceangle, animation, player.animationframe)
end

return PlayerJumping