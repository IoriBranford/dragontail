local Face     = require "Dragontail.Character.Component.Face"
local Guard    = require "Dragontail.Character.Component.Guard"
local Behavior = require "Dragontail.Character.Behavior"

---@class EnemyGuardHit:Behavior
---@field character Enemy
local EnemyGuardHit = pooledclass(Behavior)

---@param hit AttackHit
function EnemyGuardHit:start(hit)
    local enemy = self.character
    Guard.standardImpact(enemy, hit)
    local guardangle = assert(hit.guardangle)
    Guard.startGuarding(enemy, guardangle)

    local guardcounterstate = enemy.guardcounterstate
    local numguardedhitsuntilcounter = enemy.numguardedhitsuntilcounter
    if guardcounterstate and numguardedhitsuntilcounter then
        enemy.numguardedhits = (enemy.numguardedhits or 0) + 1
    end
    self.attacker = hit.attacker
end

function EnemyGuardHit:fixedupdate()
    local enemy = self.character
    local guardcounterstate = enemy.guardcounterstate
    local numguardedhitsuntilcounter = enemy.numguardedhitsuntilcounter
    if guardcounterstate and numguardedhitsuntilcounter then
        numguardedhitsuntilcounter = numguardedhitsuntilcounter - enemy.numguardedhits
        if numguardedhitsuntilcounter <= 0 then
            enemy.numguardedhits = nil
            Face.faceObject(enemy, self.attacker)
            return guardcounterstate
        end
        local numguardedhitsuntilwarning = enemy.numguardedhitsuntilwarning or 1
        if numguardedhitsuntilcounter <= numguardedhitsuntilwarning then
            enemy:updateFlash(enemy.statetime)
        end
    end
end

function EnemyGuardHit:interrupt(nextstate, ...)
    local enemy = self.character
    enemy:resetFlash()
    return nextstate, ...
end

function EnemyGuardHit:timeout(nextstate, ...)
    return self:interrupt(nextstate, ...)
end

return EnemyGuardHit