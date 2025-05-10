local Database = require "Data.Database"

---@class Combo:Mana
---@field comboindex integer
local Combo = {}

function Combo:reset()
    self.comboindex = 1
end

function Combo:parse(combostring)
    local comboattacks = {}
    for attacktype in string.gmatch(combostring, "%g+") do
        comboattacks[#comboattacks+1] = attacktype
    end
    return comboattacks
end

function Combo:advance(desiredcombo, fallbackcombo)
    local combo = desiredcombo
    local attacktype = combo[self.comboindex]
    local attackdata = Database.get(attacktype)
    local cost = attackdata and attackdata.attackmanacost
    if cost and cost > self.mana then
        combo = fallbackcombo
        attacktype = combo[self.comboindex]
        attackdata = Database.get(attacktype)
    end

    if not attackdata
    or attackdata.attackendscombo
    or self.comboindex >= #combo then
        self.comboindex = 1
    else
        self.comboindex = self.comboindex + 1
    end

    return attacktype
end

return Combo