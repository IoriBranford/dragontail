local Movement = require "Component.Movement"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"
local Audio          = require "System.Audio"
local coFade         = require "Dragontail.Movie.coFade"
local Color          = require "Tiled.Color"
local multitask      = require "multitask"

local wrap = coroutine.wrap
local yield = coroutine.yield

local function RoseHitEnemy(movie)
    local fg = movie.fg
    local directions = movie.directions
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup
    directions.visible = false
    movie.visible = true
    local title = movie.title
    title.visible = false

    Audio.play(movie.hitsound)

    local path = assert(directions.path)
    local walk = coroutine.wrap(coRelativePath)
    local speed = 50
    repeat
        coroutine.yield()
        -- speed = math.max(10, speed - 2)
    until walk(path, fg, speed)

    title:setVisibleUp(true)

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

    local rose = fg.Rose
    local enemy = fg.enemy
    local hit = fg.hit
    local tasks = {
        function() return coDrift(rose, math.rad(210), 1, 60) end,
        function() return coDrift(enemy, math.rad(210), 2, 60) end,
        function() return coDrift(hit, math.rad(210), 1.5, 60) end,
        function() return coFade(hit, 0, Color.White, 60) end,
        function()
            coHitShake(title, 100, 50, 150, 30)
            for i = 1, #title do
                local word = title[i]
                local c1 = word.color
                local c2 = word.color2 or c1
                coFade(word, Color.White, c1, 10)
                for _=1,10 do yield() end
                coFade(word, c2, Color.White, 10)
            end
            return true
        end
    }

    local mt = multitask.new()
    for i = 1, #tasks do
        mt:push(wrap(tasks[i]))
    end
    repeat
        mt:runAll()
        yield()
    until mt:allDone()
end

return RoseHitEnemy