local huge = math.huge

---@generic T : {x: number, y: number}
---@param x number
---@param y number
---@param items T[]
---@return T closest, number closestdsq
return function(x, y, items)
    local closest
    local closestdsq = huge
    for i = 1, #items do
        local item = items[i]
        local ix, iy = item.x, item.y
        local dx, dy = x - ix, y - iy
        local dsq = dx*dx + dy*dy
        if dsq < closestdsq then
            closest = item
            closestdsq = dsq
        end
    end
    return closest, closestdsq
end