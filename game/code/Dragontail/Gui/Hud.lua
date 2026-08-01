local Gui = require "Gui"
local Audio = require "System.Audio"

local Hud = class(Gui)

love.event.newEvents({
    playerheld = 1,
    playerunheld = 1,
    bossactive = 1
})

function Hud:spawn()
    self:showOnlyNamed("hud")
end

function Hud:playerheld(player, holder)
    local dirx, diry = math2.frompolar(holder.holdangle)
    local axis = math.abs(dirx) < math.abs(diry) and "y" or "x"
    local str = assert(holder.holdstrength)
    local inistr = assert(holder.initialholdstrength)
    local progress = 1 - str / inistr

    local ui = self.hud_breakgrab
    ui.visible = true

    local camera = player.camera
    local promptover = player--axis == "y" and holddiry > 0 and holder or player
    ui.x = promptover.x - camera.x
    ui.y = promptover.y - promptover.z - promptover.bodyheight - camera.y

    local prompt = ui.prompt
    if prompt then
        prompt:changeAnimation(axis)

        local x1, y1, x2, y2 = prompt:getExtents()
        if ui.x + x1 < 0 then
            ui.x = - x1
        end
        if ui.y + y1 < 0 then
            ui.y = - y1
        end
        if ui.x + x2 > camera.width then
            ui.x = camera.width - x2
        end
        if ui.y + y2 > camera.height then
            ui.y = camera.height - y2
        end
    end

    local gaugel, gauger, gaugeu, gauged, gaugex, gaugey =
        ui.gaugel, ui.gauger, ui.gaugeu, ui.gauged, ui.gaugex, ui.gaugey
    if gaugel then
        gaugel:setPercent(progress)
        gaugel.visible = axis == "x"
    end
    if gauger then
        gauger:setPercent(progress)
        gauger.visible = axis == "x"
    end
    if gaugeu then
        gaugeu:setPercent(progress)
        gaugeu.visible = axis == "y"
    end
    if gauged then
        gauged:setPercent(progress)
        gauged.visible = axis == "y"
    end
    if gaugex then gaugex.visible = axis == "x" end
    if gaugey then gaugey.visible = axis == "y" end
end

function Hud:playerunheld()
    self.hud_breakgrab.visible = false
end

function Hud:bossactive(boss)
    local ui = self.hud_boss
    ui.visible = Audio.isPlayingMusic() and boss.health > 0

    local healthbar = ui.health
    ---@cast healthbar Gauge
    healthbar:setPercent(boss.health / boss.maxhealth)
end

function Hud:draw()
    Gui.draw(self)
end

return Hud