local yield = coroutine.yield
local function coDrift(obj, a, s, t)
    local dx, dy = math2.frompolar(a)
    local ds = s / t
    for _ = 1, t do
        yield()
        obj.x = obj.x + dx * s
        obj.y = obj.y + dy * s
        s = s - ds
    end
    return true
end

return coDrift
