local Team = {}

local Units = require "System.Units"

function Team.start(unit, defaultteam, defaultenemyteams)
    unit.team = unit.team or defaultteam
    unit.enemyteams = unit.enemyteams or defaultenemyteams
    if unit.team == "opponent" then
        unit.team = Team.getOpposingTeam(unit.team)
    end
end

function Team.getOpposingTeam(team)
    if team == "PlayerTeam" then
        return "EnemyTeam"
    elseif team == "EnemyTeam" then
        return "PlayerTeam"
    end
end

function Team.isEnemyOf(unit, other)
    local unitteam = unit.team
    local otherenemies = other.enemyteams
    return unitteam and otherenemies and
        string.find(otherenemies, unitteam)
end

function Team.areEnemies(a, b)
    local teamA, teamB = a.team, b.team
    local enemyA, enemyB = a.enemyteams, b.enemyteams
    return teamA and enemyB and teamB and enemyA
        and string.find(enemyB, teamA) and string.find(enemyA, teamB)
end

function Team.findAnyOnCamera(team)
    local found
    local camera = Units.get("camera")
    camera:rectCast(function(otherfixture)
        local otherid = otherfixture:getBody():getUserData()
        local other = Units.get(otherid)
        if other and other.team == team then
            found = other
            return false
        end
        return true
    end)
    return found
end

function Team.findNearestOnCamera(team, x, y)
    local nearest
    local nearestdsq = math.huge
    local camera = Units.get("camera")
    camera:rectCast(function(otherfixture)
        local otherid = otherfixture:getBody():getUserData()
        local other = Units.get(otherid)
        if other and other.team == team then
            local dsq = math.lensq(other.x - x, other.y - y)
            if dsq < nearestdsq then
                nearest = other
                nearestdsq = dsq
            end
        end
        return true
    end)
    return nearest
end

return Team