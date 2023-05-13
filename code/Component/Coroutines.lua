local type = type
local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class Coroutines
---@field [integer] thread|boolean Running coroutines (false = finished coroutine)
---@field tagged table[string => integer] Array indexes of tagged coroutines
local Coroutines = class()

function Coroutines:_init(user)
    self.user = user
end

function Coroutines:put(f)
    local tag, tagged
    if type(f) == "string" then
        local name
        tag, name = f:match("(%w+)[:=](%w+)")
        if tag then
            tagged = self.tagged
            if not tagged then
                tagged = {}
                self.tagged = tagged
            end
            f = self.user[name]
        else
            f = self.user[f]
        end
    end
    if type(f) ~= "function" then
        return
    end
    local co = co_create(f)
    local i
    if tag then
        i = tagged[tag] or #self+1
        tagged[tag] = i
    else
        i = #self+1
    end
    self[i] = co
end

function Coroutines:stop(tag)
    local tagged = self.tagged
    if not tagged then
        return
    end
    local i = tagged[tag]
    if i and self[i] then
        tagged[tag] = nil
        self[i] = false
    end
end

function Coroutines:startNext()
    local next = self.next
    if next then
        self.next = nil
        self:clear()
        if type(next) == "string" then
            for f in next:gmatch("%S+") do
                self:put(f)
            end
        elseif type(next) == "table" then
            for _, f in ipairs(next) do
                self:put(f)
            end
        elseif type(next) == "function" then
            self:put(next)
        end
    end
end

function Coroutines:run()
    local user = self.user
    for i, co in ipairs(self) do
        if type(co) == "thread" then
            local ok, err = co_resume(co, user)
            if not ok then
                error(debug.traceback(err))
            elseif co_status(co) == "dead" then
                self[i] = false
            end
        end
    end
    for i = #self, 1, -1 do
        if self[i] ~= false then
            break
        end
        self[i] = nil
    end
    -- TODO a way to maintain order of tagged coroutines
    -- even after they finish.
    -- local tagged = self.tagged
    -- if tagged then
    --     for tag, i in pairs(tagged) do
    --         if not self[i] then
    --             tagged[tag] = nil
    --         end
    --     end
    -- end
end

function Coroutines:setNext(funcs)
    self.next = funcs
end

function Coroutines:clear()
    for i = #self, 1, -1 do
        self[i] = nil
    end
end

return Coroutines