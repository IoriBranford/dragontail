local Scene = require "System.Scene"
local Tiled     = require "Tiled"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local State       = require "Dragontail.Character.State"
local Characters  = require "Dragontail.Stage.Characters"
local CameraPath  = require "Object.CameraPath"
local Config      = require "System.Config"
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
    Characters.init(scene, map.nextobjectid)

    for _, object in pairs(map.objects) do
        if object.type == "CameraPath" then
            CameraPath.cast(object)
            object:init()
        else
            local characters = object.layer.characters or {}
            object.layer.characters = characters
            characters[#characters+1] = object
            object.y = object.y + (object.z or 0)
            if object.type == "Boundary" then
                object.visible = Config.drawbodies
            end
        end
    end

    local CameraTopMargin = 32

    camera = Characters.spawn({
        visible = false,
        shape = "polygon",
        bodysolid = true,
        bodyheight = 512,
        x = 0, y = 0, velx = 0, vely = 0,
        width = Stage.CameraWidth, height = Stage.CameraHeight,
        points = {
            0, CameraTopMargin,
            Stage.CameraWidth, CameraTopMargin,
            Stage.CameraWidth, Stage.CameraHeight,
            0, Stage.CameraHeight
        }
    })

    scene:addMap(map, "group,tilelayer")

    local rooms = map.layers.rooms
    local firstroomindex = 1
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
    local rooms = map.layers.rooms
    if roomindex < #rooms then
        Stage.openRoom(roomindex + 1)
    end
end

function Stage.setToLastRoom()
    roomindex = #map.layers.rooms
end

function Stage.openRoom(i)
    local room = map.layers.rooms[i]
    if room then
        roomindex = i
        local camerawarp = room.camerawarp
        if camerawarp then
            Stage.warpCamera(camerawarp.x, camerawarp.y)
        end
        Characters.spawnArray(room.characters)
    else
        winningteam = "players"
        for _, player in ipairs(Characters.getGroup("players")) do
            State.start(player, "victory")
        end
        Audio.fadeMusic()
    end
end

function Stage.updateGoingToNextRoom()
    local room = map.layers.rooms[roomindex]
    if not room then
        return
    end

    local camerapath = room.camerapath ---@type CameraPath

    local camhalfw, camhalfh = camera.width/2, camera.height/2

    if not camerapath or camerapath:isEnd(camera.x + camhalfw, camera.y + camhalfh) then
        camera.velx = 0
        camera.vely = 0
        local enemies = Characters.getGroup("enemies")
        local donewhenenemiesleft = room.donewhenenemiesleft or 0
        if #enemies <= donewhenenemiesleft then
            Stage.openRoom(roomindex + 1)
        end
        return
    end

    local centerx, centery = 0, 0
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        centerx = centerx + player.x
        centery = centery + player.y
    end
    centerx, centery = centerx/#players, centery/#players

    local pathx1, pathy1, pathx2, pathy2
    centerx, centery, pathx1, pathy1, pathx2, pathy2 = camerapath:getCameraCenter(centerx, centery)

    local destx, desty = centerx - camhalfw, centery - camhalfh
    if math.dot(destx - camera.x, desty - camera.y, pathx2-pathx1, pathy2-pathy1) < 0 then
        camera.velx, camera.vely = 0, 0
    else
        camera.velx, camera.vely = Movement.getVelocity_speed(camera.x, camera.y, destx, desty, 8)
    end
end

function Stage.fixedupdate()
    Characters.fixedupdate()
    Characters.pruneDisappeared()

    if not winningteam then
        Stage.updateGoingToNextRoom()
    end

    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local room = map.layers.rooms[roomindex]
    local solids = Characters.getGroup("solids")
    for _, solid in ipairs(solids) do
        if solid.layer ~= room then
            if not solid:isOnCamera(cx, cy, cw, ch) then
                solid:disappear()
            end
        end
    end

    local items = Characters.getGroup("items")
    for _, item in ipairs(items) do
        if item.layer ~= room then
            if not item:isOnCamera(cx, cy, cw, ch) then
                item:disappear()
            end
        end
    end
    scene:animate(1)
end

function Stage.fixedupdateGui(gui)
    local players = Characters.getGroup("players")
    local player = players[1]

    local healthpercent = player.health / player.maxhealth
    local hud = gui.gameplay.hud

    hud.health:setPercent(healthpercent)

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

    local runpercent = player.runenergy / player.runenergymax
    hud.run:setPercent(runpercent)
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