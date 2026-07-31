local Audio = require "System.Audio"
local coHitShake = require "Dragontail.Movie.coHitShake"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coFade     = require "Dragontail.Movie.coFade"
local Color      = require "Tiled.Color"
local multitask  = require "multitask"
local coDrift    = require "Dragontail.Movie.coDrift"

---@param movie Movie
local function RoseUppercut (movie)
    local rose = (movie.Rose)
    local path = (movie.direction.path)
    local shaking = movie.shaking
    shaking.visible = false
    movie.direction.visible = false
    rose:setVisible(true)
    Audio.play(movie.swipesound)
    local swipe = rose.swipe
    swipe.tintcolor = Color.White

    coRelativePath(path, rose, 50)
    local yield = coroutine.yield
    yield("hit")

    shaking.visible = true
    local wrap = coroutine.wrap
    local mt = multitask.new()
    local tasks = {
        function() return coDrift(rose, math.rad(240), 1, 60) end,
        function() coroutine.wait(30); return coFade(swipe, 0x80FFFFFF, Color.White, 30) end,
        function() return coHitShake(shaking, -1.5, 50, 100, 60) end,
    }
    for i = 1, #tasks do
        mt:push(wrap(tasks[i]))
    end
    repeat
        mt:runAll()
        yield()
    until mt:allDone()

    Audio.play(movie.voice)
    return true
end

return RoseUppercut