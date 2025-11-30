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
    self.trajectory = enemy.attack.projectiletype and {
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
        Shoot.calculateTrajectoryTowardsTarget(enemy, enemy.attack.projectiletype,
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
    if self.trajectory then
        for _, dot in ipairs(self.trajectory.dots) do
            dot:disappear()
        end
    end
    return ...
end

function AttackPrepare:timeout(...)
    return self:interrupt(...)
end

return AttackPrepare