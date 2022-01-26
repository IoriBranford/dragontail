local Movement = require "Object.Movement"
local Jumping = {}

function Jumping.startJump(unit, jumppeak, destx, desty)
    local speedxy = unit.speed or 1
    unit.velz, unit.jumpgravity = Movement.getJumpStartVelAndAccelZ(unit.x, unit.y, destx, desty, jumppeak, speedxy)
    unit.groundz = unit.z
end

function Jumping.thinkJump(unit)
    local velz, g = unit.velz, unit.jumpgravity
	if velz and g then
		velz = velz + g
		unit.velz = velz
		unit.z = unit.z + velz
		if velz < 0 and unit.z <= unit.groundz then
			unit.z = unit.groundz
			unit.velz = nil
			unit.jumpgravity = nil
			unit.groundz = nil
		end
	end
end

function Jumping.getAltitude(unit)
    return unit.z - (unit.groundz or unit.z)
end

function Jumping.getVelZ(unit)
    return unit.velz or 0
end

return Jumping