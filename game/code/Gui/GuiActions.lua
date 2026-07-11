local Audio     = require "System.Audio"
local Platform     = require "System.Platform"
local Config       = require "System.Config"
local Window       = require "System.Window"

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

function GuiActions.closeMenu(gui, element)
    gui:popMenu()
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