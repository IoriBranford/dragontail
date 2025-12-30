local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Component.Guard"
local Face  = require "Dragontail.Character.Component.Face"
local AttackTarget = require "Dragontail.Character.Component.AttackTarget"
local Characters   = require "Dragontail.Stage.Characters"
local Body         = require "Dragontail.Character.Component.Body"
local Slide        = require "Dragontail.Character.Component.Slide"

---@class ShieldBandit:Enemy
local ShieldBandit = class(Enemy)

local GuardHitsUntilCounter = 3

-- function ShieldBandit:findApproachSlot(target, nextstate)
--     local bodyradius = self.bodyradius
--     local state = self.statetable[nextstate]
--     local attackrange = (state and state.maxtargetdist or 1) + target.bodyradius
--     return AttackTarget.findClosestSlot(target, attackrange + bodyradius, "melee", self.x, self.y)
--         or AttackTarget.findClosestSlot(target, attackrange + bodyradius, "missile", self.x, self.y)
-- end

function ShieldBandit:duringStand()
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    local time = 10
    local sightarc = self.sightarc or (math.pi/4)
    local maxdodgespeed, dodgedecel = self.dodgespeed or 7, self.dodgedecel or .25
    local selfx, selfy = self.x, self.y
    local dodgevelx, dodgevely, dodgefaceangle
    local function isApproachingAnEnemy(attacker)
        if not Face.isObjectInSight(self, attacker, sightarc) then return end
        local playerx, playery = attacker.x, attacker.y
        local playerradius = attacker.bodyradius
        local approachedenemy
        Characters.search("enemies", function(enemy)
            if enemy == attacker then return end
            if not Body.isInTheirWay(enemy, attacker, time) then return end
            if not approachedenemy then
                if enemy == self then
                    approachedenemy = self
                    return
                end
            end

            local enemyx, enemyy = enemy.x, enemy.y
            local enemyradius = enemy.bodyradius

            local playertoenemyx, playertoenemyy = enemyx - playerx, enemyy - playery
            if playertoenemyx == 0 and playertoenemyy == 0 then return end

            local p2e_dirx, p2e_diry = math.norm(playertoenemyx, playertoenemyy)
            local pedgex = playerx + p2e_dirx*playerradius
            local pedgey = playery + p2e_diry*playerradius
            local eedgex = enemyx - p2e_dirx*enemyradius
            local eedgey = enemyy - p2e_diry*enemyradius
            local targetx, targety = math.projpointsegment(selfx, selfy, pedgex, pedgey, eedgex, eedgey)
            if targetx == selfx and targety == selfy then
                approachedenemy = enemy
                return enemy
            end
            local targetdist = math.dist(selfx, selfy, targetx, targety)
            local dodgespeed = Slide.GetSlideSpeedForDistance(targetdist, dodgedecel)
            if dodgespeed > maxdodgespeed then return end

            dodgevelx = (targetx-selfx)*dodgespeed/targetdist
            dodgevely = (targety-selfy)*dodgespeed/targetdist
            dodgefaceangle = math.atan2(-p2e_diry, -p2e_dirx)
            approachedenemy = enemy

            -- Characters.spawn({
            --     x = 0, y = 0, shape = "polygon",
            --     polygon = {
            --         {x = selfx, y = selfy},
            --         {x = pedgex, y = pedgey},
            --         {x = eedgex, y = eedgey},
            --     },
            --     linecolor = 0xFFFFFFFF,
            --     color = 0,
            -- })

            -- Characters.spawn({
            --     x = targetx-1, y = targety-1, shape = "ellipse",
            --     width = 2, height = 2,
            --     color = 0xFFFF0000
            -- })
            return enemy
        end)
        return approachedenemy
    end
    local function isThrownEnemyApproachingAnEnemy(them)
        return them.thrower
            and them.thrower.team == "players"
            and isApproachingAnEnemy(them)
    end
    local function isInterceptable(them)
        if not Face.isObjectInSight(self, them, sightarc) then return end
        if them.z + them.bodyheight < self.z
        or self.z + self.bodyheight < them.z then return end
        local theirvelx, theirvely = them.velx, them.vely
        if theirvelx == 0 and theirvely == 0 then return end
        local theirx, theiry = them.x, them.y
        if math.dot(theirvelx, theirvely, selfx - theirx, selfy - theiry) < 0 then return end
        local theirx2 = theirx + theirvelx*time
        local theiry2 = theiry + theirvely*time
        local targetx, targety = math.projpointsegment(selfx, selfy, theirx, theiry, theirx2, theiry2)
        local targetdist = math.dist(selfx, selfy, targetx, targety)
        local dodgespeed = Slide.GetSlideSpeedForDistance(targetdist, dodgedecel)
        if dodgespeed > maxdodgespeed then return end

        if targetdist > 0 then
            dodgevelx = (targetx-selfx)*dodgespeed/targetdist
            dodgevely = (targety-selfy)*dodgespeed/targetdist
            -- Characters.spawn({
            --     x = targetx-1, y = targety-1, shape = "ellipse",
            --     width = 2, height = 2,
            --     color = 0xFFFF0000
            -- })
        end
        dodgefaceangle = math.atan2(-theirvely, -theirvelx)
        return them
    end
    local function isThrownInterceptable(them)
        return them.thrower
            and them.thrower.team == "players"
            and isInterceptable(them)
    end
    local opponenttointercept =
        Characters.search("projectiles", isInterceptable) or
        Characters.search("enemies", isThrownInterceptable) or
        Characters.search("container", isThrownInterceptable) or
        Characters.search("players", isInterceptable)
    if opponenttointercept then
        if dodgevelx and dodgevely then
            self.velx, self.vely = dodgevelx, dodgevely
        end
        if dodgefaceangle then
            Face.faceAngle(self, dodgefaceangle)
        end
        return "raiseGuard"
    end
end

function ShieldBandit:duringApproach(opponent)
    return self:duringStand()
end

function ShieldBandit:duringHurt()
    self.numguardedhits = nil
end

---@deprecated
function ShieldBandit:beforeGuard()
    self.velx, self.vely = 0, 0
    self.numguardedhits = self.numguardedhits or 0
end

---@deprecated
function ShieldBandit:duringGuard(t)
    local opponent = self.opponents[1]
    Face.turnTowardsObject(self, opponent, self.faceturnspeed, self.state.animation)
    local guardangle = math.floor((self.faceangle + (math.pi/4)) / (math.pi/2)) * math.pi/2
    Guard.startGuarding(self, guardangle)
    if self.numguardedhits + 1 >= GuardHitsUntilCounter then
        self:updateFlash(self.statetime)
    else
        self:resetFlash()
    end
end

---@deprecated
function ShieldBandit:afterGuard()
    Enemy.afterGuard(self)
    self:resetFlash()
    self.numguardedhits = nil
end

---@deprecated
function ShieldBandit:beforeGuardHit(attacker)
    Guard.pushBackAttacker(self, attacker)
    self.numguardedhits = (self.numguardedhits or 0) + 1
end

---@deprecated
function ShieldBandit:duringGuardHit(attacker, t)
    if self.numguardedhits >= GuardHitsUntilCounter then
        self.numguardedhits = nil
        Face.faceObject(self, attacker)
        return "shield-counter-bash", attacker
    elseif self.numguardedhits + 1 >= GuardHitsUntilCounter then
        self:updateFlash(self.statetime)
    end
end

return ShieldBandit