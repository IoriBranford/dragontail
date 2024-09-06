local Scene = require "System.Scene"
local Tiled     = require "Tiled"
local Audio     = require "System.Audio"
local Movement  = require "Component.Movement"
local State       = require "Dragontail.Character.State"
local Boundary    = require "Object.Boundary"
local Boundaries  = require "Dragontail.Stage.Boundaries"
local Characters  = require "Dragontail.Stage.Characters"
local Stage = {
    CameraWidth = 640,
    CameraHeight = 360
}
local sin = math.sin
local max = math.max
local min = math.min

local scene ---@type Scene
local map
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
        end
    end

    camera = Boundary.from({
        shape = "polygon",
        x = 0, y = 0, velx = 0, vely = 0,
        width = Stage.CameraWidth, height = Stage.CameraHeight,
        points = {
            0, 0,
            Stage.CameraWidth, 0,
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
end

function Stage.openNextRoom()
    roomindex = roomindex + 1
    local room = map.layers["room"..roomindex]
    if room then
        Boundaries.put("room", room.bounds)
        Characters.spawnArray(room)
        gamestatus = "goingToNextRoom"
    else
        gamestatus = "victory"
        for _, player in ipairs(Characters.getGroup("players")) do
            State.start(player, "victory")
        end
        Audio.fadeMusic()
    end
end

function Stage.updateGoingToNextRoom()
    camera.x = camera.x + camera.velx
    camera.x = max(0, camera.x)
    local room = map.layers["room"..roomindex]
    assert(room, "No room "..roomindex)
    local cameradestx = 0
    local players = Characters.getGroup("players")
    for _, player in ipairs(players) do
        cameradestx = cameradestx + player.x
    end
    cameradestx = cameradestx/#players - Stage.CameraWidth/2
    if camera.x < cameradestx then
        camera.velx = Movement.moveTowards(camera.x, cameradestx, 6) - camera.x
    else
        camera.velx = 0
    end
    local roombounds = Boundaries.get("room")
    local roomright = roombounds.x + roombounds.right
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
    Characters.spawnArray(fight)
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
    love.graphics.push()
    love.graphics.translate(-camera.x - camera.velx*fixedfrac, -camera.y - camera.vely*fixedfrac)
    scene:draw(fixedfrac)
    -- local players = Characters.getGroup("players")
    -- local player = players[1]
    -- Boundaries.get("room"):drawCollisionDebug(player.x, player.y, player.bodyradius)
    love.graphics.pop()
end

return Stage