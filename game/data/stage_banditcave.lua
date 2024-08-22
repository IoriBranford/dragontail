return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 4,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "caves",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 51,
      image = "tilesets/caves/caves.png",
      imagewidth = 1632,
      imageheight = 1536,
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
      tilecount = 2448,
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
      id = 2,
      name = "floor",
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
          x = 0, y = 0, width = 20, height = 12,
          data = "eJzlkeENRCEIg/3jwupK6kroNPders19YYUzISjQArWU/zqnltIeu4/N+n1f2Fb8vS/EHB+KvxbyA8b6hZj7DPFM1Jpnwof8Vl2kvgfcQ++D3r6/HF3mnTOuq7bXnz7GNsyzVLMU587eaaf8FSZkHRyeeQlnbTPOO1szzhTYd4DbmpFnIjcTxt45a2DNPbdxnM3zb/T3H4W4zD3A47kbcPxz51rStEG3D2NJeXs="
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJzlktENxCAMQ/lh4cBKlJXgpjnQ+UkGdYOrFJGQxLFDU/qvr+SUPsv6spF/8SOfuOazbp9tWSgO9ey6qXjoBG/KL+rtun/kV8Mp6p+G24xTt1xTHh7xkqMXHtU04Q+bxQkWXFwz/ezD51S7L4bnmNPmuq57F+3a91CMFsdDd7G+yOdeeVveih2B6bVob7LHuPgceN5v3Q0jbEdheTC5c84jn7yneviP0A72zn0BoQt00Q=="
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJzlktENxCAMQ/lhYcJKhJUC01yri9VXdBtcpaghteM4pZT/elYtZdTvu10Reb7zWZ/vd+5X7IwFzh09MeJ71ixzR5+NmifHjlzcyOjJ65hJuKhvH45cXhZwkRjL804cvQ3gVHfoG84OXfoM7FTetCeDvjSI2wjtrGO36iEt+miYbeNfiiN+QFd+7eCto7c8ylfD7uaPPvLM2QN47W9A1w4O9z3rc99Ua5jvAzeze20="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 1,
      name = "wall",
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
          x = 0, y = 0, width = 20, height = 12,
          data = "eJztx9kJACAQA9G4akUe/TfgUZLTgwv+GHiESUHKSE4/MLGwHVomBRii3XdBRUN36L+/lzsL7RUt"
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJztx9kJACAQA9G4akUe/TfgUZLTgwv+GHiESUHKSE4/MLGwHVomBRii3XdBRUN36L+/lzsL7RUt"
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJztx9kJACAQA9G4akUe/TfgUZLTgwv+GHiESUHKSE4/MLGwHVomBRii3XdBRUN36L+/lzsL7RUt"
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Object Layer 1",
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
