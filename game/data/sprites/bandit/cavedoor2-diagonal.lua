return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "cavedoor2-diagonal",
  class = "",
  tilewidth = 64,
  tileheight = 128,
  spacing = 0,
  margin = 0,
  columns = 4,
  image = "cavedoor2-diagonal.png",
  imagewidth = 256,
  imageheight = 128,
  objectalignment = "left",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 0
  },
  grid = {
    orientation = "orthogonal",
    width = 64,
    height = 128
  },
  properties = {},
  wangsets = {},
  tilecount = 4,
  tiles = {
    {
      id = 1,
      type = "bandit-cave-door",
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        class = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 1,
            name = "",
            type = "",
            shape = "polygon",
            x = 0,
            y = 64,
            width = 0,
            height = 0,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 64, y = 64 },
              { x = 62.7484, y = 46.7484 },
              { x = 16, y = 0 }
            },
            properties = {
              ["collidable"] = true
            }
          }
        }
      }
    },
    {
      id = 2,
      properties = {
        ["name"] = "collapse"
      }
    }
  }
}
