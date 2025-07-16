--[[
EXPORT SETTINGS

	Required:
		JSON Data = ON
			Hash or Array
			Layers = ON if data format = Hash
			Tags = ON for animations
			Item filename = "{layer}#{frame1}"
 	Recommended:
		Split layers = ON
		Sheet type = Packed
		Trim cels = ON
		Extrude = ON
]]

local class = require "Aseprite.class"
local json   = require "Aseprite.json"
local AseFrame = require "Aseprite.Frame"
local Animation= require "Aseprite.Animation"
local pathlite = require "Aseprite.pathlite"
local hasg3d, g3d = pcall(require, "g3d") ---@type boolean,g3d

---@class AseLayer
---@field name string
---@field opacity number
---@field blendMode string

---@class Aseprite:AseTag
---@field width number
---@field height number
---@field image love.Texture
---@field imagedata love.ImageData?
---@field imagefile string
---@field layers {[string|integer]: integer|AseLayer}
---@field animations {[string]: AseTag} '*' means the aseprite itself, i.e. all frames
---@field [integer] AseFrame|false
local Aseprite = class(Animation)
Aseprite.Frame = AseFrame
Aseprite.Animation = require "Aseprite.Animation"
Aseprite.loadImage = love.graphics.newImage

local AnimationTimeUnits = {
    milliseconds = 1,
    seconds = 1 / 1000,
    fixedupdates = 60 / 1000
}

---@param self Aseprite
---@param cel AseCel
local function loadCel(self, cel, filename, layers, image)
    local layername, framei = filename:match("(.*)#(%d+)")
	local layeri = 1
	if #layers > 1 then
		layeri = layers[layername]
		if not layeri then
			layers[#layers+1] = { name = layername }
			layeri = #layers
			layers[layername] = layeri
		end
	end

	framei = tonumber(framei)
	local frame = self[framei]
	if not frame then
		for i = #self+1, framei-1 do
			self[i] = false
		end
		frame = AseFrame(framei, image, cel.duration)
		self[framei] = frame
	end
    frame:putCel(layeri, cel)
end

---@return Aseprite ase
function Aseprite.load(jsonfile, withimagedata)
	local jsondata, err = love.filesystem.read(jsonfile)
	assert(jsondata, err)
	local doc = json.decode(jsondata)
	local cels = doc.frames
	local meta = doc.meta
    local directory = pathlite.splitpath(jsonfile)
	local imagefile = meta.image
	if directory ~= "" then
		imagefile = pathlite.normjoin(directory, meta.image)
	end
	local imagedata = withimagedata and love.image.newImageData(imagefile)
	local image = Aseprite.loadImage(imagefile)

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

	---@type Aseprite
	local ase = Aseprite.cast({
        image = image,
        imagefile = imagefile,
		imagedata = imagedata,
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
		if frame then
			frame.duration = frame.duration * animationtimescale
		end
	end

	for i = 1, #animations do
		local animation = Animation.cast(animations[i])
		animations[animation.name] = animation
		animation:load(ase)
	end
	animations['*'] = ase
	for i = #animations, 1, -1 do
		animations[i] = nil
	end

	return ase
end

function Aseprite.loadWithPixelData(jsonfile)
	return Aseprite.load(jsonfile, true)
end

---@return {[integer]: AseCel[]} celsbysrcpos
function Aseprite:mapCelsBySourcePositions()
	local celsbysrcpos = {}
    local imagewidth = self.image:getWidth()
    for f = 1, #self do
        local frame = self[f]
        if frame then
            for _, cel in ipairs(frame) do
                if cel then
                    local srcx, srcy = cel.quad:getViewport()
                    local key = srcx + srcy*imagewidth
					local celsatsrcpos =  celsbysrcpos[key] or {}
					celsbysrcpos[key] = celsatsrcpos
					celsatsrcpos[#celsatsrcpos+1] = cel
                end
            end
        end
    end
	return celsbysrcpos
end

function Aseprite:newModel()
	assert(hasg3d, [[
		3D models require g3d.
		https://github.com/groverburger/g3d
	]])

	local w, h = self.width, self.height
	local tl = {
		0, 0, 0,
		0, 0,
		0, 0, 1,
		1, 1, 1, 1
	}
	local bl = {
		0, -h, 0,
		0, 1,
		0, 0, 1,
		1, 1, 1, 1
	}
	local tr = {
		w, 0, 0,
		1, 0,
		0, 0, 1,
		1, 1, 1, 1
	}
	local br = {
		w, -h, 0,
		1, 1,
		0, 0, 1,
		1, 1, 1, 1
	}
	local verts = {tl, tr, bl, tr, bl, br}
	local texture = #self.layers <= 1 and self.image
		or love.graphics.newCanvas(w, h)
	return g3d.newModel(verts, texture)
end

function Aseprite:updateModel(model, framei)
	local frame = self[framei]
	if not frame then return end

	if #self.layers > 1 then
		local texture = model.texture
		---@cast texture love.Canvas
		assert(texture:typeOf("Canvas"),
			"Multi-layer aseprite billboard requires canvas texture")

		texture:renderTo(function()
			frame:draw()
		end)
	else
		local verts = model.verts
		local tl, tr = verts[1], verts[2]
		local bl, br = verts[5], verts[6]

		local cel = frame[1]
		if cel then
			cel:updateVertices(tl, bl, tr, br)
		else
			tl[1], tl[2] = 0, 0
			bl[1], bl[2] = 0, 0
			tr[1], tr[2] = 0, 0
			br[1], br[2] = 0, 0
		end
	end
end

return Aseprite