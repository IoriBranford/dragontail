local Behavior = require "Dragontail.Character.Behavior"
local Characters = require "Dragontail.Stage.Characters"
local Color      = require "Tiled.Color"
local Body       = require "Dragontail.Character.Component.Body"
local Downed = pooledclass(Behavior)

function Downed:start()
    local fighter = self.character
    Characters.spawn({
        type = "spark-fall-down-dust",
        x = fighter.x,
        y = fighter.y + 1,
        z = fighter.z,
    })

    local color = fighter.color
    if color ~= Color.White then
        fighter.color = Color.White
        for i = 1, 8 do
            local offsetangle = love.math.random()*2*math.pi
            local offsetdist = love.math.random()*fighter.bodyradius
            local offsetx = offsetdist*math.cos(offsetangle)
            local offsety = offsetdist*math.sin(offsetangle)
            local velx = offsetx/8
            local vely = offsety/8

            Characters.spawn({
                type = "particle",
                x = fighter.x + offsetx,
                y = fighter.y + offsety,
                z = fighter.z,
                velx = velx,
                vely = vely,
                velz = 30/16,
                color = color,
                gravity = 1/16,
                lifetime = 30
            })
        end
    end
end

function Downed:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
end

function Downed:timeout(...)
    local fighter = self.character
    fighter.velx, fighter.vely, fighter.velz = 0, 0, 0
    if fighter.health <= 0 then
        return "defeat"
    end
    return ...
end

return Downed
