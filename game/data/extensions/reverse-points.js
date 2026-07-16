/// <reference types="@mapeditor/tiled-api" />
/**
 *
 * @param {MapObject[]} objs
 * @returns
 */
const reverse = (objs) =>
  objs.forEach((o) => {
    if (o.shape == MapObject.Polygon || o.shape == MapObject.Polyline)
      o.polygon = [...o.polygon.reverse()];
  });

const reversePoints = () => {
  if (tiled.activeAsset.isTileMap) reverse(tiled.activeAsset.selectedObjects);
  reverse(tiled.tilesetEditor.collisionEditor.selectedObjects);
};

tiled.registerAction("reversePoints", reversePoints).text = "Reverse points";

tiled.extendMenu("MapView.Objects", [{ action: "reversePoints" }]);
