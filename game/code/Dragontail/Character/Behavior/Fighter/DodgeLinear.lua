local Face = require "Dragontail.Character.Component.Face"
local Slide= require "Dragontail.Character.Component.Slide"
local Body = require "Dragontail.Character.Component.Body"
local Behavior = require "Dragontail.Character.Behavior"
local Characters = require "Dragontail.Stage.Characters"

local DodgeLinear = pooledclass(Behavior)
DodgeLinear._nrec = Behavior._nrec + 3

function DodgeLinear:start(dodgeangle)
    local fighter = self.character
    local opponent = fighter.opponents[1]
    local x, y, oppox, oppoy = fighter.x, fighter.y, opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    if tooppox == 0 and tooppoy == 0 then
        tooppox = 1
    end
    tooppox, tooppoy = math.norm(tooppox, tooppoy)
    Face.faceVector(fighter, tooppox, tooppoy)
    self.opponent = opponent
    self.dodgeangle = dodgeangle
    self.speed = fighter.dodgespeed or 1
    self.speed = Slide.updateSlideSpeed(fighter, self.dodgeangle, self.speed, (fighter.accel or 1))
    fighter.statetime = fighter.statetime or 30
end

function DodgeLinear:fixedupdate()
    local fighter = self.character
    local newstate, a, b, c, d, e, f = fighter:duringDodge(self.opponent)
    if newstate then
        return newstate, a, b, c, d, e, f
    end
    self.speed = Slide.updateSlideSpeed(fighter, self.dodgeangle, self.speed, (fighter.accel or 1))
    if fighter.floorz == fighter.z
    and fighter.statetime + 3 >= fighter.state.statetime then
        local angle = self.dodgeangle
        local velx, vely = math2.frompolar(angle, -(self.speed or 1))
        Characters.spawn({
            type = "spark-slide-dust",
            x = fighter.x,
            y = fighter.y,
            z = fighter.z,
            velx = velx, vely = vely
        })
    end
    if not fighter.statetime then
        if self.speed == 0 then
            return "stand"
        end
    end
end

return DodgeLinear