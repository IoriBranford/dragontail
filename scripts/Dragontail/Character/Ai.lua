local Character = require "Dragontail.Character"
local co_create = coroutine.create
local yield = coroutine.yield
local resume = coroutine.resume
local status = coroutine.status
local wait = coroutine.wait

local Ai = {}

function Ai:stand(duration)
    -- stand still for a short period facing player
    self.sprite:changeAsepriteAnimation("stand0")
    wait(duration)
end

function Ai:walk()
    -- move to a position to attack player

    -- keep animation updated for movement direction
end

function Ai:attack()
    -- throw attack
    -- return to walk
end

function Ai:hurt()
    while self.hitstun > 0 do
        yield()
    end
    if self.health <= 0 then
        return "dizzy", 300
    else
        return "stand", 60
    end
end

function Ai:dizzy(duration)
    wait(duration)
    return "defeat"
end

function Ai:spin()
end

function Ai:defeat()
    -- remove self
end

function Character:startAi(ainame, ...)
    local f = Ai[ainame]
    local ai = co_create(f)
    self.ai = ai
    resume(ai, self, ...)
end

function Character:runAi()
    local ai = self.ai
    local nextainame, a, b, c, d, e = resume(ai, self)
    if nextainame then
        self:startAi(nextainame, a, b, c, d, e)
    elseif status(ai) == "dead" then
        self.ai = nil
    end
end

return Character