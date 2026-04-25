---@class Catcher:Body
---@field catchradius number
---@field catcharc number
local Catcher = {}

function Catcher:isCatching(character, catchdirx, catchdiry)
    local catchradius = (self.catchradius or 20)
    local coscatcharc = math.cos(self.catcharc or (math.pi/4))
    local x, y, z = self.x, self.y, self.z
    local ztop = z + self.bodyheight + catchradius/2
    if self ~= character.thrower
    and not character.uncatchable
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
    end
end

function Catcher:findCharacterToCatch(characters, catchdirx, catchdiry)
    for _, character in ipairs(characters) do
        if Catcher.isCatching(self, character, catchdirx, catchdiry) then
            return character
        end
    end
end

return Catcher