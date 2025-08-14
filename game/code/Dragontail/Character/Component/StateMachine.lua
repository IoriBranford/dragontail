local Database = require "Data.Database"
local Audio    = require "System.Audio"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Component.Body"
local Assets               = require "Tiled.Assets"
local CollisionMask        = require "Dragontail.Character.Component.Body.CollisionMask"

local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class State
---@field statecoroutine string?
---@field statebehavior string?
---@field attack string?
---@field nextstate string?
---@field asefile string?
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
---@field statethread thread?
---@field statebehavior Behavior?
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
    "gravity",
    "mass",
    "speed",
    "faceturnspeed"
}

function StateMachine.start(self, statename, a,b,c,d,e,f,g)
    if self.statebehavior then
        statename, a,b,c,d,e,f,g = self.statebehavior:interrupt(statename, a,b,c,d,e,f,g)
        self.statebehavior:_release()
    end
    self.statebehavior = nil
    self.statethread = nil
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
        local hitslayers = self.attack.hitslayers
        if type(hitslayers) == "string" then
            hitslayers = CollisionMask.parse(hitslayers)
            self.attack.hitslayers = hitslayers
        end

        local animationname = state.animation
        local frame = state.frame1

        local newaseprite = state.asefile and Assets.get(state.asefile)
        if newaseprite then
            ---@cast newaseprite Aseprite
            if newaseprite ~= self.aseprite then
                self.aseprite = newaseprite
            end
        end

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
        elseif newaseprite then
            self:setAnimation(newaseprite, frame, state.loopframe)
        end
        -- DirectionalAnimation.set(self, animationname, angle, frame, state.loop)

        Audio.play(state.sound)

        local behavior = state.statebehavior
        if behavior then
            local ok
            ok, behavior = pcall(require, behavior)
            if ok then
                self.statebehavior = behavior(self)
                self.statebehavior:start(a,b,c,d,e,f,g)
                behavior = self.statebehavior
            else
                print(behavior)
                behavior = nil
            end
        end
        if not behavior then
            local statecoroutine = self[state.statecoroutine]
            if type(statecoroutine) == "function" then
                self.statethread = co_create(statecoroutine)
                StateMachine.run(self, a,b,c,d,e,f,g)
            end
        end
    else
        print("W: no state "..statename)
    end
end

function StateMachine.run(self, ...)
    local nextstate, a,b,c,d,e,f,g
    if self.statebehavior then
        nextstate, a,b,c,d,e,f,g = self.statebehavior:fixedupdate()
    elseif self.statethread then
        local ok
        ok, nextstate, a,b,c,d,e,f,g = co_resume(self.statethread, self, ...)
        if not ok then
            error(debug.traceback(self.statethread, nextstate))
        end
    end

    if not nextstate then
        if self.statethread and co_status(self.statethread) == "dead" then
            nextstate = self.nextstate
            self.statethread = nil
        else
            local statetime = self.statetime
            if statetime then
                if statetime <= 0 then
                    nextstate = self.nextstate
                    self.statetime = nil
                    if self.statebehavior then
                        nextstate, a,b,c,d,e,f,g =
                            self.statebehavior:timeout(nextstate, a,b,c,d,e,f,g)
                        self.statebehavior:_release()
                        self.statebehavior = nil
                    end
                else
                    statetime = statetime - 1
                    self.statetime = statetime
                end
            end
        end
    end

    if nextstate then
        StateMachine.start(self, nextstate, a,b,c,d,e,f,g)
    end
end

return StateMachine