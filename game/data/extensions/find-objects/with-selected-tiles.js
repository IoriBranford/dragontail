/// <reference types="@mapeditor/tiled-api" />

let SelectObjectsWithTiles = tiled.registerAction('SelectObjectsWithTiles',
    action => {
        /** @type {TileMap} */ 
        let map = tiled.activeAsset
        if (map.isTileMap) {
            let tiles = new Set(tiled.mapEditor.tilesetsView.selectedTiles);
            map.selectedObjects = TileMap_findObjects(map,
                objects => findObjectsWithTiles(objects, tiles));
        }
    }
);
SelectObjectsWithTiles.text = 'Select objects with selected tiles';

tiled.extendMenu("TilesetView.Tiles", {
    action: 'SelectObjectsWithTiles'
})