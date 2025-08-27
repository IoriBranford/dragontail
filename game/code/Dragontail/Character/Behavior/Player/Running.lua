local Behavior = require "Dragontail.Character.Behavior"
local Mana          = require "Dragontail.Character.Component.Mana"
local Body          = require "Dragontail.Character.Component.Body"
local Characters   = require "Dragontail.Stage.Characters"
local Audio    = require "System.Audio"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"

---@class PlayerRunning:Behavior
---@field character Player
local PlayerRunning = pooledclass(Behavior)
PlayerRunning._nrec = Behavior._nrec + 2

---@param heldenemy Enemy?
function PlayerRunning:start(heldenemy)
    local player = self.character
    player.facedestangle = player.faceangle
    player.joysticklog:clear()
    player.velx = player.speed*math.cos(player.faceangle)
    player.vely = player.speed*math.sin(player.faceangle)
    self.runningtime = 0
    if heldenemy then
        self.heldenemy = heldenemy
        StateMachine.start(heldenemy, player.attack.heldopponentstate or "HumanInSpinningThrow", player)
        heldenemy:startAttack(player.faceangle)
    end
end

local function findSomethingToRunningAttack(self, velx, vely)
    local x, y, opponents, solids = self.x, self.y, self.opponents, self.solids
    for i, opponent in ipairs(opponents) do
        if math.dot(opponent.x - x, opponent.y - y, velx, vely) > 0 then
            if opponent.canbeattacked and Body.predictBodyCollision(self, opponent) then
                return opponent
            end
        end
    end
    for i, solid in ipairs(solids) do
        if math.dot(solid.x - x, solid.y - y, velx, vely) > 0 then
            if solid.canbeattacked and Body.predictBodyCollision(self, solid) then
                return solid
            end
        end
    end
end

local function findWallCollision(self)
    local oobx, ooby = Body.keepInBounds(self)
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        return math.norm(oobx, ooby)
    end
end

local RunningChargeAttacks = {
    "FireballStorm", "RunningSpitMultiFireball", "RunningSpitFireball"
}

local GroundNextStates = {
    walk = "walk",
    catchProjectile = "catchProjectile",
    toggleFlying = "flyStart",
    run = "run",
    hold = "hold",
    runIntoEnemy = "RunningElbow",
    RunningIntoWall = "RunningIntoWall",
    runningAttack = "RunningKick",
    throwWeapon = "throwWeapon",
    ["FireballStorm"] = "FireballStorm",
    ["RunningSpitMultiFireball"] = "RunningSpitMultiFireball",
    ["RunningSpitFireball"] = "RunningSpitFireball",
}

local AirNextStates = {
    walk = "hover",
    catchProjectile = "AirCatchProjectile",
    toggleFlying = "flyEnd",
    run = "AirRun",
    hold = "AirHold",
    RunningIntoWall = "AirRunningIntoWall",
    runIntoEnemy = "AirRunningElbow",
    runningAttack = "AirRunningKick",
    throwWeapon = "AirThrowWeapon",
    ["FireballStorm"] = "AirFireballStorm",
    ["RunningSpitMultiFireball"] = "AirRunningSpitMultiFireball",
    ["RunningSpitFireball"] = "AirRunningSpitFireball",
}

function PlayerRunning:fixedupdate()
    local player = self.character

    local inair = player.gravity == 0
    local nextstates = inair and AirNextStates or GroundNextStates

    local heldenemy = self.heldenemy
    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)

    player:turnTowardsJoystick(heldenemy and "holdwalk" or "Walk", "Stand")
    player:accelerateTowardsFace()

    player:makePeriodicAfterImage(self.runningtime, player.afterimageinterval or 6)

    if heldenemy then
        player.holdangle = player.faceangle
        HoldOpponent.updateOpponentPosition(player)
    else
        local caughtprojectile = player:catchProjectileAtJoystick()
        if caughtprojectile then
            return nextstates.catchProjectile, caughtprojectile
        end
    end

    if player.flybutton.pressed then
        return nextstates.toggleFlying
    end

    local velx, vely = player.velx, player.vely
    local velangle = velx == 0 and vely == 0 and player.faceangle or math.atan2(vely, velx)

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(RunningChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return nextstates[chargedattack], player.facedestangle
    end

    if player.attackbutton.pressed then
        if heldenemy then
            heldenemy:stopAttack()
            HoldOpponent.stopHolding(player, heldenemy)
            heldenemy.canbeattacked = true

            -- if fireattackpressed then
            --     for _, attacktype in ipairs(RunningSpecialAttacks) do
            --         if Mana.canAffordAttack(self, attacktype) then
            --             return attacktype, self.faceangle
            --         end
            --     end
            -- end

            return nextstates.runningAttack, player.faceangle
        end
        if player.weaponinhand then
            return nextstates.throwWeapon, player.facedestangle, 2, #player.inventory
        end

        -- if fireattackpressed then
        --     for _, attacktype in ipairs(RunningSpecialAttacks) do
        --         if Mana.canAffordAttack(player, attacktype) then
        --             return attacktype, atan2(vely, velx)
        --         end
        --     end
        -- end
        return nextstates.runningAttack, velangle
    end

    if heldenemy then
        local oobx, ooby = HoldOpponent.handleOpponentCollision(player)
        if oobx or ooby then
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "WallSlammed", player, oobx, ooby)
            return nextstates.runIntoEnemy, player.faceangle
        end
    else
        local attacktarget = findSomethingToRunningAttack(player, velx, vely)
        if attacktarget then
            return nextstates.runIntoEnemy, velangle
        end

        local oobx, ooby = findWallCollision(player)
        if oobx or ooby then
            local oobdotvel = math.dot(oobx, ooby, velx, vely)
            local speed = math.len(velx, vely)
            local ooblen = math.len(oobx, ooby)
            if oobdotvel > speed*ooblen/2 then
                Characters.spawn(
                    {
                        type = "SparkBigHit",
                        x = player.x + oobx*player.bodyradius,
                        y = player.y + ooby*player.bodyradius,
                        z = player.z + player.bodyheight/2
                    }
                )
                player.hurtstun = 10
                return nextstates.RunningIntoWall, velangle
            end
        end
    end

    if self.runningtime < 15 then
    elseif player.sprintbutton.down then --player.runenergy > 0 and rundown then
    --     player.runenergy = player.runenergy - 1
    else
        Audio.play(player.stopdashsound)
        if heldenemy then
            Audio.play(player.throwsound)
            heldenemy:stopAttack()
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "KnockedBack", player, player.faceangle)
        end
        return nextstates.walk
    end
    self.runningtime = self.runningtime + 1
end

return PlayerRunning