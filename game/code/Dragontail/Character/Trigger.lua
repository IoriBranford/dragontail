local Audio = require "System.Audio"
-- local Rescue= require "Dragontail.Stage.Rescue"
local Object= require "Tiled.Object"
local Tiled = require "Tiled"
local Characters = require "Dragontail.Stage.Characters"
-- local Background = require "Dragontail.Stage.Background"
-- local Campaign   = require "Dragontail.Campaign"
local Assets     = require "Tiled.Assets"
local Config     = require "System.Config"
local Stage      = require "Dragontail.Stage"
local Character  = require "Dragontail.Character"

---@class Trigger:Character
---@field action string Name of the function to call on activation
---@field target table|string? Object that should be the "self" argument to the action
---@field module string? Name of the module containing the action, defaults to target
---@field usesleft integer? Number of times it can be activated
---@field user Character? The sole character who can activate this trigger
---@field difficulties string? On what difficulty levels can this trigger activate
local Trigger = class(Character)
Trigger.module = "Dragontail.Character.Trigger"
Trigger.team = "trigger"

function Trigger:hasUsesLeft()
    return not self.usesleft or self.usesleft > 0
end

---@return number? intersectionx
---@return number? intersectiony
function Trigger:checkHit(x, y, prevx, prevy)
    local shape = self.shape
    if shape == "polygon" then
        local points = self.points ---@type number[]
        local tx, ty = self.x, self.y
        if math.pointinpolygon(points, x - tx, y - ty)
        and not math.pointinpolygon(points, prevx - tx, prevy - ty) then
            return x, y
        end
    elseif shape == "point" then
        if self.x == x and self.y == y then
            return x, y
        end
    elseif shape == "rectangle" then
        local tx, ty, tw, th = self.x, self.y, self.width, self.height
        if not math.testrects(prevx, prevy, 0, 0, tx, ty, tw, th) then
            if math.testrects(tx, ty, 0, 0, tx, ty, tw, th) then
                return tx, ty
            end
        end
    elseif shape == "polyline" then
        local points = self.points ---@type number[]
        local tx, ty = self.x, self.y
        local tx1, ty1 = tx + points[1], ty + points[2]
        for i = 4, #points, 2 do
            local tx2, ty2 = tx + points[i-1], ty + points[i]
            local ix, iy = math.intersectsegments(tx1, ty1, tx2, ty2, prevx, prevy, x, y)
            if ix then
                if not prevx or ix ~= prevx or iy ~= prevy then
                    return ix, iy
                end
            end
            tx1, ty1 = tx2, ty2
        end
    end
end

function Trigger:validateAction()
    local modulename = self.module
    local ok, module = pcall(require, modulename)
    if not ok then
        return false, string.format("trigger %s expects missing module %s",
            tostring(self.id or self), modulename)
    end
    local actionname = self.action
    local action = module[actionname]
    if type(action) == "function" then
        return true
    end
    return false, string.format("trigger %s expects missing function %s in module %s",
        tostring(self.id or self), actionname, modulename)
end

function Trigger:isUser(user)
    return not self.user or self.user == user
end

function Trigger:activate(user, hitx, hity)
    local GamePhase  = require "Dragontail.GamePhase"
    if not (self:isUser(user)
    and self:hasUsesLeft()
    and self:isAllowedByDifficulty(GamePhase.Difficulty)) then
        return
    end
    local target = self.target or "trigger"
    if target == "trigger" then
        target = self
    elseif target == "user" then
        target = user
    end
    local module = self.module and require(self.module) or target
    local action = module[self.action]
    if type(action) == "function" then
        action(target, self, hitx, hity)
        if self.usesleft then
            self.usesleft = self.usesleft - 1
        end
    end
end

function Trigger:activateIfHit(user, x, y, prevx, prevy)
    local hitx, hity = self:checkHit(x, y, prevx, prevy)
    if hitx then
        self:activate(user, hitx, hity)
    end
end

function Trigger:playSound()
    Audio.play(self.soundfile)
end

-- function Trigger:playMusic()
--     local musicfile = self.musicid and Campaign.getMusicFile(self.musicid, Config.soundtrack)
--     if musicfile and Assets.fileInfo(musicfile) then
--         Audio.playMusic(musicfile)
--     end
-- end

