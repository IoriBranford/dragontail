local Count = {}

function Count.inc(unit, key, inc)
    local count = (unit[key] or 0) + (inc or 1)
    unit[key] = count
    return count
end

return Count