local class = require "Aseprite.class"

---@class AseTag
---@field name string
---@field from integer 1-based
---@field to integer 1-based
---@field direction "forward"|"reverse"|"pingpong"
---@field loopframe integer Frame index that should follow the last one. 0 = hold the last frame. -1 = last frame - 1, etc. Default is 1.
---@field [integer] AseFrame
local AseTag = class()

---@param ase Aseprite
function AseTag:load(ase)
    self.from = self.from + 1
    self.to = self.to + 1
    local direction = self.direction
    if direction == "reverse" then
        for f = self.to, self.from, -1 do
            self[#self + 1] = ase[f]
        end
    else
        for f = self.from, self.to do
            self[#self + 1] = ase[f]
        end
        if direction == "pingpong" then
            for f = self.to-1, self.from+1, -1 do
                self[#self + 1] = ase[f]
            end
        end
    end
end

function AseTag:setLoopFrame(loopframe)
    if loopframe <= 0 then
        loopframe = #self + loopframe
    end
    self.loopframe = loopframe
end

function AseTag:isFinished(i, t)
    local duration = self[i].duration
    while t >= duration do
        t = t - duration
        i = i + 1
        if i > #self then
            return true
        end
        duration = self[i].duration
    end
end

function AseTag:getUpdate(i, t, loopi)
    loopi = loopi or self.loopframe or 1
    local duration = self[i].duration
    while t >= duration do
        t = t - duration
        i = (i >= #self) and loopi or (i + 1)
        duration = self[i].duration
    end
    return i, t
end

return AseTag