local Tiled = require "Tiled"
local GuiObject = require "Gui.GuiObject"
local LayerGroup= require "Tiled.LayerGroup"
local Object      = require "Tiled.Object"
local Canvas      = require "System.Canvas"
local Config      = require "System.Config"

---@class Gui:LayerGroup
---@field width integer
---@field height integer
---@field activemenu Menu
---@field menustack Menu[]
---@field canvas Canvas
---@field [integer] Layer
local Gui = class(LayerGroup)

---@param map string|TiledMap Tiled map exported to Lua, either table or filename
---@return Gui
function Gui.new(map, rootpath)
    if type(map) == "string" then
        map = Tiled.Map.load(map)
        map:indexEverythingByName()
    end
    local self = Gui.get(map.layers, rootpath) or map.layers
    assert(self.type == "group", "GUI root layer must be a group")
    self.width = map.width*map.tilewidth
    self.height = map.height*map.tileheight
    self.class = "Gui"
    self.visible = true
    self.menustack = {}
    self:bindClasses()

    local function init(element)
        for i = 1, #element do
            init(element[i])
        end

        if getmetatable(element) == Object then
            GuiObject.cast(element)
        end

        if element.spawn then
            element:spawn()
        end
        element.gui = self
    end
    for _, layer in ipairs(self) do
        init(layer)
    end
    self:resize_s(love.graphics.getWidth(), love.graphics.getHeight())
    return self
end

---@param path string separated by '.'
---@return GuiObject?
function Gui:get(path)
    if type(path) ~= "string" then
        return
    end
    local guiobject = self
    for layername in path:gmatch("[^.]+") do
        guiobject = guiobject[layername]
        if not guiobject then
            break
        end
    end
    return guiobject
end

function Gui:getExpandedCanvasSize(screenwidth, screenheight, maincanvas)
    local canvaswidth, canvasheight = self.width, self.height
    if maincanvas then
        canvaswidth, canvasheight = maincanvas:inverseTransformVector(screenwidth, screenheight)
    else
        local s = Canvas.GetScaleFactor(canvaswidth, canvasheight,
            screenwidth, screenheight,
            math.rad(Config.rotation),
            true)
        canvaswidth = screenwidth/s
        canvasheight = screenheight/s
        if Config.isPortraitRotation() then
            canvaswidth, canvasheight = canvasheight, canvaswidth
        end
    end
    canvaswidth = math.floor(math.abs(canvaswidth)/2)*2
    canvasheight = math.floor(math.abs(canvasheight)/2)*2
    return canvaswidth, canvasheight
end

---@param screenwidth integer
---@param screenheight integer
---@param maincanvas Canvas?
---@param expand boolean? to show ui outside the gui width/height
---@deprecated
function Gui:resize_s(screenwidth, screenheight, maincanvas, expand)
    -- for i = 1, #self do
    --     self[i]:reanchor(self.width, self.height, screenwidth, screenheight)
    -- end

    local cw, ch = self.width, self.height

    if expand then
        cw, ch = self:getExpandedCanvasSize(screenwidth, screenheight, maincanvas)
    end

    local prescale = Config.upscale

    local canvas = self.canvas
    if canvas then
        canvas:resize(cw, ch, prescale)
    else
        canvas = Canvas(cw, ch, prescale)
        self.canvas = canvas
    end
    if maincanvas then
        canvas:transformToAnotherCanvas(screenwidth, screenheight, maincanvas)
    else
        canvas:transformToScreen(screenwidth, screenheight,
            math.rad(Config.rotation), Config.upscaleinteger)
    end
    canvas:setFiltered(Config.linearfilter)
    self.x = (self.canvas:getBaseWidth() - self.width) / 2
    self.y = (self.canvas:getBaseHeight() - self.height) / 2
end

function Gui:setActiveMenu(menu)
    if menu then
        menu:setVisible(true)
        menu:doAction(menu.openaction)
    end
    self.activemenu = menu
end

---@param menu Menu
function Gui:pushMenu(menu)
    if not menu or menu == self.activemenu then
        return
    end
    for _, m in ipairs(self.menustack) do
        m:setVisible(false)
    end
    self.menustack[#self.menustack+1] = menu
    self:setActiveMenu(menu)
    menu:loadConfigValues()
    menu:initCursor()
end

function Gui:popMenu()
    local menu = self.menustack[#self.menustack]
    if not menu then
        return
    end
    menu:setVisible(false)
    menu:doAction(menu.closeaction)
    self.menustack[#self.menustack] = nil
    menu = self.menustack[#self.menustack]
    self:setActiveMenu(menu)
    if not menu then return end
    menu:loadConfigValues()
    menu:selectButton(menu.cursorposition)
end

function Gui:clearMenuStack()
    for i = #self.menustack, 1, -1 do
        local menu = self.menustack[i]
        menu:setVisible(false)
        self.menustack[i] = nil
    end
    self:setActiveMenu()
end

function Gui:keypressed_s(key)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:keypressed(key)
    end
end

function Gui:gamepadpressed_s(gamepad, button)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:gamepadpressed(gamepad, button)
    end
end

function Gui:touchpressed_s(id, x, y)
    x, y = self.canvas:inverseTransformPoint(x, y)
    x, y = x - self.x, y - self.y
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchpressed(id, x, y)
    end
end

function Gui:touchmoved_s(id, x, y, dx, dy)
    x, y = self.canvas:inverseTransformPoint(x, y)
    x, y = x - self.x, y - self.y
    dx, dy = self.canvas:inverseTransformVector(dx, dy)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchmoved(id, x, y, dx, dy)
    end
end

function Gui:touchreleased_s(id, x, y)
    x, y = self.canvas:inverseTransformPoint(x, y)
    x, y = x - self.x, y - self.y
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchreleased(id, x, y)
    end
end

function Gui:fixedupdate_s()
    self:animate(1)
end

function Gui:drawOnOwnCanvas()
    self.canvas:drawOn(function()
        love.graphics.clear()
        self:draw()
    end)
end

function Gui:drawOnCanvas(canvas)
    canvas:drawOn(function()
        self:draw()
    end)
end

function Gui:drawViaOwnCanvas()
    self:drawOnOwnCanvas()
    self.canvas:draw()
end

function Gui:compose(f)
    self.canvas:drawOn(function ()
        f()
        self:draw()
    end)
end

function Gui:lerpdraw_s()
    LayerGroup.draw(self)
end

return Gui