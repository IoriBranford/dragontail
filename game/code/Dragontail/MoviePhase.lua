local Tiled = require "Tiled"
local Dragontail = require "Dragontail"
local Assets     = require "Tiled.Assets"
local Movie      = require "Tiled.Movie"
local Color      = require "Tiled.Color"
local Config     = require "System.Config"
local fixedupdate= require "fixedupdate"
local MoviePhase = {}

local moviemap ---@type TiledMap
local playingmovie ---@type Movie
local playingi
local time, pause
local showoverlay
local movieerror

MoviePhase.draworder = -1

function MoviePhase:loadphase(file)
    moviemap = assert(Tiled.Map.load(file))
    moviemap:bindClasses()

    showoverlay = true
    time = 0
    pause = true

    love.event.connect(Dragontail.predraw)
    love.event.connect(moviemap)
    love.event.connect(MoviePhase.Overlay)
    love.event.connect(MoviePhase.ErrorOverlay)
    love.event.connect(Dragontail.postdraw)
end

function MoviePhase:fixedupdate()
    moviemap:animate(1)
    if not pause then
        MoviePhase:step()
    end
end

local fixedfrac = 0
function MoviePhase:update(dsecs)
    local fixedrate = Config.fixedupdaterate
    fixedfrac = fixedupdate(fixedrate, fixedfrac, dsecs,
    function()
        love.event.send("fixedupdate")
    end)
end

function MoviePhase:step()
    if not playingmovie then return end
    time = time + 1
    local ok, err = playingmovie:play()
    if not ok then
        movieerror = err
        print(err)
    end
    if playingmovie:ended() then
        playingmovie = nil
    end
end

local keypressed = {
    space = function ()
        pause = not pause
    end,
    f1 = function()
        showoverlay = not showoverlay
    end,
    ['.'] = function()
        if pause then
            MoviePhase:step()
        end
    end
}

function MoviePhase:startMovie(i)
    local movie = moviemap.layers[i]
    if not movie or not Movie.is(movie) then return end
    ---@cast movie Movie

    Assets.maps[moviemap.file] = nil
    love.event.disconnect(moviemap)
    moviemap = assert(Tiled.Map.load(moviemap.file))
    moviemap:bindClasses()
    moviemap:indexLayersByName()
    moviemap:indexLayerObjectsByName()
    love.event.connect(moviemap)

    movie = moviemap.layers[i]
    moviemap:showOnlyNamed(movie.name)
    time = 0
    playingmovie = movie
    playingi = i
    movieerror = nil
    pause = love.keyboard.isDown("lshift")
        or love.keyboard.isDown("rshift")
    MoviePhase:step()
end

function MoviePhase:keypressed(k)
    local i = tonumber(k)
    if i then
        MoviePhase:startMovie(i == 0 and 10 or i)
        return
    end
    if keypressed[k] then keypressed[k]() end
end

function MoviePhase:quit()
    moviemap, playingmovie = nil, nil
end

MoviePhase.Overlay = {
    draworder = 50,
    draw = function ()
        if not showoverlay then return end

        local gw, gh = Dragontail.width, Dragontail.height
        local font = Assets.getFont("Unifont", 16)
        ---@cast font love.Font
        local fh = font:getHeight()

        love.graphics.setColor(0, 1, 0)
        love.graphics.printf("Press a number to play", font, 0, 0, gw, "left")

        local movies = moviemap.layers
        local y = fh
        for i = 1, math.min(10, #movies) do
            local s = string.format("%s %d. %s",
                i == playingi and '>' or ' ',
                i == 10 and 0 or i, movies[i].name)
            local light = Movie.is(movies[i]) and 1 or .5
            love.graphics.setColor(0, light, 0)
            love.graphics.printf(s, font, 0, y, gw, "left")
            y = y + fh
        end

        love.graphics.setColor(0, 1, 0)
        love.graphics.printf(tostring(time), font, 0, gh-fh, gw, "left")
        if pause then
            love.graphics.printf("PAUSE", font, 0, fh, gw, "right")
        end
    end
}

MoviePhase.ErrorOverlay = {
    draworder = 100,
    draw = function()
        local gw, gh = Dragontail.width, Dragontail.height
        local font = Assets.getFont("Silver", 19)
        ---@cast font love.Font
        if movieerror then
            love.graphics.setColor(0, 0, 0, .75)
            love.graphics.rectangle("fill", 8, 8, gw-16, gh-16)
            love.graphics.setColor(1, 0, 0)
            love.graphics.printf(movieerror, font, 8, 16, gw-8, "left")
        end
    end
}

function MoviePhase.draw()
    return "args", fixedfrac
end

return MoviePhase