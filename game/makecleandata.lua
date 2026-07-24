local lapp = require "pl.lapp"
local path = require "pl.path"
local psplit = path.splitpath
local pjoin = path.join
local splitext = path.splitext

local function mv(from, to)
    os.rename(from, to)--execute(string.format('mv "%s" "%s"', from, to))
end

local function mkdir_p(dir)
    os.execute(string.format('mkdir -p "%s"', dir))
end

local args = lapp [[
Build a clean map data directory
    -v,--verbose
    -f,--force
    <outdir>       (string)          Clean data dir
    <maps...>      (string)          Maps to scan
]]

local outroot = args.outdir
mkdir_p(outroot)

local exts = {
    png = true,
    ase = true,
    jase = true,
    json = true,
    txt = true,
    ogg = true,
    mp3 = true,
}

for _, mapinfile in ipairs(args.maps) do
    local map = loadfile(mapinfile)()

    local mapindir, mapfile = psplit(mapinfile)
    local mapoutdir = pjoin(outroot, mapindir)
    local mapoutfile = pjoin(mapoutdir, mapfile)
    mkdir_p(mapoutdir)
    mv(mapinfile, mapoutfile)

    local tmxfile = splitext(mapfile)..".tmx"
    local tmxinfile = pjoin(mapindir, tmxfile)
    local tmxoutfile = pjoin(mapoutdir, tmxfile)
    mv(tmxinfile, tmxoutfile)

    local tses = map.tilesets
    for _, ts in ipairs(tses) do
        local tsdir, tsfile = psplit(ts.filename)
        local expdir, expfile = psplit(ts.exportfilename)

        local tsoutdir = pjoin(mapoutdir, tsdir)
        mkdir_p(tsoutdir)

        local expoutdir = pjoin(mapoutdir, expdir)
        mkdir_p(expoutdir)

        local tsin = pjoin(mapindir, tsdir, tsfile)
        local tsout = pjoin(tsoutdir, tsfile)
        mv(tsin, tsout)

        local expin = pjoin(mapindir, expdir, expfile)
        local expout = pjoin(expoutdir, expfile)
        mv(expin, expout)

        for ext in pairs(exts) do
            local file = splitext(tsfile)..'.'..ext
            local infile = pjoin(mapindir, tsdir, file)
            local outfile = pjoin(tsoutdir, file)
            mv(infile, outfile)
        end
    end

    local function copyLayerAssets(l)
        local prop = l.properties
        for _, v in pairs(prop) do
            if type(v) == "string" then
                local _, ext = splitext(v)
                if exts['.'..ext] then
                    local dir = psplit(v)
                    mkdir_p(pjoin(mapoutdir, dir))
                    local infile = pjoin(mapindir, v)
                    local outfile = pjoin(mapoutdir, v)
                    mv(infile, outfile)
                end
            end
        end
        local llyrs = l.layers
        if llyrs then
            for _, ll in ipairs(llyrs) do
                copyLayerAssets(ll)
            end
            return
        end
        local img = l.image
        if img then
            local imgdir = psplit(img)
            mkdir_p(pjoin(mapoutdir, imgdir))

            local infile = pjoin(mapindir, img)
            local outfile = pjoin(mapoutdir, img)
            mv(infile, outfile)
        end
    end

    local lyrs = map.layers
    for _, l in ipairs(lyrs) do
        copyLayerAssets(l)
    end
end

local ftcsv = require "ftcsv"

