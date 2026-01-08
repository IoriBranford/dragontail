local Behavior = require "Dragontail.Character.Behavior"
local Body     = require "Dragontail.Character.Component.Body"

---@class GetItem:Behavior
---@field character Enemy
local GetItem = pooledclass(Behavior)
GetItem._nrec = 1

function GetItem:_init(character)
    self.character = character
end

---@param item Character
function GetItem:start(item)
    local enemy = self.character
    if item.giveweapon then
        if enemy:tryToGiveWeapon(item.giveweapon) then
            item:disappear()
        end
    end
end

---@return string? nextstate
---@return any ...
function GetItem:fixedupdate()
    local enemy = self.character
    Body.forceTowardsVelXY(enemy, 0, 0, enemy.accel)
end

---@return string? nextstate
---@return any ...
function GetItem:interrupt(nextstate, ...)
    return nextstate, ...
end

---@return string? nextstate
---@return any ...
function GetItem:timeout(nextstate, ...)
    return nextstate, ...
end

---@param fixedfrac number
function GetItem:draw(fixedfrac)
end

return GetItem