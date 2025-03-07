local Tiled = require "Tiled"

---@class ComicPanel:LayerGroup
---@field isnewpage boolean
---@field sound string?

---@class Comic:TiledMap
local Comic = class(Tiled.Map)

function Comic:start()
    self.index = 0
    self:hideAll()
    self:advance()
end

function Comic:hideAll()
    for _, layer in ipairs(self.layers) do
        layer.visible = false
    end
end

function Comic:advance()
    self.index = self.index + 1
    if self.index <= #self.layers then
        local page = self.layers[self.index]
        ---@cast page ComicPanel

        if page.isnewpage then
            self:hideAll()
        end
        page.visible = true
    else
        self:hideAll()
    end
end

return Comic