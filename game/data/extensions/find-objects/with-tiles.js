/// <reference types="@mapeditor/tiled-api" />

/**
 * @param {MapObject} object 
 * @param {Set<Tile>} tiles 
 * @returns 
 */
function objectHasOneOfTiles(object, tiles) {
    return object.tile && tiles.has(object.tile) || false;
}

/**
 * @param {MapObject[]} objects 
 * @param {Set<Tile>} tiles 
 */
function findObjectsWithTiles(objects, tiles) {
    return objects.filter(object => objectHasOneOfTiles(object, tiles));
}
