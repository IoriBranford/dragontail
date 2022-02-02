local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Controls  = require "System.Controls"
local Audio     = require "System.Audio"
local Stage = {}

local scene
local player, enemy

function Stage.init()
    scene = Scene.new()

    player = Character.new({
        x = 160, y = 180, bodyradius = 24, attackradius = 48, attackarc = math.pi/2, attackstun = 10
    })
    enemy = Character.new({
        x = 480, y = 180, bodyradius = 24
    })
    scene:add(1, player)
    scene:add(2, enemy)
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
    player:fixedupdate()
    enemy:fixedupdate()
    player:separateColliding(enemy)
    if enemy:takeHit(player) then
        player.hitstun = player.attackstun
        Audio.play("sounds/hit.mp3")
    end
    if targetvelx ~= 0 or targetvely ~= 0 then
        player.attackradius = 48
        player:rotateAttackTowards(math.atan2(targetvely, targetvelx) + math.pi, math.pi/10)
    else
        player.attackradius = 0
    end
end

function Stage.draw()
    scene:draw()
end

return Stage