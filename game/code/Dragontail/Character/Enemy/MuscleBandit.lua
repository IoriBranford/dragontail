local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Component.Guard"
local Characters   = require "Dragontail.Stage.Characters"
local Catcher      = require "Dragontail.Character.Component.Catcher"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Component.Body"
local CollisionMask        = require "Dragontail.Character.Component.Body.CollisionMask"
local Face                 = require "Dragontail.Character.Component.Face"
local Slide        = require "Dragontail.Character.Component.Slide"

---@class MuscleBandit:Enemy
local MuscleBandit = class(Enemy)

-- function MuscleBandit:findApproachSlot(target, nextstate)
--     local bodyradius = self.bodyradius
--     local state = self.statetable[nextstate]
--     local attackrange = (state and state.maxtargetdist or 1) + target.bodyradius
--     return AttackTarget.findClosestSlot(target, attackrange + bodyradius, "melee", self.x, self.y)
--         or AttackTarget.findClosestSlot(target, attackrange + bodyradius, "missile", self.x, self.y)
-- end

function MuscleBandit:duringStand()
    local opponent = self.opponents[1]
    return self:duringApproach(opponent)
end

function MuscleBandit:duringApproach(opponent)
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    if self.weaponinhand then return end

    local time = 10
    local sightarc = self.sightarc or (math.pi/4)
    local maxdodgespeed, dodgedecel = self.dodgespeed or 7, self.dodgedecel or .25
    local selfx, selfy = self.x, self.y
    local dodgevelx, dodgevely, dodgefaceangle

    local function isComing(them)
        if Face.isObjectInSight(self, them, sightarc)
        and Body.isInTheirWay(self, them, time) then
            Face.faceObject(self, them)
            return them
        end
    end
    local function isThrownEnemyComing(them)
        if them.thrower
        and them.thrower.team == "players"
        and Face.isObjectInSight(self, them, sightarc)
        and Body.isInTheirWay(self, them, time) then
            Face.faceObject(self, them)
            return them
        end
    end
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
    local function isCloseEnoughToGrab(them)
        if them.health < 1 then return end

        local cx, cy, cz, cr, ch =
            them.x,them.y,them.z,
            them.bodyradius,them.bodyheight

        local radii = self.bodyradius + cr
        if math.distsq(self.x, self.y, cx, cy) <= radii*radii then
            if cz <= self.z + self.bodyheight and cz + ch >= self.z then
                return them
            end
        end
    end

    local function isInterceptable(them)
        if not Face.isObjectInSight(self, them, sightarc) then return end
        if them.z + them.bodyheight < self.z
        or self.z + self.bodyheight < them.z then return end
        local theirvelx, theirvely = them.velx, them.vely
        if theirvelx == 0 and theirvely == 0 then return end
        local theirx, theiry = them.x, them.y
        local theirdist = math.dist(selfx, selfy, theirx, theiry)
        local theirspeed = math.len(theirvelx, theirvely)
        if math.dot(theirvelx, theirvely, selfx - theirx, selfy - theiry)
        < theirdist*theirspeed*.5 then
            return
        end
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

    local whotocatch = Characters.search("players", isApproachingAnEnemy)
        or Characters.search("projectiles", isApproachingAnEnemy)
        or Characters.search("enemies", isThrownEnemyApproachingAnEnemy)
        or Characters.search("container", isThrownEnemyApproachingAnEnemy)
    if whotocatch then
        if dodgevelx and dodgevely then
            self.velx, self.vely = dodgevelx, dodgevely
        end
        if dodgefaceangle then
            Face.faceAngle(self, dodgefaceangle)
        end
        return "catchReady"
    end
    local whattograb = Characters.search("container", isCloseEnoughToGrab)
    if whattograb then return "grab", whattograb end
end

function MuscleBandit:decideNextAttack()
    if self.weaponinhand then
        return "throwBackProjectile"
    end
    return Enemy.decideNextAttack(self)
end

function MuscleBandit:duringPrepareAttack(target)
    local dirx, diry = math.cos(self.faceangle), math.sin(self.faceangle)
    local projectiles = Characters.getGroup("projectiles")
    local caught = Catcher.findCharacterToCatch(self, projectiles, dirx, diry)
    if caught then
        caught:stopAttack() ; caught:unassignSelfAsAttacker()
        return "catchProjectile", caught
    end

    if self.attack.opponentstateonhit == "held" then
        local guardangle = DirectionalAnimation.SnapAngle(self.faceangle, self.animationdirections)
        Guard.startGuarding(self, guardangle)
    end
    Enemy.duringPrepareAttack(self, target)
end

function MuscleBandit:duringAttackSwing(target)
    if self.attack.opponentstateonhit == "held" then
        Guard.startGuarding(self, self.attackangle)
    else
        Guard.stopGuarding(self)
    end
end

return MuscleBandit