local Cache = require "Data.Cache"
local Aseprite = require "Data.Aseprite"
local json_decode = (require "json").decode
local Platform     = require "System.Platform"
local VGMPlayer
local GameMusicEmu
if Platform.supports("ffi") then
    VGMPlayer = require "VGMPlayer"
    if not VGMPlayer then
        GameMusicEmu = require "GameMusicEmu"
    end
end
local Assets = {}

local cache

local lfs_read = love.filesystem.read

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

local loaders = {
    png = love.graphics.newImage,
    vgm = load_vgm,
    vgz = load_vgm,
    mp3 = load_audio,
    ogg = load_audio,
    wav = load_audio,
    it  = load_audio,
    xm  = load_audio,
    s3m = load_audio,
    mod = load_audio,
    lua = love.filesystem.load,
    fnt = love.graphics.newFont,
    json = function (path) return json_decode(lfs_read(path)) end,
    jase = Aseprite.load,
    vert = love.graphics.newShader,
    frag = love.graphics.newShader,
}

function Assets.init(root)
    cache = Cache.new(root or "data/")
end

function Assets.isAsset(path)
    if type(path) ~= "string" then
        return
    end
    local ext = path:match("%.(%w-)$")
    return ext and loaders[ext] ~= nil
end

function Assets.load(path, ...)
    if type(path) ~= "string" then
        return
    end
    local ext = path:match("%.(%w-)$")
    local loader = loaders[ext] or lfs_read
    return cache:load(loader, path, ...)
end

function Assets.get(path)
    return cache:get(path) or Assets.load(path)
end

function Assets.clear()
    cache:clear()
end

return Assets