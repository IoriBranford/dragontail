local Database = require "Data.Database"
local Script   = require "Component.Script"

---@class State
---@field action function
---@field animation string
---@field frame integer
---@field loop integer
---@field canbeattacked boolean
---@field canbegrabbed boolean
---@field sound string

local State = {}

local StateVarsOnChange = {
    "canbeattacked",
    "canbegrabbed"
}

---@param self Character
function State.change(self, statename, ...)
    local state = Database.get(statename) ---@type State
    if state then
        for _, var in ipairs(StateVarsOnChange) do
            if state[var] ~= nil then
                self[var] = state[var]
            end
        end
        local animationname = state.animation
        local frame = state.frame
        if animationname or frame then
            local aseprite = self.aseprite
            if aseprite then
                local dirs = self.animationdirections or 1
                if dirs > 1 then
                    local facex, facey = self.facex, self.facey
                    if facex and facey then
                        local angle = math.atan2(facey, facex)
                        animationname = self.getDirectionalAnimation_angle(animationname, angle, dirs)
                    end
                end

                self:changeAseAnimation(animationname, frame, state.loop)
            end
        end
        Script.start(self, state.action, ...)
    end
end

return State