-- function Trigger:fadeMusic()
--     local nextmusicfile = self.nextmusicid and Campaign.getMusicFile(self.nextmusicid, Config.soundtrack)
--     if not nextmusicfile or Assets.fileInfo(nextmusicfile) then
--         Audio.fadeMusic()
--     end
-- end

function Trigger:isAllowedByDifficulty(difficulty)
    local difficulties = self.difficulties or "all"
    if difficulties == "all" then
        return true
    end
    for diff in difficulties:gmatch("%S+") do
        if diff == difficulty then
            return true
        end
    end
end

-- function Trigger:areRequiredTriggerEnemiesCleared()
--     local requiretriggerenemiescleared = self.requiretriggerenemiescleared ---@type Trigger
--     if not requiretriggerenemiescleared then
--         return true
--     end
--     local layer = requiretriggerenemiescleared and requiretriggerenemiescleared.layer
--     if not layer or not layer.charactersspawned then
--         return
--     end
--     local characters = layer.characters ---@type CharacterGroup
--     return not characters or characters:areAllEnemyShipsDefeated()
-- end

-- function Trigger:isPlayerOnRequiredStageSide()
--     local requireplayeronstageside = self.requireplayeronstageside or 0
--     if requireplayeronstageside == 0 then
--         return true
--     end
--     local Stage = require "Dragontail.Stage"
--     return Stage.isPlayerOnSide(requireplayeronstageside)
-- end

-- function Trigger:spawnCharacters()
--     if self.layer.charactersspawned then
--         return
--     end
--     if not self:areRequiredTriggerEnemiesCleared()
--     or not self:isPlayerOnRequiredStageSide() then
--         return
--     end
--     local characters = self.layer.characters
--     Characters.spawnArray(characters)
--     self.layer.charactersspawned = true
-- end

-- function Trigger:spawnFromPrefabs()
--     Characters.spawnPrefabs(self.prefabs, self.layer)
-- end

-- function Trigger:spawnCharactersFromTileLayer()
--     if not self:areRequiredTriggerEnemiesCleared()
--     or not self:isPlayerOnRequiredStageSide() then
--         return
--     end

--     local layergroup = self.layer.layer ---@cast layergroup LayerGroup
--     if layergroup.type ~= "group" then
--         return
--     end

--     local tilelayer = layergroup[self.layername] ---@type TileLayer
--     if not tilelayer or not tilelayer.visible then
--         return
--     end

--     tilelayer:setVisible(false)
--     local z = tilelayer.z

--     tilelayer:forCells(
--         function(x, y, tile, sx, sy)
--             return tile and Characters.spawn(Tiled.Object.from {
--                 tile = tile,
--                 x = x + tile.offsetx + tile.objectoriginx,
--                 y = y + tile.offsety + tile.objectoriginy - tile.height,
--                 z = z,
--                 scalex = sx,
--                 scaley = sy,
--             })
--         end)
-- end

-- function Trigger:lerpCameraVelocity()
--     local Stage = require "Dragontail.Stage"
--     Stage.lerpCameraVelocity(self.cameravely0, self.cameravely, self.height)
-- end

-- function Trigger:stopStageScroll()
--     local Stage = require "Dragontail.Stage"
--     Stage.setVelY(0)
-- end

-- function Trigger:addRescuees()
--     local characters = self.layer.characters
--     if characters then
--         for _, character in ipairs(characters) do
--             if character.needsrescue then
--                 Rescue.addToRescue()
--             end
--         end
--     end
-- end

-- function Trigger:startRescue()
--     Rescue.reset()
--     self:addRescuees()
-- end

-- function Trigger:finishRescue()
--     Rescue.finish(self.pointsperrescue or 0, self.minrescuesforbonus or 1, self.rescueetype or "friend")
-- end

-- function Trigger:setLayersInGame(trigger)
--     Background.setLayersInGame(trigger.layerpaths, trigger.ingame)
-- end

function Trigger:startStageEvent()
    Stage.startEvent(self.event)
end

return Trigger