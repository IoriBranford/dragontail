local min = math.min
local max = math.max
local cos = math.cos
local sin = math.sin
local rad = math.rad
local sqrt = math.sqrt
local modf = math.modf

function math.round(x)
    local i, f = modf(x)
    if x < 0 then
        return f > -0.5 and i or i - 1
    end
    return f < 0.5 and i or i + 1
end

function math.clamp(x, a, b)
    return max(a, min(x, b))
end

function math.dot(x, y, x2, y2)
    return x2*x + y2*y
end
local dot = math.dot

function math.det(x, y, x2, y2)
    return x*y2 - y*x2
end
local det = math.det

function math.lensq(x, y)
    return x*x+y*y
end
local lensq = math.lensq

function math.distsq(x1, y1, x2, y2)
    local dx, dy = x2-x1, y2-y1
    return dx*dx + dy*dy
end

function math.dist(x1, y1, x2, y2)
    local dx, dy = x2-x1, y2-y1
    return sqrt(dx*dx + dy*dy)
end

function math.len(x, y)
    return sqrt(x*x + y*y)
end

function math.norm(x, y)
    local len = sqrt(x*x + y*y)
    return x/len, y/len
end

function math.mid(x1, y1, x2, y2)
    return x1 + (x2 - x1)/2, y1 + (y2 - y1)/2
end

function math.rot(x, y, a)
    local cosa, sina = cos(a), sin(a)
    return x*cosa - y*sina, y*cosa + x*sina
end

function math.rot90(x, y, dir)
    if dir < 0 then
        return y, -x
    end
    return -y, x
end

function math.testrects(ax, ay, aw, ah, bx, by, bw, bh)
    if ax + aw < bx then return false end
    if bx + bw < ax then return false end
    if ay + ah < by then return false end
    if by + bh < ay then return false end
    return true
end

function math.rectintersection(ax, ay, aw, ah, bx, by, bw, bh)
    local ax2 = ax + aw
    if ax2 < bx then return end
    local bx2 = bx + bw
    if bx2 < ax then return end
    local ay2 = ay + ah
    if ay2 < by then return end
    local by2 = by + bh
    if by2 < ay then return end
    local ix = max(ax, ay)
    local iy = max(ay, by)
    local ix2 = min(ax2, bx2)
    local iy2 = min(ay2, by2)
    return ix, iy, ix2-ix, iy2-iy
end

function math.testcircles(ax, ay, ar, bx, by, br)
    local dx, dy = ax - bx, ay - by
    local distsq = lensq(dx, dy)
    local radii = ar + br
    local radiisq = radii * radii
    return distsq <= radiisq and distsq
end

---Barycentric coordinates of point p in triangle abc
---@return number? a how much is p outside edge bc; 1 = on the edge
---@return number? b how much is p outside edge ac; 1 = on the edge
---@return number? c how much is p outside edge ab; 1 = on the edge
function math.bary(px, py, ax, ay, bx, by, cx, cy)
    local acx, acy = cx - ax, cy - ay
    local abx, aby = bx - ax, by - ay
    local apx, apy = px - ax, py - ay

    local div = det(abx, aby, acx, acy)
    if div == 0 then
        return
    end

    local b = det(apx, apy, acx, acy) / div
    local c = det(abx, aby, apx, apy) / div
    return 1-b-c, b, c
end

function math.frombary(a, b, c, ax, ay, bx, by, cx, cy)
    local x = a*ax + b*bx + c*cx
    local y = a*ay + b*by + c*cy
    return x, y
end

