local TakingHit    = require "Dragontail.Character.Behavior.Fighter.TakingHit"

---@class EnemyGetHit:TakingHit
---@field character Enemy
local EnemyGetHit = pooledclass(TakingHit)

function EnemyGetHit:start(hit)
    local enemy = self.character
    if enemy.escapeafterhits then
        enemy.hitsuntilescape = (enemy.hitsuntilescape or enemy.escapeafterhits) - 1
    end
    if enemy.escapeafterdamage then
        enemy.damageuntilescape = math.max(0, (enemy.damageuntilescape or enemy.escapeafterdamage) - hit.attack.damage)
    end
    TakingHit.start(self, hit)
end

function EnemyGetHit:timeout(nextstate, ...)
    local enemy = self.character
    local escapestate

    if enemy.hitsuntilescape == 0 then
        enemy.hitsuntilescape = nil
        escapestate = enemy.escapestate
    end
    if enemy.damageuntilescape == 0 then
        enemy.damageuntilescape = nil
        escapestate = enemy.escapestate
    end
    if escapestate then
        return escapestate
    end

    return TakingHit.timeout(self, nextstate, ...)
end

return EnemyGetHit