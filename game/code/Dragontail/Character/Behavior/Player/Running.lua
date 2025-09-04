local Behavior = require "Dragontail.Character.Behavior"
local Mana          = require "Dragontail.Character.Component.Mana"
local Body          = require "Dragontail.Character.Component.Body"
local Characters   = require "Dragontail.Stage.Characters"
local Audio    = require "System.Audio"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Face       = require "Dragontail.Character.Component.Face"
local Player     = require "Dragontail.Character.Player"

---@class PlayerRunning:Behavior
---@field character Player
local PlayerRunning = pooledclass(Behavior)
PlayerRunning._nrec = Behavior._nrec + 5

---@param heldenemy Enemy?
function PlayerRunning:start(heldenemy)
    local player = self.character
    player.facedestangle = player.faceangle
    player.joysticklog:clear()
    player.velx = player.speed*math.cos(player.faceangle)
    player.vely = player.speed*math.sin(player.faceangle)
    self.targetvelx = player.velx
    self.targetvely = player.vely
    self.runningtime = 0
    if heldenemy then
        self.heldenemy = heldenemy
        StateMachine.start(heldenemy, player.attack.heldopponentstate or "human-in-spinning-throw", player)
        heldenemy:startAttack(player.faceangle)
    end
    self.attackpressed = false
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
    "fireball-storm", "running-spit-multi-fireball", "running-spit-fireball"
}

local GroundStates = Player.GroundStates
local GroundToAirStates = Player.GroundToAirStates

function PlayerRunning:fixedupdate()
    local player = self.character

    local inair = player.gravity == 0
    local nextstates = inair and GroundToAirStates or GroundStates

    local heldenemy = self.heldenemy
    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)

    local targetvelx = self.targetvelx
    local targetvely = self.targetvely
    if inx ~= 0 or iny ~= 0 then
        inx, iny = math.norm(inx, iny)
        targetvelx = inx*player.speed
        targetvely = iny*player.speed
        if math.dot(targetvelx, targetvely, self.targetvelx, self.targetvely) < 0 then
            Audio.play(player.stopdashsound)
        end
        self.targetvelx = targetvelx
        self.targetvely = targetvely
    end
    local targetvelangle = math.atan2(targetvely, targetvelx)
    player.facedestangle = targetvelangle

    local animation = heldenemy and "holdwalk" or "Walk"
    Face.turnTowardsAngle(player, targetvelangle, nil, animation, player.animationframe or 1)
    Body.accelerateTowardsVel(player, targetvelx, targetvely, player.mass or 1)

    local fullspeed = player.speed*player.speed/2 <=
        math.dot(player.velx, player.vely, targetvelx, targetvely)

    if fullspeed then
        player:makePeriodicAfterImage(self.runningtime, player.afterimageinterval or 6)
    end

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

    self.attackpressed = self.attackpressed or player.attackbutton.pressed
    if self.attackpressed and player.attackbutton.down then
        if heldenemy then
            heldenemy:stopAttack()
            -- HoldOpponent.stopHolding(player, heldenemy)
            -- heldenemy.canbeattacked = true

            -- if fireattackpressed then
            --     for _, attacktype in ipairs(RunningSpecialAttacks) do
            --         if Mana.canAffordAttack(self, attacktype) then
            --             return attacktype, self.faceangle
            --         end
            --     end
            -- end

            return nextstates["spinning-throw"], player.faceangle, heldenemy
        end

        if fullspeed then
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
    end

    if heldenemy then
        local oobx, ooby = HoldOpponent.handleOpponentCollision(player)
        if oobx or ooby then
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "wallSlammed", player, oobx, ooby)
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
                        type = "spark-bighit",
                        x = player.x + oobx*player.bodyradius,
                        y = player.y + ooby*player.bodyradius,
                        z = player.z + player.bodyheight/2
                    }
                )
                player.hurtstun = 9
                return nextstates.runIntoWall, velangle
            end
        end
    end

    if self.runningtime < 15 then
    elseif player.sprintbutton.down then --player.runenergy > 0 and rundown then
    --     player.runenergy = player.runenergy - 1
    else
        Audio.play(player.stopdashsound)
        if heldenemy then
            heldenemy:stopAttack()
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "knockedBack", player, player.faceangle)
        end
        return nextstates.stopRunning
    end
    self.runningtime = self.runningtime + 1
end

return PlayerRunning