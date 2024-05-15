local Graphics = {}

local _transform = love.math.newTransform()

local colorstack = {}
local red, green, blue, alpha = 1, 1, 1, 1

function Graphics.pushTransform(element, excludeflags)
    local x, y, r, sx, sy, ox, oy, kx, ky =
        element.x, element.y,
        element.rotation or 0,
        element.scalex or 1, element.scaley or 1,
        element.originx or 0, element.originy or 0,
        element.skewx or 0, element.skewy or 0
    if excludeflags then
        if bit.band(excludeflags, 1) then x = 0 end
        if bit.band(excludeflags, 2) then y = 0 end
        if bit.band(excludeflags, 4) then r = 0 end
        if bit.band(excludeflags, 8) then sx = 1 end
        if bit.band(excludeflags, 16) then sy = 1 end
        if bit.band(excludeflags, 32) then ox = 0 end
        if bit.band(excludeflags, 64) then oy = 0 end
        if bit.band(excludeflags, 128) then kx = 0 end
        if bit.band(excludeflags, 256) then ky = 0 end
    end
    love.graphics.push()
    _transform:setTransformation(x, y, r, sx, sy, ox, oy, kx, ky)
    love.graphics.applyTransform(_transform)
end

function Graphics.pushColor(r, g, b, a)
    colorstack[#colorstack+1] = r
    colorstack[#colorstack+1] = g
    colorstack[#colorstack+1] = b
    colorstack[#colorstack+1] = a
    red = red * r
    green = green * g
    blue = blue * b
    alpha = alpha * a
    love.graphics.setColor(red, green, blue, alpha)
end

function Graphics.popColor()
    for i = #colorstack, #colorstack - 3, -1 do
        colorstack[i] = nil
    end
    red, green, blue, alpha = 1, 1, 1, 1
    for i = 4, #colorstack, 4 do
        red = red * colorstack[i-3]
        green = green * colorstack[i-2]
        blue = blue * colorstack[i-1]
        alpha = alpha * colorstack[i]
    end
    love.graphics.setColor(red, green, blue, alpha)
end

return Graphics