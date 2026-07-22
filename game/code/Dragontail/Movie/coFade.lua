local Color = require "Tiled.Color"

local function setColor(obj, r, g, b, a)
    local color = Color.asARGBInt(r, g, b, a)
    obj.tintcolor = color
    obj.color = color
end

local function coFade(obj, c2, c1, t)
    t = math.max(1, t)

    local r1, g1, b1, a1 = Color.unpack(c1
        or obj.tintcolor or obj.color or Color.White)
    setColor(obj, r1, g1, b1, a1)

    local r2, g2, b2, a2 = Color.unpack(c2)
    for i = 1, t do
        coroutine.yield()
        local time = i/t
        setColor(obj,
            math1.lerp(time, r1, r2),
            math1.lerp(time, g1, g2),
            math1.lerp(time, b1, b2),
            math1.lerp(time, a1, a2))
    end
    return true
end

return coFade