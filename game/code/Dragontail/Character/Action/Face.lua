local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

---@class Face:TiledObject
---@field faceangle number
---@field facedestangle number?
---@field facedegrees number?
local Face = {}

function Face:init()
    self.faceangle = self.faceangle
        or self.facedegrees and math.rad(self.facedegrees)
        or 0
end

---@param object { x: number, y: number }
function Face:faceObject(object, animation, frame1, loopframe)
    if object then
        Face.facePosition(self, object.x, object.y, animation, frame1, loopframe)
    end
end

function Face:facePosition(x, y, animation, frame1, loopframe)
    Face.faceVector(self, x - self.x, y - self.y, animation, frame1, loopframe)
end

function Face:faceVector(vx, vy, animation, frame1, loopframe)
    Face.faceAngle(self, (vx ~= 0 or vy ~= 0) and math.atan2(vy, vx), animation, frame1, loopframe)
end

function Face:faceAngle(angle, animation, frame1, loopframe)
    if angle then
        self.faceangle = angle
    end
    if animation then
        DirectionalAnimation.set(self, animation, angle or self.faceangle, frame1, loopframe)
    end
end

function Face:turnTowardsAngle(destangle, turnspeed, animation, frame1, loopframe)
    local faceangle = math.rotangletowards(self.faceangle, destangle, turnspeed)
    Face.faceAngle(self, faceangle, animation, frame1, loopframe)
end

function Face:turnTowardsVector(vecx, vecy, turnspeed, animation, frame1, loopframe)
    if vecx ~= 0 or vecy ~= 0 then
        Face.turnTowardsAngle(self, math.atan2(vecy, vecx), turnspeed, animation, frame1, loopframe)
    end
end

function Face:turnTowardsPosition(x, y, turnspeed, animation, frame1, loopframe)
    Face.turnTowardsVector(self, x - self.x, y - self.y, turnspeed, animation, frame1, loopframe)
end

---@param object { x: number, y: number }
function Face:turnTowardsObject(object, turnspeed, animation, frame1, loopframe)
    if object then
        Face.turnTowardsPosition(self, object.x, object.y, turnspeed, animation, frame1, loopframe)
    end
end

function Face:updateTurnToDestAngle(turnspeed, animation, frame1, loopframe)
    if self.facedestangle then
        Face.turnTowardsAngle(self, self.facedestangle, turnspeed, animation, frame1, loopframe)
    end
end

return Face