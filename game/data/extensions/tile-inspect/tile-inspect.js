/// <reference types="@mapeditor/tiled-api" />

/**
 * 
 * @param {Tileset} tileset 
 */

function markAndCountEmptyTiles(tileset) {
    let numEmpty = tileset.tileCount
    tileset.tiles.map(tile => {
        let empty = true
        let image = tile.image
        let rect = tile.imageRect
        let x2 = rect.x + rect.width
        let y2 = rect.y + rect.height
        for (let y = rect.y; empty && y < y2; ++y) {
            for (let x = rect.x; empty && x < x2; ++x) {
                if (image.pixel(x, y) >= 0x01000000) {
                    empty = false
                    --numEmpty
                }
            }
        }
        if (empty)
            tile.setProperty("empty", true)
        else
            tile.removeProperty("empty")
    })
    tileset.setProperty("numempty", numEmpty)
}

tiled.registerAction('MarkAndCountEmptyTiles',
    action => {
        let asset = tiled.activeAsset
        if (asset.isTileset)
            markAndCountEmptyTiles(asset)
        else if (asset.isTileMap) {
            /** @type {TileMap} */
            let map = asset
            map.tilesets.map(tileset =>
                markAndCountEmptyTiles(tileset)
            )
        }
    }).text = 'Mark and count empty tiles';

tiled.extendMenu("Map", [
    { action: 'MarkAndCountEmptyTiles' },
]);
tiled.extendMenu("Tileset", [
    { action: 'MarkAndCountEmptyTiles' },
]);

tiled.assetAboutToBeSaved.connect(asset => {
    if (asset.isTileset) {
        if (asset.resolvedProperty("OnSaveInspectForEmptyTiles") === true)
            markAndCountEmptyTiles(asset)
    }
})