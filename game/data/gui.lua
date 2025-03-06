return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 15,
  tilewidth = 16,
  tileheight = 18,
  nextlayerid = 12,
  nextobjectid = 39,
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
    },
    {
      name = "keyboard-keys",
      firstgid = 5,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 17,
      image = "tilesets/ui/keyboard-keys.png",
      imagewidth = 272,
      imageheight = 256,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 272,
      tiles = {
        {
          id = 206,
          animation = {
            {
              tileid = 70,
              duration = 100
            },
            {
              tileid = 206,
              duration = 100
            }
          }
        },
        {
          id = 207,
          animation = {
            {
              tileid = 71,
              duration = 100
            },
            {
              tileid = 207,
              duration = 900
            }
          }
        }
      }
    },
    {
      name = "gamepad-buttons",
      firstgid = 277,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 20,
      image = "tilesets/ui/gamepad-buttons.png",
      imagewidth = 320,
      imageheight = 80,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 100,
      tiles = {
        {
          id = 9,
          animation = {
            {
              tileid = 5,
              duration = 100
            },
            {
              tileid = 7,
              duration = 100
            },
            {
              tileid = 3,
              duration = 100
            },
            {
              tileid = 1,
              duration = 100
            }
          }
        },
        {
          id = 60,
          animation = {
            {
              tileid = 20,
              duration = 100
            },
            {
              tileid = 21,
              duration = 100
            }
          }
        },
        {
          id = 71,
          animation = {
            {
              tileid = 30,
              duration = 100
            },
            {
              tileid = 31,
              duration = 900
            }
          }
        },
        {
          id = 80,
          animation = {
            {
              tileid = 40,
              duration = 100
            },
            {
              tileid = 41,
              duration = 100
            }
          }
        },
        {
          id = 91,
          animation = {
            {
              tileid = 50,
              duration = 100
            },
            {
              tileid = 51,
              duration = 900
            }
          }
        }
      }
    },
    {
      name = "flamegaugefull",
      firstgid = 377,
      class = "",
      tilewidth = 40,
      tileheight = 20,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "tilesets/ui/flamegaugefull.png",
      imagewidth = 40,
      imageheight = 160,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 40,
        height = 20
      },
      properties = {},
      wangsets = {},
      tilecount = 8,
      tiles = {
        {
          id = 0,
          animation = {
            {
              tileid = 0,
              duration = 50
            },
            {
              tileid = 1,
              duration = 50
            },
            {
              tileid = 2,
              duration = 50
            },
            {
              tileid = 3,
              duration = 50
            },
            {
              tileid = 4,
              duration = 50
            },
            {
              tileid = 5,
              duration = 50
            },
            {
              tileid = 6,
              duration = 50
            },
            {
              tileid = 7,
              duration = 50
            }
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
              y = 12,
              width = 100,
              height = 9,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffff1f1f",
                ["roundcorners"] = 1,
                ["z"] = 0
              }
            },
            {
              id = 5,
              name = "healthbox",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 12,
              width = 100,
              height = 9,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
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
              id = 30,
              name = "flame1",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 47,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 31,
              name = "flame2",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 80,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 32,
              name = "flame3",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 113,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 33,
              name = "flamebox",
              type = "",
              shape = "rectangle",
              x = 47,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
                ["roundcorners"] = 1,
                ["z"] = 2
              }
            },
            {
              id = 34,
              name = "flamebox",
              type = "",
              shape = "rectangle",
              x = 80,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
                ["roundcorners"] = 1,
                ["z"] = 2
              }
            },
            {
              id = 35,
              name = "flamebox",
              type = "",
              shape = "rectangle",
              x = 113,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
                ["roundcorners"] = 1,
                ["z"] = 2
              }
            },
            {
              id = 36,
              name = "flamefull1",
              type = "",
              shape = "rectangle",
              x = 42,
              y = 37,
              width = 40,
              height = 20,
              rotation = 0,
              gid = 377,
              visible = true,
              properties = {}
            },
            {
              id = 37,
              name = "flamefull2",
              type = "",
              shape = "rectangle",
              x = 75,
              y = 37,
              width = 40,
              height = 20,
              rotation = 0,
              gid = 377,
              visible = true,
              properties = {}
            },
            {
              id = 38,
              name = "flamefull3",
              type = "",
              shape = "rectangle",
              x = 108,
              y = 37,
              width = 40,
              height = 20,
              rotation = 0,
              gid = 377,
              visible = true,
              properties = {}
            },
            {
              id = 29,
              name = "development ver.",
              type = "",
              shape = "text",
              x = 360,
              y = 252,
              width = 112,
              height = 18,
              rotation = 0,
              visible = true,
              text = "DEVELOPMENT VER. 2025",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "right",
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 10,
          name = "hud_weapon",
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
              id = 15,
              name = "weaponname",
              type = "",
              shape = "text",
              x = 48,
              y = 45,
              width = 90,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Weapon",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 16,
              name = "count",
              type = "",
              shape = "text",
              x = 48,
              y = 63,
              width = 16,
              height = 9,
              rotation = 0,
              visible = true,
              text = "99",
              fontfamily = "Press Start 2P",
              pixelsize = 8,
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 18,
              name = "/",
              type = "",
              shape = "text",
              x = 64,
              y = 58.5,
              width = 16,
              height = 18,
              rotation = 0,
              visible = true,
              text = "/",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 17,
              name = "max",
              type = "",
              shape = "text",
              x = 80,
              y = 63,
              width = 16,
              height = 9,
              rotation = 0,
              visible = true,
              text = "99",
              fontfamily = "Press Start 2P",
              pixelsize = 8,
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 14,
              name = "box",
              type = "",
              shape = "rectangle",
              x = 8,
              y = 45,
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
              id = 20,
              name = "icon",
              type = "",
              shape = "rectangle",
              x = 26,
              y = 59,
              width = 32,
              height = 32,
              rotation = 0,
              gid = 1,
              visible = true,
              properties = {
                ["z"] = 0
              }
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
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 11,
          name = "gameover",
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
              id = 21,
              name = "playagain",
              type = "",
              shape = "text",
              x = 224,
              y = 126,
              width = 128,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Play again",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 22,
              name = "",
              type = "",
              shape = "rectangle",
              x = 284,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 7,
              visible = false,
              properties = {}
            },
            {
              id = 23,
              name = "",
              type = "",
              shape = "rectangle",
              x = 180,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 293,
              visible = true,
              properties = {}
            },
            {
              id = 24,
              name = "",
              type = "",
              shape = "rectangle",
              x = 204,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 295,
              visible = true,
              properties = {}
            },
            {
              id = 25,
              name = "+",
              type = "",
              shape = "text",
              x = 196,
              y = 126,
              width = 8,
              height = 18,
              rotation = 0,
              visible = true,
              text = "+",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 26,
              name = "",
              type = "",
              shape = "rectangle",
              x = 232,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 333,
              visible = false,
              properties = {}
            },
            {
              id = 27,
              name = "",
              type = "",
              shape = "rectangle",
              x = 256,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 335,
              visible = false,
              properties = {}
            },
            {
              id = 28,
              name = "+",
              type = "",
              shape = "text",
              x = 248,
              y = 126,
              width = 8,
              height = 18,
              rotation = 0,
              visible = false,
              text = "+",
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
      visible = false,
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
    },
    {
      type = "group",
      id = 8,
      name = "wipe",
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
          draworder = "topdown",
          id = 9,
          name = "diagonalCurtains",
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
  }
}
