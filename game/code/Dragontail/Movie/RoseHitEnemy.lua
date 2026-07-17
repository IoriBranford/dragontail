local Movement = require "Component.Movement"
local Gui      = require "Dragontail.Gui"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"
local Audio          = require "System.Audio"

local function RoseHitEnemy(movie)
    local fg = movie.fg
    local directions = movie.directions
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup
    directions.visible = false
    movie.visible = true
    local menu = Gui.title.mainmenus.normal
    menu.visible = false

    Audio.play(movie.hitsound)

    local path = assert(directions.path)
    coRelativePath(path, fg, 50)

    menu:setVisibleUp(true)
    coHitShake(menu, 100, 50, 120, 60)
end

return RoseHitEnemy