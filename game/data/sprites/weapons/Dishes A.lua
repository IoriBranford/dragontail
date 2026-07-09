return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "Dishes A",
  class = "",
  tilewidth = 32,
  tileheight = 32,
  spacing = 0,
  margin = 0,
  columns = 8,
  image = "Dishes A.png",
  imagewidth = 256,
  imageheight = 96,
  objectalignment = "center",
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
  tilecount = 24,
  tiles = {
    {
      id = 0,
      type = "item-dish",
      properties = {
        ["name"] = "dish-small"
      }
    },
    {
      id = 16,
      properties = {
        ["name"] = "Shatter"
      },
      animation = {
        {
          tileid = 16,
          duration = 50
        },
        {
          tileid = 17,
          duration = 50
        },
        {
          tileid = 18,
          duration = 50
        },
        {
          tileid = 19,
          duration = 50
        }
      }
    }
  }
}
