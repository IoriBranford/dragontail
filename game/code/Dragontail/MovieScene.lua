local LayerGroup = require "Tiled.LayerGroup"

---@class MovieScene:LayerGroup
---@field thread thread
---@field func function
---@field script string
local MovieScene = class(LayerGroup)
--MovieScene.runphase = "Dragontail.MoviePhase"

function MovieScene:started()
    return self.thread ~= nil
end

function MovieScene:start(arg, ...)
    local script = self.script
    local _, scriptf = assert(pcall(require, script))
    self.func = scriptf
    self.thread = coroutine.create(self.func)
    if arg ~= nil then
        self:play(arg, ...)
    end
    return self.thread
end

function MovieScene:play(...)
    local thread = self.thread or self:start()
    if coroutine.status(thread) == "dead" then return "dead" end
    local ok, a,b,c,d,e,f,g,h = coroutine.resume(thread, ...)
    local status = ok and coroutine.status(thread)
    return status, a,b,c,d,e,f,g,h
end

return MovieScene