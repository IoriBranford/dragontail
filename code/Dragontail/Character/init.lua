local SceneObject = require "System.SceneObject"
local Assets      = require "System.Assets"
local Database      = require "Data.Database"
local Audio       = require "System.Audio"
local Config      = require "System.Config"
local Script      = require "Component.Script"
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

---@class Character
local Character = {}

Character.metatable = {
    __index = Character,
    __lt = SceneObject.__lt
}
local Metatable = Character.metatable

function Character.init(ch, chprefab)
    if chprefab then
        for k,v in pairs(chprefab) do
            ch[k] = v
        end
    end
    local type = ch.type
    if type then
        Database.fillBlanks(ch, type)
    end
    ch.health = ch.health or 1
    ch.maxhealth = ch.maxhealth or ch.health
    ch.x = ch.x or 0
    ch.y = ch.y or 0
    ch.z = ch.z or 0
    ch.velx = ch.velx or 0
    ch.vely = ch.vely or 0
    ch.velz = ch.velz or 0
    ch.speed = ch.speed or 1
    ch.bodyradius = ch.bodyradius or 1
    ch.attackradius = ch.attackradius or 0
    -- ch.attackangle = ch.attackangle or 0
    ch.attackarc = ch.attackarc or 0
    ch.attackdamage = ch.attackdamage or 1
    ch.attackstun = ch.attackstun or 1
    ch.hitstun = ch.hitstun or 0
    ch.hurtstun = ch.hurtstun or 0
    return setmetatable(ch, Metatable)
end
local init = Character.init

function Character.new(chprefab)
    return init({}, chprefab)
end

function Character:addSprite(scene, file, frameortag, tagframe, ox, oy)
    local ase = file and Assets.get(file)
    if ase then
        local sprite
        if type(frameortag) == "string" then
            sprite = scene:addManualAnimatedAseprite(ase, frameortag, tagframe,
                self.x, self.y, 0,
                0, 1, 1, ox or 0, oy or 0)
        else
            sprite = scene:addAseprite(ase, frameortag,
                self.x, self.y, 0,
                0, 1, 1, ox or 0, oy or 0)
        end
        return sprite
    end
end

function Character:removeSprite(key)
    local sprite = self[key]
    if sprite then
        sprite:markRemove()
        self[key] = nil
    end
end

function Character:animateSprite(sprite)
    if sprite then
        if sprite.animate then
            sprite:animate(1)
        end
    end
end

function Character:updateSprite(sprite, fixedfrac)
    if sprite then
        local vx, vy = self.velx or 0, self.vely or 0
        local x, y, z = self.x, self.y, self.z
        sprite.x = x + vx * fixedfrac
        sprite.y = y + vy * fixedfrac
        sprite.oy = (self.spriteoriginy or 0) + z
    end
end

function Character:addToScene(scene)
    local asepritefile = self.asepritefile
    local sprite = asepritefile and self:addSprite(scene,
        asepritefile, self.animation or 1, nil,
        self.spriteoriginx, self.spriteoriginy)
    if sprite then
        self.sprite = sprite
        local baseDraw = sprite.draw
        if self.shadowtype then
            sprite.draw = function(sprite)
                self:drawShadow()
                baseDraw(sprite)
            end
        end
    end
    local emoteasepritefile = self.emoteasepritefile
    local emote = emoteasepritefile and self:addSprite(scene,
        emoteasepritefile, 1, nil,
        self.emoteoriginx or (emoteasepritefile.width/2),
        self.emoteoriginy or (emoteasepritefile.height + (self.spriteoriginy or 0)))
    if emote then
        self.emote = emote
        emote.hidden = true
    end
end

function Character:makeAfterImage()
    local Stage = require "Dragontail.Stage"
    Stage.addCharacter({
        x = self.x,
        y = self.y,
        asepritefile = self.asepritefile,
        animation = self.sprite.asepriteframe,
        spriteoriginx = self.spriteoriginx,
        spriteoriginy = self.spriteoriginy,
        script = "Dragontail.Character.Common",
        initialai = "afterimage"
    })
end

function Character:move(dx, dy)
    self.x = self.x + dx * self.speed
    self.y = self.y + dy * self.speed
end

function Character:accelerate(ax, ay)
    self.velx = self.velx + ax
    self.vely = self.vely + ay
end

function Character:accelerateTowardsVel(targetvelx, targetvely, t, e)
    assert(t > 0, "t <= 0")
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
end

function Character:updatePosition()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
end

function Character:fixedupdate()
    if self.hitstun > 0 then
        self.hitstun = self.hitstun - 1
        if self.hitstun > 0 then
            return
        end
    end
    if self.hurtstun > 0 then
        self.hurtstun = self.hurtstun - 1
        if self.hurtstun > 0 then
            return
        end
    end
    self.x = self.x + self.velx
    self.y = self.y + self.vely
    Script.run(self)
    self:animateSprite(self.sprite)
    self:animateSprite(self.emote)
end

function Character:fixedupdateShake(time)
    time = max(0, time - 1)
    if self.sprite then
        self.sprite.ox = self.spriteoriginx + 2*math.sin(time)
    end
    return time
end

function Character:update(dsecs, fixedfrac)
    self:updateSprite(self.sprite, fixedfrac)
    self:updateSprite(self.emote, fixedfrac)
    if self.sprite then
        self.sprite.ox = self.spriteoriginx + 2*math.sin(self.hurtstun)
    end
