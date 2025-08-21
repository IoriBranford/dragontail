local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Color    = require "Tiled.Color"
local Shoot    = require "Dragontail.Character.Action.Shoot"
local Characters = require "Dragontail.Stage.Characters"

---@class AttackPrepare:Behavior
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
        for i = 3, #trajectory, 3 do
            local point = {
                x = trajectory[i-2],
                y = trajectory[i-1],
                z = trajectory[i],
                type = "projectile-path-point"
            }
            Characters.spawn(point)
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