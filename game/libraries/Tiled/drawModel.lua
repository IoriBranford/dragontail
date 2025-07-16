---@param self Layer|Object3D
---@param fixedfrac number
local function drawModel(self, fixedfrac)
    local model = self.model
    if not model then return end

    local x, y, z = self.x, self.y, self.z
    x = x + (self.velx or 0)*fixedfrac
    y = y + (self.vely or 0)*fixedfrac
    z = z + (self.velz or 0)*fixedfrac
    model:setTranslation(x, -y, z)
    local rotaxisx = self.rotaxisx
    local rotaxisy = self.rotaxisy
    local rotaxisz = self.rotaxisz
    if not (rotaxisx and rotaxisy and rotaxisz) then
        rotaxisx, rotaxisy, rotaxisz = 0, 0, -1
    end
    model:setAxisAngleRotation(rotaxisx, rotaxisy, rotaxisz, self.rotation or 0)
    model:setScale(self.scalex or 1, self.scaley or 1, self.scalez or 1)
    model:draw()
end

return drawModel