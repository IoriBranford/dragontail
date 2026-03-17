local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local StateMachine       = require "Dragontail.Character.Component.StateMachine"
local Color       = require "Tiled.Color"
local Character   = require "Dragontail.Character"
local Characters  = require "Dragontail.Stage.Characters"
local Body        = require "Dragontail.Character.Component.Body"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Face                 = require "Dragontail.Character.Component.Face"
local Mana = require "Dragontail.Character.Component.Mana"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"
local Shoot         = require "Dragontail.Character.Component.Shoot"
local Attacker      = require "Dragontail.Character.Component.Attacker"

local yield = coroutine.yield
local wait = coroutine.wait
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local max = math.max

local MaxProjectileItems = 16

---@class DropItem
---@field item Character?
---@field itempopouttime integer?
---@field itemvelx number?
---@field itemvely number?

---@class Item
---@field itemtype string?
---@field healhealth number?
---@field itemgetsound string?
---@field giveweapon string?

---@class Projectile
---@field bouncefactor number?

---@class WallHit
---@field wallbumpdamage number?
---@field wallbumpstun integer?
---@field wallslamdamage number?
---@field wallslamstun integer?
---@field bodyslamsound string?

---@class Defeat
---@field defeatai string?
---@field defeatsound string?
---@field defeatedanimation string?

---@class Common:Character,DropItem,Item,Projectile,WallHit,Defeat
---@field lifetime integer?
---@field opponents Fighter[]
local Common = class(Character)

function Common:idle()
    while true do yield() end
end

function Common:stayOnCameraOnceEntered()
    if not self.enteredcamera and self:isCylinderFullyOnCamera(self.camera) then
        self.enteredcamera = true
        self.bodyhitslayers = bit.bor(self.bodyhitslayers, CollisionMask.get("Camera"))
    end
end

function Common:decelerateXYto0()
    Body.forceTowardsVelXY(self, 0, 0, self.accel)
end

function Common:turnTowardsOpponent()
    while true do
        Face.turnTowardsObject(self, self.opponents[1], self.faceturnspeed, self.state.animation)
        yield()
    end
end

function Common:spark(time)
    local baseanim = self.asetag or self.tileid
    if baseanim and self.faceangle and (self.animationdirections or 1) > 1 then
        Face.faceAngle(self, self.faceangle, baseanim, self.frame1, self.loopframe)
    end
    time = time or self.lifetime or 30
    wait(time)
    self:disappear()
end

function Common:updateFadeOut()
    local r, g, b, a = Color.unpack(self.color)
    local lifetime = max(1, self.lifetime or 16)
    local deltaalpha = self.deltaalpha or (1/lifetime)
    self.deltaalpha = deltaalpha
    a = a - deltaalpha
    if a <= 0 then
        self:disappear()
    else
        self.color = Color.asARGBInt(r, g, b, a)
    end
end

local function updateBlinkOut(t, color)
    local r, g, b = Color.unpack(color)
    return Color.asARGBInt(r, g, b, cos(t))
end

function Common:blinkOut(t)
    t = t or 30
    for i = 1, t do
        self.color = updateBlinkOut(i, self.color)
        yield()
    end
    self:disappear()
end

function Common:shrinkOut(t)
    t = t or self.lifetime or 60
    local sx, sy = self.scalex or 1, self.scaley or 1
    self.scalex, self.scaley = sx, sy
    local shrinkspeedx = -sx/t
    local shrinkspeedy = -sy/t
    for i = 1, t do
        self.scalex = self.scalex + shrinkspeedx
        self.scaley = self.scaley + shrinkspeedy
        yield()
    end
    self:disappear()
end

