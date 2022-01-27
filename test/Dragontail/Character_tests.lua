local cute = require("cute")

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

notion("Character keeping out of other's body", function()
    local a = Character.new({x = 0, y = 0, bodyradius = 3})
    local b = Character.new({x = 16, y = 0, bodyradius = 2})
    a:move(15, 0)
    a:separateColliding(b)
    check(a.x).is(11)
end)

notion("Character getting damaged by other's attack", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi, attackarc = math.pi/2, attackdamage = 1})
    a:takeHit(b)
    check(a.health).is(1)
end)

notion("Character not damaged during hitstun", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi, attackarc = math.pi/2, attackdamage = 1, attackstun = 1})
    a:takeHit(b)
    a:takeHit(b)
    check(a.health).is(1)
end)

notion("Character not damaged by attack in the wrong direction", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 4, attackangle = math.pi/2, attackarc = math.pi/2, attackdamage = 1})
    a:takeHit(b)
    check(a.health).is(2)
end)

notion("Character not damaged by out-of-range attack", function()
    local a = Character.new({x = 0, y = 0, health = 2, bodyradius = 2})
    local b = Character.new({x = 4, y = 0, attackradius = 2, attackangle = math.pi, attackarc = math.pi/2, attackdamage = 1})
    a:takeHit(b)
    check(a.health).is(2)
end)