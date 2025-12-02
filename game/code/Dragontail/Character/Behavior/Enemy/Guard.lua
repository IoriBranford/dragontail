local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Guard                = require "Dragontail.Character.Component.Guard"

---@class EnemyGuard:Behavior
---@field character Enemy
local EnemyGuard = pooledclass(Behavior)

function EnemyGuard:start(...)
    local enemy = self.character
    enemy.velx, enemy.vely = 0, 0
end

function EnemyGuard:fixedupdate()
    local enemy = self.character
    local opponent = enemy.opponents[1]
    local faceangle = Face.turnTowardsObject(enemy, opponent, enemy.faceturnspeed,
        enemy.state.animation, enemy.animationframe, enemy.state.loopframe)
    local guardangle = DirectionalAnimation.SnapAngle(faceangle, enemy.animationdirections or 4)
    Guard.startGuarding(enemy, guardangle)

    local numguardedhitsuntilcounter = enemy.numguardedhitsuntilcounter
    if numguardedhitsuntilcounter then
        local numguardedhits = enemy.numguardedhits or 0
        numguardedhitsuntilcounter = numguardedhitsuntilcounter - numguardedhits
        local numguardedhitsuntilwarning = enemy.numguardedhitsuntilwarning or 1
        if numguardedhitsuntilcounter <= numguardedhitsuntilwarning then
            local statetime = enemy.statetime or math.floor(love.timer.getTime()*60)
            enemy:updateFlash(statetime)
        end
    end
end

function EnemyGuard:interrupt(nextstate, ...)
    local enemy = self.character
    Guard.stopGuarding(enemy)
    enemy:resetFlash()
    return nextstate, ...
end

function EnemyGuard:timeout(nextstate, ...)
    return self:interrupt(nextstate, ...)
end

return EnemyGuard