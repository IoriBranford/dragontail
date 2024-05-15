local class = require "Aseprite.class"
local json   = require "Aseprite.json"
local AseFrame = require "Aseprite.Frame"
local Animation= require "Aseprite.Animation"

---@class AseLayer
---@field name string
---@field opacity number
---@field blendMode string

---@class Aseprite:AseTag
---@field width number
---@field height number
---@field image love.Image
---@field imagefile string
---@field layers {[string|integer]: integer|AseLayer}
---@field animations {[string]: AseTag}
---@field [integer] AseFrame
local Aseprite = class(Animation)
Aseprite.Frame = AseFrame
Aseprite.Animation = require "Aseprite.Animation"

local AnimationTimeUnits = {
    milliseconds = 1,
    seconds = 1 / 1000,
    fixedupdates = 60 / 1000
}

local function loadCel(self, cel, filename, layers, image)
    local layername, framei = filename:match("(.*)#(%d+)")
	local layeri = layers[layername]
	if not layeri then
		layers[#layers+1] = { name = layername }
		layeri = #layers
		layers[layername] = layeri
	end

	framei = tonumber(framei)
	local frame = self[framei]
	if not frame then
		frame = AseFrame(image, cel.duration)
		self[framei] = frame
	end
    frame:putCel(layeri, cel)
end

---@return Aseprite ase
function Aseprite.load(jsonfile)
	local jsondata, err = love.filesystem.read(jsonfile)
	assert(jsondata, err)
	local doc = json.decode(jsondata)
	local cels = doc.frames
	local meta = doc.meta
	local imagefile = meta.image
    local directory = string.match(jsonfile, "^(.+/)") or ""
	local image = love.graphics.newImage(directory..imagefile)
	image:setFilter("nearest", "nearest")

	local layers = meta.layers
	if not cels[1] and not layers then
		error("Aseprite "..imagefile.." was exported with hash frames and no layer list. There is no way to ensure the correct layer order.")
	end

	layers = layers or {}

	for i = 1, #layers do
		layers[layers[i].name] = i
	end

	local animations = meta.frameTags
	local _, cel1 = next(cels)
	local size = cel1.sourceSize
	local ase = Aseprite.cast({
        image = image,
        imagefile = imagefile,
        width = size.w,
        height = size.h,
        layers = layers,
        animations = animations
    })

	if cels[1] then
		for i = 1, #cels do
			local cel = cels[i]
			loadCel(ase, cel, cel.filename, layers, image)
		end
	else
		for k,v in pairs(cels) do
			loadCel(ase, v, k, layers, image)
		end
	end

	local animationtimescale = AnimationTimeUnits[Aseprite.animationtimeunit] or 1
	for i = 1, #ase do
		local frame = ase[i]
		frame.duration = frame.duration * animationtimescale
	end

	for i = 1, #animations do
		local animation = Animation.cast(animations[i])
		animations[animation.name] = animation
		animation:load(ase)
	end
	for i = #animations, 1, -1 do
		animations[i] = nil
	end

	return ase
end

return Aseprite