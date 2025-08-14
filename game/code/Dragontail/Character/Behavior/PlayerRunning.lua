local Behavior = require "Dragontail.Character.Behavior"
local Mana          = require "Dragontail.Character.Component.Mana"
local Body          = require "Dragontail.Character.Component.Body"
local Characters   = require "Dragontail.Stage.Characters"
local Audio    = require "System.Audio"

---@class PlayerRunning:Behavior
---@field character Player
local PlayerRunning = class(Behavior)

function PlayerRunning:start()
    local player = self.character
    player.facedestangle = player.faceangle
    player.joysticklog:clear()
    player.velx = player.speed*math.cos(player.faceangle)
    player.vely = player.speed*math.sin(player.faceangle)
    self.runningtime = 0
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

function PlayerRunning:fixedupdate()
    local player = self.character
    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)

    player:turnTowardsJoystick("Walk", "Stand")
    player:accelerateTowardsFace()

    player:makePeriodicAfterImage(self.runningtime, player.afterimageinterval or 6)

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return "catchProjectile", caughtprojectile
    end

    -- if player.flybutton.pressed then
    --     return "flyStart"
    -- end

    local velx, vely = player.velx, player.vely
    local velangle = velx == 0 and vely == 0 and player.faceangle or math.atan2(vely, velx)

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(RunningChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return chargedattack, player.facedestangle
    end

    if player.attackbutton.pressed then
        if player.weaponinhand then
            return "throwWeapon", player.facedestangle, 2, #player.inventory
        end

        -- if fireattackpressed then
        --     for _, attacktype in ipairs(RunningSpecialAttacks) do
        --         if Mana.canAffordAttack(player, attacktype) then
        --             return attacktype, atan2(vely, velx)
        --         end
        --     end
        -- end
        return "running-kick", velangle
    end

    local attacktarget = findSomethingToRunningAttack(player, velx, vely)
    if attacktarget then
        return "running-elbow", velangle
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
            player.hurtstun = 10
            return "runIntoWall", velangle
        end
    end

    if self.runningtime < 15 then
    elseif player.sprintbutton.down then --player.runenergy > 0 and rundown then
    --     player.runenergy = player.runenergy - 1
    else
        Audio.play(player.stopdashsound)
        return "walk"
    end
    self.runningtime = self.runningtime + 1
end

function PlayerRunning:stop()
end

return PlayerRunning