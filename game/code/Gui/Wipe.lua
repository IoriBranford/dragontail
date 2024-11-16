local ObjectGroup = require "Tiled.ObjectGroup"
local Movement    = require "Component.Movement"

---@class Wipe:ObjectGroup
---@field wipefunction string
local Wipe = class(ObjectGroup)

---@param direction "close"|"open"|"closeandopen"
function Wipe:start(direction)
    local funcname = self[direction.."function"]
    local func = self[funcname]
    if type(func) == "function" then
        self.thread = coroutine.create(func)
        self:run(0)
    end
end

function Wipe:run(dt)
    if self.thread then
        local ok, err = coroutine.resume(self.thread, self, dt)
        if coroutine.status(self.thread) == "dead" then
            self.thread = nil
            if not ok then
                print(err)
            end
        end
    end
end

function Wipe:animate(dt)
    ObjectGroup.animate(self, dt)
    self:run(dt)
end

function Wipe:isDone()
    return not self.thread
end

function Wipe:twoCurtainsMove(leftstartx, leftdestx, rightstartx, rightdestx)
    local left = self.left ---@cast left GuiObject
    local right = self.right ---@cast right GuiObject
    if not left or not right then
        return
    end
    local speed = self.speed or 8
    local leftvelx, rightvelx = leftdestx - leftstartx, rightdestx - rightstartx
    leftvelx, rightvelx = leftvelx*speed/math.abs(leftvelx), rightvelx*speed/math.abs(rightvelx)
    left.x = leftstartx
    right.x = rightstartx
    repeat
        local _, dt = coroutine.yield()
        left.x = Movement.moveTowards(left.x, leftdestx, leftvelx*dt)
        right.x = Movement.moveTowards(right.x, rightdestx, rightvelx*dt)
    until left.x == leftdestx and right.x == rightdestx
end

function Wipe:twoCurtainsClose()
    local left = self.left ---@cast left GuiObject
    local right = self.right ---@cast right GuiObject
    if not left or not right then
        return
    end
    self:twoCurtainsMove(left.openx, left.closedx, right.openx, right.closedx)
end

function Wipe:twoCurtainsOpen()
    local left = self.left ---@cast left GuiObject
    local right = self.right ---@cast right GuiObject
    if not left or not right then
        return
    end
    self:twoCurtainsMove(left.closedx, left.openx, right.closedx, right.openx)
end

function Wipe:twoCurtainsCloseAndOpen()
    self:twoCurtainsClose()
    self:twoCurtainsOpen()
end

return Wipe