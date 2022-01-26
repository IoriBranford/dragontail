
local Heap = require "Data.Heap"
local Navigation = {}

local MaxSearch = 100
local blockgrid

function Navigation.setBlockGrid(grid)
    blockgrid = grid
end

local fscores = {}
local gscores = {}
local prevs = {}
local searchmap = {}
local searchheap = Heap.new(function(i1, i2)
    return fscores[i1] < fscores[i2]
end)

function Navigation.inBounds(x, y)
    return blockgrid:positionInBounds(x, y)
end

function Navigation.destChanged(destx, desty, destvelx, destvely)
    local c1, r1 = blockgrid:cellAt(destx, desty)
    local c2, r2 = blockgrid:cellAt(destx+destvelx, desty+destvely)
    return c1 ~= c2 or r1 ~= r2
end

function Navigation.search(x, y, destx, desty, destisblock)
    searchheap:clear()
    for k,v in pairs(fscores) do
        fscores[k] = nil
    end
    for k,v in pairs(gscores) do
        gscores[k] = nil
    end
    for k,v in pairs(prevs) do
        prevs[k] = nil
    end
    for k,v in pairs(searchmap) do
        searchmap[k] = nil
    end

    local t = love.timer.getTime()
    local destc, destr = blockgrid:cellAt(destx, desty)
    local startc, startr = blockgrid:cellAt(x, y)

    local gridwidth = blockgrid.width
    local gridheight = blockgrid.height
    local starti = blockgrid:toIndex(startc, startr)
    local desti = blockgrid:toIndex(destc, destr)
    if destisblock or blockgrid[desti] then
        for r = math.max(1, destr - 1), math.min(destr + 1, gridheight) do
            for c = math.max(destc - 1), math.min(destc + 1, gridwidth) do
                if not blockgrid:get(c, r) then
                    local i = blockgrid:toIndex(c, r)
                    fscores[i] = math.lensq(c - startc, r - startr)
                    searchheap:push(i)
                end
            end
        end
        if searchheap[1] then
            desti = searchheap[1]
            destc, destr = blockgrid:toCell(desti)
        end
        searchheap:clear()
        for k,v in pairs(fscores) do
            fscores[k] = nil
        end
    end

    if startc == destc and startr == destr then
        return
    end

    local function heuristic(i)
        local c, r = blockgrid:toCell(i)
        return math.lensq(destc - c, destr - r)
    end

    local bestdest
    local bestcost
    local function tryStep(i, j, d)
        if blockgrid[j] then
            return
        end
        local cost = gscores[i] + d
        if not gscores[j] or cost < gscores[j] then
            prevs[j] = i
            gscores[j] = cost
            local fscore = cost + heuristic(j)
            fscores[j] = fscore

            if not bestcost or fscore < bestcost then
                bestdest = j
                bestcost = fscore
            end

            if not searchmap[j] then
                searchheap:push(j)
                searchmap[j] = true
            end
        end
    end

    searchheap:push(starti)
    searchmap[starti] = true
    gscores[starti] = 0
    fscores[starti] = heuristic(starti)

    local i
    local numsearched = 0
    while #searchheap > 0 and numsearched < MaxSearch do
        numsearched = numsearched + 1
        i = searchheap:pop()
        searchmap[i] = nil

        if i == desti then
            bestdest = i
            break
        end

        local left = i - 1
        local right = i + 1
        local up = i - gridwidth
        local down = i + gridwidth

        local leftopen = i % gridwidth ~= 1
        local rightopen = i % gridwidth ~= 0
        local upopen = i > gridwidth
        local downopen = i <= gridwidth * (gridheight-1)

        if leftopen then
            tryStep(i, left, 1)

            if upopen and not blockgrid[left] and not blockgrid[up] then
                local leftup = left - gridwidth
                tryStep(i, leftup, 1.5)
            end
            if downopen and not blockgrid[left] and not blockgrid[down] then
                local leftdown = left + gridwidth
                tryStep(i, leftdown, 1.5)
            end
        end

        if rightopen then
            tryStep(i, right, 1)

            if upopen and not blockgrid[right] and not blockgrid[up] then
                local rightup = right - gridwidth
                tryStep(i, rightup, 1.5)
            end
            if downopen and not blockgrid[right] and not blockgrid[down] then
                local rightdown = right + gridwidth
                tryStep(i, rightdown, 1.5)
            end
        end

        if upopen then
            tryStep(i, up, 1)
        end

        if downopen then
            tryStep(i, down, 1)
        end
    end

    return blockgrid:toCell(bestdest)
    -- DEBUG
    -- print(string.format("Navigation searched %d squares and took %f secs", numsearched, love.timer.getTime() - t))
end

function Navigation.buildPath(destc, destr, path)
    local c, r = destc, destr
    path = path or {}
    path.x = 0
    path.y = 0
    local points = path.points or {}
    path.points = points
    for i = #points, 3, -1 do
        points[i] = nil
    end
    local x, y = blockgrid:cellCenter(c, r)
    points[1] = x
    points[2] = y

    local i = blockgrid:toIndex(c, r)
    while prevs[i] do
        c, r = blockgrid:toCell(i)
        x, y = blockgrid:cellCenter(c, r)
        points[#points+1] = x
        points[#points+1] = y
        i = prevs[i]
    end

    for i1 = 2, math.floor(#points/2), 2 do
        local i2 = #points - i1
        local x1, y1 = points[i1 - 1], points[i1]
        local x2, y2 = points[i2 + 1], points[i2 + 2]
        points[i1 - 1] = x2
        points[i1    ] = y2
        points[i2 + 1] = x1
        points[i2 + 2] = y1
    end

    return path
end

function Navigation.drawBlockGrid(x, y)
    if blockgrid then
        blockgrid:draw(x, y)
    end
end

return Navigation