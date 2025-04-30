local Database = require "Data.Database"

---@class InventoryItem
---@field itemsize integer

---@class Inventory
---@field [integer] string[]
---@field size integer
---@field capacity integer
local Inventory = class()

function Inventory:_init(capacity)
    self.capacity = capacity or 4
    self.size = 0
end

function Inventory:add(itemtype)
    local itemdata = Database.get(itemtype)
    if not itemdata then return false end

    local itemsize = itemdata.itemsize or 1
    local freespace = self.capacity - self.size
    if itemsize <= freespace then
        self[#self + 1] = itemtype
        self.size = self.size + itemsize
        return true
    end
end

function Inventory:peek(index)
    return 1 <= index and index <= #self
        and self[index]
end

function Inventory:take(index)
    local itemtype = Inventory.peek(self, index)
    if itemtype then
        for i = index, #self do
            self[i] = self[i+1]
        end
        local itemdata = Database.get(itemtype)
        assert(itemdata)
        self.size = self.size - itemdata.itemsize
        return itemtype
    end
end

function Inventory:last()
    return Inventory.peek(self, #self)
end

function Inventory:pop()
    return Inventory.take(self, #self)
end

return Inventory