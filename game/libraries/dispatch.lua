local setmt = setmetatable

---@class listeners
---@field [integer] table<string,function>
---@field free table<integer,true>

---@class dispatch
---@field [string] listeners
local dispatch = {}

function dispatch.new()
    return setmt({}, dispatch)
end

function dispatch:addEvent(ev)
    local lsts = self[ev] or {free = {}}
    self[ev] = lsts
    return lsts
end

function dispatch:sub(ev, l)
    local lsts = self:addEvent(ev)
    local free = lsts.free
    local i = free and free[#free] or (#lsts+1)
    free[#free] = nil
    lsts[i] = l
    return i
end

function dispatch:unsub(ev, i)
    local lsts = self[ev]
    if lsts then
        local free = lsts.free or {}
        lsts.free = free
        free[#free+1] = i
    end
end

function dispatch:sortSubs(ev, comp)
    local lsts = self[ev]
    if lsts then table.sort(lsts, comp) end
end

local function event(lsts, ev, i1, i2, di, ...)
    for i = i1, i2, di do
        lsts[i][ev](...)
    end
end

function dispatch:eventUp(ev, ...)
    local lsts = self[ev]
    if lsts then
        event(lsts, ev, 1, #lsts, 1, ...)
    end
end

function dispatch:eventDown(ev, ...)
    local lsts = self[ev]
    if lsts then
        event(lsts, ev, #lsts, 1, -1, ...)
    end
end

local function eventMut(lsts, ev, i1, i2, di, a, b, c, d, e, f)
    for i = i1, i2, di do
        local u, v, w, x, y, z
            = lsts[i][ev](a, b, c, d, e, f)
        if u ~= nil then a = u end
        if v ~= nil then b = v end
        if w ~= nil then c = w end
        if x ~= nil then d = x end
        if y ~= nil then e = y end
        if z ~= nil then f = z end
    end
    return a, b, c, d, e, f
end


function dispatch:eventUpMut(ev, a, b, c, d, e, f)
    local lsts = self[ev]
    if lsts then
        eventMut(lsts, ev, 1, #lsts, 1, a, b, c, d, e, f)
    end
end

function dispatch:eventDownMut(ev, a, b, c, d, e, f)
    local lsts = self[ev]
    if lsts then
        eventMut(lsts, ev, #lsts, 1, -1, a, b, c, d, e, f)
    end
end

local callbacks = {}

local function eventCB(lsts, ev, i1, i2, di, ...)
    if not lsts then return end
    local cbs = callbacks
    for i = i1, i2, di do
        cbs[#cbs+1] = lsts[i][ev]()
    end
    for i = #cbs, 1, -1 do
        local cb = cbs[i]
        cbs[#cbs] = nil
        cb()
    end
end

function dispatch:eventUpCB(ev, ...)
    local lsts = self[ev]
    if lsts then
        eventCB(lsts, ev, 1, #lsts, 1, ...)
    end
end

function dispatch:eventDownCB(ev, ...)
    local lsts = self[ev]
    if lsts then
        eventCB(self[ev], ev, #lsts, 1, -1, ...)
    end
end

return dispatch