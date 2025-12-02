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
---@field statefunction string?
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

---@alias StateFunction fun(self:StateMachine):string?,any,any,any,any,any,any,any

---@class StateMachine:Face
---@field state State
---@field nextstate string?
---@field statetime integer?
---@field statetable {[string]:State}
---@field attacktable {[string]:Attack}?
---@field statefunction StateFunction?
---@field statethread thread?
---@field statebehavior Behavior?
---@field statevoice love.Source?
---@field statecounters table<string, integer>?
local StateMachine = {}

function StateMachine:init()
    StateMachine.setTable(self, self.statetable, self.attacktable)
end

function StateMachine:setTable(statetable, attacktable)
    self.statetable = statetable and Database.getTable(statetable)
    self.attacktable = attacktable and Database.getTable(attacktable)
end

local StateVarsToCopy = {
    nextstate = true,
    statetime = true,
    canbeattacked = true,
    canbegrabbed = true,
    canbejuggled = true,
    faceturnspeed = true,
    moveturnspeed = true,
    bodyinlayers = true,
    bodyhitslayers = true,
    color = true,
    afterimageinterval = true,
    manachargerate = true,
    manadecayrate = true,
    gravity = true,
    accel = true,
    speed = true,
    bodyheight = true,
    guardai = true,
}

local Period = string.byte('.')

local Operations = {
    ['+='] = function(t, k, v) return t[k] + v end,
    ['-='] = function(t, k, v) return t[k] - v end,
    ['*='] = function(t, k, v) return t[k] * v end,
    ['/='] = function(t, k, v) return t[k] / v end,
}

local function evalStateVar(self, state, k)
    local v = state[k]
    local op, val = nil, v
    if type(v) == "string" and type(self[k]) == "number" then
        op, val = v:match("^([+%-*/]=)(%-?[%w.]+)$")
        v = op and tonumber(val) or v
    end
    if type(v) == "string" and v:byte(1,1) == Period then
        v = self[v:sub(2)]
    end
    if op then
        if type(v) ~= "number" then
            error(string.format("attempted to %s non-numeric %s into %s",
                op, v, k))
        end
        v = Operations[op](self, k, v)
    end
    return v
end

function StateMachine.start(self, statename, a,b,c,d,e,f,g)
    if self.statebehavior then
        statename, a,b,c,d,e,f,g = self.statebehavior:interrupt(statename, a,b,c,d,e,f,g)
        self.statebehavior:_release()
    end
    self.statebehavior = nil
    self.statethread = nil
    self.statefunction = nil
    local state = self.statetable and self.statetable[statename]
    if state then
        self.state = state
        for k in pairs(state) do
            if StateVarsToCopy[k] then
                local v = evalStateVar(self, state, k)
                if v ~= nil then
                    self[k] = v
                end
            end
        end

        local statecounters = self.statecounters
        if statecounters then
            local statecounter = (statecounters[statename] or 0)
            statecounter = statecounter + 1
            statecounters[statename] = statecounter
        end

        Body.initLayerMasks(self)

        self.attacktype = evalStateVar(self, state, "attack")
        self.attack = self.attacktable and self.attacktable[self.attacktype]
        local hitslayers = self.attack.hitslayers
        if type(hitslayers) == "string" then
            hitslayers = CollisionMask.parse(hitslayers)
            self.attack.hitslayers = hitslayers
        end

        local animationname = evalStateVar(self, state, "animation")
        local frame = evalStateVar(self, state, "frame1")

        local newaseprite = evalStateVar(self, state, "asefile")
        newaseprite = Assets.get(newaseprite)
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

                self:setAnimation(animationname, frame, evalStateVar(self, state, "loopframe"))
            end
        elseif newaseprite then
            self:setAnimation(newaseprite, frame, evalStateVar(self, state, "loopframe"))
        end
        -- DirectionalAnimation.set(self, animationname, angle, frame, state.loop)

        Audio.play(evalStateVar(self, state, "sound"))

        local voice = self.statevoice
        if voice then
            voice:stop()
        end
        voice = Audio.newSource(evalStateVar(self, state, "voice"))
        if voice then
            voice:play()
        end
        self.statevoice = voice

        local behavior = evalStateVar(self, state, "statebehavior")
        local statecoroutine = self[evalStateVar(self, state, "statecoroutine")]
        local statefunction = self[evalStateVar(self, state, "statefunction")]
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
        elseif type(statecoroutine) == "function" then
            self.statethread = co_create(statecoroutine)
            StateMachine.run(self, a,b,c,d,e,f,g)
        elseif type(statefunction) == "function" then
            self.statefunction = statefunction
        end
    else
        print("W: no state ", statename)
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
    elseif self.statefunction then
        nextstate, a,b,c,d,e,f,g = self:statefunction()
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

function StateMachine:release()
    if self.statebehavior then
        self.statebehavior:_release()
        self.statebehavior = nil
    end
end

function StateMachine:draw()
    if self.state then
        local font = Assets.getFont("TinyUnicode", 16)
        if font then
            love.graphics.setColor(1, 1, 1, 1)
            local w = love.graphics.getWidth()
            love.graphics.printf(self.state.state, font,
                self.x - w/2, self.y - self.z - self.bodyheight - font:getHeight(),
                w, "center")
        end
    end
end

return StateMachine