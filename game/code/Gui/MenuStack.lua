local MenuStack = {}

local activemenu

local function setActiveMenu(menu)
    if menu then
        menu:setVisible(true)
        menu:doAction(menu.openaction)
    end
    activemenu = menu
end

---@param menu Menu
function MenuStack.push(menu)
    if not menu then
        return
    end
    for _, m in ipairs(MenuStack) do
        m:setVisible(false)
    end
    MenuStack[#MenuStack+1] = menu
    setActiveMenu(menu)
    menu:loadConfigValues()
    menu:initCursor()
end

function MenuStack.pop()
    local menu = MenuStack[#MenuStack]
    if not menu then
        return
    end
    menu:setVisible(false)
    menu:doAction(menu.closeaction)
    MenuStack[#MenuStack] = nil
    local belowmenu = MenuStack[#MenuStack]
    setActiveMenu(belowmenu)
    belowmenu:loadConfigValues()
    belowmenu:selectButton(belowmenu.cursorposition)
    return menu
end

function MenuStack.clear()
    for i = #MenuStack, 1, -1 do
        local menu = MenuStack[i]
        menu:setVisible(false)
        MenuStack[i] = nil
    end
    setActiveMenu()
end

function MenuStack.keypressed(key)
    if activemenu and activemenu.visible then
        activemenu:keypressed(key)
    end
end

function MenuStack.gamepadpressed(gamepad, button)
    if activemenu and activemenu.visible then
        activemenu:gamepadpressed(gamepad, button)
    end
end

-- TODO when pointer input needed

-- function MenuStack.touchpressed(id, x, y)
--     x, y = self.canvas:inverseTransformPoint(x, y)
--     x, y = x - self.x, y - self.y
--     if activemenu and activemenu.visible then
--         activemenu:touchpressed(id, x, y)
--     end
-- end

-- function MenuStack.touchmoved(id, x, y, dx, dy)
--     x, y = self.canvas:inverseTransformPoint(x, y)
--     x, y = x - self.x, y - self.y
--     dx, dy = self.canvas:inverseTransformVector(dx, dy)
--     if activemenu and activemenu.visible then
--         activemenu:touchmoved(id, x, y, dx, dy)
--     end
-- end

-- function MenuStack.touchreleased(id, x, y)
--     x, y = self.canvas:inverseTransformPoint(x, y)
--     x, y = x - self.x, y - self.y
--     if activemenu and activemenu.visible then
--         activemenu:touchreleased(id, x, y)
--     end
-- end