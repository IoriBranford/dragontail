local Tiled = require "Tiled"
local GuiObject = require "Gui.GuiObject"
local LayerGroup= require "Tiled.LayerGroup"
local Object      = require "Tiled.Object"
local Canvas      = require "System.Canvas"
local Config      = require "System.Config"

---@class Gui:LayerGroup
---@field activemenu Menu
---@field menustack Menu[]
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
    -- self:resize(love.graphics.getWidth(), love.graphics.getHeight())
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

function Gui:resize(screenwidth, screenheight)
    -- for i = 1, #self do
    --     self[i]:reanchor(self.width, self.height, screenwidth, screenheight)
    -- end

    local scalefactor = Canvas.GetOutputScaleFactor(self.width, self.height, screenwidth, screenheight, math.rad(Config.rotation))
    local canvaswidth = math.ceil(screenwidth/scalefactor)
    local canvasheight = math.ceil(screenheight/scalefactor)
    if canvaswidth % 2 == 1 then
        canvaswidth = canvaswidth - 1
    end
    if canvasheight % 2 == 1 then
        canvasheight = canvasheight - 1
    end
    if Config.isPortraitRotation() then
        canvaswidth, canvasheight = canvasheight, canvaswidth
    end
    local canvas = Canvas(canvaswidth, canvasheight)
    canvas:transformToScreen(screenwidth, screenheight, math.rad(Config.rotation), Config.canvasscaleint)
    canvas:setFiltered(Config.canvasscalesoft)
    self.canvas = canvas
    self.x = (canvaswidth - self.width) / 2
    self.y = (canvasheight - self.height) / 2
end

function Gui:setActiveMenu(menu)
    if menu then
        menu:setVisible(true)
        menu:doAction(menu.openaction)
    end
    self.activemenu = menu
end

function Gui:pushMenu(menu)
    if not menu then
        return
    end
    for _, m in ipairs(self.menustack) do
        m:setVisible(false)
    end
    self.menustack[#self.menustack+1] = menu
    self:setActiveMenu(menu)
    menu:selectButton(menu.initialbutton or 1)
end

function Gui:popMenu()
    local menu = self.menustack[#self.menustack]
    if not menu then
        return
    end
    menu:setVisible(false)
    menu:doAction(menu.closeaction)
    self.menustack[#self.menustack] = nil
    self:setActiveMenu(self.menustack[#self.menustack])
end

function Gui:clearMenuStack()
    for i = #self.menustack, 1, -1 do
        local menu = self.menustack[i]
        menu:setVisible(false)
        self.menustack[i] = nil
    end
    self:setActiveMenu()
end

function Gui:keypressed(key)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:keypressed(key)
    end
end

function Gui:gamepadpressed(gamepad, button)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:gamepadpressed(gamepad, button)
    end
end

function Gui:touchpressed(id, x, y)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchpressed(id, x, y)
    end
end

function Gui:touchmoved(id, x, y, dx, dy)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchmoved(id, x, y, dx, dy)
    end
end

function Gui:touchreleased(id, x, y)
    if self.activemenu and self.activemenu.visible then
        self.activemenu:touchreleased(id, x, y)
    end
end

function Gui:fixedupdate()
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

Gui.draw = LayerGroup.draw

return Gui