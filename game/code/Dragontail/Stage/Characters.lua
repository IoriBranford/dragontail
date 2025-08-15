local Database = require "Data.Database"
local Character= require "Dragontail.Character"
local StateMachine    = require "Dragontail.Character.Component.StateMachine"
local Assets = require "Tiled.Assets"
local TiledObject  = require "Tiled.Object"
local Body         = require "Dragontail.Character.Component.Body"
local CollisionMask= require "Dragontail.Character.Component.Body.CollisionMask"
local Attacker     = require "Dragontail.Character.Component.Attacker"
local tablepool    = require "tablepool"

---@module 'Dragontail.Stage.Characters'
local Characters = {}

local players ---@type Character[]
local enemies ---@type Character[] characters player must beat to advance
local solids ---@type Character[] characters who should block others' movement
local allcharacters ---@type Character[]
local groups
local scene
local nextid
local camera
local clearlostenemiestimer
local ClearLostEnemiesAfterTime = 180

function Characters.init(scene_, nextid_, camera_)
    nextid = nextid_ or 1
    clearlostenemiestimer = 0
    allcharacters = {}
    players = {}
    enemies = {}
    solids = {}
    groups = {
        players = players,
        enemies = enemies,
        items = {},
        projectiles = {},
        solids = solids,
        triggers = {},
        all = allcharacters
    }
    scene = scene_
    camera = Characters.spawn(camera_)
end

function Characters.quit()
    allcharacters = nil
    players = nil
    enemies = nil
    solids = nil
    groups = nil
    scene = nil
    nextid = 1
    camera = nil
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
    character.camera = camera
    character.solids = solids
    if not character.opponents then
        if character.team == "player" then
            character.opponents = enemies
        else
            character.opponents = players
        end
    end
    if character.bodyinlayers ~= 0 then
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
    if character.team == "projectile" then
        groups.projectiles[#groups.projectiles+1] = character
    end
    if character.team == "trigger" then
        groups.triggers[#groups.triggers+1] = character
        local ok, err = character:validateAction()
        if not ok then print(err) end
    end
    if character.initialai then
        StateMachine.start(character, character.initialai)
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

local AttackHits = {}

function Characters.fixedupdate()
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:fixedupdate()
    end

    for i = #AttackHits, 1, -1 do
        tablepool.release("AttackHit", AttackHits[i])
        AttackHits[i] = nil
    end

    for i = 1, #solids do local character = solids[i]
        if character:isAttacking() then
            for j = 1, #solids do local opponent = solids[j]
                AttackHits[#AttackHits+1] = Attacker.getAttackHit(character, opponent)
            end
        end
    end

    for _, hit in ipairs(AttackHits) do
        hit.target:onHitByAttack(hit)
        Attacker.onAttackHit(hit.attacker, hit)
    end

    for i = 1, #players do local player = players[i]
        Body.keepInBounds(player)
        player:updateAttackerSlots()
        Characters.hitTriggers(player)
    end

    Characters.fixedupdateLostEnemies()
end

function Characters.fixedupdateLostEnemies()
    if #enemies == 0 then
        clearlostenemiestimer = 0
        return
    end

    local numenemiesonscreen = 0
    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy:isCylinderOnCamera(camera) then
            numenemiesonscreen = numenemiesonscreen + 1
        end
    end

    if numenemiesonscreen == 0 then
        clearlostenemiestimer = clearlostenemiestimer + 1
        if clearlostenemiestimer > ClearLostEnemiesAfterTime then
            Characters.clearEnemies()
            clearlostenemiestimer = 0
        end
    else
        clearlostenemiestimer = 0
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
function Characters.castRay2(raycast, caster)
    raycast.hitdist = nil
    local hitsomething
    local rdx, rdy = raycast.dx, raycast.dy
    for _, character in ipairs(allcharacters) do
        if character ~= caster and Body.collideWithRaycast2(character, raycast) then
            raycast.dx, raycast.dy = raycast.hitx - raycast.x, raycast.hity - raycast.y
            hitsomething = character
        end
    end
    raycast.dx, raycast.dy = rdx, rdy
    raycast.hitcharacter = hitsomething
    return hitsomething
end

---@param raycast Raycast
function Characters.castRay3(raycast, caster)
    raycast.hitdist = nil
    local hitsomething
    local rdx, rdy, rdz = raycast.dx, raycast.dy, raycast.dz
    for _, character in ipairs(allcharacters) do
        if character ~= caster and Body.collideWithRaycast3(character, raycast) then
            raycast.dx = raycast.hitx - raycast.x
            raycast.dy = raycast.hity - raycast.y
            raycast.dz = raycast.hitz - raycast.z
            hitsomething = character
        end
    end
    raycast.dx = rdx
    raycast.dy = rdy
    raycast.dz = rdz
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

function Characters.keepCircleIn(x, y, r, solidlayersmask)
    local totalpenex, totalpeney, penex, peney
    for _, solid in ipairs(solids) do
        if bit.band(solid.bodyinlayers, solidlayersmask) ~= 0 then
            penex, peney = Body.getCirclePenetration(solid, x, y, r)
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

function Characters.keepCylinderIn(x, y, z, r, h, self, iterations)
    iterations = iterations or 3
    local solidlayersmask = self.bodyhitslayers
    local totalpenex, totalpeney, totalpenez, penex, peney, penez
    for i = 1, iterations do
        local anycollision = false
        for _, solid in ipairs(solids) do
            if solid ~= self
            and bit.band(solid.bodyinlayers, solidlayersmask) ~= 0
            then
                penex, peney, penez = Body.getCylinderPenetration(solid, x, y, z, r, h)
                if penex then
                    anycollision = true
                    x = x - penex
                    totalpenex = (totalpenex or 0) + penex
                end
                if peney then
                    anycollision = true
                    y = y - peney
                    totalpeney = (totalpeney or 0) + peney
                end
                if penez then
                    anycollision = true
                    z = z - penez
                    totalpenez = (totalpenez or 0) + penez
                end
            end
        end
        if not anycollision then
            break
        end
    end
    return x, y, z, totalpenex, totalpeney, totalpenez
end

function Characters.getCylinderFloorZ(x, y, z, r, h, solidlayersmask)
    local floorz
    for _, solid in ipairs(solids) do
        if bit.band(solid.bodyinlayers, solidlayersmask) ~= 0 then
            local fz = Body.getCylinderFloorZ(solid, x, y, z, r, h)
            if fz then
                floorz = math.max(floorz or fz, fz)
            end
        end
    end
    return floorz
end

function Characters.hitTriggers(hitter)
    for _, trigger in ipairs(groups.triggers) do
        ---@cast trigger Trigger
        if Body.testBodyCollision(trigger, hitter) then
            trigger:activate(hitter)
        end
    end
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

function Characters.clearEnemies(boss)
    for _, enemy in ipairs(enemies) do
        if enemy ~= boss then
            enemy:disappear()
        end
    end
end

return Characters
