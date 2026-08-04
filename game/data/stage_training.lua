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
  nextlayerid = 15,
  nextobjectid = 77,
  properties = {
    ["hudfile"] = "gui/hud_training.lua",
    ["pausemenumap"] = "gui/menu_pause_training.lua",
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
      name = "tree2b-trunk",
      firstgid = 2081,
      filename = "sprites/sandy/tree2b-trunk.tsx",
      exportfilename = "sprites/sandy/tree2b-trunk.lua"
    },
    {
      name = "tree2b-crown",
      firstgid = 2082,
      filename = "sprites/sandy/tree2b-crown.tsx",
      exportfilename = "sprites/sandy/tree2b-crown.lua"
    },
    {
      name = "tree2a-crown",
      firstgid = 2083,
      filename = "sprites/sandy/tree2a-crown.tsx",
      exportfilename = "sprites/sandy/tree2a-crown.lua"
    },
    {
      name = "tree2a-trunk",
      firstgid = 2084,
      filename = "sprites/sandy/tree2a-trunk.tsx",
      exportfilename = "sprites/sandy/tree2a-trunk.lua"
    },
    {
      name = "tree1b-trunk",
      firstgid = 2085,
      filename = "sprites/sandy/tree1b-trunk.tsx",
      exportfilename = "sprites/sandy/tree1b-trunk.lua"
    },
    {
      name = "tree1b-crown",
      firstgid = 2086,
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
      offsety = 0,
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
          name = "desert_ground",
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
              data = "eJxjYBgFo2AUMAwxcIyVgWEVG2l6vrEyMPxgZWD4zsrAcISVgeEMGwMDAKR/Bgs="
            },
            {
              x = 0, y = -16, width = 16, height = 16,
              data = "eJztzjtuAkEQhOEvme6TgCVzHCzAR1uLh1MLuAUJEHAbMERoxEgbcoGtpEr9d5eaQYMGeaOucCvcC7t45Ufp+bWwjZ5Xrzt19l/YB6fgN/hOLsFfY3X3UD2YJF/JZzJOVsFPsA42LR+Deb7yo7Fb6683taf2j5JFMkumyTlYBl374yN5AlZ9I5g="
            },
            {
              x = 16, y = -16, width = 16, height = 16,
              data = "eJztjjsKgEAMBadJchDRI3k4O0t/pxCt9DyrgiBL1lqw3mleeJDhQSaT4SeHwCV+rwKnwKjQpO6LyqBTGBQmhdogqHfRs3x4SoNboTDY0v+u0KrnLNAnfxDPuPHd9wBqqhUk"
            },
            {
              x = -16, y = 0, width = 16, height = 16,
              data = "eJydk1lKg0EQhL+XqT5I4oKexqCip9FTiHHBeAA9hksWPM2foESQpjuQt/RvwbwMU13V1T1Qx0DwIBgaDAxOrQcZuBZcGnSChWCqfvwrwZfgXqH/05M/EvwKDtL74z/0Dw0+FD2si/xlg1WDl/T+qfA+srquZ3VswfUZnFtd/yQ1Pfs9iwy9xkR1/W9FZhcWXs4s6vXJ/VlwZNHHOj3twttWbk+Zg/vo0sMuDHNO/n6ce3OX+zcp6L8KbhrMBe85t32DmeKugtsWNTxD/zur3MFK/9s1ugZLxXHvPsMqxpnjRntz/gBs1z/c"
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJylkjlulEEUhD9Ev9chBNyAxWBOgAQEnADj8UIICbIslpSUJYCQzBiP7RMAZs0Q0eDxmDkN2zCWUNH1C+cErd5e1auq7l7Cl4STFX4kzNW2n61wusJ1z+crvEgYJsxX+J3wK+FshYOEXsLXhHWf7WXjO1dh4LmfMEqYGPstYabCOOF7wtQ86v3TXOqvmq2EjYS1hDPurx7SpLXqB67vu3Y3Yd86lmrTt2HcyJo6D7vWI/xC/ednYt6JfV+zX60777p7ns1Hp1k6lZn6/vXlfHvWOnG/vrFrxg2tTbqmzkV+hdvyftn5jIzdPNRrsbY33PSbikfYOecon0Nzb1uLzqfO8cAepK+r1XtIw4x5161F/P+LP+UM9ccGznBs7Ng8285b+S167oY491w/X+BVgdcF7kZb73it+Xa0te41dkrr8dJ39wLeFnhf4F2B5QKPDu0fFrgP3Ah4UuFpbdiFAlcDlgqsRvPbnR/XuX2eCLgZ8DngQ4WPFa4EHD0CnwIuR8tGni6Y70FpfPp3t6JpkEbpWYlW9yzgYsDjAncC3pR2fizau+tvKL9O06Vob6X//wcFCpfY"
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJydkr9OVGEQxX9uvpkv0cRY+AauuuATYKKFbyC7gbVE7IhYaGELUWotZflrYkEH0UQrGgoEo5v4BvIOCwqYmJOZGxNLi8m9M989Z8453z106FToVXhQYegwcLhZ49mtcJrf9Cvcr/DTYc9g2aBd4bfDeIVvDisObxw+O2w6XKuw7nHWyR2qfYcth5FDz2O2ofcKZw6/HI4To/2rDicOBx77hJG+jazVxJzn+SB3q5aTXxq/pj7VocfZZA28ZvpGHtaTY5i8+maUeWwm7kZqvl5D11hmIe/aK9xU4pSbNOhsJednqUHvDa/eVcr/JPUoq1uZvzLpJ2f/n33ilQ/lNZW98lQv3+KbrlFrHiVdekpbJ3dJxxePux2mL/GMp65uetP8f/FN7sp8lFk29yutwp1m386s5HeQc+UgH48NdgrMGzyx6LdLzNQ3pb5XIkftaqeH1xUuGnwHXhT4WKBfwAxmc6b+tsHLAu9LeFXu8vC2FdjpAnMW/icMXhk8a8Edg4UCnwq84y9H89+Le9fgKHnl754BF+BDgcUSGV01eGQwY3DX4p9THtr1EPhR4s6Fv2Rw2eCKRcbdAksFngNPWzHXHYnjD1RBjAE="
            },
            {
              x = 32, y = 0, width = 16, height = 16,
              data = "eJxjYKAMHGWlTL8vG2X65SnUH8Y2sO4/zEpZGJ5noywMlNkpC4OzFNqvxU5ZGKqyMzBUU6D/DIXu12ZnYNCgQP9PNsrCP4ydgWElGwPDLzLTEABhgAvq"
            },
            {
              x = -16, y = 16, width = 16, height = 16,
              data = "eJztzqENg1AARdFj/vuTkI7UcboFDsECbbcgwbBMQaBQeEA2HH+TyzGvMIQu9OFRaerBGEPhV5gLY3hW1jjtHdrCEqYL/f7yCd+L/e3mT2zSfw07"
            },
            {
              x = 0, y = 16, width = 16, height = 16,
              data = "eJztzj1KQ2EQheGHMPNdXIaFK7C1trQRUwsiqIhZQwhapwnps4D4A6KViGvQ1kWosQ4f9wYr7YUceGFmzsxhhsEoeMWsxxsug4PgPLkLboOL5CrYTvrBINt5v2EYPAY7yUvyHuwl4+QQRw3HyW6PJ2wkm8lzstXwXdqMh+C+Y1WfJKcddVY5yx/vI/mqvxRuCp/JdWGR7Ddt/qTzV169qdT+N81Lu1uZ/rG31lr+sZaDlyk9"
            },
            {
              x = 16, y = 16, width = 16, height = 16,
              data = "eJztzjtKRFEQBNDjo/teMHIhrsNQMBgDo0ETf8GsQXQJopFgZDiOIGazAHUz/rJB5HGfYDS5MAVFUVXdTU+S247T5D6YBaNgL7mIlk2S7WQzOcBG8lx4LWx13GGMRfAd7FfWk26N+bAzr82fB2fBbuWmcJyNj8FTND3Kxt+uzw8HPUkWhbf+38K0NP1I3rP5Xr+Sl8JOZVS5TD7/9A/FUlwP92cDr3L5/Aor+If4ARRSKGM="
            },
            {
              x = 32, y = 16, width = 16, height = 16,
              data = "eJz7ysbAMJ+NgSGMjYEs8JGVgeELKwPDJjL1n2AlT98oGAWjgIFiAAClrQVx"
            }
          }
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
              data = "eJztzjFOglEQReGPmfWgxLAGNqESib0NrEOgt9F9CD2NLsfGaCY+khdjTPxL4kledc/c+9bY4gZTrHHb3gJ7LBPBKIjgY8RdMssvr253uGhu5b3/mJwF58EkGAcPySq5x6ZtV1+5lff+S3IVXAfz4DI4JE/tftp2q6/cynv/vf7/jbfkNXnudqvvJ/c3+t3q+ytDd48M3T0ydPcfJ8Enu2kkaA=="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJzti8kJgEAUxTKxHpd+XEqwIiuyIm96GJGPzElvYuAdEngKewKEJHju3qLPFRedUAuN0Jq91KIv4T8JvTAIo9lLLfoa/k/YXv5/fvgIByHWDT4="
            }
          }
        },
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 30,
          height = 15,
          id = 11,
          name = "onwall",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["z"] = -2
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = -16, y = -16, width = 16, height = 16,
              data = "eJxjYBgFo2AUMAwxsJiVgYGZjXy951gZGJzZGBgARSUCdg=="
            },
            {
              x = 0, y = -16, width = 16, height = 16,
              data = "eJztzLERQEAURdFj+H+rUq0SUAZ60IcZwUrNyCR7khu9R9M0frImS9YOyRS1X42Fq3AmW7AHc9I9v31yxPv+BouECRk="
            },
            {
              x = -16, y = 0, width = 16, height = 16,
              data = "eJztzcENglAUAMG5vGdVGvowsR9sgx4QsApLEGvwDCGhgf/Dkb1PlrK64JXMwTcLMdrkkQzB/1Lu70kf/IJbxX9Ilt1fK/zWM3kHTaX/BGMyVfqzMwe1Ak+UDwA="
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJztz7EJwlAQgOGvuXttiuAoLuBCmcQVxBmsDC5j4Q6CIuEhaYSgSWWRD648/ru2sE26wia5BdegSx7BKziGSffynqZwCPrknDy/7I1OQZvskn2ard5cu7X5S+9T/fGyoDta0lyt/IkBZroR9Q=="
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
          x = 480,
          y = 272,
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
          name = "trainingobjects",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["music"] = {
              "../ccdata/music/Ooolin Poolin Oy intro.ogg",
              "../ccdata/music/Ooolin Poolin Oy loop.ogg"
            }
          },
          objects = {
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
                { x = 0, y = -32 },
                { x = 0, y = 240 },
                { x = 160, y = 80 },
                { x = 288, y = 80 },
                { x = 320, y = 48 },
                { x = 448, y = 48 },
                { x = 480, y = 80 },
                { x = 512, y = 48 },
                { x = 928, y = 48 },
                { x = 960, y = 80 },
                { x = 960, y = -32 }
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
              id = 17,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 576,
              y = 240,
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
              x = 896,
              y = 192,
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
              x = 608,
              y = 160,
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
              x = 800,
              y = 248,
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
              x = 736,
              y = 144,
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
              x = 680,
              y = 200,
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
              x = 576,
              y = 0,
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
              x = 896,
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
              id = 35,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 608,
              y = -80,
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
              x = 800,
              y = 8,
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
              x = 736,
              y = -96,
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
              x = 680,
              y = -40,
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
              id = 23,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 392,
              y = 232,
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
              x = 368,
              y = 256,
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
              x = 400,
              y = 264,
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
              x = 408,
              y = 248,
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
              x = 384,
              y = 250,
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
              x = 336,
              y = 480,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2085,
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
              id = 63,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 808,
              y = 472,
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
                ["leaves"] = { id = 62 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 47,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 168,
              y = 472,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2085,
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
              x = 784,
              y = 496,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2085,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 50 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 28,
              name = "",
              type = "",
              shape = "rectangle",
              x = 384,
              y = 202,
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
              x = 336,
              y = 432,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2086,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 62,
              name = "",
              type = "",
              shape = "rectangle",
              x = 808,
              y = 424,
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
              x = 168,
              y = 424,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2086,
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
              x = 784,
              y = 448,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2086,
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
              x = 368,
              y = 206,
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
              x = 400,
              y = 200,
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
              x = 536,
              y = 648,
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
              x = 536,
              y = 648,
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
              x = 656,
              y = 480,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2085,
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
              x = 624,
              y = 504,
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
              x = 656,
              y = 432,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2086,
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
              x = 624,
              y = 456,
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
              id = 60,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 464,
              y = 504,
              width = 64,
              height = 48,
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
                ["leaves"] = { id = 61 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 61,
              name = "",
              type = "",
              shape = "rectangle",
              x = 464,
              y = 472,
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
              id = 64,
              name = "",
              type = "",
              shape = "rectangle",
              x = 504,
              y = 480,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2083,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 65,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 504,
              y = 512,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2084,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 64 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 70,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 240,
              y = 152,
              width = 480,
              height = 270,
              rotation = 0,
              opacity = 1,
              visible = false,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 10,
          name = "start",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["cameraboundary"] = { id = 70 },
            ["donewhenenemiesleft"] = -1
          },
          objects = {
            {
              id = 71,
              name = "missileentrance",
              type = "Trigger",
              shape = "polygon",
              x = 376,
              y = 208,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -568, y = 64 },
                { x = 56, y = 64 },
                { x = 56, y = -376 },
                { x = -568, y = -376 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "missilerange"
              }
            },
            {
              id = 72,
              name = "rockentrance",
              type = "Trigger",
              shape = "polygon",
              x = 568,
              y = 208,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -40, y = 64 },
                { x = 488, y = 64 },
                { x = 488, y = -376 },
                { x = -40, y = -376 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "rockgarden"
              }
            },
            {
              id = 73,
              name = "trackentrance",
              type = "Trigger",
              shape = "polygon",
              x = 472,
              y = 352,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -472, y = 0 },
                { x = -688, y = 352 },
                { x = 800, y = 352 },
                { x = 488, y = 0 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "racetrack"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 12,
          name = "missilerange",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["clearotherroom"] = "start",
            ["donewhenenemiesleft"] = -1
          },
          objects = {
            {
              id = 57,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 0,
              y = 18,
              width = 480,
              height = 270,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 74,
              name = "backtostart",
              type = "Trigger",
              shape = "polygon",
              x = 472,
              y = 232,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 8, y = 24 },
                { x = -24, y = 56 },
                { x = 8, y = 56 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "start"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 13,
          name = "rockgarden",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["clearotherroom"] = "start",
            ["donewhenenemiesleft"] = -1
          },
          objects = {
            {
              id = 58,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 480,
              y = 18,
              width = 480,
              height = 270,
              rotation = 0,
              opacity = 1,
              visible = false,
              properties = {}
            },
            {
              id = 75,
              name = "backtostart",
              type = "Trigger",
              shape = "polygon",
              x = 504,
              y = 232,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 8, y = 56 },
                { x = -24, y = 24 },
                { x = -24, y = 56 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "start"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 14,
          name = "racetrack",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["clearotherroom"] = "start",
            ["donewhenenemiesleft"] = -1
          },
          objects = {
            {
              id = 59,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 0,
              y = 288,
              width = 960,
              height = 320,
              rotation = 0,
              opacity = 1,
              visible = false,
              properties = {}
            },
            {
              id = 76,
              name = "backtostart",
              type = "Trigger",
              shape = "polygon",
              x = 528,
              y = 264,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -80, y = 80 },
                { x = -16, y = 80 },
                { x = 40, y = 24 },
                { x = -136, y = 24 }
              },
              properties = {
                ["action"] = "openRoom",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ff55ffff",
                ["room"] = "start"
              }
            }
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "notes",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
