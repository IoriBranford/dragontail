local Database      = require "Data.Database"
local Color      = require "Tiled.Color"
local Config      = require "System.Config"
local StateMachine       = require "Dragontail.Character.StateMachine"
local Object      = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Attacker      = require "Dragontail.Character.Attacker"
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

---@class Character:AsepriteObject,DropAfterimage,Body,Attacker,Victim,Shadow
---@field initialai string
---@field camera Camera
---@field opponents Character[]
---@field shadowcolor Color?
---@field animationdirections integer?
---@field emote Character?
local Character = class(Object)
Character.attack = {}

function Character:init()
    Characters = Characters or require "Dragontail.Stage.Characters"
    if self.visible == nil then
        self.visible = true
    end
    self.health = self.health or 1
    self.maxhealth = self.maxhealth or self.health

    Body.init(self)
    StateMachine.init(self)

    self.drawz = self.drawz or 0
    -- ch.attackangle = ch.attackangle or 0
    self.hitstun = self.hitstun or 0
    self.hurtstun = self.hurtstun or 0
end

local function nop() end

---@param scene Scene
function Character:addToScene(scene)
    scene:add(self)

    if self.draw == Character.draw then
        self.baseDraw = nop
    else
        self.baseDraw = self.draw
    end
    self.draw = nil
end

function Character:draw(fixedfrac)
    Shadow.drawSprite(self, fixedfrac)
    love.graphics.push()
    love.graphics.translate(0, -self.z - self.velz*fixedfrac)
    self:baseDraw(fixedfrac)
    if Config.drawbodies then
        Body.draw(self, fixedfrac)
        Attacker.drawCircle(self, fixedfrac)
    end
    love.graphics.pop()
end

function Character:makeAfterImage()
    local afterimage = Characters.spawn({
        x = self.x,
        y = self.y,
        z = self.z,
        asefile = self.asefile,
        type = "afterimage"
    })
    afterimage.originx, afterimage.originy = self:getOrigin()
    afterimage:setAseAnimation(self.aseanimation, self.animationframe)
end

function Character:makePeriodicAfterImage(t, interval)
    if (interval or 0) ~= 0 and t % interval == 0 then
        self:makeAfterImage()
    end
end

Character.accelerate = Body.accelerate
Character.accelerateTowardsVel = Body.accelerateTowardsVel
Character.accelerateTowardsVel3 = Body.accelerateTowardsVel3

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
        local s = min(4, self.hurtstun) * sin(self.hurtstun)
        self.scalex = 1 + s/8
        self.scaley = 1 - s/32
        if self.hurtstun > 0 then
            return false
        end
        self.color = 0xffffffff
        self.hurtparticle = nil
        self.hurtcolorcycle = nil
    end
    return true
end

function Character:fixedupdate()
    if self:fixedupdateHitStop() then
        self:animate(1)
        Body.updatePosition(self)
        StateMachine.run(self)
        Body.updateGravity(self)
    end
end

function Character:update(dsecs, fixedfrac)
end

Character.moveTo = Body.executeMove

Character.isAttacking = Attacker.isAttacking
Character.startAttack = Attacker.startAttack
Character.stopAttack = Attacker.stopAttack

function Character:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Character:stopGuarding()
    self.guardangle = nil
end

function Character:onHitByAttack(attacker)
    local guardhitai = self.guardai or "guardHit"
    local hurtai = self.hurtai or "hurt"
    local hitai = attacker.attack.selfstateonhit
    local attacktype = attacker.attacktype
    local canbedamagedbyattack = self.canbedamagedbyattack
    if type(attacktype) == "string"
    and type(canbedamagedbyattack) == "string" then
        canbedamagedbyattack = attacktype:find(canbedamagedbyattack) ~= nil
    else
        canbedamagedbyattack = true
    end

    if self.guardangle or not canbedamagedbyattack then
        StateMachine.start(self, guardhitai, attacker)
        hitai = attacker.selfstateonguard or hitai
    else
        StateMachine.start(self, hurtai, attacker)
        if attacker.hitstun <= 0 then
            attacker.hitstun = attacker.attack.selfstun or 3
        end
        hitai = attacker.attack.selfstateonhitopponent or hitai
        attacker.numopponentshit = (attacker.numopponentshit or 0) + 1
    end
    if hitai then
        StateMachine.start(attacker, hitai, self)
    end
end

function Character:debugPrint_collideWithCharacterAttack(attacker)
    print("hurtstun", self.hurtstun)
    print("canbeattacked", self.canbeattacked)
    print("attacker.attack.canjuggle", attacker.attack.canjuggle)
    print("canbejuggled", self.canbejuggled)
    if not Attacker.checkAttackCollision(attacker, self) then
        Attacker.debugPrint_checkAttackCollision_circle(attacker, self)
    end
end

---@param attacker Character
function Character:collideWithCharacterAttack(attacker)
    if self.hurtstun > 0 then
        return
    end
    if not self.canbeattacked then
        if not attacker.attack.canjuggle or not self.canbejuggled then
            return
        end
    end
    if Attacker.checkAttackCollision(attacker, self) then
        self:onHitByAttack(attacker)
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
    local _, _, iw, ih = math.rectintersection(x, y-self.z, w, h, cx, cy, cw, ch)
    return iw and iw == w and ih == h
end

function Character:isCylinderOnCamera(camera)
    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local radius = self.bodyradius
    local height = self.bodyheight
    local w = 2 * radius
    local h = w + height
    local x, y = self.x - radius, self.y - radius - height
    local _, _, iw, ih = math.rectintersection(x, y - self.z, w, h, cx, cy, cw, ch)
    return iw and iw > 0 and ih > 0
end

function Character:isCylinderFullyOnCamera(camera)
    local cx, cy, cw, ch = camera.x, camera.y, camera.width, camera.height
    local radius = self.bodyradius
    local height = self.bodyheight
    local w = 2 * radius
    local h = w + height
    local x, y = self.x - radius, self.y - radius - height
    local _, _, iw, ih = math.rectintersection(x, y - self.z, w, h, cx, cy, cw, ch)
    return iw and iw == w and ih == h
end

function Character:disappear()
    self.disappeared = true
end

function Character:hasDisappeared()
    return self.disappeared
end

return Character