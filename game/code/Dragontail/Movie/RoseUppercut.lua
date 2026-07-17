local Audio = require "System.Audio"
local coHitShake = require "Dragontail.Movie.coHitShake"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coFade     = require "Dragontail.Movie.coFade"
local Gui        = require "Dragontail.Gui"

---@param movie Movie
local function RoseUppercut (movie)
    local rose = (movie.Rose)
    local path = (movie.direction.path)
    rose:setVisible(true)
    Audio.play(rose.swipesound)

    coRelativePath(path, rose, 30)
    local cowrap = coroutine.wrap
    local yield = coroutine.yield

    local swipe = rose.swipe
    local menu = (Gui.gameplay.victory)
    menu:setVisible(true)

    local fade = cowrap(coFade)
    fade(swipe, 0, 1, 60)
    local shake = cowrap(coHitShake)
    shake(menu, -1.5, 50, 100, 60)
    for i = 1, 60 do
        yield()
        fade()
        shake()
    end

    Audio.play(rose.voice)
    Gui:pushMenu(menu)
    return true
end

return RoseUppercut