---@class Path:TiledObject
---@field triggers PathTrigger[][]
local Path = class()

function Path:_init()
    self.x = self.x or 0
    self.y = self.y or 0
    self.points = self.points or {}
end

function Path:getWorldPoint(i)
    if not self or not i then
        return
    end
	local points = self.points
    if i < 2 then
        i = 2
    elseif i > #points then
        i = #points
    end
    local dx = points[i-1]
    local dy = points[i]
    return self.x + dx, self.y + dy
end

function Path:getNextIndex(i, di)
    if not i then return end

    di = di or 1
    i = i + 2*di
    if self then
        local points = self.points
        if self.shape == "polygon" then
            if i > #points then
                i = 2
            elseif i < 2 then
                i = #points
            end
        end
    end
    return i
end

---Precalc data for one-dimensional self progress
function Path:calcLengths()
    local startslengths = self.startslengths
    if startslengths then
        return
    end
    startslengths = {}
    local points = self.points
    local x, y = points[1], points[2]
    local totallength = 0;
    for i = 2, #points-2, 2 do
        local x2, y2 = points[i+1], points[i+2]
        local seglength = math.dist(x, y, x2, y2)
        startslengths[i-1] = totallength
        startslengths[i] = seglength
        x, y = x2, y2
        totallength = totallength+seglength
        print(i, totallength, seglength)
    end
    startslengths[#points-1] = totallength
    startslengths[#points] = 0
    self.startslengths = startslengths
    self.totallength = totallength
end

function Path:clampIndex(i)
    if i < 2 then
        return 2
    end
    if i > #self.points then
        return #self.points
    end
    return i
end

function Path:clampPosition1d(pos)
    if pos < 0 then
        return 0
    end
    if pos > self.totallength then
        return self.totallength
    end
    return pos
end

function Path:updatePosition1d(i, pos, speed)
    i = Path.clampIndex(self, i)
    pos = pos + speed
    pos = Path.clampPosition1d(self, pos)
    local points = self.points
    local startslengths = self.startslengths

    if speed > 0 then
        while i <= #points do
            local segstart = startslengths[i-1]
            local seglength = startslengths[i]
            if pos >= segstart + seglength then
                i = i + 2
            else
                break
            end
        end
    elseif speed < 0 then
        while i >= 2 do
            local segstart = startslengths[i-1]
            if pos <= segstart then
                i = i - 2
            else
                break
            end
        end
    end
    return i, pos
end

function Path:getPosition2d(i, pos)
    i = Path.clampIndex(self, i)
    pos = Path.clampPosition1d(self, pos)
    local points = self.points
    local startslengths = self.startslengths
    local segx1, segy1 = points[i-1], points[i]
    local segstart, seglength = startslengths[i-1], startslengths[i]
    if seglength <= 0 then
        return segx1, segy1
    end
    local segx2, segy2 = points[i+1] or segx1, points[i+2] or segy1
    local segdx, segdy = segx2 - segx1, segy2 - segy1
    local segpos = pos - segstart
    local dirx, diry = segdx / seglength, segdy / seglength
    return segx1 + segpos*dirx, segy1 + segpos*diry
end

function Path:getTotalLength()
    local points = self.points
    local len = 0
    for i = 4, #points, 2 do
        len = len + math.dist(points[i-3], points[i-2], points[i-1], points[i])
    end
    return len
end

function Path:getSegmentLengthSq(endi)
    if endi < 4 or endi > #self then
        return 0
    end
    return math.distsq(self[endi-3], self[endi-2], self[endi-1], self[endi])
end

function Path:getPathPointDistSq(i, x, y)
    local px, py = Path.getWorldPoint(self, i)
    return math.distsq(x, y, px, py)
end

function Path:addPointData(pointdata)
    local pointsdata = self.pointsdata
    local points = self.points
    local x, y = pointdata.x, pointdata.y
    local pathx, pathy = self.x, self.y
    for i = 2, #points, 2 do
        if pathx + points[i-1] == x and pathy + points[i] == y then
            if not pointsdata then
                pointsdata = {}
                self.pointsdata = pointsdata
                for i = 2, #points, 2 do
                    pointsdata[i-1] = 0
                    pointsdata[i] = false
                end
            end
            local numdatas = pointsdata[i-1] + 1
            pointsdata[i-1] = numdatas
            if numdatas == 1 then
                pointsdata[i] = pointdata
            elseif numdatas == 2 then
                pointsdata[i] = {pointsdata[i], pointdata}
            else
                pointsdata[i][#pointsdata[i]+1] = pointdata
            end
            return true
        end
    end
end

function Path:getPointData(i, j)
    local pointsdata = self.pointsdata
    if not pointsdata then
        return
    end
    local numdatas = pointsdata[i-1]
    if numdatas > 1 then
        return pointsdata[i][j]
    end
    return pointsdata[i]
end

function Path:addTrigger(trigger)
    local px, py = self.x, self.y
    local ppoints = self.points
    local ptriggers = self.triggers
    local tx, ty = trigger.x, trigger.y
    if trigger.shape == "point" then
        for i = 2, #ppoints, 2 do
            local ppx, ppy = px + ppoints[i-1], py + ppoints[i]
            if ppx == tx and ppy == ty then
                ptriggers = ptriggers or {}
                self.triggers = ptriggers
                local pointtriggers = ptriggers[i] or {}
                ptriggers[i-1] = pointtriggers
                ptriggers[i] = pointtriggers
                pointtriggers[#pointtriggers+1] = trigger
            end
        end
        return
    end
    local tpoints = trigger.points
    local px1, py1 = px + ppoints[1], py + ppoints[2]
    for i = 4, #ppoints, 2 do
        local px2, py2 = px + ppoints[i-1], py + ppoints[i]
        local tx1, ty1 = tx + tpoints[1], ty + tpoints[2]
        for j = 4, #tpoints, 2 do
            local tx2, ty2 = tx + tpoints[j-1], ty + tpoints[j]
            local ix, iy = math.intersectsegments(px1, py1, px2, py2, tx1, ty1, tx2, ty2)
            if ix then
                ptriggers = ptriggers or {}
                self.triggers = ptriggers
                local segtriggers = ptriggers[i] or {}
                ptriggers[i-1] = segtriggers
                ptriggers[i] = segtriggers
                segtriggers[#segtriggers+1] = trigger
                break
            end
            tx1, ty1 = tx2, ty2
        end
        px1, py1 = px2, py2
    end
end

function Path:hitTriggers(user, i, x, y, prevx, prevy)
    local ptriggers = self.triggers
    if not ptriggers then
        return
    end
    local segtriggers = ptriggers[i]
    if not segtriggers then
        return
    end
    for _, trigger in ipairs(segtriggers) do
        trigger:activateIfHit(user, x, y, prevx, prevy)
    end
end

function Path:draw()
    local points = self.points
    local x, y = self.x, self.y
    for i = 2, #points-2, 2 do
        local x1 = x + points[i-1]
        local y1 = y + points[i-0]
        local x2 = x + points[i+1]
        local y2 = y + points[i+2]
        love.graphics.line(x1, y1, x2, y2)
        love.graphics.rectangle("fill", x1-1.5, y1-1.5, 3, 3)
    end
    local lastx = x + points[#points-1]
    local lasty = y + points[#points-0]
    love.graphics.rectangle("fill", lastx-1.5, lasty-1.5, 3, 3)
end

return Path