local Audio     = require "System.Audio"
local Platform     = require "System.Platform"
local Config       = require "System.Config"
local Window       = require "System.Window"
local pathlite     = require "pathlite"
local Dragontail   = require "Dragontail"

---@module 'GuiActions'
local GuiActions = class()

function GuiActions.playInvalidSound(gui, element)
    Audio.play(element.invalidsound)
end

function GuiActions.incSlider(gui, slider)
    slider:changeValue(1)
end

function GuiActions.openURL(gui, element)
    love.system.openURL(element.url)
end

function GuiActions.openMenu(gui, element)
    local menu = gui:get(element.guipath) ---@type Menu?
    if menu then
        gui:pushMenu(menu)
    end
end

function GuiActions.openMenuMap(gui, element)
    local Gui          = require "Gui"
    local menugui = Gui.new(pathlite.normjoin(gui.directory, element.mapfile))
    local menu = menugui:get(element.menupath)
    if menu then
        love.event.connect(menugui)
        Dragontail.sortDrawers()
        menugui:pushMenu(menu)
    end
end

---comment
---@param gui Gui
---@param element GuiObject
function GuiActions.closeMenu(gui, element)
    gui:popMenu()
    if #gui.menustack <= 0 then
        love.event.disconnect(gui)
    end
end

function GuiActions.quitGame(gui, element)
    if Platform.supports("quit") then
        love.event.quit()
    end
end

function GuiActions.resetPrefs(gui, element)
    Config.reset()
    Window.refresh()
    love.event.push("resize", love.graphics.getWidth(), love.graphics.getHeight())
end

function GuiActions.refreshMusicVolume(gui, element)
    Audio.setMusicVolume(Config.musicvolume)
end

function GuiActions.resize(gui, element)
    love.event.push("resize", love.graphics.getWidth(), love.graphics.getHeight())
end

function GuiActions.refreshWindow(gui, element)
    Window.refresh()
    GuiActions.resize()
end

---@param element Slider
function GuiActions.updateFullscreenDeviceName(gui, element)
    element:setValueDescription(love.window.getDisplayName(element.value))
end

return GuiActions