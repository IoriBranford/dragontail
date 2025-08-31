/// <reference types="@mapeditor/tiled-api" />

/**
 * @param {Layer} layer
 * @param {(objects: MapObject[])=>MapObject[]} find
 */
function Layer_findObjects(layer, find) {
    if (layer.isGroupLayer) {
        return Layers_findObjects(layer.layers, find);
    }
    if (layer.isObjectLayer) {
        return find(layer.objects);
    }
    return [];
}

/**
 * @param {Layer[]} layers
 * @param {(objects: MapObject[])=>MapObject[]} find
 */
function Layers_findObjects(layers, find) {
    return layers.reduce(
        /** @param {MapObject[]} objects */
        (objects, layer) =>
            [...objects, ...Layer_findObjects(layer, find)]
        , []);
}

/**
 * @param {TileMap} map
 * @param {(objects: MapObject[])=>MapObject[]} find
 */
function TileMap_findObjects(map, find) {
    return Layers_findObjects(map.layers, find);
}