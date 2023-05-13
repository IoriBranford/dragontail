---@class SceneObject
local SceneObject = class()

local t_sort = table.sort

local temptransform = love.math.newTransform()

function SceneObject.__lt(a, b)
    local az = a.z or 0
    local bz = b.z or 0
    if az < bz then
        return true
    end
    if az == bz then
        local ay = a.y or 0
        local by = b.y or 0
        if ay < by then
            return true
        end
        if ay == by then
            local ax = a.x or 0
            local bx = b.x or 0
            return ax < bx
        end
    end
end

function SceneObject:setVisible(visible)
    self.visible = visible
end

function SceneObject:setColor(red, green, blue, alpha)
    self.red = red
    self.green = green
    self.blue = blue
    if alpha then
        self.alpha = alpha
    end
end

function SceneObject:applyTransform()
    temptransform:setTransformation(
        (self.x),
        (self.y),
        self.rotation,
        self.scalex, self.scaley,
        self.originx, self.originy,
        self.skewx, self.skewy)
    love.graphics.applyTransform(temptransform)
end
local applyTransform = SceneObject.applyTransform

function SceneObject:drawLine()
    love.graphics.push()
    applyTransform(self)

    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    love.graphics.setLineWidth(self.linewidth or 1)
    love.graphics.line(self.drawable)

    love.graphics.pop()
end

function SceneObject:drawPolygon()
    love.graphics.push()
    applyTransform(self)

    local r,g,b,a = self.red, self.green, self.blue, self.alpha
    love.graphics.setColor(r,g,b,a)
    local triangles = self.drawable
    for i = 6, #triangles, 6 do
        love.graphics.polygon("fill",
            triangles[i-5], triangles[i-4],
            triangles[i-3], triangles[i-2],
            triangles[i-1], triangles[i-0])
    end

    r,g,b,a = self.linered, self.linegreen, self.lineblue, self.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.setLineWidth(self.linewidth or 1)
        love.graphics.polygon("line", self.points)
    end

    love.graphics.pop()
end

function SceneObject:drawRectangle()
    love.graphics.push()
    applyTransform(self)

    local r,g,b,a = self.red, self.green, self.blue, self.alpha
    love.graphics.setColor(r,g,b,a)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height, self.roundcorners or 0)

    r,g,b,a = self.linered, self.linegreen, self.lineblue, self.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.rectangle("line", 0, 0, self.width, self.height, self.roundcorners or 0)
    end

    love.graphics.pop()
end

function SceneObject:drawEllipse()
    love.graphics.push()
    applyTransform(self)

    local hw, hh = self.width/2, self.height/2

    local r,g,b,a = self.red, self.green, self.blue, self.alpha
    love.graphics.setColor(r,g,b,a)
    love.graphics.ellipse("fill", hw, hh, hw, hh)

    r,g,b,a = self.linered, self.linegreen, self.lineblue, self.linealpha
    if a then
        love.graphics.setColor(r,g,b,a)
        love.graphics.ellipse("line", hw, hh, hw, hh)
    end

    love.graphics.pop()
end

function SceneObject:drawQuad()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    love.graphics.draw(self.drawable, self.quad,
        (self.x),
        (self.y),
        self.rotation,
        self.scalex, self.scaley,
        self.originx, self.originy,
        self.skewx, self.skewy)
end

function SceneObject:drawText()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    local font = self.font or love.graphics.getFont()
    local str = self.text
    local x, y = self.x, self.y
    local w, h = self.width, self.height
    local _, lines = font:getWrap(str, w)
    local n = #lines
    local lineh = font:getHeight()
    local valign = self.valign
    if valign == "bottom" then
        y = y + h - lineh*n
    elseif valign == "center" then
        y = y + (h - lineh*n) / 2
    end
    for i = 1, n do
        love.graphics.printf(lines[i], font, x, y,
            self.width, self.halign,
            self.rotation,
            self.scalex, self.scaley,
            self.originx, self.originy,
            self.skewx, self.skewy)
        y = y + lineh
    end
end
local drawText = SceneObject.drawText

function SceneObject:drawGeneric()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    love.graphics.draw(self.drawable,
        (self.x),
        (self.y),
        self.rotation,
        self.scalex, self.scaley,
        self.originx, self.originy,
        self.skewx, self.skewy)
