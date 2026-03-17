local Body = require "Dragontail.Character.Component.Body"
---@class Slide:Character
local Slide = {}

function Slide.GetSlideDistance(speed, decel)
    return speed * (speed+decel) / (2*decel)
end

function Slide.GetSlideSpeedForDistance(dist, decel)
    -- dist = (accel*time*time)/2 + speed0*time
    -- dist - (accel*time*time)/2 = speed0*time
    -- dist/time - (accel*time)/2 = speed0
    -- 0 = speed0 + accel/time
    -- speed0 = -accel/time
    -- time = -speed0/accel
    -- -dist*accel/speed0 + speed0/2 = speed0
    -- -dist*accel/speed0 = speed0/2
    -- -2*dist*accel/speed0 = speed0
    -- -2*dist*accel = speed0*speed0
    -- speed0 = sqrt(-2*dist*accel)
    return math.sqrt(2*dist*decel)
end

function Slide:updateSlideSpeed(angle, speed, decel)
    decel = decel or 1
    self.velx = speed * math.cos(angle)
    self.vely = speed * math.sin(angle)
    if speed < 0 then
        speed = math.min(0, speed + decel)
    else
        speed = math.max(0, speed - decel)
    end
    return speed
end

--- Burst of speed towards angle (away from angle if speed < 0) then slow to 0
function Slide:slide(angle, speed, decel)
    repeat
        speed = Slide.updateSlideSpeed(self, angle, speed, decel)
        coroutine.yield()
    until speed == 0
end

return Slide