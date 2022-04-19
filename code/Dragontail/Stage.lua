local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Tiled     = require "Data.Tiled"
local Database    = require "Data.Database"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local Assets    = require "System.Assets"
local SceneObject = require "System.SceneObject"
local Script      = require "Component.Script"
local Stage = {}
local sin = math.sin
local max = math.max
local min = math.min
local t_remove = table.remove

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

    local music = Audio.playMusic("music/retro-chiptune-guitar.ogg")
    if music then
        music:setLooping(true)
    end
    Stage.openNextRoom()

    local faceasepritefile = player.faceasepritefile
    local facease = faceasepritefile and Assets.get(faceasepritefile)
    facesprite = facease and SceneObject.newAseprite(facease, 1, 32, 32)
    facesprite.ox, facesprite.oy = facesprite.w/2, facesprite.h/2
end

function Stage.addCharacter(object)
    local character = Character.init(object)
    character.bounds = bounds
    character.solids = solids
    if character.team == "player" then
        character.opponents = enemies
    else
        character.opponent = player
    end
    character:addToScene(scene)
    allcharacters[#allcharacters+1] = character
    if character.bodysolid then
        solids[#solids+1] = character
    end
    if character.team == "enemy" then
        enemies[#enemies+1] = character
    end
    if character.script then
        Script.load(character, character.script)
        if character.initialai then
            Script.start(character, character.initialai)
        end
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
                addCharacter(object)
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
        Script.start(player, "victory")
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
    local n = #characters
    local n0 = n
    for i = n, 1, -1 do
        if characters[i].disappeared then
            characters[i] = characters[n]
            t_remove(characters)
            n = n - 1
        end
    end
    if onempty and n0 > 0 and n == 0 then
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

local NameX, NameY = 48, 16
local BarX, BarY = NameX, NameY + 17
local BarH = 14

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
    love.graphics.printf(" Rose", NameX, NameY, 64, "left")

    if facesprite then
        facesprite.ox = facesprite.w/2 + sin(hurtstun)
        if gamestatus == "victory" then
            facesprite:changeAsepriteAnimation("win")
        elseif hurtstun > 0 or health <= player.maxhealth/2 then
            facesprite:changeAsepriteAnimation("hurt")
        elseif player.attackangle then
            facesprite:changeAsepriteAnimation("attack")
        else
            facesprite:changeAsepriteAnimation("normal")
        end
        facesprite:draw()
        love.graphics.rectangle("line", facesprite.x - facesprite.ox, facesprite.y - facesprite.oy, facesprite.w, facesprite.h)
    end
end

return Stage