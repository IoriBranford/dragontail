local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Controls  = require "System.Controls"
local Audio     = require "System.Audio"
local Stage = {}

local scene
local player, enemy
local lasttargetvelx, lasttargetvely

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
    lasttargetvelx = 0
    lasttargetvely = 0
end

function Stage.quit()
    scene = nil
    player = nil
end

function Stage.fixedupdate()
    local targetvelx, targetvely = Controls.getDirectionInput()
    if targetvelx ~= 0 or targetvely ~= 0 then
        targetvelx, targetvely = math.norm(targetvelx, targetvely)
        targetvelx = targetvelx * 8
        targetvely = targetvely * 8
        lasttargetvelx = targetvelx
        lasttargetvely = targetvely
    end

    player:accelerateTowardsVel(targetvelx, targetvely, 8)
    player:fixedupdate()
    enemy:fixedupdate()
    player:separateColliding(enemy)

    if lasttargetvelx ~= 0 or lasttargetvely ~= 0 then
        local targetspeed = math.len(lasttargetvelx, lasttargetvely)
        local dot = math.dot(-lasttargetvelx, -lasttargetvely, math.cos(player.attackangle), math.sin(player.attackangle))
        if dot < targetspeed then
            player.attackradius = 48
            player:rotateAttackTowards(math.atan2(-lasttargetvely, -lasttargetvelx), math.pi/10)
        else
            player.attackradius = 0
        end
    else
        player.attackradius = 0
    end

    if enemy:takeHit(player) then
        player.hitstun = player.attackstun
        Audio.play("sounds/hit.mp3")
    end
end

function Stage.draw()
    scene:draw()
end

return Stage