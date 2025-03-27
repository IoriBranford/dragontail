local Database = require "Data.Database"
local Audio    = require "System.Audio"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class State:Character,Face
---@field state string
---@field stateaction string?
---@field stateanimation string?
---@field stateframe1 integer?
---@field stateloopframe integer?
---@field canbeattacked boolean
---@field canbegrabbed boolean
---@field statesound string?
---@field thread thread?
local State = {}

function State.start(self, statename, ...)
    if Database.get(statename) then
        Database.fill(self, statename)

        local animationname = self.stateanimation
        local frame = self.stateframe1
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

                self:changeAseAnimation(animationname, frame, self.stateloopframe)
            end
        end
        -- DirectionalAnimation.set(self, animationname, angle, frame, state.loop)

        Audio.play(self.statesound)

        local action = self[self.stateaction]
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