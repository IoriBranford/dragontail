local Movement = require "Component.Movement"
local Gui      = require "Dragontail.Gui"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"

local function RoseHitEnemy(movie)
    local fg = movie.fg
    local directions = movie.directions
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup
    directions.visible = false
    movie.visible = true

    local path = assert(directions.path)
    coRelativePath(path, fg, 50)

    local menu = Gui.title.mainmenus.normal
    menu:setVisible(true)
    coHitShake(menu, 100, 50, 120, 60)
end

return RoseHitEnemy