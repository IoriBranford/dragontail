---@alias Color string|integer|table "#aarrggbb" or "#rrggbb" or 0xAARRGGBB or [r, g, b, a]
local Color = {
    Red     = 0xffff0000,
    Green   = 0xff00ff00,
    Blue    = 0xff0000ff,
    Cyan    = 0xff00ffff,
    Magenta = 0xffff00ff,
    Yellow  = 0xffffff00,
    White   = 0xffffffff,
    Grey    = 0xff808080,
    Black   = 0xff000000,
}

local pi = math.pi
local floor = math.floor
local max, min = math.max, math.min
local tonumber = tonumber

function Color.normalize(r, g, b, a)
    if type(r) == "table" then
        g = r[2]
        b = r[3]
        a = r[4] or 255
        r = r[1]
    end
    r = r and (r / 256) or 1
    g = g and (g / 256) or 1
    b = b and (b / 256) or 1
    a = a and (a / 256) or 1
    return r, g, b, a
end
local normalize = Color.normalize

function Color.parseARGBString(color)
    local a, r, g, b = string.match(color, "(%x%x)(%x%x)(%x%x)(%x%x)")
    if not a then
        return 1, 1, 1, 1
    end
    r = tonumber(r, 16)
    g = tonumber(g, 16)
    b = tonumber(b, 16)
    a = tonumber(a, 16)
    return normalize(r,g,b,a)
end
local parseARGBString = Color.parseARGBString

function Color.parseARGBInt(color)
    local a = floor(color / 0x1000000)
    local r = floor(color / 0x10000  ) % 256
    local g = floor(color / 0x100    ) % 256
    local b = color % 256
    return normalize(r,g,b,a)
end
local parseARGBInt = Color.parseARGBInt

function Color.asARGBInt(r, g, b, a)
    a = a or 1
    local color = min(255, b*256)
    color = color + min(255, g*256)*0x100
    color = color + min(255, r*256)*0x10000
    color = color + min(255, a*256)*0x1000000
    return color
end

function Color.unpack(color)
    if type(color) == "string" then
        return parseARGBString(color)
    elseif type(color) == "number" then
        return parseARGBInt(color)
    elseif type(color) == "table" then
        return color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1
    end
    return 1, 1, 1, 1
end

function Color.fromHSV(h, s, v)
    local function f(n)
        local k = (n + h*3/pi) % 6
        return v - v*s*max(0, min(k, 4-k, 1))
    end
    return f(5), f(3), f(1)
end

return Color