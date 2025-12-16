local Characters = require "Dragontail.Stage.Characters"
local Body       = require "Dragontail.Character.Component.Body"
local Audio    = require "System.Audio"
local StateMachine   = require "Dragontail.Character.Component.StateMachine"
local Guard          = require "Dragontail.Character.Component.Guard"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"

---@class HeldByOpponent:Character
---@field heldby HoldOpponent?
---@field heldai string?
---@field aiafterbreakaway string?
---@field aiafterheld string?
---@field struggleoffset number?
---@field strugglestrength number?

---@class HoldOpponent:Character
---@field heldopponent HeldByOpponent?
---@field holdangle number?
---@field grabradius number?
---@field holdsound string?
---@field holdstrength number?
---@field initialholdstrength number?
local HoldOpponent = {}
HoldOpponent.DefaultInitialHoldStrength = 120

---@param opponent HeldByOpponent
function HoldOpponent:startHolding(opponent, holdangle)
    self.heldopponent = opponent
    opponent:stopAttack()
    Guard.stopGuarding(opponent)
    opponent.heldby = self
    StateMachine.start(opponent, opponent.heldai or "held", self)
    holdangle = holdangle or HoldOpponent.getInitialHoldAngle(self, opponent)
    self.holdangle = holdangle
    self.initialholdstrength = self.initialholdstrength or HoldOpponent.DefaultInitialHoldStrength
    self.holdstrength = self.initialholdstrength
    return holdangle
end

function HoldOpponent:getInitialHoldAngle(opponenttohold)
    local holddirx, holddiry = opponenttohold.x - self.x,
        opponenttohold.y - self.y
    local holdangle = holddirx == 0 and holddiry == 0
        and self.faceangle or math.atan2(holddiry, holddirx)
    local animationdirections = math.max(1, self.animationdirections or 1)
    return DirectionalAnimation.SnapAngle(holdangle, animationdirections)
end

---@param opponent HeldByOpponent
function HoldOpponent:isHolding(opponent)
    return self.heldopponent == opponent
        and opponent.heldby == self
end

function HoldOpponent:weakenHold(strugglestrength)
    local holdstrength = math.min(
        self.holdstrength - strugglestrength,
        self.initialholdstrength)
    self.holdstrength = holdstrength
    return holdstrength
end

---@param opponent HeldByOpponent
function HoldOpponent:stopHolding(opponent)
    if self then
        self.heldopponent = nil
        self.holdangle = nil
        self.holdstrength = nil
    end
    if opponent then
        opponent.heldby = nil
    end
end

---@param self HeldByOpponent
---@param holder HoldOpponent
function HoldOpponent:heldBy(holder)
    self:stopAttack()
    Guard.stopGuarding(self)
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

function HoldOpponent:updateVelocities()
    local enemy = self.heldopponent
    if not enemy then return end

    local radii = self.bodyradius + enemy.bodyradius + 1
        + (enemy.struggleoffset or 0)
    local ox = radii*math.cos(self.holdangle or 0)
    local oy = radii*math.sin(self.holdangle or 0)
    local oz = math.max(0, (self.bodyheight - enemy.bodyheight)/2)
    local pvelx, pvely, pvelz = self.velx, self.vely, self.velz
    enemy.velx = self.x + pvelx + ox - enemy.x
    enemy.vely = self.y + pvely + oy - enemy.y
    enemy.velz = self.z + pvelz + oz - enemy.z
    local pushvelx, pushvely = Body.predictCollisionVelocity(enemy)
    if pushvelx or pushvely then
        enemy.velx = enemy.velx + pushvelx
        enemy.vely = enemy.vely + pushvely
        self.velx = self.velx + pushvelx
        self.vely = self.vely + pushvely
    end
end

---@deprecated
function HoldOpponent:updateOpponentPosition()
    local enemy = self.heldopponent
    if not enemy then return end

    local radii = self.bodyradius + enemy.bodyradius + 1
    local ox = radii*math.cos(self.holdangle or 0)
    local oy = radii*math.sin(self.holdangle or 0)
    local oz = math.max(0, (self.bodyheight - enemy.bodyheight)/2)
    enemy.velx = self.x + ox - enemy.x
    enemy.vely = self.y + oy - enemy.y
    enemy.velz = self.z + oz - enemy.z
end

---@deprecated
function HoldOpponent:handleOpponentCollision()
    local enemy = self.heldopponent
    if not enemy then return end
    local epenex, epeney = enemy.penex, enemy.peney
    if epenex or epeney then
        local radii = self.bodyradius + enemy.bodyradius + 1
        local ox = radii*math.cos(self.holdangle or 0)
        local oy = radii*math.sin(self.holdangle or 0)
        self.velx = self.velx + enemy.x - ox - self.x
        self.vely = self.vely + enemy.y - oy - self.y
        return epenex, epeney
    end
end

return HoldOpponent