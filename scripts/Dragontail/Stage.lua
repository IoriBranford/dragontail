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
    local targetvelx, targetvely = Controls.getDirectionInput()
    targetvelx = targetvelx * 8
    targetvely = targetvely * 8
    player:accelerateTowardsVel(targetvelx, targetvely, 8)
    player:updatePosition()
    if targetvelx ~= 0 or targetvely ~= 0 then
        player:rotateAttackTowards(math.atan2(targetvely, targetvelx) + math.pi, math.pi/10)
    end
end

function Stage.draw()
    scene:draw()
end

return Stage