local class = require "Tiled.class"
local Gid = require "Tiled.Gid"
local Assets = require "Tiled.Assets"
local Properties = require "Tiled.Properties"
local Color      = require "Tiled.Color"
local Graphics   = require "Tiled.Graphics"

---@class TiledObject
---@field id integer Unique ID of the object (defaults to 0, with valid IDs being at least 1). Each object that is placed on a map gets a unique id. Even if an object was deleted, no object gets the same ID. Can not be changed in Tiled. (since Tiled 0.11)
---@field name string The name of the object. An arbitrary string. (defaults to “”)
---@field type string? The class of the object. An arbitrary string. (defaults to “”, was saved as class in 1.9)
---@field class string? The class of the object when saved/exported in Tiled 1.9. An arbitrary string. (defaults to “”)
---@field x number The x coordinate of the object in pixels. (defaults to 0)
---@field y number The y coordinate of the object in pixels. (defaults to 0)
---@field z number Drawing order, default is objectgroup's z, set with object property "z" (float)
---@field width number The width of the object in pixels. (defaults to 0)
---@field height number The height of the object in pixels. (defaults to 0)
---@field rotation number The rotation of the object in **radians** clockwise around (x, y). (defaults to 0)
---@field scalex number Object scale x, based on gid flipx and tile width
---@field scaley number Object scale y, based on gid flipy and tile height
---@field gid integer? A reference to a tile. (optional)
---@field visible boolean Whether the object is shown (1) or hidden (0). (defaults to 1)
---@field template string? A reference to a template file. (optional)
---@field shape string rectangle, ellipse, polyline, polygon, point, or text
---@field points number[]? Converted to array [x1, y1, x2, y2, x3, y3, ...]
---@field tile Tile?
---@field properties table? These get moved into object itself
---@field color Color?
---@field linecolor Color?
local TiledObject = class()

---@class TextObject:TiledObject
---@field text string
---@field string string Copy of text
---@field fontfamily string The font family used (defaults to “sans-serif”)
---@field pixelsize integer The size of the font in pixels (not using points, because other sizes in the TMX format are also using pixels) (defaults to 16)
---@field wrap boolean Whether word wrapping is enabled (1) or disabled (0). (defaults to 0)
---@field color Color Color of the text in #AARRGGBB or #RRGGBB format (defaults to #000000)
---@field bold boolean Whether the font is bold (1) or not (0). (defaults to 0)
---@field italic boolean Whether the font is italic (1) or not (0). (defaults to 0)
---@field underline boolean Whether a line should be drawn below the text (1) or not (0). (defaults to 0)
---@field strikeout boolean Whether a line should be drawn through the text (1) or not (0). (defaults to 0)
---@field kerning boolean Whether kerning should be used while rendering the text (1) or not (0). (defaults to 1)
---@field halign string Horizontal alignment of the text within the object (left, center, right or justify, defaults to left) (since Tiled 1.2.1)
---@field valign string Vertical alignment of the text within the object (top , center or bottom, defaults to top)
---@field font love.Font Loaded font object
--- Font file should be in Tiled.fontpath and follow this naming:
--- "fontfamily.ttf"
--- "fontfamily Bold.ttf"
--- "fontfamily Italic.ttf"
--- "fontfamily Bold Italic.ttf"
--- "fontfamily [pixelsize].fnt"
--- "fontfamily Bold [pixelsize].fnt"
--- "fontfamily Italic [pixelsize].fnt"
--- "fontfamily Bold Italic [pixelsize].fnt"

