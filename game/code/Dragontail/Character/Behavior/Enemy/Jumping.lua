local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local Audio    = require "System.Audio"
local Database = require "Data.Database"
local Character= require "Dragontail.Character"
local Characters = require "Dragontail.Stage.Characters"

---@class EnemyJumping:Behavior
---@field character Enemy
local EnemyJumping = pooledclass(Behavior)
EnemyJumping._nrec = Behavior._nrec + 3

function EnemyJumping:start()
    local enemy = self.character
    self.velx, self.vely = enemy.velx, enemy.vely

    if enemy.z <= enemy.floorz then
        local dusttype = "spark-land-on-feet-dust"
        if Database.get(dusttype) then
            Characters.spawn(Character(dusttype, enemy.x, enemy.y, enemy.z))
        end

        enemy.velz = enemy.jumpvelz or (enemy.gravity*15)
        Face.faceVector(enemy, enemy.velx, enemy.vely)
    end
    enemy.facedestangle = enemy.faceangle
end

function EnemyJumping:fixedupdate()
    local enemy = self.character
    if enemy.z <= enemy.floorz then
        enemy.velz = 0
        Audio.play(enemy.jumplandsound)
        return "stand"
    end

    enemy.velx, enemy.vely = self.velx, self.vely
end

return EnemyJumping