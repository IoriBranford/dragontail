local Face = require "Dragontail.Character.Component.Face"
local Slide= require "Dragontail.Character.Component.Slide"
local Body = require "Dragontail.Character.Component.Body"
local Behavior = require "Dragontail.Character.Behavior"
local Characters = require "Dragontail.Stage.Characters"

local DodgeLinear = pooledclass(Behavior)
DodgeLinear._nrec = Behavior._nrec + 3

function DodgeLinear:start(dodgeangle)
    local ftr = self.character
    local opponent = ftr.opponents[1]
    local x, y, oppox, oppoy = ftr.x, ftr.y, opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    if tooppox == 0 and tooppoy == 0 then
        tooppox = 1
    end
    tooppox, tooppoy = math.norm(tooppox, tooppoy)
    Face.faceVector(ftr, tooppox, tooppoy)
    self.opponent = opponent
    self.dodgeangle = dodgeangle
    self.speed = ftr.dodgespeed or 1
    self.speed = Slide.updateSlideSpeed(ftr, self.dodgeangle, self.speed, (ftr.accel or 1))
    ftr.statetime = ftr.statetime or 30
end

function DodgeLinear:fixedupdate()
    local ftr = self.character
    local newstate, a, b, c, d, e, f = ftr:duringDodge(self.opponent)
    if newstate then
        return newstate, a, b, c, d, e, f
    end
    self.speed = Slide.updateSlideSpeed(ftr, self.dodgeangle, self.speed, (ftr.accel or 1))
    if ftr.z == ftr.floorz
    and ftr.statetime > 20
    and ftr.statetime % 3 == 0 then
        local revangle = self.dodgeangle+math.pi
        local dust = {
            type="spark-dodge-dust",
            x = ftr.x, y = ftr.y, z = ftr.z,
            velz = 2,
            faceangle = revangle, accel = 1,
        }
        dust.x, dust.y = math2.vadd(dust.x, dust.y,
            math2.frompolar(self.dodgeangle, self.bodyradius))

        dust.velx, dust.vely = math2.frompolar(revangle, self.speed/4)

        Characters.spawn(dust)
    end
    if not ftr.statetime then
        if self.speed == 0 then
            return "stand"
        end
    end
end

return DodgeLinear