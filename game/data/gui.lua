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
  nextlayerid = 16,
  nextobjectid = 95,
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
    },
    {
      name = "weapon-frame",
      firstgid = 385,
      class = "",
      tilewidth = 24,
      tileheight = 24,
      spacing = 0,
      margin = 0,
      columns = 3,
      image = "tilesets/ui/weapon-frame.png",
      imagewidth = 72,
      imageheight = 48,
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
      tilecount = 6,
      tiles = {}
    },
    {
      name = "go-arrow-small",
      firstgid = 391,
      class = "",
      tilewidth = 100,
      tileheight = 20,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "sprites/ui/go-arrow-small.png",
      imagewidth = 100,
      imageheight = 180,
      objectalignment = "center",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 100,
        height = 20
      },
      properties = {},
      wangsets = {},
      tilecount = 9,
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
            },
            {
              tileid = 8,
              duration = 100
            }
          }
        }
      }
    },
    {
      name = "go-word",
      firstgid = 400,
      class = "",
      tilewidth = 48,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 9,
      image = "sprites/ui/go-word.png",
      imagewidth = 432,
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
        width = 48,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 9,
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
            },
            {
              tileid = 8,
              duration = 100
            }
          }
        }
      }
    },
    {
      name = "firespit",
      firstgid = 409,
      class = "",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "sprites/player/rose/firespit.ase",
      imagewidth = 64,
      imageheight = 64,
      objectalignment = "center",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "break-grab",
      firstgid = 410,
      class = "",
      tilewidth = 48,
      tileheight = 48,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "sprites/ui/break-grab.png",
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
                ["fullcolor"] = "#ffffd000",
                ["normalcolor"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 59,
              name = "flamecharge1",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 47,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffffff",
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
                ["fullcolor"] = "#ffffd000",
                ["normalcolor"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 58,
              name = "flamecharge2",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 80,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffffff",
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
                ["fullcolor"] = "#ffffd000",
                ["normalcolor"] = "#ffffaa00",
                ["z"] = 0
              }
            },
            {
              id = 57,
              name = "flamecharge3",
              type = "Gui.Gauge",
              shape = "rectangle",
              x = 113,
              y = 26,
              width = 30,
              height = 6,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffffffff",
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
              name = "flamefullcharge1",
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
              name = "flamefullcharge2",
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
              name = "flamefullcharge3",
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
              x = 328,
              y = 225,
              width = 144,
              height = 36,
              rotation = 0,
              visible = true,
              text = "DEVELOPMENT VER. 2025\nALL CONTENT SUBJECT TO CHANGE",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "right",
              valign = "bottom",
              properties = {}
            },
            {
              id = 94,
              name = "breakgrabprompt",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 0,
              width = 48,
              height = 48,
              rotation = 0,
              gid = 410,
              visible = true,
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
          visible = false,
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
          draworder = "index",
          id = 14,
          name = "hud_go",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 360,
          offsety = 135,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 70,
              name = "arrow",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 0,
              width = 100,
              height = 20,
              rotation = 0,
              gid = 391,
              visible = true,
              properties = {}
            },
            {
              id = 71,
              name = "word",
              type = "",
              shape = "rectangle",
              x = 0,
              y = 0,
              width = 48,
              height = 32,
              rotation = 0,
              gid = 400,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 12,
          name = "hud_weaponslots",
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
              id = 39,
              name = "emptyslot1",
              type = "",
              shape = "rectangle",
              x = 20,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 388,
              visible = true,
              properties = {}
            },
            {
              id = 43,
              name = "fullslot1",
              type = "",
              shape = "rectangle",
              x = 20,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 385,
              visible = true,
              properties = {}
            },
            {
              id = 40,
              name = "emptyslot2",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {}
            },
            {
              id = 44,
              name = "fullslot2",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 386,
              visible = true,
              properties = {}
            },
            {
              id = 41,
              name = "emptyslot3",
              type = "",
              shape = "rectangle",
              x = 68,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {}
            },
            {
              id = 45,
              name = "fullslot3",
              type = "",
              shape = "rectangle",
              x = 68,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 386,
              visible = true,
              properties = {}
            },
            {
              id = 42,
              name = "emptyslot4",
              type = "",
              shape = "rectangle",
              x = 92,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 390,
              visible = true,
              properties = {}
            },
            {
              id = 46,
              name = "fullslot4",
              type = "",
              shape = "rectangle",
              x = 92,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 387,
              visible = true,
              properties = {}
            },
            {
              id = 54,
              name = "4slotweapon1",
              type = "",
              shape = "rectangle",
              x = 56,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 56,
              name = "3slotweapon1",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 55,
              name = "3slotweapon2",
              type = "",
              shape = "rectangle",
              x = 68,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 51,
              name = "2slotweapon1",
              type = "",
              shape = "rectangle",
              x = 32,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 52,
              name = "2slotweapon2",
              type = "",
              shape = "rectangle",
              x = 56,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 53,
              name = "2slotweapon3",
              type = "",
              shape = "rectangle",
              x = 80,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 47,
              name = "1slotweapon1",
              type = "",
              shape = "rectangle",
              x = 20,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 48,
              name = "1slotweapon2",
              type = "",
              shape = "rectangle",
              x = 44,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 49,
              name = "1slotweapon3",
              type = "",
              shape = "rectangle",
              x = 68,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            },
            {
              id = 50,
              name = "1slotweapon4",
              type = "",
              shape = "rectangle",
              x = 92,
              y = 54,
              width = 24,
              height = 24,
              rotation = 0,
              gid = 389,
              visible = true,
              properties = {
                ["animationspeed"] = 0
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 6,
          name = "pausemenu",
          class = "Gui.Menu",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["backaction"] = "unpauseGame"
          },
          objects = {
            {
              id = 76,
              name = "",
              type = "",
              shape = "rectangle",
              x = 136,
              y = 112.5,
              width = 208,
              height = 117,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#80c52021",
                ["linecolor"] = "#ffff6161",
                ["roundcorners"] = 8
              }
            },
            {
              id = 8,
              name = "name",
              type = "",
              shape = "text",
              x = 192,
              y = 54,
              width = 96,
              height = 18,
              rotation = 0,
              visible = false,
              text = "PAUSE",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 72,
              name = "Resume",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 121.5,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Resume",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "unpauseGame"
              }
            },
            {
              id = 73,
              name = "Restart checkpoint",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 148.5,
              width = 144,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Restart checkpoint",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "restartStageCheckpoint"
              }
            },
            {
              id = 93,
              name = "Restart stage",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 175.5,
              width = 144,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Restart stage",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "restartStage"
              }
            },
            {
              id = 75,
              name = "Quit",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 202.5,
              width = 144,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Quit",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "quit"
              }
            },
            {
              id = 86,
              name = "Debug",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 229.5,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Debug",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "openMenu",
                ["guipath"] = "gameplay.debugmenu"
              }
            },
            {
              id = 74,
              name = "",
              type = "Gui.Cursor",
              shape = "rectangle",
              x = 152,
              y = 130.5,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 409,
              visible = true,
              properties = {
                ["alignx"] = -1,
                ["aligny"] = 0
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 15,
          name = "debugmenu",
          class = "Gui.Menu",
          visible = false,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["backaction"] = "closeMenu"
          },
          objects = {
            {
              id = 82,
              name = "",
              type = "",
              shape = "rectangle",
              x = 112,
              y = 54,
              width = 256,
              height = 180,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#ffc52021",
                ["linecolor"] = "#ffff6161",
                ["roundcorners"] = 8
              }
            },
            {
              id = 83,
              name = "name",
              type = "",
              shape = "text",
              x = 192,
              y = 18,
              width = 96,
              height = 18,
              rotation = 0,
              visible = true,
              text = "DEBUG",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 85,
              name = "Show hitboxes",
              type = "",
              shape = "text",
              x = 160,
              y = 72,
              width = 192,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Show hitboxes",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 91,
              name = "game ticks per second",
              type = "",
              shape = "text",
              x = 160,
              y = 126,
              width = 192,
              height = 18,
              rotation = 0,
              visible = true,
              text = "game ticks per second",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 89,
              name = "Refill player",
              type = "Gui.Button",
              shape = "text",
              x = 128,
              y = 99,
              width = 224,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Refill player",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "refillPlayers"
              }
            },
            {
              id = 84,
              name = "drawbodies",
              type = "Gui.Slider",
              shape = "text",
              x = 128,
              y = 72,
              width = 32,
              height = 18,
              rotation = 0,
              visible = true,
              text = "OFF",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["configkey"] = "drawbodies",
                ["increment"] = 1,
                ["max"] = 10,
                ["min"] = 0
              }
            },
            {
              id = 90,
              name = "drawbodies",
              type = "Gui.Slider",
              shape = "text",
              x = 128,
              y = 126,
              width = 32,
              height = 18,
              rotation = 0,
              visible = true,
              text = "60",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["configkey"] = "fixedupdaterate",
                ["increment"] = 10,
                ["max"] = 100,
                ["min"] = 10
              }
            },
            {
              id = 87,
              name = "Close menu",
              type = "Gui.Button",
              shape = "text",
              x = 132,
              y = 202.5,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Close",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "closeMenu"
              }
            },
            {
              id = 88,
              name = "",
              type = "Gui.Cursor",
              shape = "rectangle",
              x = 100,
              y = 81,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 409,
              visible = true,
              properties = {
                ["alignx"] = -1,
                ["aligny"] = 0
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 13,
          name = "input",
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
              id = 67,
              name = "joystickdirection",
              type = "",
              shape = "polygon",
              x = 55,
              y = 243,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 0, y = -4.5 },
                { x = 16, y = 0 },
                { x = 0, y = 4.5 }
              },
              properties = {
                ["color"] = "#ffffffff",
                ["linecolor"] = "#ffc0c0c0"
              }
            },
            {
              id = 60,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 48,
              y = 251,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 281,
              visible = true,
              properties = {}
            },
            {
              id = 61,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 120,
              y = 260,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 297,
              visible = true,
              properties = {}
            },
            {
              id = 68,
              name = "attackbuttondown",
              type = "",
              shape = "rectangle",
              x = 120,
              y = 260,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 298,
              visible = true,
              properties = {}
            },
            {
              id = 62,
              name = "sprintbutton",
              type = "",
              shape = "rectangle",
              x = 136,
              y = 242,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 311,
              visible = true,
              properties = {}
            },
            {
              id = 69,
              name = "sprintbuttondown",
              type = "",
              shape = "rectangle",
              x = 136,
              y = 242,
              width = 16,
              height = 16,
              rotation = 0,
              gid = 312,
              visible = true,
              properties = {}
            },
            {
              id = 63,
              name = "Move",
              type = "",
              shape = "text",
              x = 80,
              y = 234,
              width = 20,
              height = 18,
              rotation = 0,
              visible = true,
              text = "MOVE",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 64,
              name = "Attack",
              type = "",
              shape = "text",
              x = 144,
              y = 243,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "ATTACK",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 65,
              name = "Sprint",
              type = "",
              shape = "text",
              x = 160,
              y = 225,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "SPRINT",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 11,
          name = "gameover",
          class = "Gui.Menu",
          visible = false,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 77,
              name = "",
              type = "",
              shape = "rectangle",
              x = 136,
              y = 90,
              width = 208,
              height = 90,
              rotation = 0,
              visible = true,
              properties = {
                ["color"] = "#80c52021",
                ["linecolor"] = "#ffff6161",
                ["roundcorners"] = 8
              }
            },
            {
              id = 79,
              name = "Restart checkpoint",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 99,
              width = 144,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Restart checkpoint",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "restartStageCheckpoint"
              }
            },
            {
              id = 92,
              name = "Restart stage",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 126,
              width = 144,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Restart stage",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "restartStage"
              }
            },
            {
              id = 80,
              name = "Quit",
              type = "Gui.Button",
              shape = "text",
              x = 184,
              y = 153,
              width = 64,
              height = 18,
              rotation = 0,
              visible = true,
              text = "Quit",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["action"] = "quit"
              }
            },
            {
              id = 81,
              name = "",
              type = "Gui.Cursor",
              shape = "rectangle",
              x = 152,
              y = 108,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 409,
              visible = true,
              properties = {
                ["alignx"] = -1,
                ["aligny"] = 0
              }
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
