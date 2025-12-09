local AttackExecute = require "Dragontail.Character.Behavior.Enemy.AttackExecute"
local StateMachine  = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent  = require "Dragontail.Character.Component.HoldOpponent"

local ThrowOpponent = pooledclass(AttackExecute)

function ThrowOpponent:start(target)
    local enemy = self.character
    local held = enemy.heldopponent
    local angle = enemy.holdangle
    if held and angle then
        target = target or enemy.opponents[1]
        local tooppox, tooppoy = target.x - enemy.x, target.y - enemy.y
        local holdx, holdy = math.cos(angle), math.sin(angle)
        if math.dot(holdx, holdy, tooppox, tooppoy)
        >= math.len(tooppox, tooppoy) * math.cos(math.pi/3) then
            angle = math.atan2(tooppoy, tooppox)
        end
        HoldOpponent.stopHolding(enemy, held)
        StateMachine.start(held, "thrown", enemy, angle)
    end
    AttackExecute.start(self)
end

return ThrowOpponent