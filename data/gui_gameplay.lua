return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 80,
  height = 45,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 4,
  nextobjectid = 6,
  properties = {},
  tilesets = {
    {
      name = "rose-face",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "tilesets/ui/rose-face.png",
      imagewidth = 128,
      imageheight = 32,
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
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "hud",
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
          name = "portraitbox",
          class = "",
          shape = "rectangle",
          x = 16,
          y = 16,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "#00000000",
            ["linecolor"] = "#ffffffff",
            ["z"] = 2
          }
        },
        {
          id = 5,
          name = "healthbox",
          class = "",
          shape = "rectangle",
          x = 47.5,
          y = 15.5,
          width = 101,
          height = 17,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "#00000000",
            ["linecolor"] = "#ffff8080",
            ["roundcorners"] = 2,
            ["z"] = 1
          }
        },
        {
          id = 1,
          name = "portrait",
          class = "",
          shape = "rectangle",
          x = 32,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 1,
          visible = true,
          properties = {
            ["z"] = 0
          }
        },
        {
          id = 3,
          name = "health",
          class = "Gui.Gauge",
          shape = "rectangle",
          x = 48,
          y = 16,
          width = 100,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "#ffc04040",
            ["z"] = 0
          }
        },
        {
          id = 4,
          name = "run",
          class = "Gui.Gauge",
          shape = "rectangle",
          x = 48,
          y = 32,
          width = 100,
          height = 8,
          rotation = 0,
          visible = false,
          properties = {
            ["z"] = 0
          }
        }
      }
    }
  }
}
