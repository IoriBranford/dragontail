require "luarocks.loader"

-- luarocks install luafilesystem penlight lua-cjson
local lapp = require "pl.lapp"
local xml = require "pl.xml"
local pretty = require "pl.pretty"
local json = require "cjson"
local lfs = require "lfs" ---@type LuaFileSystem

local args = lapp [[
Generates Aseprite json files from Tiled tsx tilesets
    -e,--extension (default jase) Extension for generated files
    -r,--recursive Recurse through any directory paths
    -v,--verbose
    <paths...> (string) File(s) to convert or directory(ies) containing them
]]

local TileTemplate = [[
 <tile id="$id">
  <properties>
   <property name="name" value="$name"/>
  </properties>
  <animation>
   {{<frame tileid="$tileid" duration="$duration"/>}}
  </animation>
 </tile>
]]

local TileOffsetTemplate = '<tileoffset x="$x" y="$y"/>'

local TilesetTemplate = [[
<tileset name="$name"
 tilewidth="$tilewidth" tileheight="$tileheight"
 tilecount="$tilecount" columns="$columns"
 objectalignment="$objectalignment"
 margin="$margin" spacing="$spacing">
  <image source="$image" width="$imagewidth" height="$imageheight"/>
</tileset>
]]

local ObjectAlignments = {
    topleft     = {0.0, 0.0},
    top         = {0.5, 0.0},
    topright    = {1.0, 0.0},
    left        = {0.0, 0.5},
    center      = {0.5, 0.5},
    right       = {1.0, 0.5},
    bottomleft  = {0.0, 1.0},
    bottom      = {0.5, 1.0},
    bottomright = {1.0, 1.0},
    unspecified  = {0.0, 1.0},
}

local function loadTileset(path)
    if args.verbose then
        print(path)
    end

    local tsx, err = xml.parse(path, true)
    if not tsx then
        io.stderr:write(err)
        io.stderr:write("\n")
        return
    end

    local tileset = tsx:match(TilesetTemplate)
    local tileoffsetnode = tsx:child_with_name("tileoffset")
    if tileoffsetnode then
        tileset.tileoffset = tileoffsetnode:match(TileOffsetTemplate)
        tileset.tileoffset.x = tonumber(tileset.tileoffset.x)
        tileset.tileoffset.y = tonumber(tileset.tileoffset.y)
    else
        tileset.tileoffset = {x = 0, y = 0}
    end

    local tilenodes = tsx:get_elements_with_name("tile", true)
    for _, tilenode in ipairs(tilenodes) do
        local tile = tilenode:match(TileTemplate)
        tile.id = tonumber(tile.id)
        for _, frame in ipairs(tile) do
            frame.tileid = tonumber(frame.tileid)
            frame.duration = tonumber(frame.duration)
        end
        tileset[#tileset+1] = tile
    end

    tileset.tilecount = tonumber(tileset.tilecount)
    tileset.columns = tonumber(tileset.columns)
    tileset.tilewidth = tonumber(tileset.tilewidth)
    tileset.tileheight = tonumber(tileset.tileheight)
    tileset.imagewidth = tonumber(tileset.imagewidth)
    tileset.imageheight = tonumber(tileset.imageheight)
    tileset.margin = tonumber(tileset.margin) or 0
    tileset.spacing = tonumber(tileset.spacing) or 0
    return tileset
end

local function tilesetToAseprite(tileset)
    local namebase = tileset.name.."#%d"
    local n = (tileset.tilecount)
    local columns = (tileset.columns)
    local rows = math.ceil(n / columns)
    local tw = (tileset.tilewidth)
    local th = (tileset.tileheight)
    local spriteSourceSize = {x = 0, y = 0, w = tw, h = th}
    local sourceSize = { w = tw, h = th }
    local margin = (tileset.margin)
    local spacing = tileset.spacing

    local alignment = ObjectAlignments[tileset.objectalignment or "unspecified"]
    local originx = alignment[1]*tw - tileset.tileoffset.x
    local originy = alignment[2]*th - tileset.tileoffset.y

    local aseprite = {
        frames = {},
        meta = {
            app = "tsx2jase",
            version = "0.0.1",
            image = tileset.image,
            size = {
                w = tileset.imagewidth,
                h = tileset.imageheight
            },
            frameTags = {},
            layers = {
                {
                    name = tileset.name,
                    opacity = 255,
                    blendMode = "normal"
                }
            },
            slices = {
                {
                    name = "origin",
                    color = "#0000ffff",
                    keys = {
                        {
                            frame = 0,
                            bounds = {
                                x = 0, y = 0,
                                w = tw, h = th
                            },
                            pivot = {
                                x = originx, y = originy
                            }
                        }
                    }
                }
            }
        }
    }

    local frames = aseprite.frames
    local y = margin
    local i = 1
    for r = 1, rows do
        local x = margin
        for c = 1, columns do
            frames[i] = {
                filename = namebase:format(i),
                frame = {x = x, y = y, w = tw, h = th},
                rotated = false,
                trimmed = false,
                spriteSourceSize = spriteSourceSize,
                sourceSize = sourceSize,
                duration = 0
            }
            x = x + tw + spacing
            i = i + 1
        end
        y = y + th + spacing
    end

    local tags = aseprite.meta.frameTags
    for _, tile in ipairs(tileset) do
        local id = tile.id
        local name = tile.name or ""
        local numFrames = #tile
        if numFrames > 0 then
            if name == "" then
                name = tostring(id+1)
            end
            tags[#tags+1] = {
                name = name,
                from = #frames,
                to = #frames+numFrames-1,
                direction = "forward"
            }
            for _, animFrame in ipairs(tile) do
                local frame = frames[animFrame.tileid + 1]
                local duration = (animFrame.duration)
                local fi = #frames + 1
                frames[fi] = {
                    filename = namebase:format(fi),
                    frame = frame.frame,
                    rotated = false,
                    trimmed = false,
                    spriteSourceSize = spriteSourceSize,
                    sourceSize = sourceSize,
                    duration = duration
                }
            end
        elseif name ~= "" then
            tags[#tags+1] = {
                name = name,
                from = id,
                to = id,
                direction = "forward"
            }
        end
    end

    return aseprite
end

local function tsx2jase(path)
    local tileset = loadTileset(path)
    if not tileset then return end
    local aseprite = tilesetToAseprite(tileset)
    if not aseprite then return end
    path = path:gsub("tsx$", args.extension or "jase")
    local jase = json.encode(aseprite)
    local jasefile, err = io.open(path, "w")
    if not jasefile then
        io.stderr:write(err.."\n")
        return
    end
    jasefile:write(jase)
    jasefile:close()
    if args.verbose then
        print("-->", path)
    end
end

local function istsx(path)
    return path:find(".tsx", -4)
end

local function handlePath(path, recursive)
    local attr, err = lfs.attributes(path)
    if not attr then
        io.stderr:write(err.."\n")
        return
    end

    if attr.mode == 'directory' then
        if not recursive then
            return
        end
        for subpath in lfs.dir(path) do
            if subpath ~= "." and subpath ~= ".." then
                local fullpath = path..'/'..subpath
                local subattr = lfs.attributes(fullpath)
                if istsx(subpath) or subattr.mode == 'directory' then
                    handlePath(fullpath, args.recursive)
                end
            end
        end
    elseif attr.mode == 'file' then
        if istsx(path) then
            tsx2jase(path)
        else
            io.stderr:write(path.." does not appear to be a tsx file\n")
        end
    end
end

for _, path in ipairs(args.paths) do
    handlePath(path, true)
end