return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 7,
  nextobjectid = 4,
  backgroundcolor = { 170, 150, 132 },
  properties = {},
  tilesets = {
    {
      name = "mountains",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 42,
      image = "tilesets/mountains/mountains.png",
      imagewidth = 1344,
      imageheight = 2112,
      objectalignment = "unspecified",
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
      tilecount = 2772,
      tiles = {}
    },
    {
      name = "rose-winged-main",
      firstgid = 2773,
      class = "",
      tilewidth = 80,
      tileheight = 80,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "sprites/player/rose/winged-main.ase",
      imagewidth = 80,
      imageheight = 80,
      objectalignment = "bottom",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 24
      },
      grid = {
        orientation = "orthogonal",
        width = 80,
        height = 80
      },
      properties = {},
      wangsets = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 1,
      name = "level1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 0, y = 0, width = 15, height = 9,
          data = "eJxNkNEJxDAMQwVe85pxchmnzoRFoAf+KKojW5bVJd2S3pJ2/k/qif+SOj3GFW6FX+HoQ/NX0hO+U98gH7Nv5vFCP7N78B3dHf4Jt4efHl64Dd0zePad4e8On9Y2Rw5+N5rzG7daCw9TAw/M2Rs12kb2kaE16bEmuuSODjlzH1lwl2v/G9nDzpkzt+LzA4ZCTBI="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 2,
      name = "level2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 0, y = -9, width = 15, height = 9,
          data = "eJzljtkNwzAMQx/Aidok07RppsnRaXJN0xy7BARkwL/5rgHCz5REC/7rPARPQSEob3AleAneglrwCc2CKfwlUxe+uRG04fWCITLMaTaXa76d/RWM0ee381Kf2RlpB+/jPyzXVsFPsAl2wXGDT8EFMEgokA=="
        },
        {
          x = 0, y = 0, width = 15, height = 9,
          data = "eJztxssRgkAAQLHM8IBq5FONgv33YQ174WROmaKYYxn4Gq/YYo9j4Ge84xNX3AP/5s8zfqhSCPU="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 5,
      name = "level3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 0, y = -18, width = 15, height = 9,
          data = "eJztjMkJgAAQAwemIq9qvKrx6katUBZW8OvHl4FhQ8IGfn2hQiiFSqhf+EZohU7ohSE5hD3z88GcefhRmDJbhDU3wt+/T6KLG9ubcAGgkBJ/"
        },
        {
          x = 0, y = -9, width = 15, height = 9,
          data = "eJzlydkJQlEUA8CBE7Uat2pcnliOluNWjVsv8uA2cL8NBIbkUlyLW3EvDq2jz20f/2Nxah2/R/EsXsW7+HT4W1RImIRph2dhHhZhGVYdXodN2IZd2Hd4iL/LD4/XHwY="
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
          name = "RoseWinged",
          type = "RoseWinged",
          shape = "rectangle",
          x = 128,
          y = 144,
          width = 80,
          height = 80,
          rotation = 0,
          gid = 2773,
          visible = true,
          properties = {
            ["propertiestable"] = "database/players-properties.csv"
          }
        }
      }
    },
    {
      type = "group",
      id = 3,
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
          id = 4,
          name = "start",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = -1,
            ["sequence"] = "",
            ["titlebarcuecard"] = ""
          },
          objects = {
            {
              id = 1,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = -160,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -96 },
                { x = 0, y = 32 },
                { x = 480, y = 32 },
                { x = 480, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -112,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 2,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = 64,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -96 },
                { x = 0, y = 32 },
                { x = 480, y = 32 },
                { x = 480, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -208,
                ["linecolor"] = "#80ffffff"
              }
            }
          }
        }
      }
    }
  }
}
