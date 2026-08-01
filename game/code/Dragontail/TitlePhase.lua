-- local Wallpaper = require "System.Wallpaper"
local Assets    = require "Tiled.Assets"
local Audio  = require "System.Audio"
local Gui            = require "Gui"
local TitleHit       = require "Dragontail.Movie.TitleHit"
local fixedupdate    = require "fixedupdate"
local Config         = require "System.Config"
local Dragontail     = require "Dragontail"
local TitlePhase = {}

local scenemap ---@type Gui
local sceneco ---@type function
local ambientsound ---@type love.Source

function TitlePhase:loadphase(startwithmainmenu)
    scenemap = Gui.new("data/gui/screen_title.lua")
    scenemap:showOnlyNamed("bg", "title", "etc")

    local wipemap = Gui.new("data/gui/wipe_diagonalcurtains.lua")

    Assets.get("ccdata/music/Block Island Sound loop.ogg")

    Assets.uncacheMarked()
    Assets.packTiles()
    Assets.batchAllMapsLayers()

    if startwithmainmenu then
        TitlePhase:pushMainMenu()
    else
        scenemap:pushMenu(scenemap.title)
        ambientsound = Audio.play("data/sounds/ambient/seaside.ogg")
        if ambientsound then ambientsound:setLooping(true) end
    end

    love.event.connect(Dragontail.predraw)
    love.event.connect(scenemap)
    love.event.connect(wipemap)
    love.event.connect(Dragontail.postdraw)
    Dragontail.sortDrawers()
    love.event.send("wipestart", "open")
end

function TitlePhase:pushMainMenu()
    scenemap:showOnlyNamed("bg", "etc", "TitleHit")
    sceneco = coroutine.wrap(function ()
        local menu = scenemap.menu
        local shaking = scenemap.TitleHit.shaking
        local titlehit = coroutine.wrap(TitleHit)
        local ok, status = pcall(titlehit, scenemap.TitleHit)
        while ok and status ~= true do
            coroutine.yield()
            ok, status = pcall(titlehit)
            if status == "hit" then
                menu.visible = true
            end
            menu.x, menu.y = shaking.x, shaking.y
        end
        if not ok then print(status) end
        scenemap:pushMenu(menu)
        return true
    end)
    sceneco()
    Audio.playMusic("ccdata/music/Block Island Sound loop.ogg", nil, true)
end

function TitlePhase:quitphase()
    Audio.stop()
    Assets.markAllToUncache()
    scenemap = nil
    sceneco = nil
    ambientsound = nil
end

function TitlePhase:keypressed(key)
    -- if Config.exhibit and key == "f1" then
    --     GuiActions.openOptions(Gui)
    --     return
    -- end

    if love.keyboard.isDown("lctrl") and key == 's' then
        local filename = os.date("screenshot-%Y%m%d-%H%M%S.png")
        local i = 1
        while love.filesystem.getInfo(filename) do
            filename = os.date("screenshot-%Y%m%d-%H%M%S-"..i..".png")
        end
        love.graphics.captureScreenshot(filename)
    end
end

function TitlePhase:fixedupdate()
    if sceneco then
        if sceneco() then
            sceneco = nil
        end
    end
end

local fixedfrac = 0

function TitlePhase:update(dsecs)
    local fixedrate = Config.fixedupdaterate
    fixedfrac = fixedupdate(fixedrate, fixedfrac, dsecs,
    function()
        love.event.send("fixedupdate")
    end)
end

function TitlePhase:draw()
    return "args", fixedfrac
end

return TitlePhase