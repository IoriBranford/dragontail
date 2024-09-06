local Scene = require "System.Scene"
local Tiled     = require "Tiled"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local State       = require "Dragontail.Character.State"
local Boundary    = require "Object.Boundary"
local Boundaries  = require "Dragontail.Stage.Boundaries"
local Characters  = require "Dragontail.Stage.Characters"
local CameraPath  = require "Object.CameraPath"
local Stage = {
    CameraWidth = 640,
    CameraHeight = 360
}
local sin = math.sin
local max = math.max
local min = math.min

local scene ---@type Scene
local map ---@type TiledMap
local roomindex
local gamestatus
local camera ---@type Camera

---@class Camera:Boundary

function Stage.quit()
    scene = nil
    map = nil
    roomindex = nil
    gamestatus = nil
    camera = nil
    Boundaries.clear()
    Characters.quit()
end

function Stage.init(stagefile)
    scene = Scene()
    Characters.init(scene)

    map = Tiled.Map.load(stagefile)
    map:indexLayersByName()
    map:indexLayerObjectsByName()
    roomindex = 0

    for id, object in pairs(map.objects) do
        if object.type == "Boundary" then
            Boundary.cast(object)
            object:init()
        elseif object.type == "CameraPath" then
            CameraPath.cast(object)
            object:init()
        else
            local characters = object.layer.characters or {}
            object.layer.characters = characters
            characters[#characters+1] = object
        end
    end

    local CameraTopMargin = 32

    camera = Boundary.from({
        shape = "polygon",
        x = 0, y = 0, velx = 0, vely = 0,
        width = Stage.CameraWidth, height = Stage.CameraHeight,
        points = {
            0, CameraTopMargin,
            Stage.CameraWidth, CameraTopMargin,
            Stage.CameraWidth, Stage.CameraHeight,
            0, Stage.CameraHeight
        }
    })
    Boundaries.put("camera", camera)

    scene:addMap(map, "group,tilelayer")

    Characters.spawn({
        x = 160, y = 180, type = "Rose"
    })

    Stage.openNextRoom()
    local room = map.layers["room"..roomindex]
    local camerapath = room.camerapath
    camera.x = camerapath.x + camerapath.points[1] - camera.width/2
    camera.y = camerapath.y + camerapath.points[2] - camera.height/2
end

function Stage.openNextRoom()
    roomindex = roomindex + 1
    local room = map.layers["room"..roomindex]
    if room then
        local roombounds = room.bounds
        Boundaries.put("room"..roomindex, roombounds)
        Characters.spawnArray(room.characters)
        gamestatus = "goingToNextRoom"
        room.camerapath = room.camerapath or CameraPath.from({
            x = 0, y = camera.y + camera.height/2, shape = "polyline",
            points = {
                camera.x + camera.width/2, 0,
                roombounds.x + roombounds.right - camera.width/2, 0
            }
        })
    else
        gamestatus = "victory"
        for _, player in ipairs(Characters.getGroup("players")) do
            State.start(player, "victory")
        end
        Audio.fadeMusic()
    end
end

function Stage.updateGoingToNextRoom()
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)

    local camerapath = room.camerapath ---@type CameraPath

    camera.x, camera.y = camera.x + camera.velx, camera.y + camera.vely

    local camhalfw, camhalfh = camera.width/2, camera.height/2

    if camerapath:isEnd(camera.x + camhalfw, camera.y + camhalfh) then
        camera.velx = 0
        camera.vely = 0
        Stage.startNextFight()
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
    destx = pathx2 >= pathx1 and max(camera.x, destx) or min(camera.x, destx)
    desty = pathy2 >= pathy1 and max(camera.y, desty) or min(camera.y, desty)

    camera.velx, camera.vely = Movement.getVelocity_speed(camera.x, camera.y, destx, desty, 6)
end

function Stage.startNextFight()
    gamestatus = "fight"
    local fight = map.layers["fight"..roomindex]
    assert(fight, "No fight "..roomindex)
    Characters.spawnArray(fight.characters)
end

function Stage.fixedupdate()
    Characters.fixedupdate()

    local enemies = Characters.getGroup("enemies")
    local nenemies = #enemies
    Characters.pruneDisappeared()
    if gamestatus == "fight" then
        if nenemies > 0 and #enemies <= 0 then
            Stage.openNextRoom()
        end
    end

    if gamestatus == "goingToNextRoom" then
        Stage.updateGoingToNextRoom()
    end

    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local room = map.layers["room"..roomindex]
    local boundaries = Boundaries.getAll()
    for id, boundary in pairs(boundaries) do
        if boundary.layer ~= room then
            local x1, y1, x2, y2 = boundary:boundingBox()
            if not math.testrects(cx, cy, cw, ch, x1, y1, x2-x1, y2-y1) then
                boundaries[id] = nil
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
    scene:draw(fixedfrac)
    -- local players = Characters.getGroup("players")
    -- local player = players[1]
    -- Boundaries.get("room"):drawCollisionDebug(player.x, player.y, player.bodyradius)
    love.graphics.pop()
end

return Stage