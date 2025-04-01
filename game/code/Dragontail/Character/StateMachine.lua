local Database = require "Data.Database"
local Audio    = require "System.Audio"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class State
---@field action string?
---@field attack string?
---@field nextstate string?
---@field animation string?
---@field frame1 integer?
---@field loopframe integer?
---@field sound string?
---@field statetime integer?
---@field canbeattacked boolean
---@field canbegrabbed boolean
---@field bodysolid boolean
---@field color integer?

---@class StateMachine:Character,Face
---@field state State
---@field nextstate string?
---@field statetime integer?
---@field statetable {[string]:State}
---@field attacktable {[string]:AttackData}?
---@field thread thread?
local StateMachine = {}

function StateMachine:init()
    StateMachine.setTable(self, self.statetable, self.attacktable)
end

function StateMachine:setTable(statetable, attacktable)
    self.statetable = statetable and Database.getTable(statetable) or Database.getTable("data/db_characterstates.csv")
    self.attacktable = attacktable and Database.getTable(attacktable) or Database.getTable("data/db_attacks.csv")
end

local StateVarsToCopy = {
    "nextstate",
    "statetime",
    "canbeattacked",
    "canbegrabbed",
    "bodysolid",
    "color",
}

function StateMachine.start(self, statename, ...)
    local state = self.statetable and self.statetable[statename]
    if state then
        self.state = state
        for i = 1, #StateVarsToCopy do
            local var = StateVarsToCopy[i]
            if state[var] ~= nil then
                self[var] = state[var]
            end
        end

        local attackdata = self.attacktable and self.attacktable[state.attack]
        if attackdata then
            self.attacktype = state.attack
            Database.fill(self, attackdata)
        else
            self.attacktype = nil
        end

        local animationname = state.animation
        local frame = state.frame1
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

                self:setAseAnimation(animationname, frame, state.loopframe)
            end
        end
        -- DirectionalAnimation.set(self, animationname, angle, frame, state.loop)

        Audio.play(state.sound)

        local action = self[state.action]
        if type(action) == "function" then
            self.thread = co_create(action)
            StateMachine.run(self, ...)
        else
            self.thread = nil
        end
    else
        print("W: no state "..statename)
    end
end

function StateMachine.run(self, ...)
    local thread = self.thread
    if thread then
        local ok, nextstate, a,b,c,d,e,f,g = co_resume(thread, self, ...)
        if not ok then
            error(debug.traceback(thread, nextstate))
        end

        if not nextstate then
            local statetime = self.statetime
            if statetime then
                if statetime <= 0 then
                    nextstate = self.nextstate
                    self.statetime = nil
                else
                    statetime = statetime - 1
                    self.statetime = statetime
                end
            end
        end

        if nextstate then
            StateMachine.start(self, nextstate, a,b,c,d,e,f,g)
        elseif co_status(thread) == "dead" then
            StateMachine.stop(self)
        end
    end
end

function StateMachine.stop(self)
    self.thread = nil
end

function StateMachine.isRunning(self)
    return self.thread ~= nil
end

return StateMachine