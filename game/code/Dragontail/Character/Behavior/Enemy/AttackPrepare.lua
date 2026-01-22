local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Component.Guard"
local Color    = require "Tiled.Color"
local Shoot    = require "Dragontail.Character.Component.Shoot"
local Characters = require "Dragontail.Stage.Characters"

---@class AttackPrepare:Behavior
---@field character Enemy
local AttackPrepare = pooledclass(Behavior)
AttackPrepare._nrec = Behavior._nrec + 1

function AttackPrepare:start()
    local enemy = self.character
    enemy.numopponentshit = 0
    self.trajectory = (enemy.weaponinhand or enemy.attack.projectiletype) and {
        dots = {}
    }
end

function AttackPrepare:fixedupdate()
    local enemy = self.character
    enemy:updateFlash(enemy.statetime)
    local target = enemy.opponents[1]
    local trajectory = self.trajectory
    if trajectory then
        local targetx, targety, targetz = Shoot.getTargetObjectPosition(enemy, target)
        local projectiletype = enemy.weaponinhand or enemy.attack.projectiletype
        Shoot.calculateTrajectoryTowardsTarget(enemy, projectiletype,
            targetx, targety, targetz, trajectory)

        local statetime = enemy.state.statetime or 1
        local timeleft = enemy.statetime or 0
        local scale = 1 + timeleft/statetime
        local alpha = math.max(0, math.min(1, 1 - timeleft/statetime))
        local color = Color.asARGBInt(1, .5, .5, alpha)
        Shoot.UpdateTrajectoryDots(trajectory.dots, trajectory, scale, color)
        for i = #trajectory, 1, -1 do
            trajectory[i] = nil
        end
    end

    local state, a, b, c, d, e, f = enemy:duringPrepareAttack(target)
    if state then
        return state, a, b, c, d, e, f
    end
end

function AttackPrepare:interrupt(...)
    local enemy = self.character
    enemy:resetFlash()
    local trajectory = self.trajectory
    if trajectory then
        for i = #trajectory, 1, -1 do
            trajectory[i] = nil
        end
        Shoot.UpdateTrajectoryDots(trajectory.dots, trajectory)
    end
    return ...
end

function AttackPrepare:timeout(...)
    return self:interrupt(...)
end

function AttackPrepare:drawTimerCircle(fixedfrac)
    local enemy = self.character
    local x = enemy.x + enemy.velx*fixedfrac
    local y = enemy.y + enemy.vely*fixedfrac
    local z = enemy.z + enemy.velz*fixedfrac
    love.graphics.circle("line", x, y - z - enemy.bodyheight/2, enemy.statetime or 1)
end

return AttackPrepare