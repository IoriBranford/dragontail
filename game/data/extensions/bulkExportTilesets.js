/// <reference types="@mapeditor/tiled-api" />

const openAssets = new Set();

const exportTilesetFile = (fileName) => {
    const tileset = tiled.open(fileName);
    tiled.trigger("Export");
    tileset.save();
}

const exportTilesetFiles = (tilesetFiles) => {
    tilesetFiles.forEach((fileName) => {
        const tileset = tiled.open(fileName);
        if (tileset) {
            if (tileset.isTileset) {
                exportTilesetFile(tileset.fileName);
            }
            if (!openAssets.has(tileset.fileName)) {
                tiled.close(tileset);
            };
        }
    });
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

const bulkExportTilesets = () => {
    const {startDir} = setup();

    const fileNames = tiled.promptOpenFiles(startDir, "Tilesets (*.tsx)");
    if (fileNames.length <= 0)
        return;

    exportTilesetFiles(fileNames);
}

const bulkExportTilesetsDir = () => {
    const {startDir} = setup();

    const dir = tiled.promptDirectory(startDir, "Export all tilesets in directory");
    if (dir.length <= 0)
        return;

    const fileNames = File.directoryEntries(dir, File.Files, File.Name)
        .filter((s) => FileInfo.suffix(s) == "tsx")
        .map((s) => FileInfo.joinPaths(dir, s));

    if (fileNames.length <= 0)
        return;
    exportTilesetFiles(fileNames);
}

const bulkExportTilesetsDirRecursive = () => {}

tiled.registerAction("BulkExportTilesets", bulkExportTilesets)
.text = "Bulk Export Tilesets...";
tiled.registerAction("BulkExportTilesetsDir", bulkExportTilesetsDir)
.text = "Bulk Export Tilesets in Directory...";

tiled.extendMenu("File", [
    {action: "BulkExportTilesets", before: "Reload"},
    {action: "BulkExportTilesetsDir"}
]);

// const exportTilesetsInMaps = (mapFiles) => {
//     const openAssets = new Set(tiled.openAssets);
//     const exportedTilesets = new Set();
    
//     mapFiles.forEach((fileName) => {
//         const map = tiled.open(fileName);
//         if (map && map.isTileMap) {
//             /*** @type Tileset[] */
//             const tilesets = map.tilesets;
//             tilesets.forEach((tileset) => {
//                 if (!exportedTilesets.has(tileset.fileName)) {
//                     exportedTilesets.add(tileset.fileName);
//                     exportTilesetFile(tileset);
//                     if (!openAssets.has(tileset.fileName)) {
//                         tiled.close(tileset);
//                     };
//                 };
//             });
//             tiled.activeAsset = map;
//             tiled.trigger("Export");
//             map.save();
//             if (!openAssets.has(map.fileName)) {
//                 tiled.close(map);
//             };
//         }
//     });
// }

// tiled.registerAction("BulkExportMapsTilesets", () => {
//     const startDir =
//         tiled.activeAsset && FileInfo.cleanPath(tiled.activeAsset.fileName) ||
//         tiled.project.folders.length > 0 && tiled.project.folders[0] ||
//         tiled.project.fileName.length > 0 && FileInfo.cleanPath(tiled.project.fileName) ||
//         '.';

//     const fileNames = tiled.promptOpenFiles(startDir, "Maps (*.tmx)");
//     if (fileNames.length <= 0)
//         return;

//     exportTilesetsInMaps(fileNames);
// }).text = "Bulk Export All Tilesets in Maps...";

// tiled.extendMenu("File", [
//     {action: "BulkExportMapsTilesets", before: "Reload"}
// ]);