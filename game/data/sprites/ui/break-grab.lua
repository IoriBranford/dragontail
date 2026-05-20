return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  name = "break-grab",
  class = "",
  tilewidth = 48,
  tileheight = 48,
  spacing = 0,
  margin = 0,
  columns = 4,
  image = "break-grab.png",
  imagewidth = 192,
  imageheight = 48,
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
        ["name"] = "x"
      },
      animation = {
        {
          tileid = 0,
          duration = 100
        },
        {
          tileid = 1,
          duration = 100
        }
      }
    },
    {
      id = 2,
      properties = {
        ["name"] = "y"
      },
      animation = {
        {
          tileid = 2,
          duration = 100
        },
        {
          tileid = 3,
          duration = 100
        }
      }
    }
  }
}
