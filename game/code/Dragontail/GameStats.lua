local GameStats = {
    elapsedtime = 0,
    deaths = 0
}

function GameStats.reset()
    GameStats.elapsedtime = 0
    GameStats.deaths = 0
end

return GameStats