function Common:dropDefeatItem()
    local item = self.item
    local popsout
    if item then
        if item.spawnsmanually then
            Characters.spawn(item)
        else
            popsout = true
        end
    elseif self.itemtype then
        item = Character(self.itemtype,
            self.x, self.y, self.z)
        Characters.spawn(item)
        popsout = true
    end
    if item and popsout then
        local popouttime = self.itempopouttime or 15
        local velx, vely = self.itemvelx or 0, self.itemvely or 0
        if popouttime > 0 then
            item.gravity = item.gravity or .125
            item.velx = velx
            item.vely = vely
            item.velz = item.gravity * popouttime / 2
        end
        item.opponents = self.opponents
        StateMachine.start(item, "itemWaitForPickup")
    end
end

function Common:containerBreak()
    Audio.play(self.defeatsound)
    self:changeAnimation("collapse", 1, 0)
    self:dropDefeatItem()
    yield()
    return "blinkOut", 30
end

function Common:respawn()
    local x, y, z = self.x, self.y, self.z
    local respawnpoint = self.respawnpoint
    if respawnpoint then
        x = respawnpoint.x or x
        y = respawnpoint.y or y
        z = respawnpoint.z or z
    end
    local typ = self.respawntype or self.type
    local new = Character(typ, x, y, z)
    new.respawnpoint = new.respawnpoint or respawnpoint
    Characters.spawn(new)
    return new
end

function Common:itemDrop(y0)
    self.gravity = math.max(self.gravity or .25, .125)
    local floorz
    repeat
        floorz = self.floorz
        yield()
    until floorz and self.z <= floorz
    return "itemWaitForPickup"
end

local function testItemPickupCollision(item, picker)
    if item ~= picker
        and item.z <= picker.z + picker.bodyheight
        and picker.z <= item.z + item.bodyheight
        and math.testcircles(item.x, item.y, item.bodyradius, picker.x, picker.y,
            picker.pickupradius or picker.bodyradius)
    then
        return true
    end
end

function Common:itemWaitForPickup()
    local opponent = self.opponents[1]
    local t = -1
    local FlashPeriod = 5
    local Period = 30
    while true do
        local finished
        t = (t + 1) % Period
        self:decelerateXYto0()
        if self.gravity == 0 then
            local _, _, _, penex
                = Characters.keepCylinderIn(self.x, self.y, self.z, self.bodyradius, self.bodyheight, self)
            if not penex then
                self.gravity = 0.25
            end
        end
        if self.healhealth then
            if opponent.health < opponent.maxhealth then
                if t == 0 then
                    self.color = Color.asARGBInt(.5, 1, .5, 1)
                    self.texturealpha = 0
                elseif t == FlashPeriod then
                    self.color = Color.White
                    self.texturealpha = 1
                end
                if testItemPickupCollision(self, opponent) then
                    Audio.play(self.itemgetsound)
                    opponent:heal(self.healhealth)
                    finished = true
                end
            else
                self.color = Color.White
                self.texturealpha = 1
            end
        elseif self.givemana then
            if opponent.manastore < opponent.manastoremax then
                if t == 0 then
                    self.color = Color.asARGBInt(1, .5, .5, 1)
                    self.texturealpha = 0
                elseif t == FlashPeriod then
                    self.color = Color.White
                    self.texturealpha = 1
                end
                if testItemPickupCollision(self, opponent) then
                    Audio.play(self.itemgetsound)
                    Mana.store(opponent, self.givemana)
                    finished = true
                end
            else
                self.color = Color.White
                self.texturealpha = 1
            end
        elseif self.giveweapon then
            if t == 0 then
                self.texturealpha = 0
            elseif t == FlashPeriod then
                self.texturealpha = 1
            end
            local weapontype = self.giveweapon
            if testItemPickupCollision(self, opponent) and opponent:tryToGiveWeapon(weapontype) then
                finished = true
            else
                for _, enemy in ipairs(Characters.getGroup("enemies")) do
                    if enemy.canpickupweapons then
                        if testItemPickupCollision(self, enemy) then
                            if enemy:tryToGiveWeapon(weapontype) then
                                finished = true
                                break
                            end
                        end
                    end
                end
            end
        end
        if finished then
            self:disappear()
            break
        end
        yield()
    end
