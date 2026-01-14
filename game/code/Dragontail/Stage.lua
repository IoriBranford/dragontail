local Scene = require "System.Scene"
local Tiled     = require "Tiled"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local StateMachine       = require "Dragontail.Character.Component.StateMachine"
local Characters  = require "Dragontail.Stage.Characters"
local CameraPath  = require "Object.CameraPath"
local Config      = require "System.Config"
local Sequences      = require "Dragontail.Stage.Sequences"
local Database    = require "Data.Database"
local Assets      = require "Tiled.Assets"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"
local pathlite = require "pl.pathlite"
local CameraBoundary = require "Object.CameraBoundary"
local Stage = {
    CameraWidth = 480,
    CameraHeight = 270
}
local sin = math.sin
local max = math.max
local min = math.min

local scene ---@type Scene
local map ---@type TiledMap
local firstroomname
local roomindex
local winningteam
local camera ---@type Camera
local sequencethread ---@type thread?
local shader ---@type love.Shader

---@class Boundary:TiledObject
---@class Camera:Boundary

function Stage.quit()
    scene = nil
    map = nil
    roomindex = nil
    winningteam = nil
    camera = nil
    shader = nil
    Characters.quit()
end

function Stage.load(stagefile)
    shader = love.graphics.newShader("shaders/Stage.lslp", "shaders/Stage.lslv")
    map = Tiled.Map.load(stagefile)
    local directory = map.directory
    map:indexLayersByName()
    map:indexLayerObjectsByName()
    map:indexTilesetTilesByName()
    map:markAndCountEmptyTiles()

    for _, object in pairs(map.objects) do
        if object.type == "CameraPath" then
            CameraPath.cast(object)
            object:init()
        elseif object.type == "CameraBoundary" then
            CameraBoundary.cast(object)
            object:init()
        else
            local characters = object.layer.characters or {}
            object.layer.characters = characters
            characters[#characters+1] = object
            object.y = object.y + (object.z or 0)
            if object.type == "Boundary"
            or object.type == "Trigger" then
                object.visible = Config.drawbodies
            end
            if object.extrudeY then
                object.bodyheight = -object.extrudeY
            end
            if object.propertiestable then
                object.propertiestable = pathlite.normjoin(directory, object.propertiestable)
                Database.getTable(object.propertiestable)
            end
        end
    end
end

function Stage.init(startroom)
    local Character = require "Dragontail.Character"
    scene = Scene()

    local MinStageHeight = 1024
    local CameraTopMargin = 32
    local floorz = map.floorz or 0
    local ceilingz = map.ceilingz or (floorz + MinStageHeight)
    ceilingz = max(ceilingz, floorz + MinStageHeight)

    camera = Character()
    camera.visible = false
    camera.shape = "polygon"
    camera.bodyinlayers = CollisionMask.get("Camera")
    camera.bodyheight = 0x20000000
    camera.x = 0
    camera.y = 0
    camera.z = -0x10000000
    camera.lockz = true
    camera.width = Stage.CameraWidth
    camera.height = Stage.CameraHeight
    camera.points = {
        0, CameraTopMargin,
        Stage.CameraWidth, CameraTopMargin,
        Stage.CameraWidth, Stage.CameraHeight,
        0, Stage.CameraHeight
    }
    Characters.init(scene, map.nextobjectid, camera)

    local floorandceiling = Character()
    floorandceiling.visible = false
    floorandceiling.shape = "polygon"
    floorandceiling.bodyinlayers = CollisionMask.get("Wall")
    floorandceiling.bodyheight = ceilingz - floorz
    floorandceiling.x = 0
    floorandceiling.y = 0
    floorandceiling.z = floorz
    floorandceiling.width = 0x20000000
    floorandceiling.height = 0x20000000
    floorandceiling.points = {
        -0x10000000,-0x10000000,
        0x10000000,-0x10000000,
        0x10000000,0x10000000,
        -0x10000000,0x10000000,
    }
    Characters.spawn(floorandceiling)

    scene:addMap(map, "group,tilelayer")

    local function initLayer(layer)
        if layer.layers then
            for _, sublayer in ipairs(layer.layers) do
                initLayer(sublayer)
            end
        end
        local draw = layer.draw
        layer.draw = function(self)
            Stage.setUniform("texRgbFactor", 1)
            draw(self)
        end
    end

    for _, layer in ipairs(map.layers) do
        initLayer(layer)
    end

    local rooms = map.layers.rooms
    local firstroomindex = 1
    if startroom ~= nil then
        firstroomname = startroom
    end
    for i, room in ipairs(rooms) do
        if room.name == firstroomname then
            firstroomindex = i
            break
        end
    end
    firstroomindex = min(firstroomindex, #rooms)
    local firstroom = rooms[firstroomindex]
    local camerapath = firstroom.camerapath
    while not camerapath and firstroomindex > 1 do
        firstroomindex = firstroomindex - 1
        firstroom = map.layers.rooms[firstroomindex]
        camerapath = firstroom.camerapath
    end
    if camerapath then
        camera.x = camerapath.x + camerapath.points[1] - camera.width/2
        camera.y = camerapath.y + camerapath.points[2] - camera.height/2
    end

    local players = map.layers.players
    if players and #players > 0 then
        for _, player in ipairs(players) do
            Characters.spawn(player)
        end
    else
        Database.load("data/database/players-properties.csv")
        local player = Character("Rose")
        Characters.spawn(player)
    end
    Stage.warpCamera(camera.x+camera.width/2, camera.y+camera.height/2)
    for i = firstroomindex - 1, 1, -1 do
        local prevroom = map.layers.rooms[i]
        local characters = prevroom.characters
        if characters then
            local n = 0
            for c = #characters, 1, -1 do
                local character = characters[c]
                if character.type == "Boundary" then
                    Characters.spawn(character)
                    characters[c] = characters[#characters]
                    characters[#characters] = nil
                    n = n + 1
                end
            end
            if n > 0 then
                break
            end
        end
    end
    Stage.openRoom(firstroomindex)

    if not sequencethread then
        local players = Characters.getGroup("players")
        for _, player in ipairs(players) do
            StateMachine.start(player, "walk")
        end
    end
end

function Stage.addToScene(object)
    scene:add(object)
end

local function genDefaultCameraPath(roombounds)
    local rightmost
    for _, bound in ipairs(roombounds) do
        if bound.right then
            if not rightmost or rightmost.x + rightmost.right < bound.x + bound.right then
                rightmost = bound
            end
        end
    end
    local endx
    if rightmost then
        endx = rightmost.x + rightmost.right - camera.width/2
    else
        endx = camera.x + camera.width
    end
    return CameraPath.from({
        x = 0, y = camera.y + camera.height/2, shape = "polyline",
        points = {
            camera.x + camera.width/2, 0,
            endx, 0
        }
    })
end

function Stage.warpCamera(warpx, warpy)
    camera.x = warpx - camera.width/2
    camera.y = warpy - camera.height/2
    local players = Characters.getGroup("players")
    local spacebetween = 64
    local playerx = camera.x + camera.width/4 + spacebetween*(#players - 1)/2
    local playery = camera.y + camera.height/2 - spacebetween*(#players - 1)/2
    for _, player in ipairs(players) do
        player.x, player.y = playerx, playery
        playerx = playerx - spacebetween
        playery = playery + spacebetween
    end
end

function Stage.openNextRoom()
    Stage.openRoom(roomindex + 1)
end

function Stage.openNextRoomIfNotLast()
    local rooms = map.layers.rooms
    if roomindex < #rooms then
        Stage.openRoom(roomindex + 1)
    end
end

function Stage.setToLastRoom()
    roomindex = #map.layers.rooms
end

function Stage.startSequence(name)
    local f = Sequences[name]
    if type(f) == "function" then
        sequencethread = coroutine.create(f)
        Stage.updateSequence()
    end
end

function Stage.updateSequence()
    if sequencethread then
        local ok, err = coroutine.resume(sequencethread)
        if coroutine.status(sequencethread) == "dead" then
            sequencethread = nil
            if not ok then
                print(err)
            end
        end
    end
end

function Stage.openRoom(i)
    local room = map.layers.rooms[i]
    if room then
        roomindex = i
        Characters.spawnArray(room.characters)
        Stage.startSequence(room.sequence)
        if Config.cuecards then
            local cuecard = room.titlebarcuecard or ""
            if cuecard ~= "" then
                love.window.setTitle(cuecard)
            end
        end
        if room.checkpoint then
            firstroomname = room.name
        end
        return room
    else
        winningteam = "players"
        for _, player in ipairs(Characters.getGroup("players")) do
            StateMachine.start(player, "victory")
        end
        Audio.fadeMusic()
        local GamePhase = require "Dragontail.GamePhase"
        GamePhase.gameOver()
    end
end

function Stage.getCurrentRoom()
    return map.layers.rooms[roomindex]
end

---@return CameraPath
function Stage.getCurrentCameraPath()
    local room = map.layers.rooms[roomindex]
    return room and room.camerapath
end

function Stage.isInNextRoom()
    local room = map.layers.rooms[roomindex]
    if not room then
        return false
    end

    local camerapath = room.camerapath ---@type CameraPath

    local camhalfw, camhalfh = camera.width/2, camera.height/2
    local centerx, centery = camera.x + camhalfw, camera.y + camhalfh

    return not camerapath or camerapath:isEnd(centerx, centery)
end

function Stage.updateGoingToNextRoom()
    local room = Stage.getCurrentRoom()
    if not room then
        return
    end
    if Stage.isInNextRoom() then
        local enemies = Characters.getGroup("enemies")
        local donewhenenemiesleft = room.donewhenenemiesleft or 0
        if #enemies <= donewhenenemiesleft and not sequencethread then
            room = Stage.openRoom(roomindex + 1)
            if not room then
                return
            end
        end
    end

    local camhalfw, camhalfh = camera.width/2, camera.height/2
    local centerx, centery = camera.x + camhalfw, camera.y + camhalfh
    local centerz = camera.z + camera.bodyheight/2

    local destx, desty, destz = 0, 0, 0
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        destx = destx + player.x
        desty = desty + player.y
        destz = destz + player.z
    end
    destx = destx/#players
    desty = desty/#players
    destz = destz/#players

    if camera.lockz then
        camera.velz = 0
    else
        camera.velz = destz - centerz
    end

    local camerapath = room.camerapath ---@type CameraPath
    local cameraboundary = room.cameraboundary ---@type CameraBoundary

    if camerapath then
        if cameraboundary then
            destx, desty = cameraboundary:keepPointInside(destx, desty)
            local velx, vely = destx - centerx, desty - centery
            local _, _, ax, ay, bx, by = camerapath:projectPoint(destx, desty)
            local dx, dy = bx-ax, by-ay
            if math.dot(velx, vely, dx, dy) < 0 then
                dx, dy = math.rot90(dx, dy, 1)
                velx, vely = math.projpointline(velx, vely, 0, 0, dx, dy)
                destx, desty = centerx + velx, centery + vely
            end
        else
            local ax, ay, bx, by
            destx, desty, ax, ay, bx, by = camerapath:projectPoint(destx, desty)
            if math.dot(destx-centerx, desty-centery, bx-ax, by-ay) < 0 then
                destx, desty = camerapath:projectPoint(centerx, centery)
            end
        end
    elseif cameraboundary then
        destx, desty = cameraboundary:keepPointInside(destx, desty)
    end

    if camerapath or cameraboundary then
        camera.velx, camera.vely = Movement.getVelocity_speed(centerx, centery, destx, desty, 8)
    else
        camera.velx, camera.vely = 0, 0
    end
end

function Stage.fixedupdate()
    Stage.updateSequence()

    Characters.fixedupdate()
    Characters.pruneDisappeared()

    if not winningteam then
        Stage.updateGoingToNextRoom()
    end

    local room = map.layers.rooms[roomindex]
    local solids = Characters.getGroup("solids")
    for _, solid in ipairs(solids) do
        if solid.layer ~= room
        and CollisionMask.testAny(solid.bodyinlayers, "Object", "Wall") ~= 0 then
            if not solid:isCylinderOnCamera(camera) then
                solid:disappear()
            end
        end
    end

    local items = Characters.getGroup("items")
    for _, item in ipairs(items) do
        if item.layer ~= room then
            if not item:isCylinderOnCamera(camera) then
                item:disappear()
            end
        end
    end
    scene:animate(1)
end

---@param gui Gui
function Stage.fixedupdateGui(gui)
    local players = Characters.getGroup("players") ---@type Player[]
    local player = players[1]

    local healthpercent = player.health / player.maxhealth
    local hud = gui:get("gameplay.hud")
    if hud then
        hud.health:setPercent(healthpercent)

        local manastore = player.manastore
        local manacharge = player.manacharge
        local manaunitsize = player.manaunitsize
        for i = 1, 3 do
            local flamestorepercent = manastore/manaunitsize
            local flamestoregauge = hud["flame"..i] ---@type Gauge
            if flamestoregauge then
                flamestoregauge:setPercent(flamestorepercent)
                flamestoregauge.color = flamestorepercent < 1 and flamestoregauge.normalcolor or flamestoregauge.fullcolor
            end
            local flamechargegauge = hud["flamecharge"..i] ---@type Gauge
            if flamechargegauge then
                local percent = manacharge/manaunitsize
                flamechargegauge:setPercent(flamestorepercent >= 1 and percent or 0)
            end
            local flamefull = hud["flamefullcharge"..i] ---@type GuiObject
            if flamefull then
                flamefull.visible = manacharge >= manaunitsize
            end
            manastore = manastore - manaunitsize
            manacharge = manacharge - manaunitsize
        end
    end

    local portrait = gui:get("gameplay.hud.portrait")
    if portrait then
        portrait.originx = portrait.width/2 + sin(player.hurtstun)
        if winningteam == "players" then
            portrait:changeTile("win")
        elseif player.hurtstun > 0 or healthpercent <= 0.5 then
            portrait:changeTile("hurt")
        elseif player.attackangle then
            portrait:changeTile("attack")
        else
            portrait:changeTile("normal")
        end
    end

    -- local runpercent = player.runenergy / player.runenergymax
    -- hud.run:setPercent(runpercent)

    local weaponhud = gui:get("gameplay.hud_weaponslots")
    if weaponhud then
        local inventory = player.inventory
        if inventory and #inventory > 0 then
            weaponhud.visible = true

            weaponhud.x, weaponhud.y = player.x - camera.x,
                player.y - player.z - player.bodyheight - camera.y

            for i = 1, inventory.capacity do
                local emptyslot = weaponhud["emptyslot"..i]
                local filledslot = weaponhud["fullslot"..i]
                local isfilled = i <= inventory.size
                if filledslot then filledslot.visible = isfilled end
                if emptyslot then emptyslot.visible = not isfilled end
                for s = 1, 4 do
                    local weaponicon = weaponhud[s.."slotweapon"..i]
                    if weaponicon then weaponicon.visible = false end
                end
            end

            local sloti = 1
            for _, itemtype in ipairs(inventory) do
                local weapondata = Database.get(itemtype)
                assert(weapondata)

                local asefile, asetag = weapondata.asefile, weapondata.asetag
                local tileset, tileid = weapondata.tileset, weapondata.tileid
                local weaponsize = weapondata.itemsize

                local weaponicon = weaponhud[weaponsize.."slotweapon"..sloti]
                if not weaponicon then break end

                weaponicon.visible = false
                if asefile then
                    weaponicon.asefile = asefile
                    weaponicon.asetag = asetag
                    local ase = Assets.get(asefile)
                    local originx, originy
                    if ase then
                         ---@cast ase Aseprite
                        originx, originy = ase:getSliceFrameOrigin("origin", asetag)
                        if not originx or not originy then
                            originx, originy = ase[1]:getSliceOrigin("origin")
                        end
                    end
                    weaponicon.originx = originx or 0
                    weaponicon.originy = originy or 0
                    weaponicon.visible = true
                    weaponicon:initAseprite()
                else
                    local tile = tileset and tileid and Assets.getTile(tileset, tileid)
                    if tile then
                        weaponicon.originx = tile.width/2
                        weaponicon.originy = tile.height/2
                        weaponicon.visible = true
                        weaponicon:initTile(tile)
                    end
                end

                sloti = sloti + weaponsize
            end
        else
            weaponhud.visible = false
        end
    end

    local go = gui:get("gameplay.hud_go")
    if go then
        local camerapath = Stage.getCurrentCameraPath()
        if Stage.isInNextRoom() or not camerapath then
            go.visible = false
        else
            local cameracenterx, cameracentery =
                camera.x+camera.width/2,
                camera.y+camera.height/2
            local totargetx, totargety =
                camerapath:getGoIndicatorOffset(
                    cameracenterx, cameracentery,
                    camera.width/4)

            if totargetx ~= 0 or totargety ~= 0 then
                totargetx, totargety = math.norm(totargetx, totargety)
                totargetx = totargetx * camera.width/4
                totargety = totargety * camera.height/4
                go.visible = true
                go.x = totargetx + camera.width/2
                go.y = totargety + camera.height/2
                go.arrow.rotation = math.atan2(totargety, totargetx)
            else
                go.visible = false
            end
        end
    end
end

function Stage.update(dsecs, fixedfrac)
    Characters.update(dsecs, fixedfrac)
end

function Stage.setUniform(var, ...)
    if shader:hasUniform(var) then
        shader:send(var, ...)
    end
end

function Stage.draw(fixedfrac)
    love.graphics.setShader(shader)
    if map.backgroundcolor then
        love.graphics.clear(
            map.backgroundcolor[1],
            map.backgroundcolor[2],
            map.backgroundcolor[3])
    end
    love.graphics.push()
    local x = camera.x + camera.velx*fixedfrac
    local y = camera.y + camera.vely*fixedfrac
    local z = camera.z + camera.bodyheight/2 + camera.velz*fixedfrac
    love.graphics.translate(-x, z - y)
    scene:draw(fixedfrac, Characters.isDrawnBefore)
    love.graphics.pop()
    love.graphics.setShader()
end

return Stage