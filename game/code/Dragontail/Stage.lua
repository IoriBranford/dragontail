local Scene = require "System.Scene"
local Tiled     = require "Tiled"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local StateMachine       = require "Dragontail.Character.StateMachine"
local Characters  = require "Dragontail.Stage.Characters"
local CameraPath  = require "Object.CameraPath"
local Config      = require "System.Config"
local Events      = require "Dragontail.Stage.Events"
local Database    = require "Data.Database"
local Assets      = require "Tiled.Assets"
local CollisionMask = require "Dragontail.Character.Body.CollisionMask"
local Stage = {
    CameraWidth = 480,
    CameraHeight = 270
}
local sin = math.sin
local max = math.max
local min = math.min

local scene ---@type Scene
local map ---@type TiledMap
local roomindex
local winningteam
local camera ---@type Camera
local eventthread ---@type thread?

---@class Boundary:TiledObject
---@class Camera:Boundary

function Stage.quit()
    scene = nil
    map = nil
    roomindex = nil
    winningteam = nil
    camera = nil
    Characters.quit()
end

function Stage.init(stagefile)
    map = Tiled.Map.load(stagefile)
    map:indexLayersByName()
    map:indexLayerObjectsByName()
    map:indexTilesetTilesByName()
    map:markAndCountEmptyTiles()

    scene = Scene()

    for _, object in pairs(map.objects) do
        if object.type == "CameraPath" then
            CameraPath.cast(object)
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
        end
    end

    local MinStageHeight = 512
    local CameraTopMargin = 32
    local floorz = map.floorz or 0
    local ceilingz = map.ceilingz or (floorz + MinStageHeight)
    ceilingz = max(ceilingz, floorz + MinStageHeight)

    camera = {
        visible = false,
        shape = "polygon",
        bodyinlayers = CollisionMask.get("Camera"),
        bodyheight = 0x20000000,
        x = 0, y = 0, z = -0x10000000,
        width = Stage.CameraWidth, height = Stage.CameraHeight,
        points = {
            0, CameraTopMargin,
            Stage.CameraWidth, CameraTopMargin,
            Stage.CameraWidth, Stage.CameraHeight,
            0, Stage.CameraHeight
        }
    }
    Characters.init(scene, map.nextobjectid, camera)

    Characters.spawn({
        visible = false,
        shape = "polygon",
        bodyinlayers = CollisionMask.get("Solid"),
        bodyheight = ceilingz - floorz,
        x = 0, y = 0, z = floorz,
        width = 0x20000000, height = 0x20000000,
        points = {
            -0x10000000,-0x10000000,
            0x10000000,-0x10000000,
            0x10000000,0x10000000,
            -0x10000000,0x10000000,
        }
    })

    scene:addMap(map, "group,tilelayer")

    local rooms = map.layers.rooms
    local firstroomindex = 1
    local firstroomid = nil
    for i, room in ipairs(rooms) do
        if room.id == firstroomid then
            firstroomindex = i
            break
        end
    end
    firstroomindex = min(firstroomindex, #rooms)
    local firstroom = rooms[firstroomindex]
    local camerapath = firstroom.camerapath
    while not camerapath do
        firstroomindex = firstroomindex - 1
        firstroom = map.layers.rooms[firstroomindex]
        camerapath = firstroom.camerapath
    end
    if camerapath then
        camera.x = camerapath.x + camerapath.points[1] - camera.width/2
        camera.y = camerapath.y + camerapath.points[2] - camera.height/2
    end

    Characters.spawn({
        x = camera.x + camera.width/4, y = camera.y + camera.height/2, type = "Rose"
    })
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

    if not eventthread then
        local players = Characters.getGroup("players")
        for _, player in ipairs(players) do
            StateMachine.start(player, "control")
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

function Stage.startEvent(event)
    local eventfunction = Events[event]
    if type(eventfunction) == "function" then
        eventthread = coroutine.create(eventfunction)
        Stage.updateEvent()
    end
end

function Stage.updateEvent()
    if eventthread then
        local ok, err = coroutine.resume(eventthread)
        if coroutine.status(eventthread) == "dead" then
            eventthread = nil
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
        Stage.startEvent(room.eventfunction)
        if Config.cuecards then
            local cuecard = room.titlebarcuecard or ""
            if cuecard ~= "" then
                love.window.setTitle(cuecard)
            end
        end
    else
        winningteam = "players"
        for _, player in ipairs(Characters.getGroup("players")) do
            StateMachine.start(player, "victory")
        end
        Audio.fadeMusic()
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
    local room = map.layers.rooms[roomindex]
    if not room then
        return
    end

    if Stage.isInNextRoom() then
        camera.velx = 0
        camera.vely = 0
        local enemies = Characters.getGroup("enemies")
        local donewhenenemiesleft = room.donewhenenemiesleft or 0
        if #enemies <= donewhenenemiesleft and not eventthread then
            Stage.openRoom(roomindex + 1)
        end
        return
    end

    local camerapath = room.camerapath ---@type CameraPath

    local camhalfw, camhalfh = camera.width/2, camera.height/2
    local centerx, centery = camera.x + camhalfw, camera.y + camhalfh

    local playerscenterx, playerscentery = 0, 0
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        playerscenterx = playerscenterx + player.x
        playerscentery = playerscentery + player.y
    end
    playerscenterx, playerscentery = playerscenterx/#players, playerscentery/#players

    local newcenterx, newcentery, pathx1, pathy1, pathx2, pathy2 = camerapath:getCameraCenter(playerscenterx, playerscentery)

    if math.dot(newcenterx - centerx, newcentery - centery, pathx2-pathx1, pathy2-pathy1) < 0 then
        camera.velx, camera.vely = 0, 0
    else
        camera.velx, camera.vely = Movement.getVelocity_speed(centerx, centery, newcenterx, newcentery, 8)
    end

    -- local bestdot = math.dot(camera.velx, camera.vely, pathx2-pathx1, pathy2-pathy1)
    -- for _, player in ipairs(players) do
    --     newcenterx, newcentery, pathx1, pathy1, pathx2, pathy2 =
    --         camerapath:getCameraCenter(centerx + player.velx, centery + player.vely)
    --     if math.dot(newcenterx - centerx, newcentery - centery, pathx2-pathx1, pathy2-pathy1) >= bestdot then
    --         camera.velx = newcenterx - centerx
    --         camera.vely = newcentery - centery
    --     end
    -- end
end

function Stage.fixedupdate()
    Stage.updateEvent()

    Characters.fixedupdate()
    Characters.pruneDisappeared()

    if not winningteam then
        Stage.updateGoingToNextRoom()
    end

    local room = map.layers.rooms[roomindex]
    local solids = Characters.getGroup("solids")
    for _, solid in ipairs(solids) do
        if solid.layer ~= room
        and CollisionMask.test(solid.bodyinlayers, "Solid") ~= 0 then
            if not solid:isOnCamera(camera) then
                solid:disappear()
            end
        end
    end

    local items = Characters.getGroup("items")
    for _, item in ipairs(items) do
        if item.layer ~= room then
            if not item:isOnCamera(camera) then
                item:disappear()
            end
        end
    end
    scene:animate(1)
end

function Stage.fixedupdateGui(gui)
    local players = Characters.getGroup("players") ---@type Player[]
    local player = players[1]

    local healthpercent = player.health / player.maxhealth
    local hud = gui.gameplay.hud

    gui.gameplay.gameover.visible = player.state and
        (player.state.state == "victory" or player.state.state == "defeat")

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

    local portrait = hud.portrait
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

    -- local runpercent = player.runenergy / player.runenergymax
    -- hud.run:setPercent(runpercent)

    local weaponhud = gui.gameplay.hud_weaponslots
    if weaponhud then
        local inventory = player.inventory
        if #inventory > 0 then
            weaponhud.visible = true

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
                    weaponicon.originx = weapondata.spriteoriginx or 0
                    weaponicon.originy = weapondata.spriteoriginy or 0
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
end

function Stage.update(dsecs, fixedfrac)
    Characters.update(dsecs, fixedfrac)
end

function Stage.draw(fixedfrac)
    if map.backgroundcolor then
        love.graphics.clear(
            map.backgroundcolor[1],
            map.backgroundcolor[2],
            map.backgroundcolor[3])
    end
    love.graphics.push()
    love.graphics.translate(-camera.x - camera.velx*fixedfrac, -camera.y - camera.vely*fixedfrac)
    scene:draw(fixedfrac, Characters.isDrawnBefore)
    love.graphics.pop()
end

return Stage