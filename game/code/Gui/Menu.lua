local Config    = require "System.Config"
local Platform  = require "System.Platform"
local GuiObject = require "Gui.GuiObject"
local ObjectGroup = require "Tiled.ObjectGroup"
local InputSetter = require "Gui.InputSetter"

---@class Menu:ObjectGroup
local Menu = class(ObjectGroup)
Menu.doAction = GuiObject.doAction

function Menu:spawn()
    local platform = Platform.OS

    local cursors = {}
    local menuitems = {}
    self.cursors = cursors
    self.menuitems = menuitems

    for _, object in ipairs(self) do
        local platforms = object.platforms or "all"
        if platforms == "all" or platforms:find(platform) then
            if object.iscursor then
                cursors[#cursors+1] = object
                object.menu = self
            elseif object.ismenuitem then
                menuitems[#menuitems + 1] = object
                object.menu = self
            end
        else
            object:setVisible(false)
        end
    end

    assert(#menuitems > 0, self.name.." is a Menu without Buttons")

    table.sort(menuitems, function(a,b)
        return a.y < b.y
    end)

    if Platform.IsMobile then
        self:selectButton()
    elseif self.initialcursorposition then
        self:selectButton(self.initialcursorposition)
    elseif not self.cursorposition then
        self:selectButton(1)
    end

    return self
end

function Menu:setActiveInputSetter(inputsetter)
    self.activeinputsetter = inputsetter
end

function Menu:keypressed(key)
    local inputsetter = self.activeinputsetter
    if inputsetter then
        if inputsetter.inputdevice == "keyboard" and not InputSetter.ReservedKeys[key] then
            inputsetter:setValue(key)
            inputsetter:storeConfigValue()
            self.activeinputsetter = nil
        elseif key == "escape" then
            inputsetter:loadConfigValue()
            self.activeinputsetter = nil
        end
        return
    end
    if key == "return" or key == Config.key_fire then
        self:pressSelectedButton()
    elseif key == Config.key_up then
        self:moveCursor(-1)
    elseif key == Config.key_down then
        self:moveCursor(1)
    elseif key == Config.key_left then
        self:changeSelectedSlider(-1)
    elseif key == Config.key_right then
        self:changeSelectedSlider(1)
    elseif key == "escape" then
        self:doAction(self.backaction)
    end
end

function Menu:gamepadpressed(gamepad, button)
    local inputsetter = self.activeinputsetter
    if inputsetter then
        if inputsetter.inputdevice == "controller" and not InputSetter.ReservedButtons[button] then
            inputsetter:setValue(button)
            inputsetter:storeConfigValue()
            self.activeinputsetter = nil
        elseif button == "back" then
            inputsetter:loadConfigValue()
            self.activeinputsetter = nil
        end
        return
    end
    if button == "dpup" then
        self:moveCursor(-1)
    elseif button == "dpdown" then
        self:moveCursor(1)
    elseif button == "dpleft" then
        self:changeSelectedSlider(-1)
    elseif button == "dpright" then
        self:changeSelectedSlider(1)
    elseif button == "start" or button == Config.joy_fire then
        self:pressSelectedButton()
    elseif button == "back" then
        self:doAction(self.backaction)
    end
end

function Menu:itemAtPoint(x, y)
    for i, menuitem in ipairs(self.menuitems) do
        if menuitem.visible then
            local x1, y1, x2, y2 = menuitem:getExtents()
            if math.testrects(
                x, y, 0, 0,
                x1, y1, x2-x1, y2-y1
            ) then
                return i, menuitem
            end
        end
    end
end

function Menu:touchpressed(id, x, y)
    if self.menutouchid then
        return
    end
    x, y = self.gui.canvas:inverseTransformPoint(x, y)
    local i = self:itemAtPoint(x, y)
    if not i then
        return
    end
    self.menutouchid = id
    self:selectButton(i)
end

function Menu:touchmoved(id, x, y, dx, dy)
    if self.menutouchid ~= id then
        return
    end
    x, y = self.gui.canvas:inverseTransformPoint(x, y)
    local i = self:itemAtPoint(x, y)
    if i ~= self.cursorposition then
        self:selectButton(i)
    end
end

function Menu:touchreleased(id, x, y)
    if self.menutouchid ~= id then
        return
    end
    self:pressSelectedButton()
    self.menutouchid = nil
end

function Menu:selectButton(i)
    local menuitems = self.menuitems
    local menuitem = menuitems[i]
    local lastmenuitem = menuitems[self.cursorposition]
    if lastmenuitem then
        lastmenuitem:onDeselect()
    end
    if menuitem then
        menuitem:onSelect()
        for _, cursor in ipairs(self.cursors) do
            cursor:setVisible(true)
            cursor:moveToMenuItem(menuitem)
            cursor:onSelect(i, menuitem)
        end
    else
        for _, cursor in ipairs(self.cursors) do
            cursor:setVisible(false)
        end
    end
    self.cursorposition = i
end

function Menu:moveCursor(dir)
    dir = dir / math.abs(dir)
    local i = self.cursorposition or 0
    local menuitems = self.menuitems
    i = i + dir
    if i < 1 then
        i = #menuitems
    elseif i > #menuitems then
        i = 1
    end
    self:selectButton(i)
    for _, cursor in ipairs(self.cursors) do
        cursor:onMoveTo(i, menuitems[i])
    end
end

function Menu:changeSelectedSlider(dir)
    local slider = self.menuitems[self.cursorposition]
    if slider and slider.changeValue then
        slider:changeValue(dir)
    end
end

function Menu:pressSelectedButton()
    local button = self.menuitems[self.cursorposition]
    if button and button.press then
        button:press()
    end
end

function Menu:loadConfigValues()
    for _, guiobject in ipairs(self) do
        guiobject:loadConfigValue()
    end
end

function Menu:storeConfigValues()
    for _, menuitem in ipairs(self.menuitems) do
        if menuitem.storeConfigValue then
            menuitem:storeConfigValue()
        end
    end
end

return Menu