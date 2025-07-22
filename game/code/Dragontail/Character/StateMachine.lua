local Database = require "Data.Database"
local Audio    = require "System.Audio"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Body"

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
---@field bodyinlayers CollisionLayerMask|string
---@field bodyhitslayers CollisionLayerMask|string
---@field color integer?

---@class StateMachine:Character,Face
---@field state State
---@field nextstate string?
---@field statetime integer?
---@field statetable {[string]:State}
---@field attacktable {[string]:Attack}?
---@field thread thread?
local StateMachine = {}

function StateMachine:init()
    StateMachine.setTable(self, self.statetable, self.attacktable)
end

function StateMachine:setTable(statetable, attacktable)
    self.statetable = statetable and Database.getTable(statetable)
    self.attacktable = attacktable and Database.getTable(attacktable)
end

local StateVarsToCopy = {
    "nextstate",
    "statetime",
    "canbeattacked",
    "canbegrabbed",
    "canbejuggled",
    "faceturnspeed",
    "bodyinlayers",
    "bodyhitslayers",
    "color",
    "afterimageinterval",
    "manachargerate",
    "manadecayrate",
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

        Body.initLayerMasks(self)

        self.attacktype = state.attack
        self.attack = self.attacktable and self.attacktable[state.attack]

        local animationname = state.animation
        local frame = state.frame1
        if animationname or frame then
            local aseprite = self.aseprite
            local tile = self.tile
            if aseprite or tile then
                local dirs = self.animationdirections or 1
                if animationname and dirs > 1 then
                    local angle = self.faceangle
                    if angle then
                        local diranimationname = DirectionalAnimation.FromAngle(animationname, angle, dirs)
                        local animations = aseprite and aseprite.animations or tile and tile.tileset
                        if animations[diranimationname] then
                            animationname = diranimationname
                        end
                    end
                end

                self:setAnimation(animationname, frame, state.loopframe)
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
            if co_status(thread) == "dead" then
                nextstate = self.nextstate
            else
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