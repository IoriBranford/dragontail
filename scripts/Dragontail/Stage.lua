local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Controls  = require "System.Controls"
local Audio     = require "System.Audio"
local Tiled     = require "Data.Tiled"
local Stage = {}

local scene
local player, enemy
local lasttargetvelx, lasttargetvely
local currentbounds

function Stage.init(stagefile)
    scene = Scene.new()

    local map = Tiled.load(stagefile)
    scene:addMap(map, "group,tilelayer")

    player = Character.new({
        x = 160, y = 180, bodyradius = 16, attackradius = 32, attackarc = math.pi/2, attackstun = 10
    })
    scene:add(player)

    enemy = Character.new({
        x = 480, y = 180, bodyradius = 16, type = "bandit-dagger", animation = "walk2", opponent = player
    })
    enemy:addToScene(scene)

    lasttargetvelx = 0
    lasttargetvely = 0
    local bounds = map.layers.bounds
    currentbounds = bounds and bounds.stagebounds or {0, 0, 640, 360}
end

function Stage.quit()
    scene = nil
    player = nil
end

function Stage.fixedupdate()
    if enemy:collideWithCharacterAttack(player) then
        player.hitstun = player.attackstun
        Audio.play("sounds/combat/hit1.mp3")
    end

    local targetvelx, targetvely = Controls.getDirectionInput()
    local b1, b2 = Controls.getButtonsDown()
    if targetvelx ~= 0 or targetvely ~= 0 then
        targetvelx, targetvely = math.norm(targetvelx, targetvely)
        local speed = b2 and 4 or 8
        targetvelx = targetvelx * speed
        targetvely = targetvely * speed
        lasttargetvelx = targetvelx
        lasttargetvely = targetvely
    end

    player:accelerateTowardsVel(targetvelx, targetvely, 8)
    player:fixedupdate()
    enemy:fixedupdate()
    player:collideWithCharacterBody(enemy)
    player:keepInBounds(currentbounds.x, currentbounds.y, currentbounds.width, currentbounds.height)

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
    scene:animate(1)
end

function Stage.draw()
    scene:draw()
end

return Stage