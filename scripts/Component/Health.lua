local Units = require "System.Units"
local Audio = require "System.Audio"
local Team   = require "Component.Team"
local Height  = require "Dragontail.Height"
local Prefabs  = require "Data.Prefabs"

local Health = {}

local function calcHitDamage(unit, other)
	if not Team.areEnemies(other, unit) then
		return 0
	end
	-- print(unit.cover, other.ignorecover)

	local damagefromenemy = other.hitdamageenemy or 0
	local damageself = unit.hitdamageself or 0
	local damage = damagefromenemy + damageself

	local x1, y1 = unit.x, unit.y
	local x2, y2 = other.x, other.y
	local distx, disty = x2-x1, y2-y1
	local x, y = x1 + distx/4, y1 + disty/4

	local hitspark = damage > 0 and unit.damagespark or unit.guardspark
	hitspark = Prefabs.get(hitspark)
	if hitspark then
		hitspark = Units.newUnit_position(hitspark, x, y, Height.Spark)
		hitspark.particledirection = math.atan2(disty, distx)
	end

	return damage
end

function Health.onCollision_damage(unit, other)
    if unit.health then
		local damage = calcHitDamage(unit, other)
	    unit.health = unit.health - damage
    end

	if not other.think then
		local health = other.health
		if health then
			local damage = calcHitDamage(other, unit)
			health = health - damage
			other.health = health
			if health < 1 then
				Units.remove(other)
			end
		end
	end
end


function Health.changeColor(unit, r, g, b)
    local health = unit.health
    if health and health < unit.starthealth/2 and unit.age % health == 0 then
		r = 1
        g = 0
        b = 0
    end
	return r, g, b
end

function Health.countAliveUnits(units)
	local n = 0
	for _, unit in pairs(units) do
		if unit.health >= 1 then
			n = n + 1
		end
	end
	return n
end

return Health