local Characters = require "Dragontail.Stage.Characters"
local Body       = require "Dragontail.Character.Body"
local Audio    = require "System.Audio"
local StateMachine   = require "Dragontail.Character.StateMachine"

---@class HeldByOpponent:Character
---@field heldby HoldOpponent?
---@field heldai string?
---@field aiafterbreakaway string?
---@field attackafterbreakaway string?
---@field aiafterheld string?

---@class HoldOpponent:Character
---@field heldopponent HeldByOpponent?
---@field holdangle number?
---@field grabradius number?
---@field holdsound string?
local HoldOpponent = {}

---@param opponent HeldByOpponent
function HoldOpponent:startHolding(opponent)
    self.heldopponent = opponent
    opponent:stopAttack()
    opponent:stopGuarding()
    opponent.heldby = self
    Audio.play(self.holdsound)
    StateMachine.start(opponent, opponent.heldai or "held", self)
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

---@return HeldByOpponent?
function HoldOpponent:findOpponentToHold(inx, iny)
    local x, y, opponents = self.x, self.y, Characters.getGroup("all")
    for i, opponent in ipairs(opponents) do
        if opponent.canbegrabbed then
            local oppox, oppoy, oppoz = opponent.x, opponent.y, opponent.z
            local distx = oppox - x
            local disty = oppoy - y
            if math.dot(distx, disty, inx, iny) > 0 then
                local penex, peney = Body.getCylinderPenetration(self, oppox, oppoy, oppoz, opponent.bodyradius, opponent.bodyheight)
                if penex or peney then
                    return opponent
                end
            end
        end
    end
end

function HoldOpponent:updateOpponentPosition()
    local enemy = self.heldopponent
    if not enemy then return end

    local grabradius = self.grabradius or 8
    local radii = grabradius + enemy.bodyradius
    local ox = radii*math.cos(self.holdangle or 0)
    local oy = radii*math.sin(self.holdangle or 0)
    local oz = math.max(0, (self.bodyheight - enemy.bodyheight)/2)
    enemy.x = self.x + ox
    enemy.y = self.y + oy
    enemy.z = self.z + oz
end

function HoldOpponent:handleOpponentCollision()
    local enemy = self.heldopponent
    if not enemy then return end
    local epenex, epeney = Body.keepInBounds(enemy)
    if epenex and epeney then
        local grabradius = self.grabradius or 8
        local radii = grabradius + enemy.bodyradius
        local ox = radii*math.cos(self.holdangle or 0)
        local oy = radii*math.sin(self.holdangle or 0)
        self.x = enemy.x - ox
        self.y = enemy.y - oy
        return epenex, epeney
    end
end

return HoldOpponent