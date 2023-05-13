local Properties = {}

local function addIfNew(t, k, v)
    if t[k] then
        print(string.format("W: tried to overwrite duplicate or reserved field name %s in %s", k, t.name or t))
    else
        t[k] = v
    end
end

function Properties.resolveObjectRefs(properties, mapobjects)
    for k,v in pairs(properties) do
        if type(v) == "table" then
            properties[k] = mapobjects[v.id]
        end
    end
end

function Properties.moveUp(t, dest)
    local properties = t.properties
    if properties then
        dest = dest or t
        for k, v in pairs(properties) do
            addIfNew(dest, k, v)
        end
        t.properties = nil
    end
end

return Properties