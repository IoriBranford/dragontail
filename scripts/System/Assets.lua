local Cache = require "Data.Cache"
local json_decode = (require "json").decode
local Assets = {}

local cache = Cache.new("data/")
local lfs_read = love.filesystem.read
local loaders = {
    png = love.graphics.newImage,
    mp3 = love.audio.newSource,
    ogg = love.audio.newSource,
    wav = love.audio.newSource,
    lua = love.filesystem.load,
    json = function (path) return json_decode(lfs_read(path)) end
}

function Assets.load(path, ...)
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