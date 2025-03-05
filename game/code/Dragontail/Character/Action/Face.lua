local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

---@class Face:TiledObject
---@field faceangle number
---@field facedestangle number?
local Face = {}

function Face:init()
    self.faceangle = self.faceangle or 0
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

function Face:updateTurn(turnspeed, animation, frame1, loopframe)
    local facedestangle = self.facedestangle
    if not facedestangle then return end

    local faceangle = self.faceangle
    local facex, facey = math.cos(faceangle), math.sin(faceangle)
    local facedestx, facedesty = math.cos(facedestangle), math.sin(facedestangle)

    local facedot = math.dot(facex, facey, facedestx, facedesty)
    local acosfacedot = math.acos(facedot)
    if acosfacedot <= turnspeed then
        facex, facey = facedestx, facedesty
    else
        local facedet = math.det(facex, facey, facedestx, facedesty)
        if facedet < 0 then
            turnspeed = -turnspeed
        end
        facex, facey = math.rot(facex, facey, turnspeed)
        facex, facey = math.norm(facex, facey)
    end
    Face.faceVector(self, facex, facey, animation, frame1, loopframe)
end

return Face