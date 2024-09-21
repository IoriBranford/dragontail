local Database = require "Data.Database"
local Character= require "Dragontail.Character"
local State    = require "Dragontail.Character.State"

---@module 'Dragontail.Stage.Characters'
local Characters = {}

local players
local enemies -- characters player must beat to advance
local solids -- characters who should block others' movement
local allcharacters ---@type Character[]
local groups
local scene
local nextid

function Characters.init(scene_, nextid_)
    nextid = nextid_ or 1
    allcharacters = {}
    players = {}
    enemies = {}
    solids = {}
    groups = {
        players = players,
        enemies = enemies,
        solids = solids,
        all = allcharacters
    }
    scene = scene_
end

function Characters.quit()
    allcharacters = nil
    players = nil
    enemies = nil
    solids = nil
    groups = nil
    scene = nil
    nextid = 1
end

function Characters.getGroup(group)
    return groups[group]
end

function Characters.spawn(object)
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
    if not character.id then
        character.id = nextid
        nextid = nextid + 1
    end
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
    if character.team == "player" then
        players[#players+1] = character
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
local spawn = Characters.spawn

function Characters.spawnArray(characters)
    if not characters then return end
    for i = 1, #characters do local object = characters[i]
        spawn(object)
    end
end

function Characters.fixedupdate()
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:fixedupdate()
    end
    for i = 1, #solids do local solid = solids[i]
        for j = 1, #players do local player = players[j]
            solid:collideWithCharacterAttack(player)
        end
        for j = 1, #enemies do local enemy = enemies[j]
            solid:collideWithCharacterAttack(enemy)
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        for j = 1, #players do local player = players[j]
            enemy:collideWithCharacterAttack(player)
        end
        for j = 1, #enemies do local enemy2 = enemies[j]
            enemy:collideWithCharacterAttack(enemy2)
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        for j = 1, #players do local player = players[j]
            player:collideWithCharacterAttack(enemy)
        end
    end
    for i = 1, #solids do local solid = solids[i]
        for j = 1, #players do local player = players[j]
            player:collideWithCharacterBody(solid)
        end
    end
    for i = 1, #players do local player = players[i]
        player:keepInBounds()
        player:updateAttackerSlots()
    end
end

local function pruneCharacters(characters)
    local n = #characters
    for i = n, 1, -1 do
        if characters[i].disappeared then
            characters[i] = characters[n]
            characters[n] = nil
            n = n - 1
        end
    end
end

function Characters.pruneDisappeared()
    for _, characters in pairs(groups) do
        pruneCharacters(characters)
    end
    pruneCharacters(allcharacters)
    scene:prune(Character.hasDisappeared)
end

function Characters.update(dsecs, fixedfrac)
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:update(dsecs, fixedfrac)
    end
end

local function nop() end

---@param eval fun(character: Character):"break"|"return"?
function Characters.search(eval)
    eval = eval or nop
    for i = 1, #allcharacters do local character = allcharacters[i]
        local result = eval(character)
        if result == "break" or result == "return" then
            break
        end
    end
end

return Characters
