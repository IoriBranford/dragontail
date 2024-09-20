return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 15,
  tilewidth = 16,
  tileheight = 18,
  nextlayerid = 8,
  nextobjectid = 12,
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
  },
  layers = {
    {
      type = "group",
      id = 4,
      name = "gameplay",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "objectgroup",
          draworder = "index",
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
              id = 4,
              name = "run",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 52,
              y = 33,
              width = 100,
              height = 8,
              rotation = 0,
              visible = false,
              properties = {
                ["color"] = "#ff8080ff",
                ["z"] = 0
              }
            },
            {
              id = 6,
              name = "runbox",
              type = "",
              shape = "rectangle",
              x = 52,
              y = 33,
              width = 100,
              height = 8,
              rotation = 0,
              visible = false,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffc0c0ff",
                ["roundcorners"] = 2,
                ["z"] = 1
              }
            },
            {
              id = 3,
              name = "health",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 44,
              y = 27,
              width = 100,
              height = 9,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffc04040",
                ["z"] = 0
              }
            },
            {
              id = 5,
              name = "healthbox",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 27,
              width = 100,
              height = 9,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffff8080",
                ["roundcorners"] = 2,
                ["z"] = 2
              }
            },
            {
              id = 2,
              name = "portraitbox",
              type = "",
              shape = "rectangle",
              x = 8,
              y = 9,
              width = 36,
              height = 27,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
                ["roundcorners"] = 2,
                ["z"] = 3
              }
            },
            {
              id = 1,
              name = "portrait",
              type = "",
              shape = "rectangle",
              x = 26,
              y = 36,
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
              id = 7,
              name = "name",
              type = "",
              shape = "text",
              x = 52,
              y = 9,
              width = 90,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Rose",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 6,
          name = "pausemenu",
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
              id = 8,
              name = "name",
              type = "",
              shape = "text",
              x = 200,
              y = 18,
              width = 80,
              height = 18,
              rotation = 0,
              visible = true,
              text = "PAUSE",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            }
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "title",
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
          id = 9,
          name = "title",
          type = "",
          shape = "text",
          x = 0,
          y = 18,
          width = 480,
          height = 144,
          rotation = 0,
          visible = true,
          text = "ROSE of\nDRAGONTAIL",
          fontfamily = "Lady Radical",
          pixelsize = 32,
          wrap = true,
          color = { 255, 0, 0 },
          halign = "center",
          valign = "center",
          properties = {}
        },
        {
          id = 10,
          name = "pressstart",
          type = "",
          shape = "text",
          x = 0,
          y = 162,
          width = 480,
          height = 54,
          rotation = 0,
          visible = true,
          text = "press any key or button",
          fontfamily = "Lady Radical",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {}
        },
        {
          id = 11,
          name = "copyright",
          type = "",
          shape = "text",
          x = 0,
          y = 234,
          width = 480,
          height = 18,
          rotation = 0,
          visible = true,
          text = "© 2024 Iori Branford",
          fontfamily = "Press Start 2P",
          pixelsize = 8,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {}
        }
      }
    }
  }
}
