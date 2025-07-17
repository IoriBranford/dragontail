---@meta g3d

---@class g3d
local g3d = {}

---@class g3d.vector
---@field [1] number
---@field [2] number
---@field [3] number

---@class g3d.vertex
---@field [1] number position x
---@field [2] number position y
---@field [3] number position z
---@field [4] number texture coordinate u
---@field [5] number texture coordinate v
---@field [6] number normal x
---@field [7] number normal y
---@field [8] number normal z
---@field [9] number color red (range 0-1)
---@field [10] number color green (range 0-1)
---@field [11] number color blue (range 0-1)
---@field [12] number color alpha (range 0-1)

---@class g3d.matrix
---@field [integer] integer
g3d.matrix = {}

---@class g3d.model
---@field verts g3d.vertex[]
---@field texture love.Texture
---@field mesh love.Mesh
---@field matrix g3d.matrix
g3d.model = {}

-- this returns a new instance of the model class
-- a model must be given a .obj file or equivalent lua table, and a texture
-- translation, rotation, and scale are all 3d vectors and are all optional
---@param verts g3d.vertex[]|string vertex array, or obj model file name
---@param texture love.Texture|string texture, or texture image file name
---@param translation g3d.vector?
---@param rotation g3d.vector?
---@param scale g3d.vector?
---@return g3d.model
function g3d.newModel(verts, texture, translation, rotation, scale) end

-- move and rotate given two 3d vectors
---@param translation g3d.vector?
---@param rotation g3d.vector?
---@param scale g3d.vector?
function g3d.model:setTransform(translation, rotation, scale) end

-- move given one 3d vector
---@param tx number
---@param ty number
---@param tz number
function g3d.model:setTranslation(tx,ty,tz) end

-- rotate given one 3d vector
-- using euler angles
---@param rx number
---@param ry number
---@param rz number
function g3d.model:setRotation(rx,ry,rz) end

-- create a quaternion from an axis and an angle
---@param x number
---@param y number
---@param z number
---@param angle number
function g3d.model:setAxisAngleRotation(x,y,z,angle) end

-- rotate given one quaternion
---@param x number
---@param y number
---@param z number
---@param w number
function g3d.model:setQuaternionRotation(x,y,z,w) end

-- resize model's matrix based on a given 3d vector
---@param sx number
---@param sy number
---@param sz number
function g3d.model:setScale(sx,sy,sz) end

-- update the model's transformation matrix
function g3d.model:updateMatrix() end

-- align's the model matrix to a given point
---@param pos g3d.vector?
---@param target g3d.vector
---@param up g3d.vector? assumed to be normalized
function g3d.model:lookAtFrom(pos, target, up) end

---@param target g3d.vector
---@param up g3d.vector? assumed to be normalized
function g3d.model:lookAt(target, up) end

---draw the model
---@param shader love.Shader?
function g3d.model:draw(shader) end

---@class g3d.camera
---@field fov number
---@field nearclip number
---@field farclip number
---@field aspectRatio number
---@field position g3d.vector
---@field target g3d.vector
---@field up g3d.vector
---@field viewMatrix g3d.matrix
---@field projectionMatrix g3d.matrix
g3d.camera = {}

---@return number direction
---@return number pitch
function g3d.camera.getDirectionPitch() end

-- convenient function to return the camera's normalized look vector
---@return number,number,number
function g3d.camera.getLookVector() end

-- give the camera a point to look from and a point to look towards
---@param x number
---@param y number
---@param z number
---@param xAt number
---@param yAt number
---@param zAt number
function g3d.camera.lookAt(x,y,z, xAt,yAt,zAt) end

-- move and rotate the camera, given a point and a direction and a pitch (vertical direction)
---@param x number
---@param y number
---@param z number
---@param directionTowards number
---@param pitchTowards number
function g3d.camera.lookInDirection(x,y,z, directionTowards,pitchTowards) end

-- recreate the camera's view matrix from its current values
function g3d.camera.updateViewMatrix() end

-- recreate the camera's projection matrix from its current values
function g3d.camera.updateProjectionMatrix() end

-- recreate the camera's orthographic projection matrix from its current values
function g3d.camera.updateOrthographicMatrix(size) end

-- simple first person camera movement with WASD
-- put this local function in your love.update to use, passing in dt
---@param dt number
function g3d.camera.firstPersonMovement(dt) end

-- use this in your love.mousemoved function, passing in the movements
---@param dx number
---@param dy number
function g3d.camera.firstPersonLook(dx,dy) end