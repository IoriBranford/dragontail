local TakingHit    = require "Dragontail.Character.Behavior.Fighter.TakingHit"
local Face         = require "Dragontail.Character.Component.Face"

---@class PlayerTakingHit:TakingHit
---@field character Player
local PlayerTakingHit = pooledclass(TakingHit)

---@param hit AttackHit
function PlayerTakingHit:start(hit)
    local player = self.character
    if player.crosshair then
        player.crosshair.visible = false
    end
    TakingHit.start(self, hit)
end

function PlayerTakingHit:timeout()
    local player = self.character
    local nextstate, a, b, c, d, e = TakingHit.timeout(self)
    if nextstate == "walk" then
        if player.sprintbutton.down then
            local inx, iny = player:getJoystick()
            if inx ~= 0 or iny ~= 0 then
                Face.faceAngle(self, math.atan2(iny, inx))
            end
            nextstate = "run"
        end
    end
    return nextstate, a, b, c, d, e
end

return PlayerTakingHit