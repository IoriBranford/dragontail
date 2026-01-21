require "luarocks.loader"

-- luarocks install luafilesystem penlight lua-cjson
local lapp = require "pl.lapp"
local ftcsv = require "ftcsv"
local lfs = require "lfs"

---@alias FilePath string
---@alias AuthorName string
---@alias LicenseName string

---@class AssetCredit
---@field path FilePath
---@field authors AuthorName
---@field licenses LicenseName

---@class AssetAuthor
---@field name AuthorName
---@field works FilePath[]

---@class AssetLicense
---@field name LicenseName
---@field works FilePath[]

local CreditsFilename = "credits.csv"
local AuthorsFilename = "authors.csv"
local LicensesFilename = "licenses.csv"

local AssetTypes = {
    [".png"] = true,
    [".wav"] = true,
    [".mp3"] = true,
    [".ogg"] = true,
    [".fnt"] = true
}

local args = lapp [[
Create and update asset credit & license database
    -v,--verbose
    <paths...>      (string)                Asset directories to scan
]]

local function isAsset(path)
    local ext = path:match("%.%w+$")
    return AssetTypes[ext]
end

local ShareAlikeLicenses = {
    "CC-BY-SA",
    "GPL"
}

local credits = {} ---@type AssetCredit[]|table<FilePath,AssetCredit>
local authors = {} ---@type table<AuthorName,AssetAuthor>
local licenses = {} ---@type table<LicenseName,AssetLicense>

local function handleAsset(path)
    local credit = credits[path]
    if not credit then
        local i = #credits+1
        credit = {
            n = i,
            path = path,
            authors = "UNCREDITED",
            licenses = "UNLICENSED",
        }
        credits[i] = credit
        credits[path] = credit
    end
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
                if isAsset(subpath) or subattr.mode == 'directory' then
                    handlePath(fullpath, true)
                end
            end
        end
    elseif attr.mode == 'file' then
        if isAsset(path) then
            handleAsset(path)
        else
            io.stderr:write(path.." does not appear to be an asset file\n")
        end
    end
end

if lfs.attributes(CreditsFilename) then
    credits = ftcsv.parse(CreditsFilename)
    for _, credit in ipairs(credits) do
        credits[credit.path] = credit
    end
end

for _, path in ipairs(args.paths) do
    handlePath(path, true)
end

if #credits < 1 then
    print("No assets found")
    return
end

local text, file

text = ftcsv.encode(credits,{
    onlyRequiredQuotes = true,
    fieldsToKeep = {"path", "authors", "licenses"}
})
file = assert(io.open(CreditsFilename, "w+"))
file:write(text)
file:close()