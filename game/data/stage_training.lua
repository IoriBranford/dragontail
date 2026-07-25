return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 15,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 9,
  nextobjectid = 54,
  properties = {
    ["pausemenu"] = "gameplay.trainingmenu",
    ["runphase"] = "Dragontail.GamePhase"
  },
  tilesets = {
    {
      name = "tallstone",
      firstgid = 1,
      filename = "sprites/weapons/tallstone.tsx",
      exportfilename = "sprites/weapons/tallstone.lua"
    },
    {
      name = "rose-main",
      firstgid = 2,
      filename = "sprites/player/rose/rose-main.tsx",
      exportfilename = "sprites/player/rose/rose-main.lua"
    },
    {
      name = "desert",
      firstgid = 3,
      filename = "tilesets/sandy/desert.tsx",
      exportfilename = "tilesets/sandy/desert.lua"
    },
    {
      name = "tree2C_ss_obj",
      firstgid = 2073,
      filename = "sprites/grassland/tree2C_ss.tsx",
      exportfilename = "sprites/grassland/tree2C_ss.lua"
    },
    {
      name = "tree2C_ss_leaves",
      firstgid = 2074,
      filename = "sprites/grassland/tree2C_ss_leaves.tsx",
      exportfilename = "sprites/grassland/tree2C_ss_leaves.lua"
    },
    {
      name = "spikefruit-onground",
      firstgid = 2075,
      filename = "sprites/weapons/spikefruit-onground.tsx",
      exportfilename = "sprites/weapons/spikefruit-onground.lua"
    },
    {
      name = "spikefruit-hanging",
      firstgid = 2076,
      filename = "sprites/weapons/spikefruit-hanging.tsx",
      exportfilename = "sprites/weapons/spikefruit-hanging.lua"
    },
    {
      name = "peppers-on-plant",
      firstgid = 2077,
      filename = "sprites/items/peppers-on-plant.tsx",
      exportfilename = "sprites/items/peppers-on-plant.lua"
    },
    {
      name = "pepper-plant",
      firstgid = 2078,
      filename = "sprites/items/pepper-plant.tsx",
      exportfilename = "sprites/items/pepper-plant.lua"
    },
    {
      name = "tree1a-crown",
      firstgid = 2079,
      filename = "sprites/sandy/tree1a-crown.tsx",
      exportfilename = "sprites/sandy/tree1a-crown.lua"
    },
    {
      name = "tree1a-trunk",
      firstgid = 2080,
      filename = "sprites/sandy/tree1a-trunk.tsx",
      exportfilename = "sprites/sandy/tree1a-trunk.lua"
    },
    {
      name = "tree1b-trunk",
      firstgid = 2081,
      filename = "sprites/sandy/tree1b-trunk.tsx",
      exportfilename = "sprites/sandy/tree1b-trunk.lua"
    },
    {
      name = "tree1b-crown",
      firstgid = 2082,
      filename = "sprites/sandy/tree1b-crown.tsx",
      exportfilename = "sprites/sandy/tree1b-crown.lua"
    }
  },
  layers = {
    {
      type = "group",
      id = 7,
      name = "tilelayers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = -16,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 30,
          height = 15,
          id = 3,
          name = "sand",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["z"] = -5
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = -16, y = -16, width = 16, height = 16,
              data = "eJxjYBgFo2AUMIww8I2VgWE1GwMDAA6RAa0="
            },
            {
              x = 0, y = -16, width = 16, height = 16,
              data = "eJzty7sNAlEMRNET2K8hYqpAtAGdkNMCsBKQkVMA1fBJELL2ISog2ytdjeyxmZiY8Cfuya7xytF949DnR7JNnv3ma93UrvprsgiOwTpZJecYsxzary+rK08962cZzJJ5cgluwSZ5Bx981Rtn"
            },
            {
              x = 16, y = -16, width = 16, height = 16,
              data = "eJxjYBgFo2AUMJAJVrExMPxiJT/8NrMwMBxmZWCYRaYZrSwQM6aTqR8AuWgFqg=="
            },
            {
              x = -16, y = 0, width = 16, height = 16,
              data = "eJzNkisOQkEMRY9o70hCwg7Q4NkAnoBGY55AIQmesAY8BscnSCyC3TzBC4hZwXQM15+0vacQy1YwtyAMDAUDr+MnlfyuYv+Z4KUYexI8HbogfzNYGrSFvAskWDvsDRapfPY0Ze+Nw7mwv5Ggl3LvK4dLIf92ODo8DO4Gm4D/saBN0E9wCPi/Cr6e7/hU/N+/5Ae+YBVb"
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJytkktL1lEQxn+LubirpG+QBNUnaNGi6z5801pkixalqRUUXXZdCKIgWkaU5RdIy7wkQbgTTch9UBLWMgIzQyyGmbc3WnfgcP4z53nmeWb+Z1DhiMCYwITAuECf5j6tmYs9KbBJ4ZrADYEPAvcUTjrcd+gSOKswUueowIDCc8nvW9LChN6MpubN0guNXs3aY/UdXo4KdEsr38SGtzO1Gw4Ng3WDU5U75vDI0m/EzXPBYMjgocFjg06BhiT2qcGqwU6HTofvBmuWtbd78p5VD8Hpdtiq0F/xE4PDntorxVmoGqE3b7Bbs5/wMiXp62XFwXtg0FVa4Sf4Oxx+GOzy7O96zNLhjiQmNKP2Ns+aPQJzlpxmf9FP1J81OC5wSeGKwguBDs++Ande4a7AW0svy5L9jdR95L4K7HPY7+kl+O/rfcTMYoeP14FTaFNYFDjkcFnhRMzQYY/DdPmNOS5Jzj+4VzU1zikMC9yu+KDDAYfNDsMObwQuaovf5LY7rDlMKnzW5ETcb/BFU3vDYdTgm+bdisNq/PfCfjRYMvikMGjQY7DXYIsldtn4s6YNNhReGfyKNxHzc/jpWWNI8369MFN/cf9d7woX/+KCZm6xzv+9fgPGY4LS"
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJzNkr0JAmEQBQfZn1RsQezhmjBRMBMzE7MDQS62BbEGBUODQzAwEiuwAU20gRMRucACvr3EyWff8nh5C9pKmL3ATOEVvDF06DpsDLaW7g8cLgalwEHS/Z7DWGAi0PF0f6FQKNwMqoB/EjgKlAbvQId19lOgH+iu5m7wEFgG/Y/DXGEU9HcKK4VzcD+ZwbrBfqfBv39cG2T/A1+KHRiw"
            }
          }
        },
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 30,
          height = 15,
          id = 8,
          name = "grass",
          class = "",
          visible = false,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          encoding = "base64",
          compression = "zlib",
          chunks = {}
        },
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 30,
          height = 15,
          id = 4,
          name = "wall",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["z"] = -3
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJzty7ENglAABuGP/80juAGDiGxAxThWjmPFREZD8gZ4WhKuuVxxa0HoQsKna+tx//As9GEI13BJWy/13wpTuIc53NLWj/q/q3/l9ed3cuJAfAGlFw9o"
            }
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "players",
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
          id = 3,
          name = "Rose",
          type = "Rose",
          shape = "rectangle",
          x = 160,
          y = 136,
          width = 128,
          height = 128,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["facedegrees"] = 90,
            ["propertiestable"] = "database/players-properties.csv"
          }
        }
      }
    },
    {
      type = "group",
      id = 5,
      name = "rooms",
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
          id = 2,
          name = "training",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = -1,
            ["music"] = {
              "../../ccdata/music/Ooolin Poolin Oy intro.ogg",
              "../../ccdata/music/Ooolin Poolin Oy loop.ogg"
            }
          },
          objects = {
            {
              id = 17,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 56,
              y = 176,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 18 }
              }
            },
            {
              id = 11,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 160,
              y = 240,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 12 }
              }
            },
            {
              id = 33,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 168,
              y = 88,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 35 }
              }
            },
            {
              id = 13,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 296,
              y = 240,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 14 }
              }
            },
            {
              id = 34,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 288,
              y = 88,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 36 }
              }
            },
            {
              id = 21,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 416,
              y = 176,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 1,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 22 }
              }
            },
            {
              id = 18,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 56,
              y = -48,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 12,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 160,
              y = 16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 35,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 168,
              y = -136,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 14,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 296,
              y = 16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 36,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 288,
              y = -136,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 22,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 416,
              y = -48,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 240
              }
            },
            {
              id = 4,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = 32,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 0, y = 64 },
                { x = 32, y = 32 },
                { x = 448, y = 32 },
                { x = 480, y = 64 },
                { x = 480, y = 0 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -48,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 23,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 48,
              y = 124,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2075,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 24,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 416,
              y = 96,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2075,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 25,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 104,
              y = 100,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2075,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 26,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 368,
              y = 88,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2075,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 27,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 56,
              y = 84,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2080,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 29 },
                ["fruit2"] = { id = 30 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 28 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 43,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 240,
              y = 160,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2080,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 44 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 47,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 80,
              y = 224,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2081,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 48 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 49,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 392,
              y = 256,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2081,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 0 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 28,
              name = "",
              type = "",
              shape = "rectangle",
              x = 56,
              y = 36,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2079,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 44,
              name = "",
              type = "",
              shape = "rectangle",
              x = 240,
              y = 112,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2079,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 48,
              name = "",
              type = "",
              shape = "rectangle",
              x = 80,
              y = 176,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2082,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 50,
              name = "",
              type = "",
              shape = "rectangle",
              x = 392,
              y = 208,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2082,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 29,
              name = "",
              type = "item-spikefruit-hanging",
              shape = "rectangle",
              x = 40,
              y = 40,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2076,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 30,
              name = "",
              type = "item-spikefruit-hanging",
              shape = "rectangle",
              x = 72,
              y = 34,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 2076,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 68
              }
            },
            {
              id = 37,
              name = "",
              type = "",
              shape = "rectangle",
              x = 216,
              y = 80,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2078,
              visible = true,
              properties = {
                ["item"] = { id = 38 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 38,
              name = "",
              type = "",
              shape = "rectangle",
              x = 216,
              y = 80,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2077,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 1
              }
            },
            {
              id = 40,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 408,
              y = 80,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2081,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 42 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 45,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 440,
              y = 96,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2080,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 46 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 42,
              name = "",
              type = "",
              shape = "rectangle",
              x = 408,
              y = 32,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2082,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 46,
              name = "",
              type = "",
              shape = "rectangle",
              x = 440,
              y = 48,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2079,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 53,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 0,
              y = 0,
              width = 480,
              height = 288,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            }
          }
        }
      }
    }
  }
}
