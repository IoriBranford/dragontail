local Database      = require "Data.Database"
local Color      = require "Tiled.Color"
local Config      = require "System.Config"
local State       = require "Dragontail.Character.State"
local Object      = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Attack      = require "Dragontail.Character.Attack"
local Body        = require "Dragontail.Character.Body"
local Shadow      = require "Dragontail.Character.Shadow"
local Characters

local pi = math.pi
local floor = math.floor
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local asin = math.asin
local lensq = math.lensq
local dot = math.dot
local min = math.min
local max = math.max
local testcircles = math.testcircles

---@class DropAfterimage
---@field afterimageinterval integer?

---@class Character:AsepriteObject,DropAfterimage,Body,Attack,Hurt,Shadow
---@field initialai string
---@field camera Camera
---@field opponents Character[]
---@field shadowcolor Color?
---@field animationdirections integer?
---@field emote Character?
local Character = class(Object)

function Character:init()
    Characters = Characters or require "Dragontail.Stage.Characters"
    if self.visible == nil then
        self.visible = true
    end
    self.health = self.health or 1
    self.maxhealth = self.maxhealth or self.health

    Body.init(self)

    self.drawz = self.drawz or 0
    self.attackradius = self.attackradius or 0
    -- ch.attackangle = ch.attackangle or 0
    self.attackarc = self.attackarc or 0
    self.attackdamage = self.attackdamage or 1
    self.attackstun = self.attackstun or 1
    self.hitstun = self.hitstun or 0
    self.hurtstun = self.hurtstun or 0
end

---@param scene Scene
function Character:addToScene(scene)
    scene:add(self)
    self.originx = self.spriteoriginx
    self.originy = self.spriteoriginy

    local baseDraw = self.draw
    self.draw = function(self, fixedfrac)
        Shadow.drawSprite(self, fixedfrac)
        baseDraw(self, fixedfrac)
        if Config.drawbodies then
            Body.draw(self, fixedfrac)
            Attack.drawCircle(self, fixedfrac)
        end
    end
end

function Character:makeAfterImage()
    local afterimage = Characters.spawn({
        x = self.x,
        y = self.y,
        asefile = self.asefile,
        animationspeed = 0,
        spriteoriginx = self.spriteoriginx,
        spriteoriginy = self.spriteoriginy,
        script = "Dragontail.Character.Common",
        initialai = "afterimage",
        shadowcolor = 0
    })
    afterimage:setAseAnimation(self.aseanimation, self.animationframe)
end

Character.accelerate = Body.accelerate
Character.accelerateTowardsVel = Body.accelerateTowardsVel

function Character:makeHurtParticle()
    local particletype = Database.get(self.hurtparticle)
    if not particletype then
        return
    end

    local hurtangle = self.hurtangle or 0
    local speed = particletype.speed or 0
    local arc = particletype.conearc or 0
    hurtangle = hurtangle + (2*love.math.random() - 1)*arc
    local cosangle = cos(hurtangle)
    local sinangle = sin(hurtangle)
    local velx = cosangle*speed
    local vely = sinangle*speed
    return Characters.spawn {
        type = self.hurtparticle,
        x = self.x + velx,
        y = self.y + vely,
        z = self.z + self.bodyheight/2,
        velx = velx,
        vely = vely
    }
end

