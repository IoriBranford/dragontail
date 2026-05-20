return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  name = "rose-face",
  class = "",
  tilewidth = 32,
  tileheight = 32,
  spacing = 0,
  margin = 0,
  columns = 4,
  image = "rose-face.png",
  imagewidth = 128,
  imageheight = 32,
  objectalignment = "bottom",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 0
  },
  grid = {
    orientation = "orthogonal",
    width = 32,
    height = 32
  },
  properties = {},
  wangsets = {},
  tilecount = 4,
  tiles = {
    {
      id = 0,
      properties = {
        ["name"] = "normal"
      }
    },
    {
      id = 1,
      properties = {
        ["name"] = "hurt"
      }
    },
    {
      id = 2,
      properties = {
        ["name"] = "attack"
      }
    },
    {
      id = 3,
      properties = {
        ["name"] = "win"
      }
    }
  }
}
