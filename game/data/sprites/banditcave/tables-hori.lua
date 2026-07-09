return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "tables-hori",
  class = "",
  tilewidth = 96,
  tileheight = 48,
  spacing = 0,
  margin = 0,
  columns = 3,
  image = "tables-hori.png",
  imagewidth = 288,
  imageheight = 48,
  objectalignment = "top",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = -24
  },
  grid = {
    orientation = "orthogonal",
    width = 96,
    height = 48
  },
  properties = {},
  wangsets = {},
  tilecount = 3,
  tiles = {
    {
      id = 0,
      type = "furniture-table",
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
            id = 2,
            name = "",
            type = "",
            shape = "polygon",
            x = 8,
            y = 24,
            width = 80,
            height = 24,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 0, y = 24 },
              { x = 80, y = 24 },
              { x = 80, y = 0 }
            },
            properties = {
              ["collidable"] = true
            }
          }
        }
      }
    },
    {
      id = 1,
      type = "furniture-table",
      objectGroup = {
        type = "objectgroup",
        draworder = "topdown",
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
            x = 8,
            y = 24,
            width = 80,
            height = 24,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 0, y = 24 },
              { x = 80, y = 24 },
              { x = 80, y = 0 }
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
      type = "furniture-table",
      objectGroup = {
        type = "objectgroup",
        draworder = "topdown",
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
            x = 8,
            y = 24,
            width = 80,
            height = 24,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 0, y = 24 },
              { x = 80, y = 24 },
              { x = 80, y = 0 }
            },
            properties = {
              ["collidable"] = true
            }
          }
        }
      }
    }
  }
}
