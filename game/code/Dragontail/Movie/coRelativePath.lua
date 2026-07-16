
---@param path any
---@param obj any
local function coRelativePath(path, obj, speed)
    local pts = assert(path.points)
    local x, y, i = math2.walkpolyline(pts)
    local xn, yn = pts[#pts-1], pts[#pts]
    obj.x = obj.x + x - xn
    obj.y = obj.y + y - yn
    repeat
        print(obj.x, obj.y)
        coroutine.yield()
        local x2, y2
        x2, y2, i = math2.walkpolyline(pts, x, y, i, speed)
        obj.x = obj.x + x2 - x
        obj.y = obj.y + x2 - y
        x, y = x2, y2
    until x == xn and y == yn
end

return coRelativePath