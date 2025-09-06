local Downed = require "Dragontail.Character.Behavior.Fighter.Downed"
local Mana   = require "Dragontail.Character.Component.Mana"

local PlayerDowned = pooledclass(Downed)

function PlayerDowned:timeout(nextstate, a, b, c, d, e, f, g)
    nextstate, a, b, c, d, e, f, g =
        Downed.timeout(self, nextstate, a, b, c, d, e, f, g)
    local player = self.character
    if player.health <= 0 then
        local chargedattack, angle = player:getReversalChargedAttack()
        if chargedattack then
            player.health = 10
            Mana.releaseCharge(player)
            return chargedattack, angle
        end
    end
    return nextstate, a, b, c, d, e, f, g
end

return PlayerDowned