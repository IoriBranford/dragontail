---@class Behavior
---@field character Character
local Behavior = class()

function Behavior:_init(character)
    self.character = character
end

---@param ... any
function Behavior:start(...) end

---@return string? nextstate
---@return any ...
function Behavior:fixedupdate() end

function Behavior:stop() end

return Behavior