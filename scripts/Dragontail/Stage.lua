local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
require "Dragontail.Character.Ai"
local Tiled     = require "Data.Tiled"
local Sheets    = require "Data.Sheets"
local Stage = {}

local scene
local player, enemies, allcharacters
local currentbounds

function Stage.init(stagefile)
    scene = Scene.new()
    allcharacters = {}
    enemies = {}

    local map = Tiled.load(stagefile)
    local bounds = map.layers.bounds
    currentbounds = bounds and bounds.roombounds1 or {0, 0, 640, 360}

    scene:addMap(map, "group,tilelayer")

    player = Character.new({
        x = 160, y = 180, type = "Rose"
    })
    Sheets.fill(player, "Rose-attack")
    allcharacters[#allcharacters+1] = player

    local food = {
        x = 512, y = 180-16, z = 16, type = "food-fish"
    }
    local firstcharacters = {
        {
            x = 480, y = 120, type = "bandit-dagger"
        },
        {
            x = 480, y = 300, type = "bandit-spear"
        },
        {
            x = 512, y = 180, type = "food-container", item = food
        },
        food
    }
    for i = 0, 4 do
        firstcharacters[#firstcharacters+1] = {
            y = 240, x = 240 + i*40, type = "bandit-dagger"
        }
    end

    for i, c in ipairs(firstcharacters) do
        local character = Character.init(c)
        character.opponent = player
        character.bounds = currentbounds
        character:addToScene(scene)
        allcharacters[#allcharacters+1] = character
        if character.team == "enemy" then
            enemies[#enemies+1] = character
        end
    end

    player.opponents = enemies
    player.bounds = currentbounds
    player:addToScene(scene)
    player:startAi("playerControl")

    for i, enemy in ipairs(enemies) do
        if enemy.initialai then
            enemy:startAi(enemy.initialai, 60)
        end
    end
end

function Stage.quit()
    scene = nil
    player = nil
    enemies = nil
    allcharacters = nil
end

function Stage.fixedupdate()
    for i, character in ipairs(allcharacters) do
        character:fixedupdate()
    end
    for i, enemy in ipairs(enemies) do
        if player:collideWithCharacterBody(enemy) then
        end
        for j = i+1, #enemies do
            local otherenemy = enemies[j]
            if enemy:collideWithCharacterAttack(otherenemy) then
                -- infighting!
                -- enemy.opponent = otherenemy
            end
        end
        player:collideWithCharacterAttack(enemy)
    end
    player:keepInBounds(currentbounds.x, currentbounds.y, currentbounds.width, currentbounds.height)

    table.sort(allcharacters, function(a,b)
        return not a.disappeared and b.disappeared
    end)
    for i = #allcharacters, 1, -1 do
        if not allcharacters[i].disappeared then
            break
        end
        allcharacters[i] = nil
    end

    scene:animate(1)
end

function Stage.update(dsecs, fixedfrac)
    for i, character in ipairs(allcharacters) do
        character:update(dsecs, fixedfrac)
    end
end

function Stage.draw()
    scene:draw()
end

return Stage