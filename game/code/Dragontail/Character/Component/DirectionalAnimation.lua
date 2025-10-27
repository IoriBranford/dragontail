---@class DirectionalAnimation:AsepriteObject
---@field animationdirections integer?
local DirectionalAnimation = {}

function DirectionalAnimation.FromAngle(basename, angle, numanimations)
    numanimations = numanimations or 1
    if numanimations < 2 then
        return basename
    end
    if angle ~= angle then
        return basename..0
    end
    local faceangle = angle + (math.pi / numanimations)
    local facedir = math.floor(faceangle * numanimations / math.pi / 2)
    facedir = ((facedir % numanimations) + numanimations) % numanimations
    return basename..facedir
end

function DirectionalAnimation.SnapAngle(angle, numanimations)
    local angleinterval = 2 * math.pi / numanimations
    return math.floor(angle / angleinterval + .5) * angleinterval
end

function DirectionalAnimation:set(basename, angle, frame1, loopframe)
    local animation = DirectionalAnimation.FromAngle(basename, angle, self.animationdirections)
    self:changeAnimation(animation, frame1, loopframe)
end

return DirectionalAnimation