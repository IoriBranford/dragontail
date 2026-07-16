local Database = require "Data.Database"
local Character= require "Dragontail.Character"
local StateMachine    = require "Dragontail.Character.Component.StateMachine"
local Assets = require "Tiled.Assets"
local TiledObject  = require "Tiled.Object"
local Body         = require "Dragontail.Character.Component.Body"
local CollisionMask= require "Dragontail.Character.Component.Body.CollisionMask"
local Attacker     = require "Dragontail.Character.Component.Attacker"
local tablepool    = require "tablepool"
local AttackTarget = require "Dragontail.Character.Component.AttackTarget"
local Audio        = require "System.Audio"
local findClosest  = require "findClosest"
local ihash        = require "ihash"
local BodyLayers   = require "Dragontail.Stage.BodyLayers"

---@module 'Dragontail.Stage.Characters'
local Characters = {}

local players ---@type ihash<Character>
local enemies ---@type ihash<Character> characters player must beat to advance
local solids ---@type ihash<Character>
local allcharacters ---@type ihash<Character>
local byid ---@type table<integer,Character>
local groups
local scene
local nextid
local camera
local clearlostenemiestimer
local ClearLostEnemiesAfterTime = 60*5

function Characters.init(scene_, nextid_, camera_, mapobjects)
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
        container = {},
        solids = solids,
        triggers = {},
    }
    scene = scene_
    byid = mapobjects
    camera = Characters.spawn(camera_)
end

function Characters.quit()
    for _, character in ipairs(allcharacters) do
        Character.release(character)
    end
    allcharacters = nil
    players = nil
    enemies = nil
    solids = nil
    groups = nil
    scene = nil
    nextid = 1
    camera = nil
    byid = nil
    BodyLayers:clear()
end

function Characters.getById(id)
    return byid[id]
end

function Characters.getGroup(group)
    return group == "all" and allcharacters or groups[group]
end

function Characters.addToGroup(g, c)
    g = Characters.getGroup(g)
    if g then
        ihash.add(g, c)
    end
end

function Characters.removeFromGroup(g, c)
    g = Characters.getGroup(g)
    if g then
        ihash.remove(g, c)
    end
end

function Characters.spawn(object)
    local typ = object.type
    if typ then
        Database.fillBlanks(object, typ)
    end
    if not getmetatable(object) then
        TiledObject.from(object)
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
        if character.team == "players" then
            character.opponents = enemies
        else
            character.opponents = players
        end
    end
    if character.bodyinlayers ~= 0 then
        Characters.addToGroup("solids", character)
    end
    Characters.addToGroup(character.team, character)
    if character.team == "triggers" then
        local ok, err = character:validateAction()
        if not ok then print(err) end
    end
    if character.initialai then
        StateMachine.start(character, character.initialai)
    end
    character:addToScene(scene)
    Characters.addToGroup("all", character)
    byid[character.id] = character
    return character
end
local spawn = Characters.spawn

function Characters.spawnArray(characters)
    if not characters then return end
    for i = 1, #characters do local object = characters[i]
        if not object.spawnsmanually then
            spawn(object)
        end
    end
end

local AttackHits = {} ---@type AttackHit[]

function Characters.updateBodies()
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:updateBody()
    end

    for i = 1, #solids do local solid = solids[i]
        local hitvelx, hitvely, hitvelz = solid.hitvelx, solid.hitvely, solid.hitvelz
        if hitvelx then solid.velx = solid.velx - hitvelx end
        if hitvely then solid.vely = solid.vely - hitvely end
        if hitvelz then solid.velz = solid.velz - hitvelz end
    end
end

