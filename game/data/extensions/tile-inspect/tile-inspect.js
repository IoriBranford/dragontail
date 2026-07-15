/// <reference types="@mapeditor/tiled-api" />

/**
 *
 * @param {Tile} tile
 * @returns boolean
 */
const Tile_isBlank = (tile) => {
  let image = tile.image;
  let rect = tile.imageRect;
  let x2 = rect.x + rect.width;
  let y2 = rect.y + rect.height;
  for (let y = rect.y; y < y2; ++y) {
    for (let x = rect.x; x < x2; ++x) {
      const alpha = image.pixel(x, y) & 0xff000000;
      if (alpha != 0) return false;
    }
  }
  return true;
};

/**
 *
 * @param {Tileset} tileset
 */

function Tileset_updateBlankTiles(tileset) {
  tileset.macro("Update blank tiles", () => {
    const blanks = tileset.tiles.filter(Tile_isBlank).map((t) => t.id);
    if (blanks.length > 0) {
      // TODO make it a list when supported
      tileset.setProperty("blanktiles", blanks.join(","));
      tileset.setProperty("blanktilecount", blanks.length);
    } else {
      tileset.removeProperty("blanktiles");
      tileset.removeProperty("blanktilecount");
    }
  });
}

function Tileset_saveAndExport(tileset) {
  tiled.open(tileset.fileName);
  tiled.activeAsset = tileset;
  tiled.trigger("Export");
  tileset.save();
}

const MarkAndCountBlankTiles = (action) => {
  let asset = tiled.activeAsset;
  if (asset.isTileset) Tileset_updateBlankTiles(asset);
  else if (asset.isTileMap) {
    asset.macro("Update blank tileset tiles", () => {
      asset.tilesets.forEach(Tileset_updateBlankTiles);
      asset.tilesets.forEach(Tileset_saveAndExport);
    });
  }
};

tiled.registerAction("MarkAndCountBlankTiles", MarkAndCountBlankTiles).text =
  "Mark and count blank tiles";

tiled.extendMenu("Map", [{ action: "MarkAndCountBlankTiles" }]);
tiled.extendMenu("Tileset", [{ action: "MarkAndCountBlankTiles" }]);

