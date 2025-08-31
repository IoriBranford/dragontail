---@class JoystickLog
---@field length integer
---@field position integer
---@field sumx number
---@field sumy number
---@field [integer] number
local JoystickLog = class()

function JoystickLog:_init(length)
    self.length = length or 10
    self.position = 1
    self.sumx = 0
    self.sumy = 0
end

function JoystickLog:put(joystickx, joysticky)
    local position = self.position
    local replacedx = self[position]
    local replacedy = self[position+1]
    if replacedx then
        self.sumx = self.sumx - replacedx
    end
    if replacedy then
        self.sumy = self.sumy - replacedy
    end
    self.sumx = self.sumx + joystickx
    self.sumy = self.sumy + joysticky
    self[position] = joystickx
    self[position+1] = joysticky
    position = position + 2
    if position > self.length then
        position = 1
    end
    self.position = position
    return replacedx, replacedy
end

function JoystickLog:oldest()
    if #self < self.length then
        return self[1], self[2]
    end
    return self[self.position], self[self.position + 1]
end

function JoystickLog:newest()
    if self.position <= 2 then
        return self[#self-1], self[#self]
    end
    return self[self.position - 2], self[self.position - 1]
end

function JoystickLog:average()
    if #self < 2 then return 0, 0 end
    local n = #self/2
    return self.sumx/n, self.sumy/n
end

function JoystickLog:clear()
    for i = #self, 1, -1 do
        self[i] = nil
    end
    self.position = 1
end

return JoystickLog