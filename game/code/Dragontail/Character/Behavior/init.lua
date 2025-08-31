---@class Behavior
---@field character Character
local Behavior = pooledclass()
Behavior._nrec = 1

function Behavior:_init(character)
    self.character = character
end

---@param ... any
function Behavior:start(...) end

---@return string? nextstate
---@return any ...
function Behavior:fixedupdate() end

---@return string? nextstate
---@return any ...
function Behavior:interrupt(nextstate, ...)
    return nextstate, ...
end

---@return string? nextstate
---@return any ...
function Behavior:timeout(nextstate, ...)
    return nextstate, ...
end

return Behavior