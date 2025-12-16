---@alias ActionState "pressed"|"released"|"down"|"up"

---@class InputLog
---@field length integer
---@field position integer
---@field sumx number
---@field sumy number
---@field [integer] number joystick log; x at 2*position-1, y at 2*position
---@field actionlogs {[string]:ActionState[]}
---@overload fun(length:integer|10):InputLog
local InputLog = class()

function InputLog:_init(length)
    self.length = length or 6
    self.position = 1
    self.sumx = 0
    self.sumy = 0
    self.actionlogs = {}
end

function InputLog:logJoystick(joystickx, joysticky)
    local position = self.position
    local replacedx = self[position*2-1]
    local replacedy = self[position*2]
    if replacedx then
        self.sumx = self.sumx - replacedx
    end
    if replacedy then
        self.sumy = self.sumy - replacedy
    end
    self.sumx = self.sumx + joystickx
    self.sumy = self.sumy + joysticky
    self[position*2-1] = joystickx
    self[position*2] = joysticky
    return replacedx, replacedy
end

---@param action InputAction
function InputLog:logActionState(action)
    local position = self.position
    local log = self:getActionLog(action.name)
    log[position] =
        action.pressed and "pressed" or
        action.released and "released" or
        action.down and "down" or "up"
end

function InputLog:advance()
    local position = self.position
    position = position + 1
    if position > self.length then
        position = 1
    end
    self.position = position
end

function InputLog:getActionLog(actionname)
    local log = self.actionlogs[actionname]
    if not log then
        log = {}
        self.actionlogs[actionname] = log
    end
    return log
end

function InputLog:oldestActionState(actionname)
    local log = self.actionlogs[actionname]
    if not log then return "up" end
    local position = #log < self.length and 1
        or self.position
    return log[position] or "up"
end

function InputLog:newestActionState(actionname)
    local log = self.actionlogs[actionname]
    if not log then return "up" end
    local position = self.position - 1
    if position <= 0 then
        position = self.length
    end
    return log[position] or "up"
end

---@param actionname string
---@param state "pressed"|"released"|"down"|"up"
function InputLog:findActionState(actionname, state)
    local log = self.actionlogs[actionname]
    if not log then return end
    for i = 1, #log do
        if log[i] == state then
            return i
        end
    end
end

function InputLog:oldestJoystick()
    local i = #self < self.length and 2
        or (self.position*2)
    return self[i-1] or 0, self[i] or 0
end

function InputLog:newestJoystick()
    local position = self.position - 1
    local i = position <= 0 and #self
        or position*2
    return self[i-1] or 0, self[i] or 0
end

function InputLog:joystickAt(t)
    local l = self.length
    t = math.max(-l, math.min(t, -1))
    local i = self.position + t
    if i < 1 then
        i = i + l
    end
    i = i*2
    return self[i-1] or 0, self[i] or 0
end

function InputLog:averageJoystick()
    if #self < 2 then return 0, 0 end
    local n = #self/2
    return self.sumx/n, self.sumy/n
end

function InputLog:clear()
    for i = #self, 1, -1 do
        self[i] = nil
    end
    self:_init(self.length)
end

function InputLog:clearActionLog(actionname)
    local log = self.actionlogs[actionname]
    if log then
        for i = 1, #log do
            log[i] = "up"
        end
    end
end

return InputLog