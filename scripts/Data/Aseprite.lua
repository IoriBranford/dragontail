--[[

Aseprite module

EXPORT SETTINGS

	Required:
		Split layers = ON
		JSON Data = ON
			Hash or Array
			Layers = ON if data format = Hash
			Tags = ON for animations
			Item filename = "{layer}#{frame1}"
 	Recommended:
		Sheet type = Packed
		Trim cels = ON
		Extrude = ON

DATA STRUCTURE

	ase
	{
		[array]		= list of aseprite's frames
		image		= the sprite sheet image
		width		= the sprite frame width
		height		= the sprite frame height

		layers		= the sprite layers
		{
			[array]	= ordered list of layers
			[hash]	= maps layer name to index
		}

		animations	= the available animations
		{
			[array]		= list of frame indices making up the animation
			from		= first animation frame, 1-based instead of 0-based
			to			= last animation frame, 1-based instead of 0-based
			direction	= "forward", "reverse", or "pingpong"
						  "reverse" and "pingpong" implemented by reversing or duplicating frame indices
		}
	}
]]

local LG = love.graphics
local lg_draw = love.graphics.draw
local pretty = require "pl.pretty"
local json   = require "json"

local Aseprite = {}
Aseprite.__index = Aseprite

function Aseprite:getAnimationUpdate(tag, tagframe, t, dt)
	t = t + dt
	local animation = self.animations[tag]
	if not animation then
		return tagframe, t
	end
	local duration = self[animation[tagframe]].duration
	while t >= duration do
		t = t - duration
		tagframe = (tagframe == #animation) and 1 or (tagframe + 1)
		duration = self[animation[tagframe]].duration
	end
	return tagframe, t
end

function Aseprite:getAnimationFrame(tag, tagframe)
	local animation = self.animations[tag]
	return animation and animation[tagframe]
end

function Aseprite:drawFrame(frame, x, y, r, sx, sy, ox, oy, kx, ky)
	x = x - self.offsetx
	y = y - self.offsety
	frame = self[frame]
	local image = self.image
	for i = 1, #self.layers do
		local cel = frame[i]
		if cel then
			lg_draw(image, cel.quad, x + cel.x, y + cel.y, r, sx, sy, ox, oy, kx, ky)
		end
	end
end

function Aseprite:drawCel(frame, cel, x, y, r, sx, sy, ox, oy, kx, ky)
	cel = self[frame][cel]
	if cel then
		lg_draw(self.image, cel.quad, x + cel.x, y + cel.y, r, sx, sy, ox, oy, kx, ky)
	end
end

function Aseprite:newSpriteBatch(tag)
	local nlayers = #self.layers
	local spritebatch = LG.newSpriteBatch(self.image, nlayers, "dynamic")
	for i = 1, nlayers do
		spritebatch:add(0,0,0,0,0)
	end

	if self.animations[tag] then
		self:startSpriteBatchAnimation(spritebatch, tag)
	else
		self:setSpriteBatchFrame(spritebatch, 1)
	end
	return spritebatch
end

function Aseprite:startSpriteBatchAnimation(spritebatch, tag)
	local animation = self.animations[tag]
	if animation then
		self:setSpriteBatchFrame(spritebatch, animation[1])
	end
end

function Aseprite:setSpriteBatchFrame(spritebatch, frame)
	local offsetx = self.offsetx
	local offsety = self.offsety
	frame = self[frame]
	for i = 1, #self.layers do
		local cel = frame[i]
		if cel then
			spritebatch:set(i, cel.quad, cel.x - offsetx, cel.y - offsety)
		else
			spritebatch:set(i, 0, 0, 0, 0, 0)
		end
	end
end

function Aseprite:animateSpriteBatch(spritebatch, tag, tagframe, timer, dt)
	local f, t = self:getAnimationUpdate(tag, tagframe, timer, dt)
	if tagframe ~= f then
		self:setSpriteBatchFrame(spritebatch, self.animations[tag][f])
	end
	return f, t
end

function Aseprite:setAnchor(anchorx, anchory)
	self.offsetx = anchorx*self.width
	self.offsety = anchory*self.height
end

local function load_cel(cel, filename, ase, layers, image)
	local layername, framei = filename:match("(.*)#(%d+)")
	local layeri = layers[layername]
	if not layeri then
		layers[#layers+1] = { name = layername }
		layeri = #layers
		layers[layername] = layeri
	end

	framei = tonumber(framei)
	local frame = ase[framei]
	if not frame then
		frame = { duration = cel.duration }
		ase[framei] = frame
	end

	local rect = cel.frame
	local pos = cel.spriteSourceSize
	frame[layeri] = {
		x = pos.x,
		y = pos.y,
		quad = LG.newQuad(rect.x, rect.y, rect.w, rect.h,
				image:getWidth(), image:getHeight())
	}
end

local function loadAseprite(jsonfile)
	local doc = json.decode(love.filesystem.read(jsonfile))
	local cels = doc.frames
	local meta = doc.meta
	local image = meta.image
    local directory = string.match(jsonfile, "^(.+/)") or ""
	image = love.graphics.newImage(directory..image)
	image:setFilter("nearest", "nearest")

	local layers = meta.layers
	if not cels[1] and not layers then
		error("Aseprite "..image.." was exported with hash frames and no layer list. There is no way to ensure the correct layer order.")
	end

	layers = layers or {}

	for i = 1, #layers do
		layers[layers[i].name] = i
	end

	local ase = {}
	local size = next(cels).sourceSize
	ase.width = size.w
	ase.height = size.h

	if cels[1] then
		for i = 1, #cels do
			local cel = cels[i]
			load_cel(cel, cel.filename, ase, layers, image)
		end
	else
		for k,v in pairs(cels) do
			load_cel(v, k, ase, layers, image)
		end
	end

	local animations = meta.frameTags
	for i = 1, #animations do
		local animation = animations[i]
		animations[animation.name] = animation
		animation.from = animation.from + 1
		animation.to = animation.to + 1
		local direction = animation.direction
		if direction == "reverse" then
			for f = animation.to, animation.from do
				animation[#animation + 1] = f
			end
		else
			for f = animation.from, animation.to do
				animation[#animation + 1] = f
			end
			if direction == "pingpong" then
				for f = animation.to-1, animation.from+1 do
					animation[#animation + 1] = f
				end
			end
		end
	end
	for i = #animations, 1, -1 do
		animations[i] = nil
	end

	ase.image = image
	ase.layers = layers
	ase.animations = animations

	setmetatable(ase, Aseprite)
	return ase
end

return {
	load = loadAseprite
}
