local Aim = {}

local Team = require "Component.Team"
local Movement = require "Object.Movement"

function Aim.atVector(unit, vx, vy)
    if vx ~= 0 or vy ~= 0 then
        unit.aimx, unit.aimy = math.norm(vx, vy)
    end
end

function Aim.atAngle(unit, angle)
    unit.aimx, unit.aimy = math.cos(angle), math.sin(angle)
end

function Aim.atTarget(unit, target)
    Aim.atVector(unit, target.x - unit.x, target.y - unit.y)
end

function Aim.turnTowardsVector(unit, vx, vy)
    if vx == 0 and vy == 0 then
        return
    end
    local aimx, aimy = unit.aimx, unit.aimy
    if not aimx or not aimy then
        Aim.atVector(unit, vx, vy)
        return
    end

    local dist = math.len(vx, vy)
    local det = math.det(aimx, aimy, vx, vy)
    local totargetangle = math.asin(det/dist)

    local aimturnspeed = unit.aimturnspeed or (math.pi/60)
    if totargetangle < 0 then
        aimturnspeed = -aimturnspeed
    end
    local aimangle = math.atan2(aimy, aimx)
    local targetangle = aimangle + totargetangle
    local newangle = Movement.moveTowards(aimangle, targetangle, aimturnspeed)
    Aim.atAngle(unit, newangle)
end

function Aim.turnTowardsAngle(unit, angle)
    Aim.turnTowardsVector(unit, math.cos(angle), math.sin(angle))
end

function Aim.turnTowardsTarget(unit, target)
    Aim.turnTowardsVector(unit, target.x - unit.x, target.y - unit.y)
end

function Aim.atAnyOnTeam(unit, team)
    local target = Team.findAnyOnCamera(team)
    if target then
        Aim.atTarget(unit, target)
    end
    return target
end

return Aim