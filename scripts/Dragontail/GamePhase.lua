local Canvas= require "System.Canvas"
local Config= require "System.Config"
local Stage = require "Dragontail.Stage"
local Sheets= require "Data.Sheets"
local Assets= require "System.Assets"
local isAsset = Assets.isAsset
local getAsset = Assets.get
local GamePhase = {}

function GamePhase.loadphase()
    Canvas.init(Config.basewindowwidth, Config.basewindowheight)

    Sheets.load("data/jam_characters.csv")
    Sheets.load("data/jam_attacks.csv")
    Sheets.forEach(function(_, properties)
        for k,v in pairs(properties) do
            if isAsset(v) then
                getAsset(v)
            end
        end
    end)

    Stage.init("data/jam_village.lua")
end

function GamePhase.quitphase()
    Stage.quit()
    Sheets.clear()
    Assets.clear()
end

function GamePhase.fixedupdate()
    Stage.fixedupdate()
end

function GamePhase.update(dsecs, fixedfrac)
    Stage.update(dsecs, fixedfrac)
end

function GamePhase.resize(w, h)
    Canvas.init(Config.basewindowwidth, Config.basewindowheight)
end

function GamePhase.draw()
    Canvas.drawOnCanvas(function()
        love.graphics.clear(.25, .25, .25)
        Stage.draw()
    end)
    Canvas.drawCanvas()
end

return GamePhase