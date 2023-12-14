---@class Canvas
local Canvas = class()

function Canvas:_init(width, height)
    self.canvas = love.graphics.newCanvas(width, height)
    self.rotscale = love.math.newTransform()
    self.transform = love.math.newTransform()
end

function Canvas.GetScaleFactor(canvaswidth, canvasheight, screenwidth, screenheight, rotation, integerscale)
    local ghw = screenwidth / 2
    local ghh = screenheight / 2
    local chw = canvaswidth / 2
    local chh = canvasheight / 2

    local canvasscale
    if math.abs(math.sin(rotation)) > math.sqrt(2)/2 then
        canvasscale = math.min(ghh / chw, ghw / chh)
    else
        canvasscale = math.min(ghw / chw, ghh / chh)
    end

    if integerscale then
        canvasscale = math.floor(canvasscale)
    end
    return canvasscale
end

function Canvas:transformToScreen(screenwidth, screenheight, rotation, integerscale)
    local canvas = self.canvas
    local ghw = screenwidth / 2
    local ghh = screenheight / 2
    local chw = canvas:getWidth() / 2
    local chh = canvas:getHeight() / 2

    local canvasscale = Canvas.GetScaleFactor(canvas:getWidth(), canvas:getHeight(), screenwidth, screenheight, rotation, integerscale)

    local rotscale = love.math.newTransform()
    rotscale:rotate(rotation)
    rotscale:scale(canvasscale)
    self.rotscale = rotscale

    local transform = love.math.newTransform()
    transform:translate(math.floor(ghw), math.floor(ghh))
    transform:apply(rotscale)
    transform:translate(-chw, -chh)
    self.transform = transform
end

function Canvas:setFiltered(filtered)
    local filter = filtered and "linear" or "nearest"
    self.canvas:setFilter(filter, filter)
end

function Canvas:drawOn(draw)
    local oldcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(self.canvas)
    draw()
    love.graphics.setCanvas(oldcanvas)
end

function Canvas:drawScaledTo(draw)
    love.graphics.push()
    love.graphics.applyTransform(self.transform)
    draw()
    love.graphics.pop()
end

function Canvas:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, self.transform)
end

function Canvas:inverseTransformVector(vecx, vecy)
    return self.rotscale:inverseTransformPoint(vecx, vecy)
end

function Canvas:inverseTransformPoint(x, y)
    return self.transform:inverseTransformPoint(x, y)
end

function Canvas:transformVector(vecx, vecy)
    return self.rotscale:transformPoint(vecx, vecy)
end

function Canvas:transformPoint(x, y)
    return self.transform:transformPoint(x, y)
end

return Canvas