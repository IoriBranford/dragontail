local dispatch = require "dispatch"

local LoveEvents = {"audiodisconnected", "directorydropped", "displayrotated", "draw", "dropbegan",
    "dropcompleted", "dropmoved", "exposed", "filedropped", "focus", "gamepadaxis", "gamepadpressed", "gamepadreleased",
    "joystickadded", "joystickaxis", "joystickhat", "joystickpressed", "joystickreleased", "joystickremoved",
    "joysticksensorupdated", "keypressed", "keyreleased", "localechanged", "lowmemory", "mousefocus",
    "mousemoved", "mousepressed", "mousereleased", "occluded", "quit", "resize", "sensorupdated", "textedited",
    "textinput", "threaderror", "touchmoved", "touchpressed", "touchreleased", "update", "visible", "wheelmoved"}

local ExtraEvents = {"reset"}

local Conns = dispatch.new(unpack(LoveEvents))
Conns:newevents(unpack(ExtraEvents))

---@alias conn integer

---Reset the event engine
function love.event.reset()
    Conns = dispatch.new(unpack(LoveEvents))
    Conns:newevents(unpack(ExtraEvents))
    Conns:allsub(love)
    Conns:send("reset")
end

function love.event.resetConnections()
    Conns:clearallsubs()
    Conns:allsub(love)
end

function love.event.addSelfLoveEvents(format)
    local sformat = string.format
    format = format or "%sself"
    for _, ev in ipairs(LoveEvents) do
        ev = sformat(format, ev)
        Conns:newevent(ev)
    end
end

---Register a new event
function love.event.newEvent(ev)
    Conns:newevent(ev)
end

---Register multiple new events
---@param ... string
function love.event.newEvents(...)
    Conns:newevents(...)
end

---Register multiple new events intended for self
---@param format string with at least 1 %s for the event name
---@param ... string
function love.event.newSelfEvents(format, ...)
    local sformat = string.format
    for i = 1, select("#", ...) do
        local ev = select(i, ...)
        Conns:newevent(sformat(format, ev))
    end
end

---Connect to event
---@param ev string
---@param l listener
---@param after boolean?
---@return integer
function love.event.connect(l, after, ev)
    return Conns:sub(l, after, ev)
end

---Connect all of a table's matching functions to events
---@param l listener
---@param after boolean?
function love.event.connectAll(l, format, after)
    Conns:allsub(l, format, after)
end

---Disconnect from event
---@param ev string
---@param conn conn
---@param l listener?
function love.event.disconnect(l, conn, ev)
    Conns:unsub(l, conn, ev)
end

---Disconnect all of a table's matching functions from events
---@param l any
function love.event.disconnectAll(l, format)
    Conns:allunsub(l, format)
end

---Broadcast an event immediately, bypassing love event queue
---@param ev string
---@param ... any
function love.event.send(ev, ...)
    Conns:send(ev, ...)
end

---Broadcast an event immediately, bypassing love event queue,
---callbacks receive the listening table as 1st argument
---@param ev any
---@param ... any
function love.event.sendSelves(ev, ...)
    Conns:sendself(ev, ...)
end

---@diagnostic disable-next-line: duplicate-set-field
function love.run()
    Conns:allsub(love)
    if love.load then
        love.load(love.arg.parseGameArguments(arg), arg)
    end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    return function()
        -- Process events.
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return "quit", a or 0
                    end
                end
                Conns:send(name, a, b, c, d, e, f)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then dt = love.timer.step() end

        -- Call update and draw
        Conns:send("update", dt) -- will pass 0 if love.timer is disabled

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            Conns:send("draw")

            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end