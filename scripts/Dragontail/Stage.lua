local Scene = require "System.Scene"
local Physics = require "System.Physics"
local Stage = {}

local scene

function Stage.init()
    scene = Scene.new()
    scene:addTextObject({
        id = 1,
        width = 640,
        height = 32,
        string = "HELLO DRAGONTAIL",
        halign = "center"
    })
    Physics.init()
end

function Stage.quit()
    scene = nil
    Physics.clear()
end

function Stage.fixedupdate()
    Physics.fixedupdate()
end

function Stage.draw()
    scene:draw()
end

return Stage