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
  nextlayerid = 10,
  nextobjectid = 3,
  properties = {},
  tilesets = {
    {
      name = "title",
      firstgid = 1,
      class = "",
      tilewidth = 480,
      tileheight = 270,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "sprites/ui/title.ase",
      imagewidth = 480,
      imageheight = 270,
      objectalignment = "topleft",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 480,
        height = 270
      },
      properties = {},
      wangsets = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "sprites/ui/title/illust/bg.png",
      id = 2,
      name = "bg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "group",
      id = 7,
      name = "fg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 444,
      offsety = -90,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/07 Thug_L.png",
          id = 3,
          name = "enemy",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 68,
          offsety = -27,
          parallaxx = 1,
          parallaxy = 1,
          repeatx = false,
          repeaty = false,
          properties = {}
        },
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/08 effects L.png",
          id = 5,
          name = "hit",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 20,
          offsety = 9,
          parallaxx = 1,
          parallaxy = 1,
          repeatx = false,
          repeaty = false,
          properties = {}
        },
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/09 Rose.png",
          id = 4,
          name = "Rose",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          repeatx = false,
          repeaty = false,
          properties = {}
        },
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/10 swipe.png",
          id = 6,
          name = "swing",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = -68,
          offsety = 4.5,
          parallaxx = 1,
          parallaxy = 1,
          repeatx = false,
          repeaty = false,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "logo",
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
          name = "logo",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 480,
          height = 270,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["asetag"] = "Flaming"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "directions",
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
          name = "path",
          type = "",
          shape = "polyline",
          x = 444,
          y = -90,
          width = 0,
          height = 0,
          rotation = 0,
          opacity = 1,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -520, y = -36 }
          },
          properties = {}
        }
      }
    }
  }
}
