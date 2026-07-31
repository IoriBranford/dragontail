local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"
local coFade         = require "Dragontail.Movie.coFade"
local Color          = require "Tiled.Color"
local multitask      = require "multitask"

local wrap = coroutine.wrap
local yield = coroutine.yield

local function TitleHit(layers)
    local fg = layers.fg
    local directions = layers.directions
    directions.visible = false
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup
    local shaking = layers.shaking
    shaking.visible = false

    local path = directions.path
    coRelativePath(path, fg, 50)

    local function coDrift(obj, a, s, t)
        local dx, dy = math2.frompolar(a)
        local ds = s/t
        for _ = 1, t do
            yield()
            obj.x = obj.x + dx*s
            obj.y = obj.y + dy*s
            s = s - ds
        end
        return true
    end

    yield("hit")

    shaking.visible = true
    local rose = fg.Rose
    local swing = fg.swing
    local enemy = fg.enemy
    local hit = fg.hit
    local tasks = {
        function() return coDrift(rose, math.rad(210), .5, 60) end,
        function() return coDrift(swing, math.rad(210), .5, 60) end,
        function() return coDrift(enemy, math.rad(210), 2, 60) end,
        function() return coDrift(hit, math.rad(210), 1, 60) end,
        function() coroutine.wait(30); return coFade(hit, 0x80ffffff, Color.White, 30) end,
        function() coroutine.wait(30); return coFade(swing, 0x80ffffff, Color.White, 30) end,
        function() return coHitShake(shaking, 100, 50, 150, 60) end,
    }

    local mt = multitask.new()
    for i = 1, #tasks do
        mt:push(wrap(tasks[i]))
    end
    repeat
        mt:runAll()
        yield()
    until mt:allDone()
    return true
end

return TitleHit