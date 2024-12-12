
---@class Attack
---
---How is the attack placed in the world?
---@field radius number
---@field arc number
---@field projectile string
---
---What happens to them on impact?
---@field damage number
---@field damagestate string
---These could be part of fighter data or damage states
----@field opponentstuntime integer
----@field defeatstate string
----@field damageparticle string
----@field damagecolorcycle string
----@field pushforce number
----@field launchforce number
---
---What happens to me on impact?
---@field selfstuntime integer
---@field stateonhitopponent string
---@field stateonhitwall string
---@field stateonhitanything string
---
---What else happens on impact?
---@field damagespark string
---@field damagesound string
---@field guardspark string
---@field guardsound string
---
---Other properties
---@field invulnerable boolean
---@field candeflectprojectile boolean
---@field canjuggle boolean