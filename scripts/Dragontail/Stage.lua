local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Controls  = require "System.Controls"
local Stage = {}

local scene
local player

function Stage.init()
    scene = Scene.new()

    player = Character.new({
        x = 320, y = 180, speed = 4, bodyradius = 24, attackradius = 48, attackarc = math.pi/2
    })
    scene:add(1, player)
end

function Stage.quit()
    scene = nil
    player = nil
end

function Stage.fixedupdate()
    local dx, dy = Controls.getDirectionInput()
    player:move(dx, dy)
    if dx ~= 0 or dy ~= 0 then
        player:rotateAttackTowards(math.atan2(dy, dx) + math.pi, math.pi/6)
    end
end

function Stage.draw()
    scene:draw()
end

return Stage