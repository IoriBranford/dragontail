local Behavior = require "Dragontail.Character.Behavior"
local Characters = require "Dragontail.Stage.Characters"
local Downed = pooledclass(Behavior)

function Downed:start()
    local fighter = self.character
    Characters.spawn({
        type = "spark-fall-down-dust",
        x = fighter.x,
        y = fighter.y + 1,
        z = fighter.z,
    })
end

function Downed:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
end

function Downed:timeout(...)
    local fighter = self.character
    fighter.velx, fighter.vely, fighter.velz = 0, 0, 0
    if fighter.health <= 0 then
        return "defeat"
    end
    return ...
end

return Downed
