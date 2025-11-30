local Movement = require "Component.Movement"
local Audio    = require "System.Audio"
local Fighter  = require "Dragontail.Character.Fighter"
local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Color      = require "Tiled.Color"
local Dodge      = require "Dragontail.Character.Component.Dodge"
local Slide      = require "Dragontail.Character.Component.Slide"
local Face       = require "Dragontail.Character.Component.Face"
local Shoot      = require "Dragontail.Character.Component.Shoot"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Body                 = require "Dragontail.Character.Component.Body"
local Character            = require "Dragontail.Character"
local CollisionMask        = require "Dragontail.Character.Component.Body.CollisionMask"
local Guard                = require "Dragontail.Character.Component.Guard"
local AttackTarget         = require "Dragontail.Character.Component.AttackTarget"
local Catcher              = require "Dragontail.Character.Component.Catcher"

---@class Ambush
---@field ambushsightarc number?

---@class Enemy:Fighter,Ambush
---@field opponents Player[]
---@field defaultattack string?
local Enemy = class(Fighter)

local pi = math.pi
local huge = math.huge
local max = math.max
local cos = math.cos
local sin = math.sin
local norm = math.norm
local atan2 = math.atan2
local distsq = math.distsq
local floor = math.floor
local mid = math.mid

local yield = coroutine.yield

local lm_random = love.math.random

function Enemy:getAttackFlash(t)
    return (1 + math.cos(t or 0)) / 2
end

function Enemy:getAttackFlashColor(t, canbeattacked)
    local flash = (1+cos(t))/2
    if canbeattacked then
        return Color.asARGBInt(1, flash, flash, 1)
    end
    return Color.asARGBInt(1, .5, .5, flash)
end

function Enemy:resetFlash()
    self.color = Color.White
    self.texturealpha = 1
end

local FlashColors = {
    SuggestGrab = Color.Green,
    SuggestAttack = Color.Red,
    SuggestAvoid = Color.Blue,
}

function Enemy:updateFlash(t)
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

function Enemy:getTargetingScore(oppox, oppoy, oppofacex, oppofacey)
    if not self.canbeattacked then
        return
    end
    if Guard.isGuarding(self) then
        return
    end
    local tooppox, tooppoy = self.x - oppox, self.y - self.z - oppoy
    if math.dot(oppofacex, oppofacey, tooppox, tooppoy) < 0 then
        return
    end
    return math.abs(math.det(oppofacex, oppofacey, tooppox, tooppoy))
end

function Enemy:duringStand()
    local opponent = self.opponents[1]
    Face.facePosition(self, opponent.x, opponent.y, "Stand")
    self:decelerateXYto0()
end

