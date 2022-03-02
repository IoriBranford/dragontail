local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
require "Dragontail.Character.Ai"
local Tiled     = require "Data.Tiled"
local Sheets    = require "Data.Sheets"
local Stage = {}

local scene
local player, enemies
local currentbounds

function Stage.init(stagefile)
    scene = Scene.new()

    local map = Tiled.load(stagefile)
    scene:addMap(map, "group,tilelayer")

    player = Character.new({
        x = 160, y = 180, type = "Rose"
    })
    Sheets.fill(player, "Rose-attack")
    scene:add(player)
    player:startAi("playerControl")

    local firstenemies = {
        {
            x = 480, y = 120, type = "bandit-dagger"
        },
        {
            x = 480, y = 240, type = "bandit-spear"
        }
    }
    enemies = {}
    for i, e in ipairs(firstenemies) do
        local enemy = Character.new(e)
        enemy.opponent = player
        enemy:addToScene(scene)
        enemy:startAi("stand", 60)
        enemies[#enemies+1] = enemy
    end

    local bounds = map.layers.bounds
    currentbounds = bounds and bounds.stagebounds or {0, 0, 640, 360}
end

function Stage.quit()
    scene = nil
    player = nil
    enemies = nil
end

function Stage.fixedupdate()
    player:fixedupdate()
    for i, enemy in ipairs(enemies) do
        enemy:fixedupdate()
        if enemy:collideWithCharacterAttack(player) then
            player.hitstun = player.attackstun
        end
        for j = i+1, #enemies do
            local otherenemy = enemies[j]
            if enemy:collideWithCharacterAttack(otherenemy) then
                -- infighting!
                -- enemy.opponent = otherenemy
            end
        end
        player:collideWithCharacterBody(enemy)
        player:collideWithCharacterAttack(enemy)
    end
    player:keepInBounds(currentbounds.x, currentbounds.y, currentbounds.width, currentbounds.height)
    scene:animate(1)

    table.sort(enemies, function(a,b)
        return not a.disappeared and b.disappeared
    end)
    for i = #enemies, 1, -1 do
        if not enemies[i].disappeared then
            break
        end
        enemies[i] = nil
    end
end

function Stage.update(dsecs, fixedfrac)
    player:update(dsecs, fixedfrac)
    for i, enemy in ipairs(enemies) do
        enemy:update(dsecs, fixedfrac)
    end
end

function Stage.draw()
    scene:draw()
end

return Stage