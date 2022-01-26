local Movement = require "Object.Movement"
local Path     = require "Object.Path"
local Jumping  = require "Component.Jumping"

local Pathing = {}

function Pathing.start(unit, path, direction)
	path = path or unit.path
	direction = direction or unit.pathdirection
	if type(path) ~= "table" then
		path, direction = Pathing.findPathAtPosition(unit, direction or 0)
	end
	direction = direction or 1
	unit.path = path
	unit.pathdirection = direction
	if path and direction then
		unit.pathindex = direction > 0 and 2 or direction < 0 and #path.points
	else
		unit.pathindex = nil
	end
end

local FoundPaths = {}
function Pathing.getAllPathsAtPosition(unit, direction)
	local paths = unit.layer.paths
	if not paths then
		return
	end
	for i = #FoundPaths, 1, -1 do
		FoundPaths[i] = nil
	end

	direction = direction or 0
	local x, y = unit.x, unit.y
	for id, path in pairs(paths) do
		local points = path.points
		local pathx, pathy = path.x, path.y
		if direction > -1 then
			local pointx, pointy = pathx + points[1], pathy + points[2]
			-- if x==pointx and y==pointy then
			if math.abs(x - pointx) < 1 and math.abs(y - pointy) < 1 then
				FoundPaths[#FoundPaths+1] = path
				FoundPaths[#FoundPaths+1] = 1
			end
		end
		if direction < 1 then
			local pointx, pointy = pathx + points[#points-1], pathy + points[#points]
			-- if x==pointx and y==pointy then
			if math.abs(x - pointx) < 1 and math.abs(y - pointy) < 1 then
				FoundPaths[#FoundPaths+1] = path
				FoundPaths[#FoundPaths+1] = -1
			end
		end
	end
	return FoundPaths
end

function Pathing.getRandomPathAtPosition(unit, direction)
	local paths = Pathing.getAllPathsAtPosition(unit, direction)
	if not paths then
		return
	end
	local random = love.math.random(#paths/2) * 2
	local path = paths[random-1]
	direction = paths[random]
	return path, direction
end

function Pathing.findPathAtPosition(unit, direction)
	direction = direction or 0
	local paths = unit.layer.paths
	if not paths then
		return
	end
	local x, y = unit.x, unit.y
	local nearestdir
	local nearestdsq = math.huge
	local nearest
	local function testIfNearest(path, p1, p2)
		local points = path.points
		local pointx, pointy = points[p1], points[p2]
		local pathx, pathy = path.x + pointx, path.y + pointy
		local dsq = math.lensq(pathx - x, pathy - y)
		if dsq < nearestdsq then
			nearestdsq = dsq
			nearest = path
			return true
		end
		return false
	end
	for id, path in pairs(paths) do
		if direction > -1 then
			if testIfNearest(path, 1, 2) then
				nearestdir = 1
			end
		end
		if direction < 1 then
			local points = path.points
			if testIfNearest(path, #points-1, #points) then
				nearestdir = -1
			end
		end
	end
	return nearest, nearestdir
end

function Pathing.isAtDestPoint(unit)
	local x, y = unit.x, unit.y
	local destx, desty = Path.getWorldPoint(unit.path, unit.pathindex)
	return destx and desty
		-- and x == destx
		-- and y == desty
		and math.abs(x - destx) < 1
		and math.abs(y - desty) < 1
end

function Pathing.advanceDestPoint(unit)
	unit.pathindex = Path.getNextIndex(unit.path, unit.pathindex, unit.pathdirection)
end

function Pathing.velocityToDestPoint(unit)
	local x, y = unit.x, unit.y
	local destx, desty = Path.getWorldPoint(unit.path, unit.pathindex)
	if destx and desty then
		return Movement.getVelocity_speed(x, y, destx, desty, unit.speed or 1)
	end
	return 0, 0
end

function Pathing.thinkVelocity(unit)
	unit.velx, unit.vely = Pathing.velocityToDestPoint(unit)
	return unit.velx, unit.vely
end

function Pathing.walkPath(unit)
	if Pathing.isAtDestPoint(unit) then
		Pathing.advanceDestPoint(unit)
		local jumppeak = unit.jumppeak
		if jumppeak then
			local destx, desty = Path.getWorldPoint(unit.path, unit.pathindex)
			if destx then
				Jumping.startJump(unit, jumppeak, destx, desty)
				unit.jumppeak = nil
			end
		end
	end

	Jumping.thinkJump(unit)

	local velx, vely = 0, 0
	local destx, desty = Path.getWorldPoint(unit.path, unit.pathindex)
	if destx and desty then
		local x, y = unit.x, unit.y + Jumping.getAltitude(unit)
		velx, vely = Movement.getVelocity_speed(x, y, destx, desty, unit.speed or 1)
		vely = vely - Jumping.getVelZ(unit)
	end

	unit.velx, unit.vely = velx, vely
end

function Pathing.isAtEnd(unit)
	local path = unit.path
	local index = unit.pathindex
	if not path or not index then
		return
	end
	local direction = unit.pathdirection or 1
	if direction < 0 then
		return index <= 2 and Pathing.isAtDestPoint(unit)
	end
	if direction > 0 then
		return index >= #path.points and Pathing.isAtDestPoint(unit)
	end
end

function Pathing.reverseDirection(unit)
	local pathindex = unit.pathindex
	if not pathindex then
		return
	end
	local pathdirection = unit.pathdirection or 1
	pathdirection = -pathdirection
	unit.pathdirection = pathdirection
	unit.pathindex = pathindex + 2*pathdirection
end

function Pathing.prepareJump(unit, peak)
	unit.jumppeak = peak
end

return Pathing