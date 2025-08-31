local Audio = require "System.Audio"

---@class Mana:StateMachine
---@field manastore number
---@field manastoremax number
---@field manacharge number
---@field manaunitsize number
local Mana = {}

function Mana:init()
    self.manaunitsize = self.manaunitsize or 60
    self.manastoremax = self.manastoremax or (self.manaunitsize * 3)
    self.manastore = self.manastore or 0
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
    local oldunits = math.floor(self.manacharge/self.manaunitsize)
    local newunits = math.floor(mana / self.manaunitsize)
    if newunits > oldunits then
        local chargesound = "chargesound"..newunits
        Audio.play(self[chargesound])
    end
    self.manacharge = mana
end

function Mana:releaseCharge()
    self.manacharge = 0
end

function Mana:hasChargeForAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    if attack then
        return not attack.manacost or self.manacharge >= attack.manacost
    end
end

function Mana:decayCharge(decay)
    local manaunits = math.floor(self.manacharge/self.manaunitsize)
    decay = math.max(0, math.min(decay, self.manacharge - manaunits*self.manaunitsize))
    Mana.charge(self, -decay)
end

function Mana:canAffordAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    return attack and not attack.manacost or self.manastore >= attack.manacost
end

function Mana:consumeForAttack(attack)
    if type(attack) == "string" then
        attack = self.attacktable[attack]
    end
    if attack and attack.manacost then
        Mana.store(self, -attack.manacost)
    end
end

return Mana