function Enemy:decideNextAttack()
    local opponent = self.opponents[1]
    local toopposq = distsq(self.x, self.y, opponent.x, opponent.y)
    local attackchoices = self.attackchoices
    if type(attackchoices) == "string" then
        local choices = {}
        for attack in attackchoices:gmatch("%S+") do
            choices[#choices+1] = attack
        end
        attackchoices = choices
        self.attackchoices = choices
    end
    local attacktype = self.defaultattack
    if attackchoices and #attackchoices > 0 then
        for i, attackchoice in ipairs(attackchoices) do
            local attackstate = self.statetable[attackchoice]
            if attackstate then
                local attackrange = (attackstate.maxtargetdist or 1) + opponent.bodyradius
                if attackrange*attackrange >= toopposq then
                    attacktype = attackchoice
                    break
                end
            end
        end
        if not attacktype then
            attacktype = attackchoices[lm_random(#attackchoices)]
        end
    end
    return attacktype
end

function Enemy:debugPrint_couldAttackOpponent(target, actionstate)
    print("opponent", target)
    if target then
        print(".attacker", target.attacker)
        print(".canbeattacked", target.canbeattacked)
    end
    print("isCylinderFullyOnCamera", self:isCylinderFullyOnCamera(self.camera))

    local state = self.statetable[actionstate]
    print("statedata", state)
    if state then
        local toopposq = distsq(self.x, self.y, target.x, target.y)
        local attackrange = (state.maxtargetdist or 1) + target.bodyradius
        print("dist", math.sqrt(toopposq))
        print("attackrange", attackrange, '=', (state.maxtargetdist or 1), '+', target.bodyradius)
        print("closeEnough", toopposq <= attackrange*attackrange)
    end
end

function Enemy:couldAttackOpponent(target, actionstate)
    if not target
    or target.attacker
    or not target.canbeattacked
    or not self:isCylinderFullyOnCamera(self.camera)
    then
        return false
    end

    local state = self.statetable[actionstate]
    if not state then
        return false
    end

    local toopposq = distsq(self.x, self.y, target.x, target.y)
    local attackrange = (state.maxtargetdist or 1) + target.bodyradius
    return toopposq <= attackrange*attackrange
end

function Enemy:afterStand()
    local opponent = self.opponents[1]
    if opponent.health <= 0 then
        return "stand"
    end

    local nextattacktype = self:decideNextAttack()
    if self:couldAttackOpponent(opponent, nextattacktype) then
        opponent.attacker = self
        Face.facePosition(self, opponent.x, opponent.y)
        return nextattacktype
    end
    return "approach", opponent, nil, nextattacktype
end

function Enemy:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    Guard.stopGuarding(self)
    for _ = 1, duration do
        local state, a, b, c, d, e, f = self:duringStand()
        if state then
            return state, a, b, c, d, e, f
        end
        yield()
    end
    local state, a, b, c, d, e, f = self:afterStand()
    if state then
        return state, a, b, c, d, e, f
    end
    return "stand"
end

---@param target Character
---@param nextstate string
---@return AttackerSlot? slot
---@return number? destx
---@return number? desty
function Enemy:findApproachSlot(target, nextstate)
    if not target.attackerslots then return end
    local bodyradius = self.bodyradius
    local state = self.statetable[nextstate]
    local attackrange = (state and state.maxtargetdist or 1) + target.bodyradius
    local attackerslot, destx, desty
    local attack = self.attacktable and self.attacktable[state.attack]
    if not attack or not attack.projectiletype then
        attackerslot, destx, desty = AttackTarget.findRandomSlot(target, attackrange + bodyradius, "melee", self.x, self.y)
    end
    if not attackerslot then
        attackerslot, destx, desty = AttackTarget.findRandomSlot(target, attackrange + bodyradius, "missile", self.x, self.y)
    end
    return attackerslot, destx, desty
end

---@param attackerslot AttackerSlot
---@param actionstate string
---@return number? destx
---@return number? desty
function Enemy:getAttackerSlotPosition(attackerslot, actionstate)
    local bodyradius = self.bodyradius
    local state = self.statetable[actionstate]
    local attackrange = (state and state.maxtargetdist or 1)
        + AttackTarget.estimateSafeDistanceOnSlot(attackerslot.target, attackerslot)
    if not attackerslot:hasSpace(attackrange) then
        return
    end

    local attack = self.attacktable and self.attacktable[state.attack]
    local destx, desty
    if attack and attack.projectiletype then
        destx, desty = attackerslot:getFarPosition(bodyradius)
    else
        destx, desty = attackerslot:getPosition(attackrange)
    end
    return destx, desty
end

function Enemy:navigateAroundSolid(destx, desty)
    local x, y = self.x, self.y
    local z = self.z + self.bodyheight/2
    local bodyradius = self.bodyradius
    local raycast = Raycast(x, y, z, destx - x, desty - y, 0, 1, bodyradius/2)
    raycast.hitslayers = CollisionMask.merge("Object", "Wall", "Camera")
    if Characters.castRay3(raycast, self) then
        local todestx, todesty = destx - x, desty - y
        local frontendx, frontendy = raycast.hitwallx, raycast.hitwally
        local backendx, backendy = raycast.hitwallx2, raycast.hitwally2
        local wallvecx, wallvecy = frontendx - backendx, frontendy - backendy
        if math.dot(wallvecx, wallvecy, todestx, todesty) < 0 then
            frontendx, backendx = backendx, frontendx
            frontendy, backendy = backendy, frontendy
            wallvecx, wallvecy = -wallvecx, -wallvecy
        end
        local projx, projy = math.projpointsegment(x, y, backendx, backendy, frontendx, frontendy)
        destx, desty = x + frontendx - projx, y + frontendy - projy
    end
    return destx, desty
end

function Enemy:duringApproach(target)
end

function Enemy:leave(exitx, exity)
    if self.enteredcamera then
        self.bodyhitslayers = bit.band(self.bodyhitslayers,
            bit.bnot(CollisionMask.get("Camera")))
    end

    self.recoverai = "leave"
    exitx = exitx or self.exitpoint
    if exitx then
        self:walkTo(exitx, exity)
        if self.exitpoint then
            self.exitpoint:disappear()
        end
    end
    self:disappear()
end

function Enemy:walkToEntryPoint()
    if self.entrypoint then
        self:walkTo(self.entrypoint)
    end
end

function Enemy:attackIfAmmoElseLeave()
    local attacktype = self.defaultattack
    local attackstate = self.statetable and self.statetable[attacktype]
    local ammo = self.ammo or 0
    local opponent = self.opponents[1]
    if attackstate and ammo > 0 and opponent.health > 0 then
        local projectileheight = self.projectilelaunchheight or (self.bodyheight/2)
        local raycast = Raycast(self.x, self.y, self.z + projectileheight, 1, 0, 0, 1)
        raycast.hitslayers = CollisionMask.merge("Wall", "Camera", "Player", "Enemy")
        local hitcharacter
        repeat
            yield()
            raycast.x, raycast.y = self.x, self.y
            raycast.z = self.z + projectileheight
            raycast.dx = opponent.x - self.x
            raycast.dy = opponent.y - self.y
            raycast.dz = opponent.z - self.z
            Face.faceVector(self, raycast.dx, raycast.dy, "Stand")
            hitcharacter = Characters.castRay3(raycast, self)
        until self:isOnCamera(self.camera) and hitcharacter
            and CollisionMask.test(hitcharacter.bodyinlayers, "Player") ~= 0
        self.ammo = self.ammo - 1
        return attacktype
    end

    if self.exitpoint then
        return "leave", self.exitpoint
    end

    return "stand"
end

function Enemy:duringPrepareAttack(target)
    Face.turnTowardsObject(self, target, self.faceturnspeed or 0,
        self.state.animation, self.animationframe, self.state.loopframe)
    self:decelerateXYto0()
end

function Enemy:interruptWithDodge(target)
    if target then
        local dodgeangle = Dodge.findDodgeAngle(self)
        if dodgeangle then
            if target.attacker == self then
                target.attacker = nil
            end
            return "dodgeIncoming", dodgeangle
        end
    end
end

function Enemy:duringAttackSwing(target)
end

function Enemy:enterAndDropDown()
    if self.entrypoint then
        if self:walkTo(self.entrypoint) then
            self.entrypoint = nil
        end
    end
    self.gravity = max(self.gravity or 0.25, 0.25)
    repeat
        yield()
    until self.z == self.floorz
    Audio.play(self.jumplandsound)
    self:changeAnimation("FallRiseFromKnees", 1, 0)
    local dust = Character("spark-land-on-feet-dust",
        self.x, self.y + 1, self.z)
    Characters.spawn(dust)
    coroutine.wait(9)
    return "stand", 3
end

function Enemy:watchForOpponent()
    local opponents = self.opponents
    local sighted
    local cossightarc = cos(self.ambushsightarc or (pi/6))
    for t = 1, huge do
        self:updateFlash(t)
        yield()
        for _, opponent in ipairs(opponents) do
            local tooppox, tooppoy = opponent.x - self.x, opponent.y - self.y
            if tooppox ~= 0 or tooppoy ~= 0 then
                tooppox, tooppoy = norm(tooppox, tooppoy)
            end
            local fDotD = math.dot(tooppox, tooppoy, math.cos(self.faceangle), math.sin(self.faceangle))
            if fDotD >= cossightarc then
                sighted = opponent
                break
            end
        end
        if sighted then
            break
        end
    end
    self:resetFlash()
end

function Enemy:beforeGuard()
    self.velx, self.vely = 0, 0
end

function Enemy:duringGuard(t)
    local opponent = self.opponents[1]
    local faceangle = Face.turnTowardsObject(self, opponent, self.faceturnspeed,
        self.state.animation, self.animationframe, self.state.loopframe)
    local guardangle = DirectionalAnimation.SnapAngle(faceangle, self.animationdirections or 4)
    Guard.startGuarding(self, guardangle)
end

function Enemy:afterGuard()
    Guard.stopGuarding(self)
end

function Enemy:guard()
    local nextstate, a, b, c, d, e, f

    nextstate, a, b, c, d, e, f = self:beforeGuard()
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end

    while not self.statetime or self.statetime > 0 do
        nextstate, a, b, c, d, e, f = self:duringGuard(
            self.statetime or math.floor(love.timer.getTime()*60))
        if nextstate then
            return nextstate, a, b, c, d, e, f
        end
        yield()
    end

    nextstate, a, b, c, d, e, f = self:afterGuard()
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
end

function Enemy:beforeGuardHit(attacker)
    Guard.pushBackAttacker(self, attacker)
end

function Enemy:duringGuardHit(attacker, t)
end

---@deprecated
---@param hit AttackHit
---@return string? nextstate
---@return any ...
function Enemy:guardHit(hit)
    local attacker, attack = hit.attacker, hit.attack
    self:makeImpactSpark(attacker, attack.guardhitspark)
    self.hurtstun = attack.opponentguardstun
        or attack.opponentstun or 6

    local nextstate, a, b, c, d, e, f
    nextstate, a, b, c, d, e, f = self:beforeGuardHit(attacker)
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
    local time = max(self.state.statetime or 60, 60)
    for t = 1, time do
        nextstate, a, b, c, d, e, f = self:duringGuardHit(attacker, t)
        if nextstate then
            return nextstate, a, b, c, d, e, f
        end
        yield()
    end

    -- self.numguardedhits = (self.numguardedhits or 0) + 1
    -- local guardcounterattack = self.guardcounterattack
    -- local guardhitstocounterattack = self.guardhitstocounterattack or 3
    -- if guardcounterattack then
    --     -- print(guardcounterattack, guardhitstocounterattack, self.numguardedhits, self.attackwindupinvuln)
    --     if self.numguardedhits >= guardhitstocounterattack then
    --         self.numguardedhits = 0
    --         Guard.stopGuarding(self)
    --         return guardcounterattack
    --     end
    -- end
    -- return "guard"
        -- local afterguardattacktype = self.afterguardattacktype
        -- if afterguardattacktype then
        --     return afterguardattacktype
        -- end
        -- return afterguardhitai or "stand"
    -- end
    -- return self:hurt(attacker)
    return "stand"
end

function Enemy:tryToGiveWeapon(weapontype)
    if not self.weaponinhand then
        self.weaponinhand = weapontype
        return true
    end
end

function Enemy:readyToCatchProjectile()
    Face.turnTowardsObject(self, self.opponents[1], self.faceturnspeed,
        self.state.animation, self.animationframe, self.state.loopframe)
    local dirx, diry = cos(self.faceangle), sin(self.faceangle)
    local projectiles = Characters.getGroup("projectiles")
    local caught = Catcher.findCharacterToCatch(self, projectiles, dirx, diry)
    if caught then
        caught:stopAttack()
        return "catchProjectile", caught
    end
end

function Enemy:beforeGetUp()
end

function Enemy:duringGetUp()
end

function Enemy:getup()
    self:shakeOffColor()
    local nextstate, a, b, c, d, e, f = self:beforeGetUp()
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
    while true do
        yield()
        nextstate, a, b, c, d, e, f = self:duringGetUp()
        if nextstate then
            return nextstate, a, b, c, d, e, f
        end
    end
end

function Enemy:indicateDefeated()
    if self.health <= 0 then
        Audio.play(self.finalfallsound)
        self.finalfallsound = false
        local color = Color.asARGBInt(Color.unpack(self.color))
        if color == Color.White then
            self.color = Color.Grey
        end
    end
end

return Enemy