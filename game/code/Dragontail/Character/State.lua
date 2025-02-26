local Database = require "Data.Database"
local Audio    = require "System.Audio"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class StateData
---@field action function
---@field animation string
---@field frame integer
---@field loop integer
---@field canbeattacked boolean
---@field canbegrabbed boolean
---@field sound string

---@class State:Character,Face
---@field state string?
---@field thread thread?
local State = {}

local StateVarsOnChange = {
    "canbeattacked",
    "canbegrabbed",
    "canbejuggled",
    "bodysolid",
    "color"
}

function State.start(self, statename, ...)
    local state = Database.get(statename) ---@type StateData
    if state then
        self.state = statename
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
                if animationname and dirs > 1 then
                    local angle = self.faceangle
                    if angle then
                        local diranimationname = DirectionalAnimation.FromAngle(animationname, angle, dirs)
                        if aseprite.animations[diranimationname] then
                            animationname = diranimationname
                        end
                    end
                end

                self:changeAseAnimation(animationname, frame, state.loop)
            end
        end
        -- DirectionalAnimation.set(self, animationname, angle, frame, state.loop)

        Audio.play(state.sound)

        local action = self[state.action]
        if type(action) == "function" then
            self.thread = co_create(action)
            State.run(self, ...)
        else
            self.thread = nil
        end
    else
        print("W: no state "..statename)
    end
end

function State.run(self, ...)
    local thread = self.thread
    if thread then
        local ok, nextstate, a,b,c,d,e,f,g = co_resume(thread, self, ...)
        if not ok then
            error(debug.traceback(thread, nextstate))
        elseif nextstate then
            State.start(self, nextstate, a,b,c,d,e,f,g)
        elseif co_status(thread) == "dead" then
            State.stop(self)
        end
    end
end

function State.stop(self)
    self.thread = nil
end

function State.isRunning(self)
    return self.thread ~= nil
end

return State