local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Color    = require "Tiled.Color"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Characters = require "Dragontail.Stage.Characters"

---@class AttackPrepare:Behavior
---@field character Enemy
local AttackPrepare = pooledclass(Behavior)
AttackPrepare._nrec = Behavior._nrec + 1

function AttackPrepare:start()
    local enemy = self.character
    enemy.numopponentshit = 0
    Guard.stopGuarding(enemy)
    self.trajectory = enemy.attack.projectiletype and {}
end

function AttackPrepare:fixedupdate()
    local enemy = self.character
    enemy.color = enemy:getAttackFlashColor(enemy.statetime or 0, enemy.canbeattacked)

    local target = enemy.opponents[1]
    local trajectory = self.trajectory
    if trajectory then
        Shoot.calculateTrajectoryTowardsTarget(enemy, enemy.attack.projectiletype,
            target.x, target.y, target.z, trajectory)

        local statetime = enemy.state.statetime or 1
        local timeleft = enemy.statetime or 0
        local scale = 1 + timeleft/statetime
        local alpha = math.max(0, math.min(1, 1 - timeleft/statetime))
        for i = 3, #trajectory, 3 do
            local x = trajectory[i-2]
            local y = trajectory[i-1]
            local z = trajectory[i]
            local point = Characters.spawn {
                x = x,
                y = y,
                z = z,
                type = "ProjectilePathPoint",
                scalex = scale,
                scaley = scale,
            }
            local color = point.color or Color.Red
            local r,g,b = Color.unpack(color)
            point.color = Color.asARGBInt(r, g, b, alpha)
        end
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
    enemy.color = Color.White
    return ...
end

function AttackPrepare:timeout(...)
    local enemy = self.character
    enemy.color = Color.White
    return ...
end

return AttackPrepare