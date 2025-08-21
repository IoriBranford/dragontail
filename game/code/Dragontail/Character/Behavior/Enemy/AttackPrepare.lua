local Behavior = require "Dragontail.Character.Behavior"
local Guard    = require "Dragontail.Character.Action.Guard"
local Color    = require "Tiled.Color"

local AttackPrepare = pooledclass(Behavior)

function AttackPrepare:start()
    local enemy = self.character
    enemy.numopponentshit = 0
    Guard.stopGuarding(enemy)
end

function AttackPrepare:fixedupdate()
    local enemy = self.character
    enemy.color = enemy:getAttackFlashColor(enemy.statetime or 0, enemy.canbeattacked)

    local target = enemy.opponents[1]
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