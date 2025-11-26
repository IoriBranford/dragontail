local Behavior = require "Dragontail.Character.Behavior"
local Characters = require "Dragontail.Stage.Characters"
local Character  = require "Dragontail.Character"
local Downed = pooledclass(Behavior)

function Downed:start()
    local fighter = self.character
    local spark = Character("spark-fall-down-dust",
        fighter.x, fighter.y + 1, fighter.z)
    Characters.spawn(spark)
end

function Downed:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
end

function Downed:timeout(...)
    local fighter = self.character
    fighter.velx, fighter.vely, fighter.velz = 0, 0, 0
    if fighter.health <= 0 then
        return fighter.defeatai or "defeat"
    end
    return ...
end

return Downed
