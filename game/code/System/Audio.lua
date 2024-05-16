local Config = require "System.Config"
local Assets = require "Tiled.Assets"
local Platform     = require "System.Platform"
local VGMPlayer
local GameMusicEmu
if Platform.supports("ffi") then
    VGMPlayer = require "VGMPlayer"
    if not VGMPlayer then
        GameMusicEmu = require "GameMusicEmu"
    end
end

---@module 'Audio'
local Audio = {}

local music
local musicfadespeed = 0

local function load_audio(path, mode)
    local ok, source = pcall(love.audio.newSource, path, mode or "static")
    if ok then
        return source
    end
    print(source)
end

local load_vgm = function(path, ...)
    if VGMPlayer then
        return VGMPlayer.new(path, ...)
    end
    if GameMusicEmu and GameMusicEmu.isSupported(path) then
        return GameMusicEmu.new(path, ...)
    end
    return load_audio(path, "stream")
end

Assets.addLoaders {
    vgm = load_vgm,
    vgz = load_vgm,
    mp3 = load_audio,
    ogg = load_audio,
    wav = load_audio,
    it  = load_audio,
    xm  = load_audio,
    s3m = load_audio,
    mod = load_audio,
}

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
    music = Assets.get(file) ---@type VGMPlayer|GameMusicEmu?
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
