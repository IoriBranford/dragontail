local type = type
local co_create = coroutine.create
local co_resume = coroutine.resume
local co_status = coroutine.status

---@class Tasks
---@field [integer] thread|function|boolean Running tasks (false = finished task)
---@field labeled {[string]:integer, [integer]:string} Maps labels to indexes and vice versa
local Tasks = class()

function Tasks:_init(user)
    self.user = user
end

---@param f function|string If string: "fname", "label:fname" for coroutine, or "label=fname" for function
---@param label string?
---@param typ "thread"|"function"? Default is "thread". Overrides ':' and '=' in string f
function Tasks:put(f, label, typ)
    if type(f) == "string" then
        local l, op, name = f:match("(%w*)([:=])(%w+)")
        if l then
            label = #l > 0 and l
            f = self.user[name]
            if not typ then
                typ = op == '=' and "function" or "thread"
            end
        else
            f = self.user[f]
        end
    end

    typ = typ or "thread"

    local i
    if label then
        i = self:addLabel(label)
    else
        i = #self+1
    end

    if type(f) == "function" then
        if typ == "function" then
            self[i] = f
        else
            local co = co_create(f)
            self[i] = co
        end
    else
        self[i] = false
    end
end

function Tasks:stop(label)
    local labeled = self.labeled
    if not labeled then
        return
    end
    local i = labeled[label]
    if i and self[i] then
        self[i] = false
    end
end

function Tasks:addLabel(label)
    local labeled = self.labeled
    if not labeled then
        labeled = {}
        self.labeled = labeled
    end
    local i = labeled[label]
    if not labeled[label] then
        i = #self+1
        labeled[label] = i
        labeled[i] = label
    end
    return i
end

function Tasks:removeLabel(label)
    local labeled = self.labeled
    if not labeled then
        return
    end
    local i = labeled[label]
    if i and self[i] then
        labeled[label] = nil
        labeled[i] = nil
    end
end

function Tasks:isRunning(i)
    if type(i) == "string" then
        i = self.labeled and self.labeled[i]
    end
    return self[i] and true or false
end

function Tasks:startNext()
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

function Tasks:run()
    local user = self.user
    for i, task in ipairs(self) do
        if type(task) == "thread" then
            local ok, err = co_resume(task, user)
            if not ok then
                error(debug.traceback(task, err))
            elseif task == self[i] and co_status(task) == "dead" then
                self[i] = false
            end
        elseif type(task) == "function" then
            local result = task(user)
            if task == self[i] then
                if result == false or type(result) == "function" then
                    self[i] = result
                end
            end
        end
    end

    local labeled = self.labeled
    for i = #self, 1, -1 do
        if self[i] ~= false then
            break
        end
        if labeled and labeled[i] then
            break
        end
        self[i] = nil
    end
end

function Tasks:setNext(funcs)
    self.next = funcs
end

function Tasks:clear()
    for i = #self, 1, -1 do
        self[i] = nil
    end
end

return Tasks