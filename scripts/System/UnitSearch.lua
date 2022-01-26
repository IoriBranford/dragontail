local Physics = require "System.Physics"
local Units   = require "System.Units"

local UnitSearch = {}

local searchresults = {}
setmetatable(searchresults, { __mode="v"})

function UnitSearch.searchRect(x, y, w, h, cond)
    local found
    Physics.rectCast(x, y, w, h, function(otherfixture)
        local otherid = otherfixture:getBody():getUserData()
        local other = Units.get(otherid)
        if other and cond(other) then
            found = other
            return false
        end
        return true
    end)
    return found
end

function UnitSearch.searchRectMultiple(x, y, w, h, cond, limit)
    local i = 0
    Physics.rectCast(x, y, w, h, function(otherfixture)
        local otherid = otherfixture:getBody():getUserData()
        local other = Units.get(otherid)
        if other and cond(other) then
            i = i + 1
            searchresults[i] = other
        end
        return i < limit
    end)
    for j = #searchresults, i+1, -1 do
        searchresults[j] = nil
    end
    return searchresults
end

return UnitSearch