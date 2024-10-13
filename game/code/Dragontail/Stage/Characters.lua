local Database = require "Data.Database"
local Character= require "Dragontail.Character"
local State    = require "Dragontail.Character.State"
local Assets = require "Tiled.Assets"
local TiledObject  = require "Tiled.Object"

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
        items = {},
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
    if not getmetatable(object) then
        TiledObject.from(object)
    end
    local typ = object.type
    if typ then
        Database.fillBlanks(object, typ)
    end
    local ok, script = false, object.script
    if script then
        ok, script = pcall(require, script)
    end
    if not ok then
        script = Character
    end
    if not object.tile then
        local tileset, tile = object.tileset, object.tileid
        if type(tileset) == "string" then
            tile = Assets.getTile(tileset, tile)
            if tile then
                object:initTile(tile)
            end
        end
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
    if character.team == "item" then
        groups.items[#groups.items+1] = character
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
    for i = 1, #players do local player = players[i]
        if player:isAttacking() then
            for j = 1, #enemies do local enemy = enemies[j]
                enemy:collideWithCharacterAttack(player)
            end
            for j = 1, #solids do local solid = solids[j]
                solid:collideWithCharacterAttack(player)
            end
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        if enemy:isAttacking() then
            for j = 1, #enemies do local enemy2 = enemies[j]
                enemy2:collideWithCharacterAttack(enemy)
            end
            for j = 1, #solids do local solid = solids[j]
                solid:collideWithCharacterAttack(enemy)
            end
        end
    end
    for i = 1, #solids do local solid = solids[i]
        if solid:isAttacking() then
            for j = 1, #enemies do local enemy = enemies[j]
                enemy:collideWithCharacterAttack(solid)
            end
            for j = 1, #solids do local solid2 = solids[j]
                solid2:collideWithCharacterAttack(solid)
            end
        end
    end

    for i = 1, #solids do local solid = solids[i]
        if solid:isAttacking() then
            for j = 1, #players do local player = players[j]
                player:collideWithCharacterAttack(solid)
            end
        end
    end
    for i = 1, #enemies do local enemy = enemies[i]
        if enemy:isAttacking() then
            for j = 1, #players do local player = players[j]
                player:collideWithCharacterAttack(enemy)
            end
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

---@param raycast Raycast
function Characters.castRay(raycast, rx, ry, caster)
    raycast.hitdist = nil
    local hitsomething
    local rdx, rdy = raycast.dx, raycast.dy
    local group = groups[raycast.canhitgroup] or allcharacters
    for _, character in ipairs(group) do
        if character ~= caster and character:collideWithRaycast(raycast, rx, ry) then
            raycast.dx, raycast.dy = raycast.hitx - rx, raycast.hity - ry
            hitsomething = character
        end
    end
    raycast.dx, raycast.dy = rdx, rdy
    raycast.hitcharacter = hitsomething
    return hitsomething
end

local function nop() end

---@param eval fun(character: Character, i: integer?, characters: Character[]?):"break"|"return"?
function Characters.search(group, eval)
    local characters = groups[group] or allcharacters
    for i = 1, #characters do local character = characters[i]
        local result = eval(character, i, characters)
        if result == "break" or result == "return" then
            break
        end
    end
end

function Characters.keepCircleIn(x, y, r)
    local totalpenex, totalpeney, penex, peney
    for _, solid in ipairs(solids) do
        if solid.bodysolid then
            penex, peney = solid:getCirclePenetration(x, y, r)
            if penex then
                x = x - penex
                totalpenex = (totalpenex or 0) + penex
            end
            if peney then
                y = y - peney
                totalpeney = (totalpeney or 0) + peney
            end
        end
    end
    return x, y, totalpenex, totalpeney
end

function Characters.keepCylinderIn(x, y, z, r, h, self)
    local totalpenex, totalpeney, totalpenez, penex, peney, penez
    for _, solid in ipairs(solids) do
        if solid ~= self and solid.bodysolid then
            penex, peney, penez = solid:getCylinderPenetration(x, y, z, r, h)
            if penex then
                x = x - penex
                totalpenex = (totalpenex or 0) + penex
            end
            if peney then
                y = y - peney
                totalpeney = (totalpeney or 0) + peney
            end
            if penez then
                z = z - penez
                totalpenez = (totalpenez or 0) + penez
            end
        end
    end
    return x, y, z, totalpenex, totalpeney, totalpenez
end

function Characters.getCylinderFloorZ(x, y, z, r, h)
    local floorz
    for _, solid in ipairs(solids) do
        if solid.bodysolid then
            local fz = solid:getCylinderFloorZ(x, y, z, r, h)
            if fz then
                floorz = math.max(floorz or fz, fz)
            end
        end
    end
    return floorz
end

---@param a Character
---@param b Character
function Characters.isDrawnBefore(a, b)
    local az = a.drawz or 0
    local bz = b.drawz or 0
    if az < bz then
        return true
    elseif az > bz then
        return false
    end

    local ay = a.y or 0
    local by = b.y or 0
    if ay < by then
        return true
    elseif ay > by then
        return false
    end

    az = a.z or 0
    bz = b.z or 0
    if az < bz then
        return true
    elseif az > bz then
        return false
    end

    local ax = a.x or 0
    local bx = b.x or 0
    if ax < bx then
        return true
    elseif ax > bx then
        return false
    end

    return a.id < b.id
end

return Characters
