local Config = require "System.Config"
local Assets = require "System.Assets"

---@module 'Audio'
local Audio = {}

local music
local musicfadespeed = 0

function Audio.stop()
    Audio.stopMusic()
    love.audio.stop()
end

function Audio.play(file)
    local clip = Assets.get(file) ---@type love.Source?
    if clip then
        clip:stop()
        clip:setVolume(Config.soundvolume)
        clip:play()
    end
    return clip
end

function Audio.newSource(file)
    local clip = Assets.get(file)
    return clip and clip:clone()
end

function Audio.setMusicVolume(volume)
    if music then
        music:setVolume(volume)
    end
end

function Audio.update(dsecs)
    if music then
        if musicfadespeed > 0 then
            local volume = music:getVolume() - musicfadespeed * dsecs
            if volume <= 0 then
                Audio.stopMusic()
            else
                music:setVolume(volume)
            end
        end
    end
end

function Audio.stopMusic()
    if music then
        music:stop()
    end
    music = nil
    musicfadespeed = 0
end

function Audio.playMusic(file, track)
    Audio.stopMusic()
    music = Assets.get(file) ---@type GameMusicEmu?
    if music then
        music:setVolume(Config.musicvolume)
        music:play(track)
    end
    return music
end

function Audio.isPlayingMusic()
    return music ~= nil
end

function Audio.fadeMusic(time)
    if music then
        time = time or 3
        musicfadespeed = music:getVolume() / time
    end
    return music
end

return Audio
