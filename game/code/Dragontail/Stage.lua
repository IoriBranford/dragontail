local Scene = require "System.Scene"
local Character = require "Dragontail.Character"
local Tiled     = require "Tiled"
local Database    = require "Data.Database"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local State       = require "Dragontail.Character.State"
local Boundary    = require "Object.Boundary"
local Boundaries  = require "Dragontail.Stage.Boundaries"
local Stage = {
    CameraWidth = 640,
    CameraHeight = 360
}
local sin = math.sin
local max = math.max
local min = math.min

local scene ---@type Scene
local player -- character controlled by player
local players
local enemies -- characters player must beat to advance
local solids -- characters who should block others' movement
local allcharacters ---@type Character[]
local map
local roomindex
local gamestatus
local camera ---@type Camera

---@class Camera:Boundary

function Stage.quit()
    scene = nil
    player = nil
    players = nil
    enemies = nil
    solids = nil
    allcharacters = nil
    map = nil
    roomindex = nil
    gamestatus = nil
    camera = nil
end

function Stage.init(stagefile)
    scene = Scene()
    allcharacters = {}
    players = {}
    enemies = {}
    solids = {}

    map = Tiled.Map.load(stagefile)
    map:indexLayersByName()
    map:indexLayerObjectsByName()
    roomindex = 0

    for id, object in pairs(map.objects) do
        if object.type == "Boundary" then
            Boundary.cast(object)
            object:init()
        end
    end

    camera = Boundary.from({
        shape = "rectangle",
        x = 0, y = 0, velx = 0, vely = 0,
        width = Stage.CameraWidth, height = Stage.CameraHeight
    })
    Boundaries.put("camera", camera)

    scene:addMap(map, "group,tilelayer")

    player = Stage.addCharacter({
        x = 160, y = 180, type = "Rose"
    })
    players[#players+1] = player

    Stage.openNextRoom()
end

function Stage.addCharacter(object)
    local type = object.type
    if type then
        Database.fillBlanks(object, type)
    end
    local ok, script = false, object.script
    if script then
        ok, script = pcall(require, script)
    end
    if not ok then
        script = Character
    end
    local character = script.cast(object) ---@type Character
    character:init()
    character:initAseprite()

    character.solids = solids
    if character.team == "player" then
        character.opponents = enemies
    else
        character.opponents = players
    end
    if character.bodysolid then
        solids[#solids+1] = character
    end
    if character.team == "enemy" then
        enemies[#enemies+1] = character
    end
    if character.initialai then
        State.start(character, character.initialai)
    end
    character:addToScene(scene)
    allcharacters[#allcharacters+1] = character
    return character
end
local addCharacter = Stage.addCharacter

function Stage.addCharacters(objects)
    for i = 1, #objects do local object = objects[i]
        local typ = object.type
        if typ ~= "" then
            if typ == "Boundary" then
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
        Boundaries.put("room", room.bounds)
        addCharacters(room)
        gamestatus = "goingToNextRoom"
    else
        gamestatus = "victory"
        State.start(player, "victory")
        Audio.fadeMusic()
    end
end

function Stage.updateGoingToNextRoom()
    camera.x = camera.x + camera.velx
    camera.x = max(0, camera.x)
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    local cameradestx = player.x - Stage.CameraWidth/2
    if camera.x < cameradestx then
        camera.velx = Movement.moveTowards(camera.x, cameradestx, 6) - camera.x
    else
        camera.velx = 0
    end
    local roombounds = Boundaries.get("room")
    local roomright = roombounds.right
    local cameraxmax = roomright - Stage.CameraWidth
    if camera.x >= cameraxmax then
        camera.x = cameraxmax
        camera.velx = 0
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
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:fixedupdate()
    end
    for i = 1, #solids do local solid = solids[i]
        solid:collideWithCharacterAttack(player)
        for j = 1, #enemies do local enemy = enemies[j]
            solid:collideWithCharacterAttack(enemy)
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        enemy:collideWithCharacterAttack(player)
        for j = 1, #enemies do local enemy2 = enemies[j]
            enemy:collideWithCharacterAttack(enemy2)
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        player:collideWithCharacterAttack(enemy)
    end
    for i = 1, #solids do local solid = solids[i]
        player:collideWithCharacterBody(solid)
    end
    player:keepInBounds()

    pruneDisappeared(enemies, Stage.openNextRoom)
    pruneDisappeared(solids)
    pruneDisappeared(allcharacters)
    scene:prune(Character.hasDisappeared)

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
    portrait.originx = portrait.width/2 + sin(player.hurtstun)
    if gamestatus == "victory" then
        portrait:changeTile("win")
    elseif player.hurtstun > 0 or healthpercent <= 0.5 then
        portrait:changeTile("hurt")
    elseif player.attackangle then
        portrait:changeTile("attack")
    else
        portrait:changeTile("normal")
    end

    local runpercent = player.runenergy / player.runenergymax
    hud.run:setPercent(runpercent)
end

function Stage.update(dsecs, fixedfrac)
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:update(dsecs, fixedfrac)
    end
end

function Stage.draw(fixedfrac)
    love.graphics.push()
    love.graphics.translate(-camera.x - camera.velx*fixedfrac, -camera.y - camera.vely*fixedfrac)
    scene:draw(fixedfrac)
    -- Boundaries.get("room"):drawCollisionDebug(player.x, player.y, player.bodyradius)
    love.graphics.pop()
end

return Stage