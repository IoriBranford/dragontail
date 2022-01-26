local Movement = require "Object.Movement"
local Team     = require "Component.Team"
local Units    = require "System.Units"
local Pathing  = require "Component.Pathing"
local Navigation = require "Component.Navigation"
local Stage      = require "Dragontail.Stage"

local Follow = {}

function Follow.navigateToObject(unit, object, ox, oy)
    ox = ox or 0
    oy = oy or 0
    local x, y = unit.x, unit.y
    if Navigation.inBounds(x, y) and object then
        local destx, desty = object.x + ox, object.y + oy
        local destvelx, destvely = object.velx or 0, object.vely or 0
        if not unit.path
        or Navigation.destChanged(destx, desty, destvelx, destvely)
        or Pathing.isAtEnd(unit)
        then
            local destc, destr = Navigation.search(x, y, destx, desty, object.isblock)
            if destc then
                local path = Navigation.buildPath(destc, destr, unit.path)
                Pathing.start(unit, path, 1)
            end
        end
    elseif not unit.path then
        local speed = unit.speed or 1
        if x <= 0 then
            unit.velx, unit.vely = speed, 0
        elseif y <= 0 then
            unit.velx, unit.vely = 0, speed
        elseif x >= Stage.width then
            unit.velx, unit.vely = -speed, 0
        elseif y >= Stage.height then
            unit.velx, unit.vely = 0, -speed
        end
    end
    if unit.path then
        Pathing.walkPath(unit)
    end
end

function Follow.followObject(unit, object, ox, oy)
    ox = ox or 0
    oy = oy or 0
    if unit.followobjectnavigation then
        Follow.navigateToObject(unit, object, ox, oy)
    elseif object then
        unit.velx, unit.vely = Movement.getVelocity_speed(
            unit.x, unit.y, object.x + ox, object.y + oy, unit.speed or 1)
    end
end

function Follow.followPlayer(unit)
    local player = Units.get("player")
    if player then
        Follow.followObject(unit, player)
    end
end

function Follow.followAnyOnTeam(unit, team)
    -- if team == "opponent" then
    --     if unit.team == "PlayerTeam" then
    --         team = "EnemyTeam"
    --     elseif unit.team == "EnemyTeam" then
    --         team = "PlayerTeam"
    --     end
    -- end
    local object = Team.findAnyOnCamera(team)
    if object then
        Follow.followObject(unit, object)
    end
    return object
end

return Follow