end

function Common:storeMana(mana)
    if self.thrower and self.thrower.storeMana then
        self.thrower:storeMana(mana)
    end
end

function Common:projectileShatter(opponent)
    self:stopAttack() ; self:unassignSelfAsAttacker()
    self.velx = 0
    self.vely = 0
    self.velz = 0
    self:spark(self.state.statetime or 30)
end

function Common:projectileHit(opponent)
    if opponent then
        -- Audio.play(self.attack.hitsound)
    else
        Audio.play(self.bodyslamsound)
    end
    DirectionalAnimation.set(self, self.attack.selfanimationonhit, self.attackangle)
    self:stopAttack() ; self:unassignSelfAsAttacker()
    local hitbounce = self.attackhitbounce or 2
    local normx, normy = math.norm(-self.velx, -self.vely)
    self.velx, self.vely = normx*hitbounce, normy*hitbounce
    yield()
    return "blinkOut", 30
end

function Common:projectileEmbed(opponent, ooby, oobz)
    self:stopAttack() ; self:unassignSelfAsAttacker()
    local oobx = type(opponent) == "number" and opponent
    opponent = type(opponent) == "table" and opponent or nil
    self.velx, self.vely, self.velz = 0, 0, 0
    self.gravity = 0
    if opponent then
        for t = 1, 30 do
            if opponent then
                self.velx, self.vely, self.velz = opponent.velx, opponent.vely, opponent.velz
            end
            self.color = updateBlinkOut(t, self.color)
            yield()
        end
        self:disappear()
    else
        Audio.play(self.bodyslamsound)
        local items = Characters.getGroup("items")
        local numopponentshit = self.numopponentshit or 0
        if self.itemtype and #items < MaxProjectileItems and numopponentshit <= 0 then

            local item = Character(self.itemtype,
                self.x, self.y, self.z)
            item.gravity = 0
            Characters.spawn(item)
            item:setAseAnimation(self.aseanimation, self.animationframe)
            self:disappear()
        else
            return "blinkOut", 30
        end
    end
end

function Common:becomeItem()
    if Database.get(self.itemtype) then
        local item = Character(self.itemtype,
            self.x, self.y, self.z)
        Characters.spawn(item)
    end
    self:disappear()
end

local function findHomingTarget(self, objects)
    local best
    local bestdsq = math.huge
    local x, y = self.x, self.y
    local z = self.z + self.bodyheight/2
    for _, object in ipairs(objects) do
        if object.health > 0 and object.canbeattacked then
            local dsq = math.distsq3(x, y, z, object.x, object.y, object.z + object.bodyheight/2)
            if dsq < bestdsq then
                best = object
                bestdsq = dsq
            end
        end
    end
    return best
end

function Common:projectileHoming()
    local oobx, ooby, oobz
    local lifetime = self.lifetime or 60
    local opponents = self.opponents
    repeat
        local _
        _, _, _, oobx, ooby, oobz = Body.predictCollisionVelocity(self)
        if oobx or ooby then
            self.velx, self.vely = math.reflect(self.velx, self.vely, -oobx or 0, -ooby or 0)
        end
        if oobz then
            self.velz = -self.velz
        end
        local vx, vy, vz = self.velx, self.vely, self.velz
        local nearest = findHomingTarget(self, opponents)
        if nearest then
            vx = nearest.x - self.x
            vy = nearest.y - self.y
            vz = (nearest.z + nearest.bodyheight/2)
                - (self.z + self.bodyheight/2)
            if nearest.z >= self.z + self.bodyheight then
                vz = vz + nearest.bodyheight/2
            end
        end
        if vx == 0 and vy == 0 and vz == 0 then
            vx, vy = cos(self.faceangle), sin(self.faceangle)
        else
            vx, vy, vz = math.norm(vx, vy, vz)
        end
        Body.forceTowardsVel3(self, vx * self.speed, vy * self.speed, vz * self.speed, self.accel or 2)
        if self.velx ~= 0 or self.vely ~= 0 then
            Face.faceVector(self, self.velx, self.vely, self.state.animation)
            self:startAttack(self.faceangle)
        end
        yield()
        lifetime = lifetime - 1
    until lifetime <= 0
    local selfstateonhit = self.attack.selfstateonhitboundary or self.attack.selfstateonhit
    if selfstateonhit then
        return selfstateonhit, oobx, ooby, oobz
    end
    self:disappear()
