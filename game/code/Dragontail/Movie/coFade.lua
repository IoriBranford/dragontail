local Color = require "Tiled.Color"

local function setColor(obj, a)
    local color = Color.asARGBInt(1, 1, 1, a)
    if obj.tintcolor then
        obj.tintcolor = color
    else
        obj.color = color
    end
    return a
end

local function coFade(obj, a2, a1, t)
    t = math.max(1, t)
    local a = a1
    if a then
        setColor(obj, a)
    else
        local _
        _, _, _, a = Color.unpack(obj.tintcolor
            or obj.color or Color.White)
    end
    local da = (a2 - a) / t
    for i = 1, t do
        coroutine.yield()
        a = setColor(a + da)
    end
    a = setColor(a2)
    return true
end

return coFade