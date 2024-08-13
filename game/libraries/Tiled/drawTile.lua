local love_graphics_draw = love.graphics.draw

---@param x number
---@param y number
---@param tile Tile
---@param flipx number
---@param flipy number
local function drawTile(x, y, tile, flipx, flipy)
    if tile then
        local hw, hh = tile.width / 2, tile.height / 2
        x, y = x + hw + tile.offsetx, y - hh + tile.offsety
        love_graphics_draw(tile.image, tile.quad, x, y, 0, flipx, flipy, hw, hh)
    end
end

return drawTile