/// <reference types="@mapeditor/tiled-api" />

const openAssets = new Set();

const exportFile = (fileName) => {
    const tileset = tiled.open(fileName);
    if (!tileset) return;

    tiled.trigger("Export");
    tileset.save();
    if (!openAssets.has(tileset.fileName)) {
        tiled.close(tileset);
    };
}

const exportDir = (dir, recurse) => {
    tiled.log(dir)
    File.directoryEntries(dir, File.Files, File.Name)
        .filter((s) => FileInfo.suffix(s) == "tsx")
        .map((s) => FileInfo.joinPaths(dir, s))
        .forEach(exportFile);

    if (recurse) {
        File.directoryEntries(dir, File.Dirs | File.NoDotAndDotDot, File.Name)
            .map((s) => FileInfo.joinPaths(dir, s))
            .forEach((s) => exportDir(s, recurse));
    }
}

const setup = () => {
    openAssets.clear();
    tiled.openAssets.forEach((asset)=>openAssets.add(asset));

    return {
        startDir :
            tiled.activeAsset && FileInfo.cleanPath(tiled.activeAsset.fileName) ||
            tiled.project.folders.length > 0 && tiled.project.folders[0] ||
            tiled.project.fileName.length > 0 && FileInfo.cleanPath(tiled.project.fileName) ||
            '.'
    }
}

const BulkExportTilesets = () => {
    const {startDir} = setup();
    tiled.promptOpenFiles(startDir, "Tilesets (*.tsx)")
        .forEach(exportFile);
}

const BulkExportTilesetsDir = (recurse) => {
    const {startDir} = setup();
    const dir = tiled.promptDirectory(startDir, "Export all tilesets in directory");
    if (dir.length <= 0)
        return;
    exportDir(dir, recurse);
}

tiled.registerAction("BulkExportTilesets", BulkExportTilesets)
.text = "Bulk Export Tilesets...";
tiled.registerAction("BulkExportTilesetsDir", BulkExportTilesetsDir)
.text = "Bulk Export Tilesets in Directory...";
tiled.registerAction("BulkExportTilesetsRecursive", ()=>BulkExportTilesetsDir(true))
.text = "Bulk Export Tilesets in Directory Tree...";

tiled.extendMenu("File", [
    {action: "BulkExportTilesets", before: "Reload"},
    {action: "BulkExportTilesetsDir"},
    // {action: "BulkExportTilesetsRecursive"}
]);
