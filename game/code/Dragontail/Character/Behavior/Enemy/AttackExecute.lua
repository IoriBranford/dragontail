local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Body     = require "Dragontail.Character.Component.Body"
local Slide    = require "Dragontail.Character.Action.Slide"
local Color    = require "Tiled.Color"
local Face     = require "Dragontail.Character.Component.Face"

---@class AttackExecute:Behavior
---@field character Enemy
local AttackExecute = pooledclass(Behavior)
AttackExecute._nrec = Behavior._nrec + 3

function AttackExecute:start()
    local enemy = self.character
    enemy.numopponentshit = 0

    local target = enemy.opponents[1]

    local projectiletype = enemy.weaponinhand or enemy.attack.projectiletype
    if projectiletype then
        -- TODO if target in view then
        Shoot.launchProjectileAtObject(enemy, projectiletype, target)
        -- TODO else shoot at current faceangle
        if projectiletype == enemy.weaponinhand then
            enemy.weaponinhand = nil
        end
    else
        local attackangle = math.floor((enemy.faceangle + (math.pi/4)) / (math.pi/2)) * math.pi/2
        enemy:startAttack(attackangle)
    end

    local hittime = enemy.attack.hittingduration or 1
    enemy.statetime = enemy.statetime or hittime
    self.hitendtime = enemy.statetime - hittime

    Slide.updateSlideSpeed(enemy, enemy.faceangle, enemy.speed or 0)
end

function AttackExecute:fixedupdate()
    local enemy = self.character
    local target = enemy.opponents[1]

    local faceangle = enemy.faceangle
    if (enemy.faceturnspeed or 0) ~= 0 then
        faceangle = Face.turnTowardsObject(enemy, target, nil,
            enemy.state.animation, enemy.animationframe)

        local attackangle = math.floor((faceangle + (math.pi/4)) / (math.pi/2)) * math.pi/2
        enemy:startAttack(attackangle)
    end

    local moveturnspeed = enemy.moveturnspeed or 0
    if moveturnspeed ~= 0 then
        local velx, vely = enemy.velx, enemy.vely
        local detFV = math.det(velx, vely, math.cos(faceangle), math.sin(faceangle))
        if detFV ~= 0 then
            local sindangle = detFV / math.len(velx, vely)
            local rotation = math.asin(sindangle)
            rotation = math.max(-moveturnspeed, math.min(rotation, moveturnspeed))
            enemy.velx, enemy.vely = math.rot(velx, vely, rotation)
        end
    end
    enemy:decelerateXYto0()

    if enemy.statetime <= self.hitendtime then
        enemy:resetFlash()
        enemy:stopAttack()
    else
        enemy:updateFlash(enemy.statetime)
        enemy:makePeriodicAfterImage(enemy.statetime, enemy.afterimageinterval)
    end

    local state, a, b, c, d, e, f = enemy:duringAttackSwing(target)
    if state then
        return state, a, b, c, d, e, f
    end
end

function AttackExecute:interrupt(...)
    local enemy = self.character
    enemy:resetFlash()
    enemy:stopAttack()
    return ...
end

function AttackExecute:timeout(...)
    local enemy = self.character
    enemy:resetFlash()
    enemy:stopAttack()
    return ...
end

return AttackExecute