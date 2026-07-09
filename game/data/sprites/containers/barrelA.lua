return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "barrelA",
  class = "",
  tilewidth = 32,
  tileheight = 32,
  spacing = 0,
  margin = 0,
  columns = 3,
  image = "barrelA.png",
  imagewidth = 96,
  imageheight = 32,
  objectalignment = "bottom",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 8
  },
  grid = {
    orientation = "orthogonal",
    width = 32,
    height = 32
  },
  properties = {},
  wangsets = {},
  tilecount = 3,
  tiles = {
    {
      id = 0,
      type = "container-barrel"
    },
    {
      id = 1,
      type = "container-barrel",
      properties = {
        ["name"] = "Fall"
      }
    },
    {
      id = 2,
      type = "container-barrel",
      properties = {
        ["name"] = "closed"
      }
    }
  }
}
