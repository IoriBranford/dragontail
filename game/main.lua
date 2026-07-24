local FS = love.filesystem

FS.setRequirePath("code/?.lua;code/?/init.lua;libraries/?.lua;libraries/?/init.lua;"..love.filesystem.getRequirePath())
local sbd = FS.getSourceBaseDirectory()
FS.mount(sbd, "/")
require("System.Main")("Dragontail")