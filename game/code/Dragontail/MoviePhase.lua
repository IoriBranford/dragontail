local Tiled = require "Tiled"
local Dragontail = require "Dragontail"
local Movie      = require "Tiled.Movie"
local Assets     = require "Tiled.Assets"
local MoviePhase = {}

local moviemap ---@type TiledMap
local playingmovie ---@type Movie
local pause
local instructions

function MoviePhase.loadphase(file)
    moviemap = assert(Tiled.Map.load(file))
    moviemap:indexLayersByName()
    moviemap:indexLayerObjectsByName()
    moviemap:bindClasses()

    local strs = {"Press a number to play"}
    local movies = moviemap.layers

    for i = 1, math.min(9, #movies) do
        strs[#strs+1] = string.format("%d. %s", i, movies[i].name)
    end
    if movies[10] then
        strs[#strs+1] = string.format("0. %s", movies[10].name)
    end

    instructions = table.concat(strs, "\n")
end

function MoviePhase.fixedupdate()
    moviemap:animate(1)
    if playingmovie and not pause then
        local status, err = playingmovie:play()
        if not status then
            print(err)
        end
        if not status or status == "dead" then
            playingmovie = nil
        end
    end
end

local keypressed = {
    space = function ()
        pause = not pause
    end
}

function MoviePhase.startMovie(i)
    local movie = moviemap.layers[i]
    if not movie or not Movie.is(movie) then return end
    ---@cast movie Movie
    movie:start(movie, moviemap)
    playingmovie = movie
    pause = false
end

function MoviePhase.keypressed(k)
    local i = tonumber(k)
    if i then
        MoviePhase.startMovie(i == 0 and 10 or i)
        return
    end
    if keypressed[k] then keypressed[k]() end
end

function MoviePhase.quit()
    moviemap, playingmovie = nil, nil
end

function MoviePhase.draw()
    Dragontail.draw(function ()
        moviemap:draw()

        love.graphics.setColor(0, 1, 0)
        local gw = love.graphics.getWidth()
        local font = Assets.getFont("TinyUnicode", 16)
        ---@cast font love.Font
        love.graphics.printf(instructions, font, 16, 18, gw, "left")
        if pause then
            love.graphics.printf("PAUSE", font, gw - 16, 18, gw, "right")
        end
    end)
end
return MoviePhase