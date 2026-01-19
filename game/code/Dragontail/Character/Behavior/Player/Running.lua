local Behavior = require "Dragontail.Character.Behavior"
local Mana          = require "Dragontail.Character.Component.Mana"
local Body          = require "Dragontail.Character.Component.Body"
local Characters   = require "Dragontail.Stage.Characters"
local Audio    = require "System.Audio"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Face       = require "Dragontail.Character.Component.Face"
local Player     = require "Dragontail.Character.Player"
local Attacker   = require "Dragontail.Character.Component.Attacker"

---@class PlayerRunning:Behavior
---@field character Player
local PlayerRunning = pooledclass(Behavior)
PlayerRunning._nrec = Behavior._nrec + 5

---@param heldenemy Enemy?
function PlayerRunning:start(heldenemy, isrunstart)
    local player = self.character
    if isrunstart then
        player.facedestangle = player.faceangle
        player.velx = player.speed*math.cos(player.faceangle)
        player.vely = player.speed*math.sin(player.faceangle)
    end
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

---@param self Player
local function findSomethingToRunningAttack(self, velx, vely)
    local attack = self.attack
    if not attack then return end

    local attackangle = velx == 0 and vely == 0
        and self.faceangle or math.atan2(vely, velx)
    local solids = self.solids
    for i, solid in ipairs(solids) do
        local hit = Attacker.getAttackHit(self, solid, self.attack, attackangle)
        if hit then
            hit:_release()
            return solid
        end
    end
end

local function findWallCollision(self)
    local oobx, ooby = self.penex, self.peney
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        return math.norm(oobx, ooby)
    end
end

local RunningChargeAttackStates = {
    "fireball-storm", "running-spit-multi-fireball", "running-spit-fireball"
}

function PlayerRunning:fixedupdate()
    local player = self.character

    local inair = player.gravity == 0

    local heldenemy = self.heldenemy
    local inx, iny = player:getJoystick()

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
    local targetvelangle = player.facedestangle or player.faceangle
    if targetvely ~= 0 or targetvelx ~= 0 then
        targetvelangle = math.atan2(targetvely, targetvelx)
        player.facedestangle = targetvelangle
    end

    Body.forceTowardsVelXY(player, targetvelx, targetvely, player.accel)
    local speed = player.speed
    local isfullspeedahead = speed*speed <=
        math.dot(player.velx, player.vely, targetvelx, targetvely)

    local animation = heldenemy and "holdrun" or isfullspeedahead and "Run" or "Jog"
    Face.turnTowardsAngle(player, targetvelangle, nil, animation, player.animationframe or 1)

    if isfullspeedahead then
        player:makePeriodicAfterImage(self.runningtime, player.afterimageinterval or 6)
    end

    if heldenemy then
        player.holdangle = player.faceangle
        HoldOpponent.updateVelocities(player)
    else
        local caughtprojectile = player:catchProjectileAtJoystick()
        if caughtprojectile then
            return "catchProjectile", caughtprojectile
        end
    end

    if player:consumeActionDownAndRecentlyPressed("fly") then
        if inair then
            return "flyEnd"
        end
        return heldenemy and "holdJump" or "jump", true
    end

    local velx, vely = player.velx, player.vely
    local velangle = velx == 0 and vely == 0 and player.faceangle or math.atan2(vely, velx)

    local chargedattackstate = not player.attackbutton.down and player:getChargedAttack(RunningChargeAttackStates)
    if chargedattackstate then
        Mana.releaseCharge(player)
        return chargedattackstate, player.facedestangle
    end

    local targets
    if player.weaponinhand then
        targets = player:updateEnemyTargetingScores(player.facedestangle)
    end

    if player:consumeActionRecentlyPressed("attack") then
        if heldenemy then
            heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
            -- HoldOpponent.stopHolding(player, heldenemy)
            -- heldenemy.canbeattacked = true

            -- if fireattackpressed then
            --     for _, attacktype in ipairs(RunningSpecialAttacks) do
            --         if Mana.canAffordAttack(self, attacktype) then
            --             return attacktype, self.faceangle
            --         end
            --     end
            -- end

            return "spinning-throw", player.faceangle, heldenemy
        end

        if player.weaponinhand then
            return "throwWeapon", player.facedestangle, #player.inventory
        end

        -- if fireattackpressed then
        --     for _, attacktype in ipairs(RunningSpecialAttacks) do
        --         if Mana.canAffordAttack(player, attacktype) then
        --             return attacktype, atan2(vely, velx)
        --         end
        --     end
        -- end

        return "running-kick", player.facedestangle
    end

    if heldenemy then
        local oobx, ooby = heldenemy.penex, heldenemy.peney
        if oobx or ooby then
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "wallSlammed", player, oobx, ooby)
            return "running-elbow", player.faceangle
        end
    else
        local attacktarget = findSomethingToRunningAttack(player, velx, vely)
        if attacktarget then
            return "running-elbow", velangle
        end

        local oobx, ooby = findWallCollision(player)
        if oobx or ooby then
            local oobdotvel = math.dot(oobx, ooby, velx, vely)
            if oobdotvel > 0 then
                return player:runIntoWall()
            end
        end
    end

    if self.runningtime < 6 then
    elseif player.sprintbutton.down then --player.runenergy > 0 and rundown then
    --     player.runenergy = player.runenergy - 1
    else
        Audio.play(player.stopdashsound)
        if heldenemy then
            heldenemy:stopAttack() ; heldenemy:unassignSelfAsAttacker()
            HoldOpponent.stopHolding(player, heldenemy)
            StateMachine.start(heldenemy, "knockedBack", player, player.faceangle)
        end
        return "stopRunning"
    end

    if targets then
        for i = 1, #player.inventory do
            Attacker.updateCrosshairTargetObject(player, i, targets[i])
        end
    end

    self.runningtime = self.runningtime + 1
end

function PlayerRunning:interrupt(...)
    local player = self.character
    for i = 1, #player.crosshairs do
        Attacker.updateCrosshairTargetObject(player, i)
    end
    return ...
end

return PlayerRunning