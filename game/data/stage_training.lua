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
  nextobjectid = 66,
  properties = {
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
              data = "eJxNkstOlEEUhL+J3aeXuuAFjBdEl65Y4MInEBkuLklIjPHG1iXeEn0DRAZ8Au/KwsS4GhlGZ8WjgDoOiSm7/gyrv/v8p+pU1el2wPeAMwV+BcyWer9Y4FyBG/5eKvAyoBcwV+BvwJ+ACwWOAtoBPwM2XNuLyjdVoOtvJ6AfMDT2IGCywCDgMGBkHs3+bS7NV892wGbAesB5z9cMadJZ/V33d9y7G/DDOhZL1bdpXN+aGg+71iP8fBn7GZp3aN/X7Vfnxrv+vYjqo9EsncpMc//7cr5tax16XsfYdeN61iZdI+civ8Jt+77kfPrGbh2btVDqDre8U/EIO+sc5bNn7lfWovrIOR7Zg/Q1vdqHNEyad8NaxH/WGeiNdJ3BwNiBefR9neBehjcJ7ma477M499w/l2rtbRr/f+f7aobTGfaBVgueFXhextziVM+HBJ8SfEywlODxsfujBA+A5QyfC+yUip1PcC3DYoLbufpt6qdUt8+JDJc9Q3y3MlzNcKIFXzNcyTUbeZo238NU+fRubuaq6aRnaGfiXCnwLcMTZ/Q+Vbz6tDf16b01mmZy3ZXe75p1yNsXaj7iUd+dPM5PvE9T1b/gfFX/B6W4kr4="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJxdk8+OjFEQxX86VXUXRLwDRmtPYGHjASR0m2lWk7ESDBELW4I1YWP+6OmlHSEZ+1kwI3TiDXiHMcyYRE6qOiMWlXtv3apzTp37fVsB3QaDBlcaTAKWA061XPsNdqtm2OBig18BGw5LDica7Af0GnwNWAl4GfApYBxwvMEo8q5bHIqPAa8DtgMGkbk17RvsBfwO+Fk94l8N2AnYjORTj/StVaxWz5+6Xy5uxVLhS+OX0qfYiry71LJfOdVohlFhTApXNdvlx7j6ZkrzyZa6TpcXml286putPvkmDbpbqfxeadB+iqu9Qv7vlB55dab8lyfDwhz+xydczSG/ZussP3XW3MKbaxmvIkO6tEpbt7ik43Pk205qLuH0Sle/ZlP+lsOi5zqwzMsT9Yl3s3BGdRbf7j++H3HoOcwDNwtH8dbgtmcs1nnKsV/ea467HXjh8A14ZLBuMDRwh2vAe4PrDh8MnhXHO0vvZ9rB3ZzBDc/5zzo8dbjXgXOe3jwo3OcO3y3/Ab173+CJwQ/LOn0z5x04lNwPLb8r1V22g5z8kS/iWiAx9WbqP+xw1OGYp0dTjvtkTnOLW+9/x2HcybneWPoknqsOjy1zqrngya0ZpVNvLIy/C3WLQw=="
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
              data = "eJztjckJQkEQRN/hT3UiCqLhCMagZmEQ4kFcInA5qCH4FTUYVxAFaWbEk96FX9AUxeuubhgMBJ0MVhk0A7RDdJ9W8mXi7p4XKZcNroK94Jl8LTgIagZjwUiwFVQssoegL7grcv9ft9i1EdzSvXcNBVWL3blgl3LJIjsGOAeYC2aCU4Cp4BI+nd3E38xvfDx/00Rx16f3Y69QIf5YL3GdLSI="
            },
            {
              x = 16, y = 16, width = 16, height = 16,
              data = "eJztjckJQmEQg7/Dm0wjgliOuGEJvjLsQVxwKcEF1Bpc0FrcBT3I4/9BT94FA2ESEjKpQWrQMJgnb2Z+mcAiMvPNBEoON8FasBXUHQoONYeyoCu4C/aCa+RIodMX5ByegqrDUJB32CnoR8zLHvRFYXMVdfarJxgIDgYTwVjhngyOFnx2LwYbQdGh4tAyOH/kM/EVnbg/jWzb9/4ff/CDeAFAqizO"
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
          y = 288,
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
          id = 10,
          name = "start",
          class = "Room",
          visible = false,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 53,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 240,
              y = 144,
              width = 480,
              height = 288,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            }
          }
        },
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
            ["cameraboundary"] = { id = 53 },
            ["donewhenenemiesleft"] = -1,
            ["music"] = {
              "../ccdata/music/Ooolin Poolin Oy intro.ogg",
              "../ccdata/music/Ooolin Poolin Oy loop.ogg"
            }
          },
          objects = {
            {
              id = 17,
              name = "training-stone",
              type = "training-stone",
              shape = "rectangle",
              x = 560,
              y = 200,
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
              x = 656,
              y = 256,
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
              x = 640,
              y = 136,
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
              x = 768,
              y = 256,
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
              x = 744,
              y = 128,
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
              x = 856,
              y = 192,
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
              x = 560,
              y = -24,
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
              x = 656,
              y = 32,
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
              x = 640,
              y = -88,
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
              x = 768,
              y = 32,
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
              x = 744,
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
              x = 856,
              y = -32,
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
              x = 328,
              y = 416,
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
              x = 512,
              y = 464,
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
              y = 432,
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
              x = 808,
              y = 440,
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
              x = 328,
              y = 368,
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
              x = 512,
              y = 416,
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
              y = 384,
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
              x = 808,
              y = 392,
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
              x = 520,
              y = 632,
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
              x = 520,
              y = 632,
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
              y = 416,
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
              x = 640,
              y = 464,
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
              y = 368,
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
              x = 640,
              y = 416,
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
              x = 448,
              y = 472,
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
              x = 448,
              y = 440,
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
              x = 304,
              y = 416,
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
              x = 304,
              y = 448,
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
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 12,
          name = "missilerange",
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
              id = 57,
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
          properties = {},
          objects = {
            {
              id = 58,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 480,
              y = 0,
              width = 480,
              height = 288,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 14,
          name = "racetrack",
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
              id = 59,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 0,
              y = 288,
              width = 960,
              height = 288,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
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
      visible = true,
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
