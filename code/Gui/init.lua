local Tiled = require "Tiled"
local GuiObject = require "Gui.GuiObject"
local LayerGroup= require "Tiled.LayerGroup"
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
    end
    local self = Gui.get(map.layers, rootpath) or map.layers
    self.width = map.width*map.tilewidth
    self.height = map.height*map.tileheight
    self.class = "Gui"
    self.visible = true
    self.menustack = {}

    local function init(element)
        for i = 1, #element do
            init(element[i])
        end

        local cls = element.class or ""
        if cls == "" then
            cls = element.type or ""
        end
        if cls == "" then
            GuiObject.castinit(element)
        end
        if element ~= self then
            element.gui = self
        end
    end

    Gui.cast(self)
    init(self)
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
    for i = 1, #self do
        self[i]:reanchor(self.width, self.height, screenwidth, screenheight)
    end
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
        m:setVisible(true)
    end
    self.menustack[#self.menustack+1] = menu
    self:setActiveMenu(menu)
    local initialbutton = menu.initialbutton
    if initialbutton then
        menu:selectButton(initialbutton)
    end
end

function Gui:popMenu()
    local menu = self.menustack[#self.menustack]
    if not menu then
        return
    end
    menu:setVisible(true)
    menu:doAction(menu.closeaction)
    self.menustack[#self.menustack] = nil
    self:setActiveMenu(self.menustack[#self.menustack])
end

function Gui:clearMenuStack()
    for i = #self.menustack, 1, -1 do
        local menu = self.menustack[i]
        menu:setVisible(true)
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

return Gui