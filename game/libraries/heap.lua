local ihash = require "ihash"

---@class heap<T>:ihash<T>
---@field cmp fun(a:T, b:T):boolean
local heap = {}

heap.__index = function(h, k)
    return heap[k] or ihash[k]
end

---@return heap
function heap.new(cmp)
    cmp = cmp or function(a, b) return a < b end
    return setmetatable({cmp = cmp}, heap)
end

local swap = ihash.swap

function heap:movefwd(v)
    local i = self[v]
    if not i then return end

    local cmp = self.cmp
    local fwdi = math.floor(i/2)
    while fwdi > 0 do
        local fwdv = self[fwdi]
        if cmp(fwdv, v) then
            break
        end
        swap(self, i, fwdi)
        i, fwdi = fwdi, math.floor(i/2)
    end
    return i
end

function heap:push(v)
    ihash.add(self, v)
    return self:movefwd(v)
end

function heap:moveback(v)
    local i = self[v]
    if not i then return end

    local cmp = self.cmp
    local last = math.floor(#self/2)
    while i <= last do
        local i1 = 2*i
        local i2 = i1+1
        local v1 = self[i1]
        local v2 = self[i2]
        if cmp(v, v1) then
            if not v2 or cmp(v, v2) then
                break
            else
                swap(self, i, i2)
                i = i2
            end
        elseif not v2 or cmp(v, v2) or cmp(v1, v2) then
            swap(self, i, i1)
            i = i2
        elseif v2 then
            swap(self, i, i2)
            i = i2
        end
    end
    return i
end

function heap:pop()
    local v = self[1]
    ihash.remove(self, v)
    self:moveback(self[1])
    return v
end

function heap:update(v)
    local i = self[v]
    if not i then return end

    local i2 = self:movefwd(v)
    if i2 ~= i then return i2 end
    return self:moveback(v)
end

function heap:remove(t)
    local _, t2 = ihash.remove(self, t)
    return self:update(t2)
end

return heap