end

function Character:startAttack(attackangle)
    self.attackangle = attackangle
end

function Character:stopAttack()
    self.attackangle = nil
end

function Character:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Character:stopGuarding()
    self.guardangle = nil
end

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*pi, 2*pi) - pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*pi, 2*pi) - pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:getBoundsPenetration(bx, by, bw, bh)
    local x, y = self.x, self.y
    local bodyradius = self.bodyradius
    local x1, x2 = x - bodyradius, x + bodyradius
    local y1, y2 = y - bodyradius, y + bodyradius
    local bx2, by2 = bx + bw, by + bh
    local penex, peney
    if x1 < bx then
        penex = x1 - bx
    elseif x2 > bx2 then
        penex = x2 - bx2
    end
    if y1 < by then
        peney = y1 - by
    elseif y2 > by2 then
        peney = y2 - by2
    end
    return penex, peney
end

function Character:keepInBounds(bx, by, bw, bh, bounce)
    local penex, peney = self:getBoundsPenetration(bx, by, bw, bh)
    bounce = bounce or 0
    if penex then
        self.x = self.x - penex
        if self.velx * penex > 0 then
            self.velx = bounce * -self.velx
        end
    end
    if peney then
        self.y = self.y - peney
        if self.vely * peney > 0 then
            self.vely = bounce * -self.vely
        end
    end
    return penex, peney
end

function Character:testBodyCollision(other)
    return self ~= other and testcircles(self.x, self.y, self.bodyradius, other.x, other.y, other.bodyradius)
end

function Character:collideWithCharacterBody(other)
    if not other.bodysolid then
        return
    end
    local distsq = self:testBodyCollision(other)
    if distsq then
        local radii = self.bodyradius + other.bodyradius
        local dist = math.sqrt(distsq)
        local dx, dy = self.x - other.x, self.y - other.y
        local normx, normy = dx/dist, dy/dist
        self.x = other.x + normx*radii
        self.y = other.y + normy*radii
        return dx, dy
    end
end

function Character:checkAttackCollision(attacker)
    if self == attacker then
        return
    end
    local attackangle = attacker.attackangle
    if not attackangle then
        return
    end
    local fromattackerx, fromattackery = self.x - attacker.x, self.y - attacker.y
    local distsq = lensq(fromattackerx, fromattackery)
    local bodyradius = self.bodyradius
    local radii = bodyradius + attacker.attackradius
    local radiisq = radii * radii
    if distsq <= radiisq then
        local attackarc = attacker.attackarc
        if attackarc >= pi then
            return true
        end
        local dist = sqrt(distsq)
        local attackx, attacky = cos(attackangle), sin(attackangle)
        local dotDA = dot(fromattackerx, fromattackery, attackx, attacky)
        local bodyarc = asin(bodyradius/dist)
        return dotDA >= dist * cos(bodyarc + attackarc)
    end
end

function Character:collideWithCharacterAttack(attacker)
    if self.hurtstun > 0 or not self.canbeattacked then
        return
    end
    if self:checkAttackCollision(attacker) then
        if not self.hitreactiondisabled then
            local guardhitai = self.guardai or "guardHit"
            local hurtai = self.hurtai or "hurt"
            if self.guardangle then
                Script.start(self, guardhitai, attacker)
            else
                Script.start(self, hurtai, attacker)
                if attacker.hitstun <= 0 then
                    attacker.hitstun = attacker.attackstunself or 3
                end
            end
        end
        local hitai = attacker.attackhitai
        if hitai then
            Script.start(attacker, hitai, self)
        end
        return true
    end
end

function Character:heal(amount)
    self.health = min(self.health + amount, self.maxhealth)
end

function Character.getDirectionalAnimation_angle(basename, angle, numanimations)
    numanimations = numanimations or 1
    if numanimations < 2 then
        return basename
    end
    if angle ~= angle then
        return basename..0
    end
    local faceangle = angle + (pi / numanimations)
    local facedir = floor(faceangle * numanimations / pi / 2)
    facedir = ((facedir % numanimations) + numanimations) % numanimations
    return basename..facedir
end

function Character:setEmote(emotename)
    local emote = self.emote
    if emote then
        if emotename then
            emote.hidden = nil
            emote:changeAsepriteAnimation(emotename)
        else
            emote.hidden = true
        end
    end
end

function Character:drawShadow()
    local x, y = self.x, self.y
    love.graphics.setColor(0,0,0,.25)

    love.graphics.circle("fill", x, y, self.bodyradius)

    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius > 0 and attackangle then
        local attackarc = self.attackarc
        if attackarc > 0 then
            love.graphics.arc("fill", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
        else
            love.graphics.line(x, y, x + attackradius*cos(attackangle), y + attackradius*sin(attackangle))
        end
    end

    if Config.drawbodies then
        love.graphics.setColor(.5, .5, 1)
        love.graphics.circle("line", x, y, self.bodyradius)
        if attackradius > 0 and attackangle then
            local attackarc = self.attackarc
            love.graphics.setColor(1, .5, .5)
            if attackarc > 0 then
                love.graphics.arc("line", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
            else
                love.graphics.line(x, y, x + attackradius*cos(attackangle), y + attackradius*sin(attackangle))
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
end

function Character:disappear()
    self.disappeared = true
    self:removeSprite("sprite")
    self:removeSprite("emote")
end

return Character