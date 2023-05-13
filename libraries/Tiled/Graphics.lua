local Graphics = {}

local _transform = love.math.newTransform()

function Graphics.pushTransform(element)
    love.graphics.push()
    _transform:setTransformation(
        element.x, element.y,
        element.rotation or 0,
        element.scalex or 1, element.scaley or 1,
        element.originx or 0, element.originy or 0,
        element.skewx or 0, element.skewy or 0)
    love.graphics.applyTransform(_transform)
end

return Graphics