end

function Common:projectileBounce(opponent, ooby, oobz)
    self:stopAttack() ; self:unassignSelfAsAttacker()
    local oobx = type(opponent) == "number" and opponent
    opponent = type(opponent) == "table" and opponent or nil
    if opponent then
    else
        Audio.play(self.bodyslamsound)
    end
    self.gravity = max(self.gravity or 0, .25)
    local bouncefactor = self.bouncefactor or .5
    if opponent then
        if opponent.z <= self.z and self.z <= opponent.z + opponent.bodyheight then
            self.velx, self.vely = -self.velx*bouncefactor, -self.vely*bouncefactor
        else
            self.velz = -self.velz*bouncefactor
        end
    else
        if oobx or ooby then
            self.velx, self.vely = math.reflect(self.velx*bouncefactor, self.vely*bouncefactor, -oobx or 0, -ooby or 0)
        end
        if oobz then
            self.velz = -self.velz*bouncefactor
        end
    end
    oobz = nil
    repeat
        yield()
        oobx, ooby, oobz = self.penex, self.peney, self.penez
    until oobz and oobz <= 0
    self.velx, self.vely, self.velz = 0, 0, 0
    local items = Characters.getGroup("items")
    local numopponentshit = self.numopponentshit or 0
    if not opponent and self.itemtype and #items < MaxProjectileItems and numopponentshit <= 0 then
        self:becomeItem()
    else
        return "blinkOut", 30
    end
end

function Common:projectileFly(shooter)
    local angle = self.attackangle
    if not angle then
        local velx = self.velx
        local vely = self.vely
        if velx ~= 0 or vely ~= 0 then
            angle = atan2(vely, velx)
        else
            angle = 0
        end
        self:startAttack(angle)
    end
    local oobx, ooby, oobz
    local lifetime = self.lifetime
    repeat
        yield()
        oobx, ooby, oobz = self.penex, self.peney, self.penez
        if lifetime then
            lifetime = lifetime - 1
        end
    until oobx or ooby or oobz or lifetime and lifetime <= 0
    local selfstateonhit = self.attack.selfstateonhitboundary or self.attack.selfstateonhit
    if selfstateonhit then
        return selfstateonhit, oobx, ooby, oobz
    end
    self:disappear()
end

---@param hit AttackHit
---@return string
---@return any
function Common:projectileDeflected(hit)
    local deflector = hit.attacker
    local attack = hit.attack
    local thrower = self.thrower

    Attacker.stopAttack(self)
    self:makeImpactSpark(deflector, attack.hitspark)

    if not thrower or not attack.deflectsprojectileatopponent then
        return "projectileBounce", deflector
    end
    self.hurtstun = attack.selfstun or 3

    local targetx, targety, targetz = Shoot.getTargetObjectPosition(self, thrower)
    self.velx, self.vely, self.velz =
        Shoot.GetProjectileDeflectVelocityTowardsTarget(self, targetx, targety, targetz)

    self.thrower = deflector
    -- DirectionalAnimation.set(self, self.swinganimation, angle, 1, self.swinganimationloopframe or 1)
    yield()
    return self.initialai, deflector
end

