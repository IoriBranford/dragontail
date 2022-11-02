local Audio      = require "System.Audio"
local GuiObject    = require "Gui.GuiObject"
local class        = require "pl.class"

local Button = class(GuiObject)
Button.ismenuitem = true

function Button:init()
    Button:cast(self)

    local action = self.action
    self.action = Button[action] or Button.playInvalidSound
end

function Button:press()
    if self.action then
        self:action()
    end
end

function Button:onSelect()
end

function Button:onDeselect()
end

function Button:playInvalidSound()
    Audio.play(self.invalidsound)
end

function Button:openURL()
    love.system.openURL(self.url)
end

return Button