---@class Catcher:Body
---@field catchradius number
---@field catcharc number
local Catcher = {}

function Catcher:findCharacterToCatch(characters, catchdirx, catchdiry)
    local catchradius = (self.catchradius or 20)
    local coscatcharc = math.cos(self.catcharc or (math.pi/2))
    local x, y, z = self.x, self.y, self.z
    local ztop = z + self.bodyheight + catchradius/2
    for _, character in ipairs(characters) do
        if self ~= character.thrower
        and character:isAttacking()
        and character.z >= z
        and character.z <= ztop
        then
            local catchprojradius = catchradius
                + math.max(character.attack.radius or 0,
                            character.bodyradius)
            local mindot = coscatcharc * catchprojradius
            local toprojx = character.x - x
            local toprojy = character.y - y
            local d = math.dot(catchdirx, catchdiry, toprojx, toprojy)
            if mindot <= d and d <= catchprojradius then
                return character
            end
            local toprojx2 = toprojx + character.velx
            local toprojy2 = toprojy + character.vely
            d = math.dot(catchdirx, catchdiry, toprojx2, toprojy2)
            if mindot <= d and d <= catchprojradius then
                return character
            end
        end
    end
end

return Catcher