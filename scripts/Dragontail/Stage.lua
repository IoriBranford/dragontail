local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
require "Dragontail.Character.Ai"
local Tiled     = require "Data.Tiled"
local Sheets    = require "Data.Sheets"
local Audio     = require "System.Audio"
local Movement  = require "Object.Movement"
local Assets    = require "System.Assets"
local SceneObject = require "System.SceneObject"
require "System.SceneObject.Aseprite"
local Stage = {}
local max = math.max
local min = math.min

local scene
local player, enemies, solids, allcharacters
local bounds
local map
local roomindex
local gamestatus
local camerax, cameray
local facesprite

function Stage.quit()
    scene = nil
    player = nil
    enemies = nil
    solids = nil
    allcharacters = nil
    bounds = nil
    map = nil
    roomindex = nil
    gamestatus = nil
    camerax, cameray = nil, nil
end

function Stage.init(stagefile)
    scene = Scene.new()
    allcharacters = {}
    enemies = {}
    solids = {}

    map = Tiled.load(stagefile)
    roomindex = 0

    bounds = map.layers.stage.bounds
    bounds.width = 640
    camerax, cameray = 0, (map.height*map.tileheight) - 360

    scene:addMap(map, "group,tilelayer")

    player = Stage.addCharacter({
        x = 160, y = 180, type = "Rose"
    })
    player.opponents = enemies

    for i, character in ipairs(allcharacters) do
        if character.initialai then
            character:startAi(character.initialai, 30)
        end
    end
    local music = Audio.playMusic("music/retro-chiptune-guitar.ogg")
    if music then
        music:setLooping(true)
    end
    Stage.openNextRoom()

    local faceasepritefile = player.faceasepritefile or "sprites/rose-face.jase"
    local facease = Assets.get(faceasepritefile)
    facesprite = SceneObject.newAseprite(facease, 1, 16, 16)
end

function Stage.addCharacter(object)
    local character = Character.init(object)
    character.bounds = bounds
    character.solids = solids
    character:addToScene(scene)
    allcharacters[#allcharacters+1] = character
    if character.bodysolid then
        solids[#solids+1] = character
    end
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
                    character:startAi(character.initialai, 30)
                end
            end
        end
    end
end
local addCharacters = Stage.addCharacters

function Stage.openNextRoom()
    roomindex = roomindex + 1
    local room = map.layers["room"..roomindex]
    if room then
        addCharacters(room)
        gamestatus = "goingToNextRoom"
    else
        gamestatus = "victory"
        player:startAi("playerVictory")
        Audio.fadeMusic()
    end
end

function Stage.updateGoingToNextRoom()
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    local roombounds = room.bounds
    local cameradestx = player.x - 640/2
    if camerax < cameradestx then
        camerax = Movement.moveTowards(camerax, cameradestx, 6)
    end
    camerax = max(0, camerax)
    bounds.x = camerax
    local roomright = roombounds.x + roombounds.width
    local cameraxmax = roomright - 640
    if camerax >= cameraxmax then
        camerax = cameraxmax
        Stage.startNextFight()
    end
end

function Stage.startNextFight()
    gamestatus = "fight"
    local fight = map.layers["fight"..roomindex]
    assert(fight, "No fight "..roomindex)
    addCharacters(fight)
end

local function compDisappeared(a,b)
    return not a.disappeared and b.disappeared
end

local function pruneDisappeared(characters, onempty, ...)
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
    for i, solid in ipairs(solids) do
        player:collideWithCharacterBody(solid)
    end
    for i, enemy in ipairs(enemies) do
        for j, solid in ipairs(solids) do
            if enemy:collideWithCharacterAttack(solid) then
                -- infighting!
                -- enemy.opponent = otherenemy
            end
        end
        player:collideWithCharacterAttack(enemy)
    end
    player:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)

    pruneDisappeared(enemies, Stage.openNextRoom)
    pruneDisappeared(solids)
    pruneDisappeared(allcharacters)

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

local NameX, NameY = 16, 24
local BarX, BarY = NameX + 40, NameY
local BarH = 16

function Stage.draw()
    love.graphics.push()
    love.graphics.translate(-camerax, -cameray)
    scene:draw()
    love.graphics.pop()

    local hurtstun = player.hurtstun
    love.graphics.setColor(1, 0, 0, min(.5, hurtstun/20))
    love.graphics.rectangle("fill", 0,0,640,360)

    local health = player.health
    if health > 0 then
        love.graphics.setColor(.75, .25, .25)
        love.graphics.rectangle("fill", BarX, BarY, health, BarH)
    end
    love.graphics.setColor(1, .5, .5)
    love.graphics.rectangle("line", BarX - .5, BarY - .5, player.maxhealth, BarH + 1, 2)
    love.graphics.setColor(1,1,1)
    -- love.graphics.printf("Rose", NameX, NameY, 40, "left")

    if gamestatus == "victory" then
        facesprite:changeAsepriteAnimation("win")
    elseif hurtstun > 0 then
        facesprite:changeAsepriteAnimation("hit")
    elseif health <= player.maxhealth/2 then
        facesprite:changeAsepriteAnimation("wounded")
    else
        facesprite:changeAsepriteAnimation("normal")
    end
    facesprite:draw()
end

return Stage