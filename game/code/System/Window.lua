local Config = require "System.Config"
local Window = {}

local basewidth, baseheight

function Window.init(width, height)
    basewidth = width
    baseheight = height
    Window.refresh()
end

function Window.refresh()
    Config.applyDisplayMode(basewidth, baseheight, 2)
end

return Window