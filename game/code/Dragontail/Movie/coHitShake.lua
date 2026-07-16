
---@param obj TiledObject|Layer
---@param d number direction
---@param a number amplitude
---@param f number frequency
local function coHitShake(obj, d, a, f, t)
    t = math.max(1, t)
    local x0, y0 = obj.x0, obj.y0
	local dx, dy = math2.frompolar(d)
    local da = a/t
    for i = 0, t-1 do
        coroutine.yield()
        local l = a * math.cos(i*f)
        a = math.max(0, a - da)
        obj.x = dx * l
        obj.y = dy * l
    end
    obj.x0, obj.y0 = x0, y0
    return true
end

return coHitShake