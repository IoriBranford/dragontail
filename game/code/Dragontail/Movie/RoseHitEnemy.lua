local Movement = require "Component.Movement"
local Gui      = require "Dragontail.Gui"
local coRelativePath = require "Dragontail.Movie.coRelativePath"
local coHitShake     = require "Dragontail.Movie.coHitShake"

local function RoseHitEnemy(movie, moviemap)
    local layers = moviemap.layers
    local fg = movie
    local directions = layers.directions
    layers.logo.visible = false
    fg.visible = true
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup

    local path = assert(directions.path)
    coRelativePath(path, fg, 50)

    local menu = Gui.title.mainmenus.normal
    menu:setVisible(true)
    coHitShake(menu, 100, 50, 120, 60)

    return "done"
end

return RoseHitEnemy