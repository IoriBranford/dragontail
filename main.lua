love.filesystem.setRequirePath("scripts/?.lua;scripts/?/init.lua;libraries/?.lua;libraries/?/init.lua;"..love.filesystem.getRequirePath())
require("System.Main")("Dragontail")