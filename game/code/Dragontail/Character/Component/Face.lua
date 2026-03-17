local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"

---@class Face:TiledObject
---@field faceangle number
---@field facedestangle number?
---@field facedegrees number?
---@field faceturnspeed number? defaults to pi for instant turn in turnTowards* functions
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
    return self.faceangle
end

function Face:facePosition(x, y, animation, frame1, loopframe)
    return Face.faceVector(self, x - self.x, y - self.y, animation, frame1, loopframe)
end

function Face:faceVector(vx, vy, animation, frame1, loopframe)
    return Face.faceAngle(self, (vx ~= 0 or vy ~= 0) and math.atan2(vy, vx), animation, frame1, loopframe)
end

function Face:faceAngle(angle, animation, frame1, loopframe)
    if angle then
        self.faceangle = angle
    else
        angle = self.faceangle
    end
    if animation then
        DirectionalAnimation.set(self, animation, angle, frame1, loopframe)
    end
    return angle
end

function Face:turnTowardsAngle(destangle, turnspeed, animation, frame1, loopframe)
    local faceangle = math.rotangletowards(self.faceangle, destangle,
        turnspeed or self.faceturnspeed or math.pi)
    return Face.faceAngle(self, faceangle, animation, frame1, loopframe)
end

function Face:turnTowardsVector(vecx, vecy, turnspeed, animation, frame1, loopframe)
    if vecx ~= 0 or vecy ~= 0 then
        Face.turnTowardsAngle(self, math.atan2(vecy, vecx), turnspeed, animation, frame1, loopframe)
    end
    return self.faceangle
end

function Face:turnTowardsPosition(x, y, turnspeed, animation, frame1, loopframe)
    return Face.turnTowardsVector(self, x - self.x, y - self.y, turnspeed, animation, frame1, loopframe)
end

---@param object { x: number, y: number }
function Face:turnTowardsObject(object, turnspeed, animation, frame1, loopframe)
    if object then
        Face.turnTowardsPosition(self, object.x, object.y, turnspeed, animation, frame1, loopframe)
    end
    return self.faceangle
end

function Face:updateTurnToDestAngle(turnspeed, animation, frame1, loopframe)
    if self.facedestangle then
        Face.turnTowardsAngle(self, self.facedestangle, turnspeed, animation, frame1, loopframe)
    end
    return self.faceangle
end

function Face:dotPosition(x, y)
    local faceangle = self.faceangle
    local facex, facey = math.cos(faceangle), math.sin(faceangle)
    local tox, toy = x - self.x, y - self.y
    return math.dot(tox, toy, facex, facey)
end

function Face:isPositionInSight(x, y, sightarc)
    local dot = Face.dotPosition(self, x, y)
    local dist = math.dist(self.x, self.y, x, y)
    return dot >= dist * math.cos(sightarc)
end

function Face:isObjectInSight(object, sightarc)
    return Face.isPositionInSight(self, object.x, object.y, sightarc)
end

function Face:isAngleInSight(angle, sightarc)
    local faceangle = self.faceangle
    local dot = math.dot(math.cos(angle), math.sin(angle),
        math.cos(faceangle), math.sin(faceangle))
    return dot >= math.cos(sightarc)
end

return Face