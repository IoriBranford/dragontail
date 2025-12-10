local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Audio    = require "System.Audio"
local Database = require "Data.Database"
local Characters = require "Dragontail.Stage.Characters"
local Character  = require "Dragontail.Character"

---@class PlayerJumping:Behavior
---@field character Player
local PlayerJumping = pooledclass(Behavior)
PlayerJumping._nrec = Behavior._nrec + 3

function PlayerJumping:start(isjumpstart)
    local player = self.character
    self.velx, self.vely = player.velx, player.vely
    self.time = 0

    if isjumpstart then
        player.velz = player.gravity*16
        player.numjumpattacks = 0
        Face.faceVector(player, player.velx, player.vely)

        local dusttype = "spark-land-on-feet-dust"
        if Database.get(dusttype) then
            Characters.spawn(Character(dusttype, player.x, player.y, player.z))
        end
    end
    player.facedestangle = player.faceangle
end

function PlayerJumping:fixedupdate()
    local player = self.character
    if player.z <= player.floorz then
        player.velz = 0
        if player.sprintbutton.down then
            return "run"
        end
        Audio.play(player.jumplandsound)
        return "walk"
    end

    if player.canfly
    and math.abs(player.velz) < 1
    and player.flybutton.down then
        return "flyStart"
    end

    local animation = player.velz >= 1 and "JumpUp"
        or player.velz >= -1 and "JumpPeak"
        or "JumpDown"

    local faceangle, facedestangle =
        player:turnTowardsJoystick(animation, animation)

    if player:consumeActionRecentlyPressed("attack") then
        if player.numjumpattacks < 1 then
            player.numjumpattacks = player.numjumpattacks + 1
            local spindir = math.det(math.cos(faceangle), math.sin(faceangle),
                math.cos(facedestangle), math.sin(facedestangle))
            local attackstate = spindir < 0
                and "jump-tail-swing-ccw" or "jump-tail-swing-cw"
            return attackstate, facedestangle
        end
    end

    player:makePeriodicAfterImage(self.time, player.afterimageinterval or 6)
    self.time = self.time + 1

    player.velx, player.vely = self.velx, self.vely

    if (player.penex or 0) ~= 0 or (player.peney or 0) ~= 0 then
        local velx, vely = player.velx, player.vely
        local speedsq = math.lensq(velx, vely)
        local targetspeed = player.speed or 4
        if speedsq > targetspeed*targetspeed then
            return player:runIntoWall()
        end
    end
end

return PlayerJumping