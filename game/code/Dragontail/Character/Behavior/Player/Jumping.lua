local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Audio    = require "System.Audio"
local Database = require "Data.Database"
local Characters = require "Dragontail.Stage.Characters"
local Character  = require "Dragontail.Character"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local StateMachine = require "Dragontail.Character.Component.StateMachine"

---@class PlayerJumping:Behavior
---@field character Player
local PlayerJumping = pooledclass(Behavior)
PlayerJumping._nrec = Behavior._nrec + 3

function PlayerJumping:start(isjumpstart)
    local player = self.character
    self.velx, self.vely = player.velx, player.vely
    self.time = 0

    if isjumpstart then
        if player.velz <= 0 then
            player.velz = player.gravity*16
        end
        player.numjumpattacks = 0
        if not player.heldopponent then
            Face.faceVector(player, player.velx, player.vely)
        end

        local dusttype = "spark-land-on-feet-dust"
        if Database.get(dusttype) then
            Characters.spawn(Character(dusttype, player.x, player.y, player.z))
        end
    end
    player.facedestangle = player.faceangle
end

function PlayerJumping:fixedupdate()
    local player = self.character
    local heldenemy = player.heldopponent

    if player.z <= player.floorz then
        player.velz = 0
        if player.sprintbutton.down then
            if heldenemy then
                return "running-with-enemy", heldenemy, true
            end
            return "run"
        end
        Audio.play(player.jumplandsound)

        if heldenemy then
            heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
            return "hold", heldenemy
        end
        return "walk"
    end

    if player.canfly
    and math.abs(player.velz) < 1
    and player.flybutton.down then
        return "flyStart"
    end

    local animation
    if heldenemy then
        animation = "spinthrow"
    else
        animation = player.velz >= 1 and "JumpUp"
            or player.velz >= -1 and "JumpPeak"
            or "JumpDown"
    end

    local faceangle, facedestangle =
        player:turnTowardsJoystick(animation, animation)
    if heldenemy then
        player.holdangle = faceangle
    end

    if player:consumeActionRecentlyPressed("attack") then
        if heldenemy then
            return "groundSlam"
        elseif player.numjumpattacks < 1 then
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

    local velx, vely = self.velx, self.vely
    player.velx, player.vely = velx, vely
    HoldOpponent.updateVelocities(player)

    local targetspeed = player.speed or 4
    if math.lensq(velx, vely) > targetspeed*targetspeed then
        local whoslammedwall =
            heldenemy and (heldenemy.penex or heldenemy.peney) and heldenemy
            or ((player.penex or 0) ~= 0 or (player.peney or 0) ~= 0) and player

        if heldenemy and whoslammedwall == heldenemy then
            heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "wallSlammed", player, heldenemy.penex, heldenemy.peney)
            return "running-elbow", player.faceangle
        end

        if whoslammedwall == player then
            if heldenemy then
                heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
                HoldOpponent.stopHolding(player, heldenemy)
                StateMachine.start(heldenemy, "knockedBack", player, player.faceangle)
            end
            return player:runIntoWall()
        end
    end
end

function PlayerJumping:interrupt(...)
    local player = self.character
    local heldenemy = player.heldopponent
    if heldenemy then
        heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
    end
    return ...
end

return PlayerJumping