local function triangulate(points)
    local cantriangulate, triangles = pcall(love.math.triangulate, points)
    if cantriangulate then
        local tris = {}
        for i = 1, #triangles do
            local triangle = triangles[i]
            for i = 1, #triangle do
                tris[#tris+1] = triangle[i]
            end
        end
        return tris
    end
    return false, triangles
end

local function processPoly(object)
    local poly = object.polygon or object.polyline
    if poly then
        local points = {}
        object.points = points
        for i = 1, #poly do
            local point = poly[i]
            local px = point.x
            local py = point.y
            points[#points+1] = px
            points[#points+1] = py
        end
        if object.shape == "polygon" then
            object.triangles = triangulate(points)
        end
    end
end

function TiledObject:_init(map)
    local objecttype = self.class or self.type or ""
    local gid = self.gid
    if gid then
        local maptiles = map.tiles
        local sx, sy
        gid, sx, sy = Gid.parse(gid)
        local tile = maptiles[gid]
        self:setTile(tile)
        self.scalex = sx * self.width / tile.width
        self.scaley = sy * self.height / tile.height

        if objecttype == "" then
            objecttype = tile.type
        end
        self.draw = self.drawTile
    else
        local shape = self.shape
        if shape == "rectangle" then
            self.draw = self.drawRectangle
        elseif shape == "ellipse" then
            self.draw = self.drawEllipse
        elseif shape == "polyline" then
            self.draw = self.drawLine
        elseif shape == "polygon" then
            self.draw = self.drawPolygon
        end
    end
    self.type = objecttype
    processPoly(self)
    self:initText()
    self.rotation = math.rad(self.rotation)
    if map then
        local mapobjects = map.objects
        Properties.resolveObjectRefs(self.properties, mapobjects)
    end
    Properties.moveUp(self)
    return self
end

---@param self TextObject|TiledObject
function TiledObject:initText()
    local text = self.text
    if text then
        local font = Assets.loadFont(self.fontfamily, self.pixelsize, self.bold, self.italic)
        self.font = font
        self.draw = self.drawText
    end
end

function TiledObject:isAnimationEnding(dt)
    local tile = self.tile
    if not tile then return end
    local animation = tile.animation
    if animation then
        local aframe = self.animationframe
        local atime = self.animationtime + dt
        return animation:isFinished(aframe, atime)
    end
end

function TiledObject:animate(dt)
    local tile = self.tile
    if not tile then return end

    local animation = tile.animation
    if animation then
        local aframe = self.animationframe
        local atime = self.animationtime
        aframe, atime = animation:getUpdate(aframe, atime + dt)
        self.animationframe = aframe
        self.animationtime = atime
        self.animationquad = animation[aframe].tile.quad
    end
end

function TiledObject:setTile(tile)
    self.tile = tile
    self.animationframe = 1
    self.animationtime = 0
    self.animationquad = nil
end
local setTile = TiledObject.setTile

function TiledObject:changeTile(tileid)
    local tile = self.tile
    local newtile = tile and tile.tileset[tileid]
    if newtile and newtile ~= tile then
        setTile(self, newtile)
    end
end

function TiledObject:randomizeTile()
    local tile = self.tile
    if not tile then return end
    local tileid = love.math.random(#tile.tileset)
    local newtile = tile.tileset[tileid]
    setTile(self, newtile)
end

function TiledObject:getObjectTileset()
    local tile = self.tile
    return tile and tile.tileset
end

local pushTransform = Graphics.pushTransform

function TiledObject:drawTile()
    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)
    local tile = self.tile
    love.graphics.draw(tile.image,
        self.animationquad or tile.quad,
        (self.x),
        (self.y),
        self.rotation,
        self.scalex or 1, self.scaley or 1,
        self.originx or tile.objectoriginx, self.originy or tile.objectoriginy,
        self.skewx or 0, self.skewy or 0)
end

function TiledObject:drawLine()
    pushTransform(self)

    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)
    love.graphics.setLineWidth(self.linewidth or 1)
    love.graphics.line(self.points)

    love.graphics.pop()
end

function TiledObject:drawPolygon()
    pushTransform(self)

    local color = self.color
    local linecolor = self.linecolor
    local r,g,b,a = Color.unpack(color)
    local triangles = self.triangles
    if triangles then
        love.graphics.setColor(r,g,b,a)
        for i = 6, #triangles, 6 do
            love.graphics.polygon("fill",
                triangles[i-5], triangles[i-4],
                triangles[i-3], triangles[i-2],
                triangles[i-1], triangles[i-0])
        end
    else
        linecolor = linecolor or color
    end
    if linecolor then
        r,g,b,a = Color.unpack(linecolor)
        love.graphics.setColor(r,g,b,a)
        love.graphics.setLineWidth(self.linewidth or 1)
        love.graphics.polygon("line", self.points)
    end

    love.graphics.pop()
end

function TiledObject:drawRectangle()
    pushTransform(self)

    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height, self.roundcorners or 0)

    if self.linecolor then
        r,g,b,a = Color.unpack(self.linecolor)
        love.graphics.setColor(r,g,b,a)
        love.graphics.rectangle("line", 0, 0, self.width, self.height, self.roundcorners or 0)
    end

    love.graphics.pop()
end

function TiledObject:drawEllipse()
    pushTransform(self)

    local hw, hh = self.width/2, self.height/2

    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)
    love.graphics.ellipse("fill", hw, hh, hw, hh)

    if self.linecolor then
        r,g,b,a = Color.unpack(self.linecolor)
        love.graphics.setColor(r,g,b,a)
        love.graphics.ellipse("line", hw, hh, hw, hh)
    end

    love.graphics.pop()
end

---@param self TextObject
function TiledObject:drawText()
    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)
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
            self.originx or 0, self.originy or 0,
            self.skewx or 0, self.skewy or 0)
        y = y + lineh
    end
end

function TiledObject:draw()
end

return TiledObject