function Characters.updateAttackHits()
    for i = #AttackHits, 1, -1 do
        AttackHits[i]:_release()
        AttackHits[i] = nil
    end

    for i = 1, #solids do local character = solids[i]
        if character:isAttacking() then
            local mask = character.attack.hitslayers or 0
            for _, layer in BodyLayers:eachLayer(mask, 1) do
                for _, opponent in ipairs(layer) do
                    AttackHits[#AttackHits+1] = Attacker.getAttackHit(character, opponent)
                end
            end
        end
    end

    for _, hit in ipairs(AttackHits) do
        hit.target:onHitByAttack(hit)
        Attacker.onAttackHit(hit.attacker, hit)
    end
end

function Characters.spawnDamageNumbers()
    for _, hit in ipairs(AttackHits) do
        local ftr = hit.target
        local damage = hit.attack.damage
        Characters.spawn({
            lifetime = 60,
            x = ftr.x,
            y = ftr.y,
            z = ftr.z + ftr.bodyheight,
            gravity = .25,
            velz = 4,
            alpha = 1,
            text = tostring(damage),
            fontfamily = "Unifont",
            fixedupdate = function(self)
                if self.velz < -4 then
                    self:disappear()
                end
            end
        })
    end
end

function Characters.updateFloors()
    for i = 1, #allcharacters do local character = allcharacters[i]
        character.floorbody, character.floorz = Characters.getCylinderFloor(
            character.x, character.y, character.z,
            character.bodyradius, character.bodyheight, character.bodyhitslayers)
    end
end

function Characters.updateStates()
    for i = 1, #allcharacters do local character = allcharacters[i]
        character:fixedupdate()
    end
end

function Characters.updatePlayersMisc()
    for i = 1, #players do local player = players[i]
        AttackTarget.updateSlots(player)
        Characters.hitTriggers(player)
    end
end

function Characters.predictCollision()
    for i = 1, #solids do local solid = solids[i]
        local hitvelx, hitvely, hitvelz,
            penex, peney, penez = Body.predictCollisionVelocity(solid)
        solid.hitvelx = hitvelx
        solid.hitvely = hitvely
        solid.hitvelz = hitvelz
        solid.velx = solid.velx + hitvelx
        solid.vely = solid.vely + hitvely
        solid.velz = solid.velz + hitvelz
        solid.penex, solid.peney, solid.penez = penex, peney, penez
    end
end

function Characters.fixedupdateLostEnemiesTimer()
    local numlostenemies = 0
    for i = 1, #enemies do
        local enemy = enemies[i]
        if not enemy:isCylinderOnCamera(camera) then
            numlostenemies = numlostenemies + 1
        end
    end

    if numlostenemies > 0 then
        clearlostenemiestimer = clearlostenemiestimer + 1
    else
        clearlostenemiestimer = 0
    end
end

function Characters.isTimeToClearLostEnemies()
    return clearlostenemiestimer >= ClearLostEnemiesAfterTime
end

function Characters.debugDrawOffScreenEnemyPositions()
    for i = 1, #enemies do
        local enemy = enemies[i]
        enemy:debugDrawOffScreenPosition()
    end
end

function Characters.pruneDisappeared()
    scene:prune(Character.hasDisappeared)
    for _, g in pairs(groups) do
        ihash.prune(g, Character.hasDisappeared)
    end
    BodyLayers:prune(Character.hasDisappeared)
    ihash.prune(allcharacters, Character.hasDisappeared, Character.release)
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
    for _, layer in BodyLayers:eachLayer(raycast.hitslayers, 1) do
        for _, character in ipairs(layer) do
            if character ~= caster and Body.collideWithRaycast3(character, raycast) then
                raycast.dx = raycast.hitx - raycast.x
                raycast.dy = raycast.hity - raycast.y
                raycast.dz = raycast.hitz - raycast.z
                hitsomething = character
            end
        end
    end
    raycast.dx = rdx
    raycast.dy = rdy
    raycast.dz = rdz
    raycast.hitcharacter = hitsomething
    return hitsomething
end

---@param eval fun(character: Character, i: integer?, characters: Character[]?):any
function Characters.search(group, eval)
    local characters = groups[group] or allcharacters
    for i = 1, #characters do local character = characters[i]
        local result = eval(character, i, characters)
        if result then
            return result
        end
    end
end

function Characters.findClosest(group, x, y, z)
    local characters = groups[group] or allcharacters
    return findClosest(characters, x, y, z)
end

function Characters.keepCircleIn(x, y, r, solidlayersmask)
    local totalpenex, totalpeney, penex, peney
    for _, layer in BodyLayers:eachLayer(solidlayersmask, 1) do
        for _, solid in ipairs(layer) do
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
    local hitsmask = self.bodyhitslayers
    if type(hitsmask) == "string" then
        hitsmask = CollisionMask.parse(self.bodyhitslayers)
    end
    local totalpenex, totalpeney, totalpenez, penex, peney, penez
    local function collide(solid)
        if solid == self then return false end
        local mask = solid.bodyinlayers
        if bit.band(mask, hitsmask) == 0 then
            return false
        end

        local any = false
        penex, peney, penez = Body.getCylinderPenetration(
                                    solid, x, y, z, r, h)
        if penex then
            any = true
            x = x - penex
            totalpenex = (totalpenex or 0) + penex
        end
        if peney then
            any = true
            y = y - peney
            totalpeney = (totalpeney or 0) + peney
        end
        if penez then
            any = true
            z = z - penez
            totalpenez = (totalpenez or 0) + penez
        end
        return any
    end
    for i = 1, iterations do
        local any = false
        for _, layer in BodyLayers:eachLayer(hitsmask, 1) do
            for _, solid in ipairs(layer) do
                any = collide(solid)
            end
        end
        if not any then
            break
        end
    end
    return x, y, z, totalpenex, totalpeney, totalpenez
end

function Characters.getCylinderFloor(x, y, z, r, h, hitsmask)
    local floorchar
    local floorz = -math.huge
    local floorpenelensq = -math.huge

    local function testFloor(solid)
        local mask = solid.bodyinlayers
        if bit.band(mask, hitsmask) == 0 then
            return
        end

        local fz, penex, peney = Body.getCylinderFloorZ(
                        solid, x, y, z, r, h)
        if not fz then return end
        if not (penex ~= 0 or peney ~= 0) then return end
        local penelensq = penex and peney
            and math.lensq(penex, peney) or -math.huge
        if fz > floorz
        or fz == floorz and floorpenelensq < penelensq then
            floorchar = solid
            floorz = fz
            floorpenelensq = penelensq
        end
    end

    for _, layer in BodyLayers:eachLayer(hitsmask, 1) do
        for _, solid in ipairs(layer) do
            testFloor(solid)
        end
    end
    return floorchar, floorz
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

    az = a.z or 0
    bz = b.z or 0
    local ay = a.y or 0
    local by = b.y or 0
    local ayz = ay+az
    local byz = by+bz
    if ayz < byz then
        return true
    elseif ayz > byz then
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
    local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
    for _, enemy in ipairs(enemies) do
        ---@cast enemy Enemy
        if enemy ~= boss and enemy.health > 0 then
            enemy.health = 0
            HoldOpponent.stopHolding(enemy, enemy.heldopponent)
            HoldOpponent.stopHolding(enemy.heldby, enemy)
            StateMachine.start(enemy, "fall")
        end
    end
    clearlostenemiestimer = 0
end

function Characters.refillPlayers()
    if players then
        for _, player in ipairs(players) do
            player:cheatRefillAll()
        end
    end
end

return Characters
