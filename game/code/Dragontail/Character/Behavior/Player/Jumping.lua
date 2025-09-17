local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Audio    = require "System.Audio"

---@class PlayerJumping:Behavior
---@field character Player
local PlayerJumping = pooledclass(Behavior)

function PlayerJumping:start(isjumpstart)
    local player = self.character
    if isjumpstart then
        local inx, iny = player:getJoystick()
        if inx ~= 0 or iny ~= 0 then
            inx, iny = math.norm(inx, iny)
        end
        local speed = player.speed
        player.velx = inx * speed
        player.vely = iny * speed
        player.velz = player.gravity*15
        player.numjumpattacks = 0
        Face.faceVector(player, player.velx, player.vely)
    end
    player.facedestangle = player.faceangle
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
    local faceangle, facedestangle =
        player:turnTowardsJoystick(animation, animation)

    if player:isActionRecentlyPressed("attack") then
        if player.numjumpattacks < 1 then
            player.numjumpattacks = player.numjumpattacks + 1
            local spindir = math.det(math.cos(faceangle), math.sin(faceangle),
                math.cos(facedestangle), math.sin(facedestangle))
            local attackstate = spindir < 0
                and "jump-tail-swing-ccw" or "jump-tail-swing-cw"
            return attackstate, facedestangle
        end
    end
end

return PlayerJumping