function Character:updateHurtColorCycle(t)
    local hurtcolorcycle = self.hurtcolorcycle
    if not hurtcolorcycle then
        return
    end
    if type(hurtcolorcycle) == "string" then
        local colors = {}
        for colorstr in hurtcolorcycle:gmatch("%d+") do
            local color = tonumber(colorstr)
            if color then
                colors[#colors+1] = color
            end
        end
        hurtcolorcycle = colors
        self.hurtcolorcycle = colors
    end
    if #hurtcolorcycle <= 0 then
        return
    end
    return hurtcolorcycle[1 + (t % #hurtcolorcycle)]
end

function Character:isHitStopOver()
    return self.hitstun <= 0 and self.hurtstun <= 0
end

function Character:fixedupdateHitStop()
    if self.hitstun > 0 then
        self.hitstun = self.hitstun - 1
        if self.hitstun > 0 then
            return false
        end
    end
    if self.hurtstun > 0 then
        self:makeHurtParticle()
        local color = self:updateHurtColorCycle(self.hurtstun)
        if color then
            self.color = color
        end
        self.hurtstun = self.hurtstun - 1
        if self.hurtstun > 0 then
            return false
        end
        self.color = 0xffffffff
        self.hurtparticle = nil
        self.hurtcolorcycle = nil
        self.scalex = 1
        self.scaley = 1
    end
    return true
end

function Character:fixedupdate()
    if self:fixedupdateHitStop() then
        self:animate(1)
        Body.updatePosition(self)
        State.run(self)
        Body.updateGravity(self)
    end
end

function Character:fixedupdateShake(time)
    time = max(0, time - 1)
    self.originx = self.spriteoriginx + 2*math.sin(time)
    return time
end

function Character:update(dsecs, fixedfrac)
    if self.hurtstun > 0 then
        local s = min(4, self.hurtstun) * sin(self.hurtstun)
        self.scalex = 1 + s/8
        self.scaley = 1 - s/32
    end
    self.originy = (self.spriteoriginy or 0) + self.z
end

Character.moveTo = Body.executeMove

Character.isAttacking = Attack.isAttacking
Character.startAttack = Attack.startAttack
Character.stopAttack = Attack.stopAttack

function Character:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Character:stopGuarding()
    self.guardangle = nil
end

Character.keepInBounds = Body.keepInBounds

---@param attacker Character
function Character:collideWithCharacterAttack(attacker)
    if self.hurtstun > 0 then
        return
    end
    if not self.canbeattacked then
        if not attacker.attackcanjuggle or not self.canbejuggled then
            return
        end
    end
    if Attack.checkAttackCollision(attacker, self) then
        local guardhitai = self.guardai or "guardHit"
        local hurtai = self.hurtai or "hurt"
        local hitai = attacker.attackhitai
        local attacktype = attacker.attacktype
        local canbedamagedbyattack = self.canbedamagedbyattack
        if type(attacktype) == "string"
        and type(canbedamagedbyattack) == "string" then
            canbedamagedbyattack = attacktype:find(canbedamagedbyattack) ~= nil
        else
            canbedamagedbyattack = true
        end

        if self.guardangle or not canbedamagedbyattack then
            State.start(self, guardhitai, attacker)
            hitai = attacker.attackguardedai or hitai
        else
            State.start(self, hurtai, attacker)
            if attacker.hitstun <= 0 then
                attacker.hitstun = attacker.attackstunself or 3
            end
            hitai = attacker.attackhitopponentai or hitai
            attacker.numopponentshit = (attacker.numopponentshit or 0) + 1
        end
        if hitai then
            State.start(attacker, hitai, self)
        end
        return true
    end
end

function Character:heal(amount)
    self.health = min(self.health + amount, self.maxhealth)
end

function Character:setEmote(emotename)
    local emote = self.emote
    if emote then
        if emotename then
            emote.visible = true
            emote:changeAseAnimation(emotename)
        else
            emote.visible = false
        end
    end
end

function Character:isOnCamera(camera)
    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local x, y, x2, y2 = self:getExtents()
    local w, h = x2-x, y2-y
    local _, _, iw, ih = math.rectintersection(x, y, w, h, cx, cy, cw, ch)
    return iw and iw > 0 and ih > 0
end

function Character:isFullyOnCamera(camera)
    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local x, y, x2, y2 = self:getExtents()
    local w, h = x2-x, y2-y
    local _, _, iw, ih = math.rectintersection(x, y, w, h, cx, cy, cw, ch)
    return iw and iw == w and ih == h
end

function Character:disappear()
    self.disappeared = true
end

function Character:hasDisappeared()
    return self.disappeared
end

return Character