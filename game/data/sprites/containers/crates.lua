return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  name = "crates",
  class = "",
  tilewidth = 32,
  tileheight = 48,
  spacing = 0,
  margin = 0,
  columns = 3,
  image = "crates.png",
  imagewidth = 96,
  imageheight = 96,
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
    height = 48
  },
  properties = {},
  wangsets = {},
  tilecount = 6,
  tiles = {
    {
      id = 0,
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
            x = 16,
            y = 48,
            width = 0,
            height = 0,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 10, y = -6 },
              { x = 0, y = -12 },
              { x = -10, y = -6 }
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
            x = 16,
            y = 48,
            width = 0,
            height = 0,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 16, y = -8 },
              { x = 0, y = -16 },
              { x = -16, y = -8 }
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
      type = "container-crate-tall",
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
            x = 16,
            y = 48,
            width = 0,
            height = 0,
            rotation = 0,
            opacity = 1,
            visible = true,
            polygon = {
              { x = 0, y = 0 },
              { x = 16, y = -8 },
              { x = 0, y = -16 },
              { x = -16, y = -8 }
            },
            properties = {
              ["collidable"] = true
            }
          }
        }
      }
    },
    {
      id = 5,
      properties = {
        ["name"] = "Fall"
      }
    }
  }
}
