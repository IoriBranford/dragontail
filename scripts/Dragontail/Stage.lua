local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
require "Dragontail.Character.Ai"
local Tiled     = require "Data.Tiled"
local Sheets    = require "Data.Sheets"
local Audio     = require "System.Audio"
local Movement  = require "Object.Movement"
local Stage = {}

local scene
local player, enemies, allcharacters
local currentbounds
local map
local roomindex
local gamestatus
local camerax, cameray

function Stage.init(stagefile)
    scene = Scene.new()
    allcharacters = {}
    enemies = {}

    map = Tiled.load(stagefile)
    roomindex = 0

    currentbounds = map.layers.stage.bounds
    camerax, cameray = 0, (map.height*map.tileheight) - 360

    scene:addMap(map, "group,tilelayer")

    player = Stage.addCharacter({
        x = 160, y = 180, type = "Rose"
    })
    Sheets.fill(player, "Rose-attack")
    player.opponents = enemies

    for i, character in ipairs(allcharacters) do
        if character.initialai then
            character:startAi(character.initialai, 60)
        end
    end
    Audio.playMusic("music/retro-chiptune-guitar.ogg")
    Stage.openNextRoom()
end

function Stage.quit()
    scene = nil
    player = nil
    enemies = nil
    allcharacters = nil
end

function Stage.addCharacter(object)
    local character = Character.init(object)
    character.bounds = currentbounds
    character:addToScene(scene)
    allcharacters[#allcharacters+1] = character
    if character.team == "enemy" then
        enemies[#enemies+1] = character
    end
    return character
end
local addCharacter = Stage.addCharacter

function Stage.addCharacters(objects)
    for i, object in ipairs(objects) do
        local typ = object.type
        if typ ~= "" then
            if typ == "bounds" then
            else
                local character = addCharacter(object)
                character.opponent = player
                if character.initialai then
                    character:startAi(character.initialai, 60)
                end
            end
        end
    end
end
local addCharacters = Stage.addCharacters

function Stage.openNextRoom()
    currentbounds = map.layers.stage.bounds

    roomindex = roomindex + 1
    print(debug.traceback())
    local room = map.layers["room"..roomindex]
    if room then
        addCharacters(room)
        gamestatus = "goingToNextRoom"
    else
        gamestatus = "victory"
    end
end

function Stage.updateGoingToNextRoom()
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    local roombounds = room.bounds
    camerax = math.max(0,
            math.min(map.width * map.tilewidth - 640,
            Movement.moveTowards(camerax, player.x - 640/2, 8)))
    if camerax + 640 >= roombounds.x + roombounds.width then
        camerax = roombounds.x + roombounds.width - 640
        Stage.startNextFight()
    end
end

function Stage.startNextFight()
    gamestatus = nil
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    currentbounds = room.bounds
    local fight = map.layers["fight"..roomindex]
    assert(fight, "No fight "..roomindex)
    addCharacters(fight)
end

local function compDisappeared(a,b)
    return not a.disappeared and b.disappeared
end

local function sortAndPruneDisappeared(characters, onempty, ...)
    table.sort(characters, compDisappeared)
    local n = #characters
    for i = #characters, 1, -1 do
        if not characters[i].disappeared then
            break
        end
        characters[i] = nil
    end
    if onempty and n > 0 and #characters == 0 then
        onempty(...)
    end
end

function Stage.fixedupdate()
    for i, character in ipairs(allcharacters) do
        character:fixedupdate()
    end
    for i, enemy in ipairs(enemies) do
        if player:collideWithCharacterBody(enemy) then
        end
        for j, otherenemy in ipairs(enemies) do
            if j ~= i and enemy:collideWithCharacterAttack(otherenemy) then
                -- infighting!
                -- enemy.opponent = otherenemy
            end
        end
        player:collideWithCharacterAttack(enemy)
    end
    player:keepInBounds(currentbounds.x, currentbounds.y, currentbounds.width, currentbounds.height)

    sortAndPruneDisappeared(enemies, Stage.openNextRoom)
    sortAndPruneDisappeared(allcharacters)

    if gamestatus == "goingToNextRoom" then
        Stage.updateGoingToNextRoom()
    end

    scene:animate(1)
end

function Stage.update(dsecs, fixedfrac)
    for i, character in ipairs(allcharacters) do
        character:update(dsecs, fixedfrac)
    end
end

local NameX, NameY = 16, 16
local BarX, BarY = NameX + 40, NameY
local BarH = 16

function Stage.draw()
    love.graphics.push()
    love.graphics.translate(-camerax, -cameray)
    scene:draw()
    love.graphics.pop()
    love.graphics.setColor(.75, .25, .25)
    love.graphics.rectangle("fill", BarX, BarY, player.health, BarH)
    love.graphics.setColor(1, .5, .5)
    love.graphics.rectangle("line", BarX - .5, BarY - .5, player.maxhealth, BarH + 1, 2)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Rose", NameX, NameY, 40, "left")
end

return Stage