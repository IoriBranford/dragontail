---@class Canvas
---@field shader love.Shader?
local Canvas = class()

function Canvas:_init(width, height, inputscale)
    inputscale = inputscale or 1
    width, height = math.floor(width*inputscale), math.floor(height*inputscale)
    self.canvas = love.graphics.newCanvas(width, height)
    self.rotscale = love.math.newTransform()
    self.transform = love.math.newTransform()
    self.inputscale = inputscale
end

function Canvas.GetOutputScaleFactor(canvaswidth, canvasheight, screenwidth, screenheight, rotation, integerscale)
    local ghw = screenwidth / 2
    local ghh = screenheight / 2
    local chw = canvaswidth / 2
    local chh = canvasheight / 2

    local outputscale
    if math.abs(math.sin(rotation)) > math.sqrt(2)/2 then
        outputscale = math.min(ghh / chw, ghw / chh)
    else
        outputscale = math.min(ghw / chw, ghh / chh)
    end

    if integerscale and outputscale >= 1 then
        outputscale = math.floor(outputscale)
    end
    return outputscale
end

function Canvas:transformToScreen(screenwidth, screenheight, rotation, integerscale)
    local canvas = self.canvas
    local ghw = screenwidth / 2
    local ghh = screenheight / 2
    local chw = canvas:getWidth() / 2
    local chh = canvas:getHeight() / 2

    local outputscale = Canvas.GetOutputScaleFactor(canvas:getWidth(), canvas:getHeight(), screenwidth, screenheight, rotation, integerscale)

    local rotscale = love.math.newTransform()
    rotscale:rotate(rotation)
    rotscale:scale(outputscale)
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
    love.graphics.push()
    love.graphics.scale(self.inputscale)
    draw()
    love.graphics.pop()
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
    love.graphics.setShader(self.shader)
    love.graphics.draw(self.canvas, self.transform)
end

function Canvas:inverseTransformVector(vecx, vecy)
    local inputscale = self.inputscale
    vecx, vecy = self.rotscale:inverseTransformPoint(vecx, vecy)
    vecx, vecy = vecx/inputscale, vecy/inputscale
    return vecx, vecy
end

function Canvas:inverseTransformPoint(x, y)
    local inputscale = self.inputscale
    x, y = self.transform:inverseTransformPoint(x, y)
    x, y = x/inputscale, y/inputscale
    return x, y
end

function Canvas:transformVector(vecx, vecy)
    local inputscale = self.inputscale
    vecx, vecy = vecx*inputscale, vecy*inputscale
    vecx, vecy = self.rotscale:transformPoint(vecx, vecy)
    return vecx, vecy
end

function Canvas:transformPoint(x, y)
    local inputscale = self.inputscale
    x, y = x*inputscale, y*inputscale
    x, y = self.transform:transformPoint(x, y)
    return x, y
end

return Canvas