local Enemy = require "Dragontail.Character.Enemy"

---@class <FTName>:Enemy
local <FTName> = class(Enemy)

function <FTName>:afterStand()
    return Enemy.afterStand(self)
end

function <FTName>:duringApproach(target)
    return Enemy.duringApproach(self, target)
end

function <FTName>:decideNextAttack()
    return Enemy.decideNextAttack(self)
end

function <FTName>:duringPrepareAttack(target)
    return Enemy.duringPrepareAttack(self, target)
end

function <FTName>:duringAttackSwing(target)
    return Enemy.duringAttackSwing(self, target)
end

function <FTName>:beforeGetUp(attacker)
    return Enemy.beforeGetUp(self, attacker)
end

function <FTName>:duringGetUp(attacker)
    return Enemy.duringGetUp(self, attacker)
end

return <FTName>