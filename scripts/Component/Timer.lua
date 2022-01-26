local Timer = {}

function Timer.start(unit, timername, defaulttime)
	local time = unit[timername]
	if time == "animation" then
		local tile = unit.tile
		local animation = tile and tile.animation
		time = animation and animation.duration
	end
	time = time or defaulttime or 60
	-- time = math.floor(time)
	unit[timername] = time
end

function Timer.think(unit, timername, starttime)
	local time = unit[timername] or starttime
	time = time - 1
	unit[timername] = time
	return time
end

return Timer