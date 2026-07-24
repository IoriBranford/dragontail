return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "wall-torch",
  class = "",
  tilewidth = 32,
  tileheight = 48,
  spacing = 0,
  margin = 0,
  columns = 3,
  image = "wall-torch.png",
  imagewidth = 96,
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
    height = 48
  },
  properties = {},
  wangsets = {},
  tilecount = 3,
  tiles = {
    {
      id = 0,
      animation = {
        {
          tileid = 0,
          duration = 100
        },
        {
          tileid = 1,
          duration = 100
        },
        {
          tileid = 2,
          duration = 100
        }
      }
    },
    {
      id = 1,
      animation = {
        {
          tileid = 1,
          duration = 100
        },
        {
          tileid = 2,
          duration = 100
        },
        {
          tileid = 0,
          duration = 100
        }
      }
    },
    {
      id = 2,
      animation = {
        {
          tileid = 2,
          duration = 100
        },
        {
          tileid = 0,
          duration = 100
        },
        {
          tileid = 1,
          duration = 100
        }
      }
    }
  }
}
