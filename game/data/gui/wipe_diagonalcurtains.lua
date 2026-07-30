return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 15,
  tilewidth = 16,
  tileheight = 18,
  nextlayerid = 34,
  nextobjectid = 238,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "wipe",
      class = "Gui.Wipe",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["closeandopenfunction"] = "twoCurtainsCloseAndOpen",
        ["closefunction"] = "twoCurtainsClose",
        ["openfunction"] = "twoCurtainsOpen",
        ["speed"] = 32
      },
      objects = {
        {
          id = 12,
          name = "left",
          type = "",
          shape = "polygon",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -240, y = 270 },
            { x = -360, y = 270 },
            { x = -360, y = 0 }
          },
          properties = {
            ["closedx"] = 360,
            ["color"] = "#ff000000",
            ["openx"] = 0
          }
        },
        {
          id = 13,
          name = "right",
          type = "",
          shape = "polygon",
          x = 480,
          y = 270,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 240, y = -270 },
            { x = 360, y = -270 },
            { x = 360, y = 0 }
          },
          properties = {
            ["closedx"] = 120,
            ["color"] = "#ff000000",
            ["openx"] = 480
          }
        }
      }
    }
  }
}
