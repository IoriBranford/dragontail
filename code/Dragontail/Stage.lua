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

local scene
local player -- character controlled by player
local enemies -- characters player must beat to advance
local solids -- characters who should block others' movement
local allcharacters
local bounds
local map
local roomindex
local gamestatus
local camerax, cameray, cameravelx, cameravely
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
    cameravelx, cameravely = 0, 0

    scene:addMap(map, "group,tilelayer")

    player = Stage.addCharacter({
        x = 160, y = 180, type = "Rose", bounds = bounds
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
    for _, object in ipairs(objects) do
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
    camerax = camerax + cameravelx
    camerax = max(0, camerax)
    bounds.x = camerax
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    local roombounds = room.bounds
    local cameradestx = player.x - 640/2
    if camerax < cameradestx then
        cameravelx = Movement.moveTowards(camerax, cameradestx, 6) - camerax
    else
        cameravelx = 0
    end
    local roomright = roombounds.x + roombounds.width
    local cameraxmax = roomright - 640
    if camerax >= cameraxmax then
        camerax = cameraxmax
        bounds.x = camerax
        cameravelx = 0
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
            characters[n] = nil
            n = n - 1
        end
    end
    if onempty and n0 > 0 and n == 0 then
        onempty(...)
    end
end

function Stage.fixedupdate()
    for _, character in ipairs(allcharacters) do
        character:fixedupdate()
    end
    for _, solid in ipairs(solids) do
        solid:collideWithCharacterAttack(player)
        for _, enemy in ipairs(enemies) do
            solid:collideWithCharacterAttack(enemy)
        end
    end
    for _, enemy in ipairs(enemies) do
        enemy:collideWithCharacterAttack(player)
        for _, enemy2 in ipairs(enemies) do
            enemy:collideWithCharacterAttack(enemy2)
        end
    end
    for _, enemy in ipairs(enemies) do
        player:collideWithCharacterAttack(enemy)
    end
    for _, solid in ipairs(solids) do
        player:collideWithCharacterBody(solid)
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

function Stage.fixedupdateGui(gui)
    local healthpercent = player.health / player.maxhealth
    local hud = gui.hud

    hud.health:setPercent(healthpercent)

    local portrait = hud.portrait
    portrait.sprite.ox = portrait.sprite.w/2 + sin(player.hurtstun)
    if gamestatus == "victory" then
        portrait:changeTile("win")
    elseif player.hurtstun > 0 or healthpercent <= 0.5 then
        portrait:changeTile("hurt")
    elseif player.attackangle then
        portrait:changeTile("attack")
    else
        portrait:changeTile("normal")
    end
end

function Stage.update(dsecs, fixedfrac)
    for _, character in ipairs(allcharacters) do
        character:update(dsecs, fixedfrac)
    end
end

function Stage.draw(fixedfrac)
    love.graphics.push()
    love.graphics.translate(-camerax - cameravelx*fixedfrac, -cameray - cameravely*fixedfrac)
    scene:draw()
    love.graphics.pop()
end

return Stage