function Common:guardHit(hit)
    local attacker, attack = hit.attacker, hit.attack
    Audio.play(self.guardhitsound)
    self:makeImpactSpark(attacker, attack.guardhitspark)
    self.hurtstun = attack.selfstunonguard or 6
    yield()
    return self.recoverai or self.initialai
end

function Common:pulseRed()
    local t = 0
    local r, g, b, a = 1, 1, 1, 1
    while true do
        g = (1 + math.cos(t)) / 2
        b = r
        self.color = Color.asARGBInt(r, g, b, a)
        yield()
        t = t + math.pi/30
    end
end

---@param hit AttackHit
function Common:fruitTreeHurt(hit)
    local attack = hit.attack
    local hitsound = attack.hitsound
    Audio.play(hitsound)

    local attacker = hit.attacker
    local attackangle = hit.angle
    local launchspeed = attack.pushbackspeed
    if launchspeed then
        if launchspeed == "attackerspeed" then
            launchspeed = math.len(attacker.velx, attacker.vely)
        end
        attacker.velx = launchspeed * -math.cos(attackangle)
        attacker.vely = launchspeed * -math.sin(attackangle)
    end

    local numfruitsdropped = self.numfruitsdropped or 0
    local numfruitstodrop = self.numfruitstodroponhit or 16
    for i = numfruitsdropped + 1, numfruitsdropped + numfruitstodrop do
        local fruit = self["fruit"..i] ---@type Character|false|nil
        if fruit == nil then
            break
        end
        if fruit ~= false then
            StateMachine.start(fruit, "itemWaitForPickup")
            fruit.animationspeed = 0
            self["fruit"..i] = false
            numfruitsdropped = numfruitsdropped + 1
        end
    end
    self.numfruitsdropped = numfruitsdropped

    self.hurtstun = attack.opponentstun
    local leaves = self.leaves
    if leaves then
        leaves.hurtstun = self.hurtstun
    end

    yield()
    return self.recoverai
end

function Common:checkFruitPicked()
    local fruit = self.item
    if fruit then
        if fruit:hasDisappeared() then
            self.itemx = fruit.x
            self.itemy = fruit.y
            self.itemz = fruit.z
            self.item = nil
            return self.nextstate or "plantEmpty"
        end
    elseif Database.get(self.itemtype) then
        local x = self.itemx or self.x
        local y = self.itemy or (self.y + 1)
        local z = self.itemz or (self.z + 1)
        self.item = Characters.spawn(
            Character(self.itemtype, x, y, z))
    end
end

function Common:checkFruitNeedsRegrow()
    local fruittype = Database.get(self.itemtype)
    if fruittype then
        if fruittype.givemana then
            for _, opponent in ipairs(self.opponents) do
                if Mana.getStoredUnits(opponent) <= 0 then
                    return self.nextstate or "plantRegrowFruit"
                end
            end
        end
    end
end

function Common:getAttackFlash(t)
    return (1 + math.cos(t or 0)) / 2
end

function Common:getAttackFlashColor(t, canbeattacked)
    local flash = (1+cos(t))/2
    if canbeattacked then
        return Color.asARGBInt(1, flash, flash, 1)
    end
    return Color.asARGBInt(1, .5, .5, flash)
end

function Common:resetFlash()
    self.color = Color.White
    self.texturealpha = 1
end

local FlashColors = {
    SuggestGrab = Color.Green,
    SuggestAttack = Color.Red,
    SuggestAvoid = Color.Blue,
}

function Common:updateFlash(t)
    local flash = self:getAttackFlash(t)
    local color = Color.White

    -- if self.canbeattacked and not Guard.isGuarding(self) then
    --     if self.canbegrabbed then
    --         color = Color.White
    --     else
    --         color = FlashColors.SuggestAttack
    --     end
    -- else
    --     if self.canbegrabbed then
    --         color = FlashColors.SuggestGrab
    --     else
    --         color = FlashColors.SuggestAvoid
    --     end
    -- end
    self.color = color
    self.texturealpha = flash
end

return Common