---@param points number[] Every 2 elements is 1 point
---@param x number
---@param y number
function math.pointinpolygon(points, x, y)
    local inside = false
    local x1, y1 = points[#points-1], points[#points]
    for i = 2, #points, 2 do
        local x2, y2 = points[i-1], points[i]
        if y > min(y1, y2) then
            if y <= max(y1, y2) then
                if x <= max(x1, x2) then
                    local hitx = (y - y1) * (x2 - x1) / (y2 - y1) + x1;
                    if x1 == x2 or x <= hitx then
                        inside = not inside
                    end
                end
            end
        end
        x1, y1 = x2, y2
    end
    return inside
end

---Gets point on line segment from (ax, ay) to (bx, by) that is closest to point (px, py)
---@return number projx closest point on segment x
---@return number projy closest point on segment y
function math.projpointsegment(px, py, ax, ay, bx, by)
    local apx, apy = px-ax, py-ay
    local abx, aby = bx-ax, by-ay
    local t = dot(apx, apy, abx, aby)
    if t <= 0 then
        return ax, ay
    end
    local ablensq = lensq(abx, aby)
    if t >= ablensq then
        return bx, by
    end
    t = t / ablensq
    return ax + t*abx, ay + t*aby
end

function math.polysignedarea(points)
    local area = 0
    local x1, y1 = points[#points-1], points[#points]
    for i = 2, #points, 2 do
        local x2, y2 = points[i-1], points[i]
        area = area + det(x1, y1, x2, y2)
        x1, y1 = x2, y2
    end
    return area
end

function math.testpointtri(px, py, ax, ay, bx, by, cx, cy)
    local acx, acy = cx - ax, cy - ay
    local abx, aby = bx - ax, by - ay
    local apx, apy = px - ax, py - ay

    local area = det(abx, aby, acx, acy)
    local ac = det(apx, apy, acx, acy)
    local ab = det(abx, aby, apx, apy)
    if area < 0 then
        return ac <= 0 and ab <= 0 and ac + ab >= area
    end
    return ac >= 0 and ab >= 0 and ac + ab <= area
end

function math.testsegments(ax, ay, bx, by, cx, cy, dx, dy)
    if ax == cx and ay == cy or ax == dx and ay == dy then
        return ax, ay
    end
    if bx == cx and by == cy or bx == dx and by == dy then
        return bx, by
    end
    local abx = bx-ax
    local aby = by-ay
    local cdx = dx-cx
    local cdy = dy-cy
    local div = det(abx, aby, cdx, cdy)
    if div == 0 then
        return -- "coincide"
    end
    local cax, cay = ax-cx, ay-cy
    local s = det(abx, aby, cax, cay)/div
    local t = det(cdx, cdy, cax, cay)/div
    return s >= 0 and s <= 1 and t >= 0 and t <= 1
end

function math.intersectsegments(ax, ay, bx, by, cx, cy, dx, dy)
    if ax == cx and ay == cy or ax == dx and ay == dy then
        return ax, ay
    end
    if bx == cx and by == cy or bx == dx and by == dy then
        return bx, by
    end
    local abx = bx-ax
    local aby = by-ay
    local cdx = dx-cx
    local cdy = dy-cy
    local div = det(abx, aby, cdx, cdy)
    if div == 0 then
        return -- "coincide"
    end
    local cax, cay = ax-cx, ay-cy
    local s = det(abx, aby, cax, cay)/div
    local t = det(cdx, cdy, cax, cay)/div
    if s >= 0 and s <= 1 and t >= 0 and t <= 1 then
        local x = ax + abx*t
        local y = ay + aby*t
        return x, y
    end
end

-- DEBUG
-- print(math.intersectsegments(2,1,4,5,1,4,5,2)) -- should be 3,3

function math.intersectlines(ax, ay, bx, by, cx, cy, dx, dy)
    local bax = ax-bx
    local bay = ay-by
    local dcx = cx-dx
    local dcy = cy-dy
    local div = det(bax, dcx, bay, dcy)
    if div == 0 then
        return
    end
    local cax, cay = ax-cx, ay-cy
    local t = det(cax, dcx, cay, dcy) / div
    local x = ax - t*bax
    local y = ay - t*bay
    return x, y
end

function math.table_rad(t, k)
    local x = t[k]
    if type(x) == "number" then
        t[k] = rad(x)
    end
end