end
local drawGeneric = SceneObject.drawGeneric

function SceneObject:drawArray()
    if self.predraw then
        self:predraw()
    end
    for _, child in ipairs(self) do
        child:draw()
    end
    if self.postdraw then
        self:postdraw()
    end
end
local drawArray = SceneObject.drawArray

function SceneObject.newArray(array)
    local so = SceneObject(drawArray)
    for i = 1, #array do
        so[i] = array[i]
    end
    return so
end

function SceneObject:drawStencil()
    local stencil = self.stencil or function() end
    if type(stencil) == "table" then
        stencil = function ()
            drawArray(self)
        end
    end
    local action = self.stencilaction
    local value = self.stencilvalue
    local keepvalues = self.stencilkeepvalues
    love.graphics.stencil(stencil, action, value, keepvalues)
end
local drawStencil = SceneObject.drawStencil

function SceneObject.newStencil(stencil, action, value, keepvalues)
    local so = SceneObject(drawStencil)
    so.stencil = stencil
    so.stencilaction = action
    so.stencilvalue = value
    so.stencilkeepvalues = keepvalues
    return so
end

function SceneObject:drawClear3b()
    love.graphics.clear(self.clearcolor, self.clearstencil, self.cleardepth)
end
local drawClear3b = SceneObject.drawClear3b

function SceneObject.newClear3b(clearcolor, clearstencil, cleardepth)
    local so = SceneObject(drawClear3b)
    so.clearcolor = clearcolor
    so.clearstencil = clearstencil
    so.cleardepth = cleardepth
    return so
end

function SceneObject:updateGeneric(unit, fixedfrac)
    local vx, vy, vz = unit.velx or 0, unit.vely or 0, unit.velz or 0
    local av = unit.avel or 0
    local x, y, z = unit.x, unit.y, unit.z
    local r = unit.rotation or 0
    self.x = x + vx * fixedfrac
    self.y = y + vy * fixedfrac
    self.z = z + vz * fixedfrac
    self.rotation = r + av * fixedfrac
end
local updateGeneric = SceneObject.updateGeneric

function SceneObject:_init(draw, drawable, quad, w, h, x, y, z, r, sx, sy, ox, oy, kx, ky)
    self.draw = draw
    self.drawable = drawable
    if type(drawable) == "string" then
        self.text = drawable
    elseif drawable and drawable.type then
        self[drawable:type():lower()] = drawable
    end
    self.quad = quad
    self.width = w or math.huge
    self.height = h or math.huge
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
    self.rotation = r or 0
    self.scalex = sx or 1
    self.scaley = sy or sx or 1
    self.originx = ox or 0
    self.originy = oy or 0
    self.skewx = kx or 0
    self.skewy = ky or 0
    if self.visible ~= false then
        self.visible = true
    end
    self.red = self.red or 1
    self.green = self.green or 1
    self.blue = self.blue or 1
    self.alpha = self.alpha or 1
    self.updateFromUnit = updateGeneric
    return self
end

function SceneObject.newText(string, font, width, height, halign, valign, x, y, z, rotation, scalex, scaley, originx, originy, skewx, skewy)
    local text = SceneObject(drawText, string, nil, width, height, x, y, z, rotation, scalex, scaley, originx, originy, skewx, skewy)
    text.font = font
    text.halign = halign or "left"
    text.valign = valign or "top"
    return text
end

function SceneObject:setTextString(string)
    self.text = string
end

function SceneObject.newImage(image, x, y, z, r, sx, sy, ox, oy, kx, ky)
    return SceneObject(drawGeneric, image, nil, image:getWidth(), image:getHeight(), x, y, z, r, sx, sy, ox, oy, kx, ky)
end

function SceneObject:markRemove()
    self.z = math.huge
end

function SceneObject.sortAndPruneObjects(sceneobjects, sort)
    t_sort(sceneobjects, sort)
    for i = #sceneobjects, 1, -1 do
        local sceneobject = sceneobjects[i]
        if sceneobject.z < math.huge then
            break
        end
        sceneobjects[i] = nil
    end
end

return SceneObject