
---@class HeldByOpponent:Character
---@field heldby HoldOpponent?
---@field aiafterbreakaway string?
---@field attackafterbreakaway string?
---@field aiafterheld string?

---@class HoldOpponent:Character
---@field heldopponent HeldByOpponent?
---@field grabradius number?
---@field holdsound string?
local HoldOpponent = {}

---@param opponent HeldByOpponent
function HoldOpponent:startHolding(opponent)
    self.heldopponent = opponent
    opponent:stopAttack()
    opponent:stopGuarding()
    opponent.heldby = self
end

---@param opponent HeldByOpponent
function HoldOpponent:isHolding(opponent)
    return self.heldopponent == opponent
        and opponent.heldby == self
end

---@param opponent HeldByOpponent
function HoldOpponent:stopHolding(opponent)
    if self then
        self.heldopponent = nil
    end
    if opponent then
        opponent.heldby = nil
    end
end

---@param self HeldByOpponent
---@param holder HoldOpponent
function HoldOpponent:heldBy(holder)
    self:stopAttack()
    self:stopGuarding()
    self.velx, self.vely = 0, 0
    while HoldOpponent.isHolding(holder, self) do
        local dx, dy = holder.x - self.x, holder.y - self.y
        if dx == 0 and dy == 0 then
            dx = 1
        end
        coroutine.yield()
    end
    local recoverai = self.aiafterheld or self.recoverai
    if not recoverai then
        print("No aiafterheld or recoverai for "..self.type)
        return "defeat", holder
    end
    return recoverai
end

return HoldOpponent