local cute = require("cute")
local Body = require("Dragontail.Character.Component.Body")
local Attack = require("Dragontail.Character.Component.Attack")

local Character = require "Dragontail.Character"

notion("Character moving on XY plane", function()
    local character = Character.new({x = 0, y = 0})
    character:move(2, 3)

    local result = {
        x = character.x,
        y = character.y
    }
    local expected = {
        x = 2,
        y = 3
    }
    check(result).shallowMatches(expected)
end)

notion("Character rotating its attack with wraparound", function()
    local a = Character.new({attackangle = 3})
    a:rotateAttack(6)
    check(math.floor(a.attackangle)).is(2)
end)

notion("Character rotating its attack smoothly", function()
    local a = Character.new({attackangle = 3})
    Attack.rotateAttackTowards(a, 1, 1)
    Attack.rotateAttackTowards(a, 4, 1)
    Attack.rotateAttackTowards(a, 4, 1)
    check((a.attackangle)).is(4)
end)

notion("Character keeping out of other's body", function()
    local a = Character.new({x = 0, y = 0, bodyradius = 3})
    local b = Character.new({x = 16, y = 0, bodyradius = 2, bodysolid = true})
    a:move(15, 0)
    Body.collideWith(a, b)
    check(a.x).is(11)
end)

notion("Character getting damaged by other's attack", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2, bodysolid = true})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi, attackarc = math.pi/4, attackdamage = 1})
    a:collideWithCharacterAttack(b)
    check(a.health).is(1)
end)

notion("Character not damaged during hurtstun", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2, bodysolid = true})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi, attackarc = math.pi/4, attackdamage = 1, attackstun = 1})
    a:collideWithCharacterAttack(b)
    a:collideWithCharacterAttack(b)
    check(a.health).is(1)
end)

notion("Character not damaged by attack in the wrong direction", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi/2, attackarc = math.pi/4, attackdamage = 1})
    a:collideWithCharacterAttack(b)
    check(a.health).is(2)
end)

notion("Character not damaged by out-of-range attack", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 2, attackangle = math.pi, attackarc = math.pi/4, attackdamage = 1})
    a:collideWithCharacterAttack(b)
    check(a.health).is(2)
end)

notion("Character moving by acceleration", function()
    local a = Character.new()
    a:accelerate(1, 2)
    Body.updatePosition(a) -- pos = 1,2
    a:accelerate(1, 2) -- vel = 2,4
    Body.updatePosition(a) -- pos = 3,6
    check({x = a.x, y = a.y}).shallowMatches({x = 3, y = 6})
end)

notion("Character accelerating to target velocity", function()
    local a = Character.new()
    local targetvelx = 8
    local t = 8
    local e = 1/256
    local velxs = {}
    while true do
        local velx = velxs[#velxs] or 0
        local accelx = (targetvelx - velx) / t
        if accelx < e then
            velxs[#velxs+1] = targetvelx
            break
        end
        velx = velx + accelx
        velxs[#velxs+1] = velx
    end
    for i = 1, #velxs do
        a:accelerateTowardsVel(targetvelx, 0, t, e)
        Body.updatePosition(a)
        check(a.velx).is(velxs[i])
    end
end)