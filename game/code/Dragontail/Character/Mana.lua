---@class Mana:StateMachine
---@field mana number
---@field manamax number
---@field manaunitsize number
local Mana = {}

function Mana:init()
    self.manaunitsize = self.manaunitsize or 60
    self.manamax = self.manamax or (self.manaunitsize * 3)
    self.mana = self.mana or self.manaunitsize
end

function Mana:give(mana)
    if not self.mana or not self.manamax then
        return
    end
    mana = self.mana + mana
    if mana > self.manamax then
        mana = self.manamax
    elseif mana < 0 then
        mana = 0
    end
    self.mana = mana
end

function Mana:canAffordAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    return attack and self.mana >= attack.attackmanacost
end

function Mana:consumeForAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    if attack then
        Mana.give(self, -attack.attackmanacost)
    end
end

return Mana