local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Body     = require "Dragontail.Character.Component.Body"
local Slide    = require "Dragontail.Character.Action.Slide"
local Color    = require "Tiled.Color"

local AttackExecute = pooledclass(Behavior)
AttackExecute._nrec = Behavior._nrec + 3

function AttackExecute:start()
    local enemy = self.character
    enemy.numopponentshit = 0
    Guard.stopGuarding(enemy)

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

    self.lungespeed = enemy.attack.lungespeed or 0
    self.slideangle = enemy.faceangle
end

function AttackExecute:fixedupdate()
    local enemy = self.character

    self.lungespeed = Slide.updateSlideSpeed(enemy,
        self.slideangle, self.lungespeed,
        enemy.attack.lungedecel or 1)

    if enemy.statetime <= self.hitendtime then
        enemy.color = Color.White
        enemy:stopAttack()
    else
        enemy.color = enemy:getAttackFlashColor(enemy.statetime, enemy.canbeattacked)
        enemy:makePeriodicAfterImage(enemy.statetime, enemy.afterimageinterval)
    end

    local target = enemy.opponents[1]
    local state, a, b, c, d, e, f = enemy:duringAttackSwing(target)
    if state then
        return state, a, b, c, d, e, f
    end
end

function AttackExecute:interrupt(...)
    local enemy = self.character
    enemy.color = Color.White
    enemy:stopAttack()
    return ...
end

function AttackExecute:timeout(...)
    local enemy = self.character
    enemy.color = Color.White
    enemy:stopAttack()
    return ...
end

return AttackExecute