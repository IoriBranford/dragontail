local Audio = require "System.Audio"
local coHitShake = require "Dragontail.Movie.coHitShake"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coFade     = require "Dragontail.Movie.coFade"
local Gui        = require "Dragontail.Gui"
local Color      = require "Tiled.Color"
local coDrift    = require "Dragontail.Movie.coDrift"
local multitask  = require "multitask"

---@param movie Movie
local function RoseUppercut (movie)
    local rose = (movie.Rose)
    local path = (movie.direction.path)
    movie.direction.visible = false
    rose:setVisible(true)
    Audio.play(movie.swipesound)
    local swipe = rose.swipe
    swipe.tintcolor = Color.White

    coRelativePath(path, rose, 30)
    local yield = coroutine.yield

    local menu = (Gui.gameplay.victory)
    menu:setVisible(true)

    local wrap = coroutine.wrap
    local mt = multitask.new()
    local tasks = {
        function() return coDrift(rose, math.rad(240), .5, 60) end,
        function() coroutine.wait(30); return coFade(swipe, 0x80FFFFFF, Color.White, 60) end,
        function() return coHitShake(menu, -1.5, 50, 100, 60) end,
    }
    for i = 1, #tasks do
        mt:push(wrap(tasks[i]))
    end
    repeat
        mt:runAll()
        yield()
    until mt:allDone()

    Audio.play(movie.voice)
end

return RoseUppercut