/// <reference types="@mapeditor/tiled-api" />

/**
 * @param {MapObject[]} objects
 */
const getObjectsTiles = (objects) =>
    objects.reduce(
        /**
         * @param {Tile[]} tiles 
         */
        (tiles, object) => {
            if (object.tile)
                tiles.push(object.tile);
            return tiles;
        }
    , [])

let SelectObjectsWithSameTiles = tiled.registerAction('SelectObjectsWithSameTiles',
    action => {
        /** @type {TileMap} */ 
        let map = tiled.activeAsset
        if (map.isTileMap) {
            let tiles = new Set(getObjectsTiles(map.selectedObjects));
            if (tiles.size <= 0) {
                tiled.log('No tile objects selected.');
                return;
            }
            map.selectedObjects = TileMap_findObjects(map,
                objects => findObjectsWithTiles(objects, tiles));
        }
    },
)
SelectObjectsWithSameTiles.text = 'Select objects with same tiles';

/**
 * @param {TileMap} map 
 */
const SelectObjectsWithSameTiles_updateEnabled = (map) => {
    if (map.isTileMap)
        SelectObjectsWithSameTiles.enabled = getObjectsTiles(map.selectedObjects).length > 0;
}

tiled.extendMenu("MapView.Objects", {
    action: 'SelectObjectsWithSameTiles',
})

tiled.assetOpened.connect(
    /**
     * @param {TileMap} asset 
     */
    asset => {
        if (asset.isTileMap) {
            asset.selectedObjectsChanged.connect(
                () => SelectObjectsWithSameTiles_updateEnabled(asset))
        }
    }
);
