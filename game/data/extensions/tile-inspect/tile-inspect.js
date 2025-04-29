/// <reference types="@mapeditor/tiled-api" />

/**
 * 
 * @param {Tileset} tileset 
 */

function Tileset_updateEmptyTiles(tileset) {
    tileset.macro("Update empty tiles", () => {
        let numEmpty = tileset.tileCount
        tileset.tiles.forEach(tile => {
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
        if (numEmpty > 0)
            tileset.setProperty("numempty", numEmpty)
        else
            tileset.removeProperty("numempty")
    })
}

/**
 * 
 * @param {TileLayer} layer 
 */
function TileLayer_clearEmptyTiles(layer) {
    if (!layer.isTileLayer) return

    let editor = layer.edit()
    layer.region().rects.forEach(rect => {
        let x2 = x + rect.width, y2 = y + rect.height
        for (let y = rect.y; y < y2; ++y)
            for (let x = rect.x; x < x2; ++x)
                if (layer.tileAt(x, y).property("empty") === true)
                    editor.setTile(x, y, null)
        
    })
    editor.apply()
}

/**
 * 
 * @param {TileMap} map 
 */
function TileMap_updateEmptyTilesetTiles(map) {
    map.macro("Update empty tileset tiles", () => {
        map.tilesets.forEach(Tileset_updateEmptyTiles)
    })
}

/**
 * 
 * @param {TileMap} map 
 */
function TileMap_clearEmptyLayerTiles(map) {
    map.macro("Clear empty layer tiles", () => {
        map.layers.forEach(TileLayer_clearEmptyTiles)
    })
}

tiled.registerAction('MarkAndCountEmptyTiles',
    action => {
        let asset = tiled.activeAsset
        if (asset.isTileset)
            Tileset_updateEmptyTiles(asset)
        else if (asset.isTileMap) {
            TileMap_updateEmptyTilesetTiles(asset)
            TileMap_clearEmptyLayerTiles(asset)
        }
    }).text = 'Mark and count empty tiles';

tiled.extendMenu("Map", [
    { action: 'MarkAndCountEmptyTiles' },
]);
tiled.extendMenu("Tileset", [
    { action: 'MarkAndCountEmptyTiles' },
]);

tiled.assetAboutToBeSaved.connect(asset => {
    if (asset.resolvedProperty("OnSaveInspectForEmptyTiles") !== true)
        return

    if (asset.isTileset) {
        Tileset_updateEmptyTiles(asset)
    } else if (asset.isTileMap) {
        /** @type {TileMap} */
        let map = asset
        TileMap_updateEmptyTilesetTiles(map)
        TileMap_clearEmptyLayerTiles(map)
        map.tilesets.forEach(tileset => tileset.save())
    }
})