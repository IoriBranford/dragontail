---@class Mana:StateMachine
---@field manastore number
---@field manastoremax number
---@field manacharge number
---@field manaunitsize number
local Mana = {}

function Mana:init()
    self.manaunitsize = self.manaunitsize or 60
    self.manastoremax = self.manastoremax or (self.manaunitsize * 3)
    self.manastore = self.manastore or self.manaunitsize
    self.manacharge = self.manacharge or 0
end

function Mana:store(mana)
    if not self.manastore or not self.manastoremax then
        return
    end
    mana = self.manastore + mana
    if mana > self.manastoremax then
        mana = self.manastoremax
    elseif mana < 0 then
        mana = 0
    end
    self.manastore = mana
end

function Mana:charge(mana)
    mana = self.manacharge + mana
    if mana > self.manastore then
        mana = self.manastore
    elseif mana < 0 then
        mana = 0
    end
    self.manacharge = mana
end

function Mana:releaseCharge()
    Mana.store(self, -self.manacharge)
    self.manacharge = 0
end

function Mana:canAffordAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    return attack and self.manastore >= attack.attackmanacost
end

function Mana:consumeForAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    if attack then
        Mana.store(self, -attack.attackmanacost)
    end
end

return Mana