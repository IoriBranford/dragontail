local Units = require "System.Units"
local Body = require "Component.Body"
local Sprite = require "Component.Sprite"
local Timer = require "Component.Timer"
local Health= require "Component.Health"
local Audio = require "System.Audio"
local Team   = require "Component.Team"
local Autofire= require "Component.Autofire"
local Cover   = require "Component.Cover"
local Text    = require "Component.Text"

local Bullet = {}
Bullet.metatable = {
    __index = Bullet
}

function Bullet:start(scene)
    if self.team == "PlayerShot" then
        Team.start(self, self.team, "EnemyTeam")
        self.health = self.health or 1
        self.hitdamageself = self.hitdamageself or 1
        self.offscreenremove = true
    elseif self.team == "PlayerBomb" then
        Team.start(self, self.team, "EnemyTeam EnemyShot")
        self.hitdamageself = self.hitdamageself or 0
    else
        Team.start(self, "EnemyShot", "PlayerTeam PlayerBomb")
        self.health = self.health or 1
        self.hitdamageself = self.hitdamageself or 1
        self.offscreenremove = true
    end
    self.hitdamageenemy = self.hitdamageenemy or 1
    if self.lifetime then
        Timer.start(self, "lifetime")
        self.think = self.think or Bullet.thinkAdvanced
    end
    self.inbattle = true
    if Autofire.hasAutofire(self) then
        self.think = self.think or Bullet.thinkAdvanced
    end
    if self.accelx or self.accely then
        self.accelx = self.accelx or 0
        self.accely = self.accely or 0
        self.think = self.think or Bullet.thinkAdvanced
    end
    self.bodytype = self.bodytype or "dynamic"
    self.bodybullet = true
    if self.bodyrotation == nil then
        self.bodyrotation = true
    end
    if self.bodyrotation then
        local velx, vely = self.velx or 0, self.vely or 0
        if velx ~= 0 or vely ~= 0 then
            self.rotation = math.atan2(vely, velx)
        end
    end
    self.bodystayawake = true
    Sprite.start(self, scene)
    Body.start(self)
    Audio.play(self.sound)
    self:emitParticles()
end

function Bullet:onCollision(other)
    if Cover.isInCover(other, self) then
        return
    end
    Health.onCollision_damage(self, other)
end

function Bullet:thinkAdvanced()
    Body.thinkCollision(self, Bullet.onCollision)
    if self.health then
        if self.health < 1 then
            Units.remove(self)
        end
    end
    if self.lifetime then
        if Timer.think(self, "lifetime") < 0 then
            Units.remove(self)
        end
    end
    Autofire.think(self)
    local accelx, accely = self.accelx, self.accely
    if accelx or accely then
        local velx, vely = self.velx, self.vely
        velx = velx + accelx
        vely = vely + accely
        self.velx, self.vely = velx, vely
        if self.bodyrotation then
            if velx ~= 0 or vely ~= 0 then
                self.rotation = math.atan2(vely + accely * 15, velx + accelx * 15)
            end
        end
    end
end

function Bullet:emitParticles()
    local particletype = Units.get(self.particletype)
    local particlecount = self.particlecount or 0
    local particledirection = self.particledirection or love.math.random() * 2 * math.pi
    if particletype and particlecount > 0 then
        particletype:emit(particlecount, self.x, self.y, particledirection)
    end
end

function Bullet:startSpark(scene)
    self.lifetime = self.lifetime or "animation"
    Sprite.start(self, scene)
    Timer.start(self, "lifetime")
    Text.start(self, scene)
    Audio.play(self.sound)
    self:emitParticles()
end

function Bullet:thinkSpark()
    if Timer.think(self, "lifetime") < 0 then
        Units.remove(self)
    end
end

return Bullet