local Behavior = require "Dragontail.Character.Behavior"
local Mana     = require "Dragontail.Character.Component.Mana"
local Face     = require "Dragontail.Character.Component.Face"
local Slide    = require "Dragontail.Character.Action.Slide"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Characters = require "Dragontail.Stage.Characters"
local Combo      = require "Dragontail.Character.Component.Combo"
local Attacker   = require "Dragontail.Character.Component.Attacker"
local Body       = require "Dragontail.Character.Component.Body"

---@class AttackingStraight:Behavior
---@field character Player
local AttackingStraight = pooledclass(Behavior)

local function findInstantThrowTarget(self, targetfacex, targetfacey)
    local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    local projectilez = self.z + projectileheight
    local enemy, enemytargetingscore = nil, 128
    Characters.search("enemies",
    ---@param e Enemy
    function(e)
        if not e.getTargetingScore then
            return
        end
        local score = e:getTargetingScore(self.x, self.y, targetfacex, targetfacey)

        local etop, ebottom = e.z + self.bodyheight, e.z
        if ebottom > projectilez or projectilez > etop then
            score = score / 2
        end
        if score < enemytargetingscore then
            enemy, enemytargetingscore = e, score
        end
    end)
    if enemy then
        return enemy.x, enemy.y, enemy.z
    end
    return self.x + targetfacex*512,
        self.y + targetfacey*512,
        self.z
end

function AttackingStraight:start(angle, heldenemy)
    local player = self.character
    player.numopponentshit = 0
    if player.attack.projectiletype then
        local numprojectiles = player.attack.numprojectiles or 1
        local targetx, targety, targetz = findInstantThrowTarget(player, math.cos(angle), math.sin(angle))
        if numprojectiles <= 1 then
            Shoot.launchProjectile(player, "spark-spit-fireball", math.cos(angle), math.sin(angle), 0)
            Shoot.launchProjectileAtPosition(player, player.attack.projectiletype, targetx, targety, targetz)
        else
            local arc = player.attack.arc or 0
            local arcbetweenprojectiles = arc * 2 / (numprojectiles - 1)
            local totargetx, totargety = targetx - player.x, targety - player.y
            totargetx, totargety = math.rot(totargetx, totargety, -arc)
            for i = 1, numprojectiles do
                targetx, targety = player.x + totargetx, player.y + totargety
                if totargetx ~= 0 or totargety ~= 0 then
                    local dirx, diry = math.norm(totargetx, totargety)
                    Shoot.launchProjectile(player, "spark-spit-fireball", dirx, diry, 0)
                end
                Shoot.launchProjectileAtPosition(player, player.attack.projectiletype, targetx, targety, targetz)
                totargetx, totargety = math.rot(totargetx, totargety, arcbetweenprojectiles)
            end
        end
    else
        player:startAttack(angle)
    end
    Mana.store(player, -(player.attack.manacost or 0))
    Face.faceAngle(player, angle, player.state.animation)
    local lungespeed = player.attack.lungespeed
    if lungespeed then
        Slide.updateSlideSpeed(player, angle, lungespeed)
        self.lungespeed = lungespeed
    end
    self.pressedattackbutton = nil
    self.angle = angle
    self.heldenemy = heldenemy

    local hittime = player.attack.hittingduration or 10
    player.statetime = player.statetime or hittime
    self.hitendtime = player.statetime - hittime
end

function AttackingStraight:fixedupdate()
    local player = self.character

    if self.pressedattackbutton ~= player.attackbutton then
        -- if player.fireattackbutton.pressed then
        --     pressedattackbutton = player.fireattackbutton
        -- else
        if player.attackbutton.pressed then
            self.pressedattackbutton = player.attackbutton
        end
    end
    if self.lungespeed then
        if math.abs(self.lungespeed - math.len(player.velx, player.vely)) >= 1 then
            self.lungespeed = nil
        end
    end
    if self.lungespeed then
        self.lungespeed = Slide.updateSlideSpeed(player, self.angle, self.lungespeed)
    else
        Body.accelerateTowardsVel(player, 0, 0, player.mass or 4)
    end
    local afterimageinterval = player.afterimageinterval or 0
    player:makePeriodicAfterImage(player.statetime, afterimageinterval)

    if player.statetime <= self.hitendtime then
        Attacker.stopAttack(player)
    end
end

function AttackingStraight:interrupt(nextstate, ...)
    local player = self.character
    Attacker.stopAttack(player)
    Combo.reset(player)
    return nextstate, ...
end

function AttackingStraight:timeout(nextstate, a, b, c, d, e, f, g)
    local player = self.character
    local inair = player.gravity == 0
    if player.numopponentshit <= 0 then
        Combo.reset(player)
    end

    if self.pressedattackbutton then
        local faceangle = player.faceangle
        local inx, iny = player:getJoystick()
        if not self.heldenemy then
            if inx ~= 0 or iny ~= 0 then
                faceangle = math.atan2(iny, inx)
            end
        end
        return player:doComboAttack(faceangle, self.heldenemy,
                inx ~= 0 or iny ~= 0, inair)
    end

    if self.heldenemy and self.heldenemy.health > 0 then
        return inair and "air-hold" or "hold", self.heldenemy
    end

    if nextstate then
        return nextstate, a, b, c, d, e, f, g
    end

    return inair and "hover" or "walk"
end

return AttackingStraight