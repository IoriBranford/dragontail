local setmetatable = setmetatable

local function initObject(object, class, ...)
    setmetatable(object, class)
    local init = object._init
    if init then
        init(object, ...)
    end
    return object
end

local function createObject(class, ...)
    return initObject({}, class, ...)
end

---@param base table?
---@param init function?
local function createClass(base, init)
    local class = {
        _init = init
    }
    class.__index = class

    function class.cast(t)
        return setmetatable(t, class)
    end

    function class.castinit(t, ...)
        return initObject(t, class, ...)
    end

    if base then
        -- metamethods must be copied as they can't be inherited
        class.__lt = base.__lt
    end

    local classmt = {
        __call = createObject,
        __index = base
    }

    return setmetatable(class, classmt)
end

local function requireCastInit(object, requirestr, ...)
    requirestr = requirestr or ""
    if requirestr == "" then
        return
    end
    local ok, class = pcall(require, requirestr)
    if not ok then
        return nil, class
    end
    return class.castinit(object, ...)
end

return setmetatable({
    requirecastinit = requireCastInit
}, {
    __call = function(_, ...)
        return createClass(...)
    end
})