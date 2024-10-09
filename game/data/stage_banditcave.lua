return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 200,
  height = 12,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 24,
  nextobjectid = 237,
  backgroundcolor = { 41, 58, 24 },
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
    },
    {
      name = "grassland",
      firstgid = 2449,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 64,
      image = "tilesets/grassland.png",
      imagewidth = 2048,
      imageheight = 1408,
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
      wangsets = {
        {
          name = "grass_corner",
          class = "",
          tile = -1,
          wangsettype = "corner",
          properties = {},
          colors = {
            {
              color = { 0, 255, 0 },
              name = "grass_lightgreen",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 0, 170, 0 },
              name = "grass_green",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 100, 100, 100 },
              name = "grass_grey",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 0, 85, 0 },
              name = "grass_darkgreen",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 204, 183, 127 },
              name = "path_stone",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 215, 140, 52 },
              name = "ledge",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            },
            {
              color = { 64, 118, 134 },
              name = "water",
              class = "",
              probability = 1,
              tile = -1,
              properties = {}
            }
          },
          wangtiles = {
            {
              wangid = { 0, 6, 0, 1, 0, 6, 0, 6 },
              tileid = 0
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 6 },
              tileid = 1
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 6 },
              tileid = 2
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 6 },
              tileid = 3
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 6 },
              tileid = 4
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 6 },
              tileid = 5
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 6 },
              tileid = 6
            },
            {
              wangid = { 0, 6, 0, 1, 0, 6, 0, 6 },
              tileid = 8
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 6 },
              tileid = 9
            },
            {
              wangid = { 0, 6, 0, 2, 0, 6, 0, 6 },
              tileid = 11
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 6 },
              tileid = 12
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 6 },
              tileid = 13
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 6 },
              tileid = 14
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 6 },
              tileid = 15
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 6 },
              tileid = 16
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 6 },
              tileid = 17
            },
            {
              wangid = { 0, 6, 0, 2, 0, 6, 0, 6 },
              tileid = 19
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 6 },
              tileid = 20
            },
            {
              wangid = { 0, 6, 0, 4, 0, 6, 0, 6 },
              tileid = 22
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 6 },
              tileid = 23
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 6 },
              tileid = 24
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 6 },
              tileid = 25
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 6 },
              tileid = 26
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 6 },
              tileid = 27
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 6 },
              tileid = 28
            },
            {
              wangid = { 0, 6, 0, 4, 0, 6, 0, 6 },
              tileid = 30
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 6 },
              tileid = 31
            },
            {
              wangid = { 0, 6, 0, 3, 0, 6, 0, 6 },
              tileid = 33
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 6 },
              tileid = 34
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 6 },
              tileid = 35
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 6 },
              tileid = 36
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 6 },
              tileid = 37
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 6 },
              tileid = 38
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 6 },
              tileid = 39
            },
            {
              wangid = { 0, 6, 0, 3, 0, 6, 0, 6 },
              tileid = 41
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 6 },
              tileid = 42
            },
            {
              wangid = { 0, 7, 0, 1, 0, 7, 0, 7 },
              tileid = 44
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 7 },
              tileid = 45
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 7 },
              tileid = 46
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 7 },
              tileid = 47
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 7 },
              tileid = 48
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 7 },
              tileid = 49
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 7 },
              tileid = 50
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 7 },
              tileid = 51
            },
            {
              wangid = { 0, 7, 0, 1, 0, 7, 0, 7 },
              tileid = 52
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 7 },
              tileid = 53
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 6 },
              tileid = 64
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 1 },
              tileid = 70
            },
            {
              wangid = { 0, 6, 0, 1, 0, 6, 0, 6 },
              tileid = 71
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 6 },
              tileid = 72
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 1 },
              tileid = 73
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 6 },
              tileid = 74
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 6 },
              tileid = 75
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 2 },
              tileid = 81
            },
            {
              wangid = { 0, 6, 0, 2, 0, 6, 0, 6 },
              tileid = 82
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 6 },
              tileid = 83
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 2 },
              tileid = 84
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 6 },
              tileid = 85
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 6 },
              tileid = 86
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 4 },
              tileid = 92
            },
            {
              wangid = { 0, 6, 0, 4, 0, 6, 0, 6 },
              tileid = 93
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 6 },
              tileid = 94
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 4 },
              tileid = 95
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 6 },
              tileid = 96
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 6 },
              tileid = 97
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 3 },
              tileid = 103
            },
            {
              wangid = { 0, 6, 0, 3, 0, 6, 0, 6 },
              tileid = 104
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 6 },
              tileid = 105
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 3 },
              tileid = 106
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 6 },
              tileid = 107
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 7 },
              tileid = 108
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 1 },
              tileid = 114
            },
            {
              wangid = { 0, 7, 0, 1, 0, 7, 0, 7 },
              tileid = 115
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 7 },
              tileid = 116
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 1 },
              tileid = 117
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 7 },
              tileid = 118
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 6 },
              tileid = 128
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 1 },
              tileid = 134
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 6 },
              tileid = 135
            },
            {
              wangid = { 0, 6, 0, 1, 0, 1, 0, 1 },
              tileid = 138
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 6 },
              tileid = 139
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 2 },
              tileid = 145
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 6 },
              tileid = 146
            },
            {
              wangid = { 0, 6, 0, 2, 0, 2, 0, 2 },
              tileid = 149
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 6 },
              tileid = 150
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 4 },
              tileid = 156
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 6 },
              tileid = 157
            },
            {
              wangid = { 0, 6, 0, 4, 0, 4, 0, 4 },
              tileid = 160
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 6 },
              tileid = 161
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 3 },
              tileid = 167
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 6 },
              tileid = 168
            },
            {
              wangid = { 0, 6, 0, 3, 0, 3, 0, 3 },
              tileid = 171
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 7 },
              tileid = 172
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 1 },
              tileid = 178
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 7 },
              tileid = 179
            },
            {
              wangid = { 0, 7, 0, 1, 0, 1, 0, 1 },
              tileid = 182
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 6 },
              tileid = 192
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 1 },
              tileid = 198
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 1 },
              tileid = 199
            },
            {
              wangid = { 0, 1, 0, 6, 0, 1, 0, 1 },
              tileid = 202
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 6 },
              tileid = 203
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 2 },
              tileid = 209
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 2 },
              tileid = 210
            },
            {
              wangid = { 0, 2, 0, 6, 0, 2, 0, 2 },
              tileid = 213
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 6 },
              tileid = 214
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 4 },
              tileid = 220
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 4 },
              tileid = 221
            },
            {
              wangid = { 0, 4, 0, 6, 0, 4, 0, 4 },
              tileid = 224
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 6 },
              tileid = 225
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 3 },
              tileid = 231
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 3 },
              tileid = 232
            },
            {
              wangid = { 0, 3, 0, 6, 0, 3, 0, 3 },
              tileid = 235
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 7 },
              tileid = 236
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 1 },
              tileid = 242
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 1 },
              tileid = 243
            },
            {
              wangid = { 0, 1, 0, 7, 0, 1, 0, 1 },
              tileid = 246
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 6 },
              tileid = 256
            },
            {
              wangid = { 0, 6, 0, 6, 0, 1, 0, 1 },
              tileid = 262
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 6 },
              tileid = 263
            },
            {
              wangid = { 0, 1, 0, 1, 0, 6, 0, 1 },
              tileid = 264
            },
            {
              wangid = { 0, 1, 0, 6, 0, 1, 0, 1 },
              tileid = 265
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 1 },
              tileid = 266
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 6 },
              tileid = 267
            },
            {
              wangid = { 0, 6, 0, 6, 0, 2, 0, 2 },
              tileid = 273
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 6 },
              tileid = 274
            },
            {
              wangid = { 0, 2, 0, 2, 0, 6, 0, 2 },
              tileid = 275
            },
            {
              wangid = { 0, 2, 0, 6, 0, 2, 0, 2 },
              tileid = 276
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 2 },
              tileid = 277
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 6 },
              tileid = 278
            },
            {
              wangid = { 0, 6, 0, 6, 0, 4, 0, 4 },
              tileid = 284
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 6 },
              tileid = 285
            },
            {
              wangid = { 0, 4, 0, 4, 0, 6, 0, 4 },
              tileid = 286
            },
            {
              wangid = { 0, 4, 0, 6, 0, 4, 0, 4 },
              tileid = 287
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 4 },
              tileid = 288
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 6 },
              tileid = 289
            },
            {
              wangid = { 0, 6, 0, 6, 0, 3, 0, 3 },
              tileid = 295
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 6 },
              tileid = 296
            },
            {
              wangid = { 0, 3, 0, 3, 0, 6, 0, 3 },
              tileid = 297
            },
            {
              wangid = { 0, 3, 0, 6, 0, 3, 0, 3 },
              tileid = 298
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 3 },
              tileid = 299
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 7 },
              tileid = 300
            },
            {
              wangid = { 0, 7, 0, 7, 0, 1, 0, 1 },
              tileid = 306
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 7 },
              tileid = 307
            },
            {
              wangid = { 0, 1, 0, 1, 0, 7, 0, 1 },
              tileid = 308
            },
            {
              wangid = { 0, 1, 0, 7, 0, 1, 0, 1 },
              tileid = 309
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 1 },
              tileid = 310
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 6 },
              tileid = 320
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 1 },
              tileid = 321
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 1 },
              tileid = 322
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 1 },
              tileid = 323
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 1 },
              tileid = 324
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 1 },
              tileid = 325
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 1 },
              tileid = 326
            },
            {
              wangid = { 0, 1, 0, 6, 0, 6, 0, 6 },
              tileid = 328
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 1 },
              tileid = 329
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 6 },
              tileid = 331
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 2 },
              tileid = 332
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 2 },
              tileid = 333
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 2 },
              tileid = 334
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 2 },
              tileid = 335
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 2 },
              tileid = 336
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 2 },
              tileid = 337
            },
            {
              wangid = { 0, 2, 0, 6, 0, 6, 0, 6 },
              tileid = 339
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 2 },
              tileid = 340
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 6 },
              tileid = 342
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 4 },
              tileid = 343
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 4 },
              tileid = 344
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 4 },
              tileid = 345
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 4 },
              tileid = 346
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 4 },
              tileid = 347
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 4 },
              tileid = 348
            },
            {
              wangid = { 0, 4, 0, 6, 0, 6, 0, 6 },
              tileid = 350
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 4 },
              tileid = 351
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 6 },
              tileid = 353
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 3 },
              tileid = 354
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 3 },
              tileid = 355
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 3 },
              tileid = 356
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 3 },
              tileid = 357
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 3 },
              tileid = 358
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 3 },
              tileid = 359
            },
            {
              wangid = { 0, 3, 0, 6, 0, 6, 0, 6 },
              tileid = 361
            },
            {
              wangid = { 0, 6, 0, 6, 0, 6, 0, 3 },
              tileid = 362
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 7 },
              tileid = 364
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 1 },
              tileid = 365
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 1 },
              tileid = 366
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 1 },
              tileid = 367
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 1 },
              tileid = 368
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 1 },
              tileid = 369
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 1 },
              tileid = 370
            },
            {
              wangid = { 0, 1, 0, 7, 0, 7, 0, 7 },
              tileid = 372
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 1 },
              tileid = 373
            },
            {
              wangid = { 0, 7, 0, 2, 0, 7, 0, 7 },
              tileid = 684
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 7 },
              tileid = 685
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 7 },
              tileid = 686
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 7 },
              tileid = 687
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 7 },
              tileid = 688
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 7 },
              tileid = 689
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 7 },
              tileid = 690
            },
            {
              wangid = { 0, 7, 0, 2, 0, 7, 0, 7 },
              tileid = 692
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 7 },
              tileid = 693
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 7 },
              tileid = 748
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 2 },
              tileid = 754
            },
            {
              wangid = { 0, 7, 0, 2, 0, 7, 0, 7 },
              tileid = 755
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 7 },
              tileid = 756
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 2 },
              tileid = 757
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 7 },
              tileid = 758
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 7 },
              tileid = 812
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 2 },
              tileid = 818
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 7 },
              tileid = 819
            },
            {
              wangid = { 0, 7, 0, 2, 0, 2, 0, 2 },
              tileid = 822
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 7 },
              tileid = 876
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 2 },
              tileid = 882
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 2 },
              tileid = 883
            },
            {
              wangid = { 0, 2, 0, 7, 0, 2, 0, 2 },
              tileid = 886
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 7 },
              tileid = 940
            },
            {
              wangid = { 0, 7, 0, 7, 0, 2, 0, 2 },
              tileid = 946
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 7 },
              tileid = 947
            },
            {
              wangid = { 0, 2, 0, 2, 0, 7, 0, 2 },
              tileid = 948
            },
            {
              wangid = { 0, 2, 0, 7, 0, 2, 0, 2 },
              tileid = 949
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 2 },
              tileid = 950
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 7 },
              tileid = 1004
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 2 },
              tileid = 1005
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 2 },
              tileid = 1006
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 2 },
              tileid = 1007
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 2 },
              tileid = 1008
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 2 },
              tileid = 1009
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 2 },
              tileid = 1010
            },
            {
              wangid = { 0, 2, 0, 7, 0, 7, 0, 7 },
              tileid = 1012
            },
            {
              wangid = { 0, 7, 0, 7, 0, 7, 0, 2 },
              tileid = 1013
            },
            {
              wangid = { 0, 1, 0, 2, 0, 1, 0, 1 },
              tileid = 1920
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 1 },
              tileid = 1921
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 1 },
              tileid = 1922
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 2 },
              tileid = 1923
            },
            {
              wangid = { 0, 2, 0, 1, 0, 2, 0, 2 },
              tileid = 1924
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 2 },
              tileid = 1925
            },
            {
              wangid = { 0, 2, 0, 4, 0, 2, 0, 2 },
              tileid = 1930
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 2 },
              tileid = 1931
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 2 },
              tileid = 1932
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 4 },
              tileid = 1933
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 4 },
              tileid = 1934
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 2 },
              tileid = 1935
            },
            {
              wangid = { 0, 1, 0, 3, 0, 1, 0, 1 },
              tileid = 1940
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 1 },
              tileid = 1941
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 1 },
              tileid = 1942
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 3 },
              tileid = 1943
            },
            {
              wangid = { 0, 3, 0, 1, 0, 3, 0, 3 },
              tileid = 1944
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 3 },
              tileid = 1945
            },
            {
              wangid = { 0, 1, 0, 5, 0, 1, 0, 1 },
              tileid = 1950
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 1 },
              tileid = 1951
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 1 },
              tileid = 1952
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 5 },
              tileid = 1953
            },
            {
              wangid = { 0, 5, 0, 1, 0, 5, 0, 5 },
              tileid = 1954
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 5 },
              tileid = 1955
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 1 },
              tileid = 1984
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 2 },
              tileid = 1985
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 2 },
              tileid = 1986
            },
            {
              wangid = { 0, 2, 0, 1, 0, 2, 0, 2 },
              tileid = 1987
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 2 },
              tileid = 1988
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 1 },
              tileid = 1989
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 2 },
              tileid = 1994
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 4 },
              tileid = 1995
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 4 },
              tileid = 1996
            },
            {
              wangid = { 0, 4, 0, 2, 0, 4, 0, 4 },
              tileid = 1997
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 2 },
              tileid = 1998
            },
            {
              wangid = { 0, 2, 0, 4, 0, 2, 0, 2 },
              tileid = 1999
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 1 },
              tileid = 2004
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 3 },
              tileid = 2005
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 3 },
              tileid = 2006
            },
            {
              wangid = { 0, 3, 0, 1, 0, 3, 0, 3 },
              tileid = 2007
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 3 },
              tileid = 2008
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 1 },
              tileid = 2009
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 1 },
              tileid = 2014
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 5 },
              tileid = 2015
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 5 },
              tileid = 2016
            },
            {
              wangid = { 0, 5, 0, 1, 0, 5, 0, 5 },
              tileid = 2017
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 5 },
              tileid = 2018
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 1 },
              tileid = 2019
            },
            {
              wangid = { 0, 1, 0, 2, 0, 1, 0, 1 },
              tileid = 2048
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2049
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2050
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2051
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 1 },
              tileid = 2052
            },
            {
              wangid = { 0, 2, 0, 1, 0, 2, 0, 2 },
              tileid = 2053
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2054
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2055
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2056
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 2 },
              tileid = 2057
            },
            {
              wangid = { 0, 2, 0, 4, 0, 2, 0, 2 },
              tileid = 2058
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2059
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2060
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2061
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 2 },
              tileid = 2062
            },
            {
              wangid = { 0, 4, 0, 2, 0, 4, 0, 4 },
              tileid = 2063
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2064
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2065
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2066
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 4 },
              tileid = 2067
            },
            {
              wangid = { 0, 1, 0, 3, 0, 1, 0, 1 },
              tileid = 2068
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2069
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2070
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2071
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 1 },
              tileid = 2072
            },
            {
              wangid = { 0, 3, 0, 1, 0, 3, 0, 3 },
              tileid = 2073
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2074
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2075
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2076
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 3 },
              tileid = 2077
            },
            {
              wangid = { 0, 1, 0, 5, 0, 1, 0, 1 },
              tileid = 2078
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2079
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2080
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2081
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 1 },
              tileid = 2082
            },
            {
              wangid = { 0, 5, 0, 1, 0, 5, 0, 5 },
              tileid = 2083
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2084
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2085
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2086
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 5 },
              tileid = 2087
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2112
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2116
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2117
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2121
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2122
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2123
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2124
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2125
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2126
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2127
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2131
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2132
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2133
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2134
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2135
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2136
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2137
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2141
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2142
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2146
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2147
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2151
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2176
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 2 },
              tileid = 2178
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2180
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2181
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2185
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2186
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2187
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2188
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2189
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2190
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2191
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2195
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2196
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2197
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2198
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2199
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2200
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2201
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2205
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2206
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2210
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2211
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2215
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2240
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2244
            },
            {
              wangid = { 0, 1, 0, 1, 0, 2, 0, 2 },
              tileid = 2245
            },
            {
              wangid = { 0, 2, 0, 2, 0, 1, 0, 1 },
              tileid = 2249
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2250
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2251
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2252
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2253
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2254
            },
            {
              wangid = { 0, 2, 0, 2, 0, 4, 0, 4 },
              tileid = 2255
            },
            {
              wangid = { 0, 4, 0, 4, 0, 2, 0, 2 },
              tileid = 2259
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2260
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2261
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2262
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2263
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2264
            },
            {
              wangid = { 0, 1, 0, 1, 0, 3, 0, 3 },
              tileid = 2265
            },
            {
              wangid = { 0, 3, 0, 3, 0, 1, 0, 1 },
              tileid = 2269
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2270
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2274
            },
            {
              wangid = { 0, 1, 0, 1, 0, 5, 0, 5 },
              tileid = 2275
            },
            {
              wangid = { 0, 5, 0, 5, 0, 1, 0, 1 },
              tileid = 2279
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 1 },
              tileid = 2304
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2305
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2306
            },
            {
              wangid = { 0, 2, 0, 1, 0, 1, 0, 2 },
              tileid = 2307
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 2 },
              tileid = 2308
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 2 },
              tileid = 2309
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2310
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2311
            },
            {
              wangid = { 0, 1, 0, 2, 0, 2, 0, 1 },
              tileid = 2312
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 1 },
              tileid = 2313
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 2 },
              tileid = 2314
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2315
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2316
            },
            {
              wangid = { 0, 4, 0, 2, 0, 2, 0, 4 },
              tileid = 2317
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 4 },
              tileid = 2318
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 4 },
              tileid = 2319
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2320
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2321
            },
            {
              wangid = { 0, 2, 0, 4, 0, 4, 0, 2 },
              tileid = 2322
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 2 },
              tileid = 2323
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 1 },
              tileid = 2324
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2325
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2326
            },
            {
              wangid = { 0, 3, 0, 1, 0, 1, 0, 3 },
              tileid = 2327
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 3 },
              tileid = 2328
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 3 },
              tileid = 2329
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2330
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2331
            },
            {
              wangid = { 0, 1, 0, 3, 0, 3, 0, 1 },
              tileid = 2332
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 1 },
              tileid = 2333
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 1 },
              tileid = 2334
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2335
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2336
            },
            {
              wangid = { 0, 5, 0, 1, 0, 1, 0, 5 },
              tileid = 2337
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 5 },
              tileid = 2338
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 5 },
              tileid = 2339
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2340
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2341
            },
            {
              wangid = { 0, 1, 0, 5, 0, 5, 0, 1 },
              tileid = 2342
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 1 },
              tileid = 2343
            },
            {
              wangid = { 0, 1, 0, 0, 0, 1, 0, 1 },
              tileid = 2368
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 1 },
              tileid = 2369
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 1 },
              tileid = 2370
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 0 },
              tileid = 2371
            },
            {
              wangid = { 0, 0, 0, 1, 0, 0, 0, 0 },
              tileid = 2372
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 0 },
              tileid = 2373
            },
            {
              wangid = { 0, 0, 0, 4, 0, 0, 0, 0 },
              tileid = 2378
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 0 },
              tileid = 2379
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 0 },
              tileid = 2380
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 4 },
              tileid = 2381
            },
            {
              wangid = { 0, 4, 0, 0, 0, 4, 0, 4 },
              tileid = 2382
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 4 },
              tileid = 2383
            },
            {
              wangid = { 0, 0, 0, 3, 0, 0, 0, 0 },
              tileid = 2388
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 0 },
              tileid = 2389
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 0 },
              tileid = 2390
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 3 },
              tileid = 2391
            },
            {
              wangid = { 0, 3, 0, 0, 0, 3, 0, 3 },
              tileid = 2392
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 3 },
              tileid = 2393
            },
            {
              wangid = { 0, 2, 0, 5, 0, 2, 0, 2 },
              tileid = 2398
            },
            {
              wangid = { 0, 2, 0, 2, 0, 5, 0, 2 },
              tileid = 2399
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 2 },
              tileid = 2400
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 5 },
              tileid = 2401
            },
            {
              wangid = { 0, 5, 0, 2, 0, 5, 0, 5 },
              tileid = 2402
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 5 },
              tileid = 2403
            },
            {
              wangid = { 0, 0, 0, 5, 0, 0, 0, 0 },
              tileid = 2408
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 0 },
              tileid = 2409
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 0 },
              tileid = 2410
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 5 },
              tileid = 2411
            },
            {
              wangid = { 0, 5, 0, 0, 0, 5, 0, 5 },
              tileid = 2412
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 5 },
              tileid = 2413
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 1 },
              tileid = 2432
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 0 },
              tileid = 2433
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 0 },
              tileid = 2434
            },
            {
              wangid = { 0, 0, 0, 1, 0, 0, 0, 0 },
              tileid = 2435
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 0 },
              tileid = 2436
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 1 },
              tileid = 2437
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 0 },
              tileid = 2442
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 4 },
              tileid = 2443
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 4 },
              tileid = 2444
            },
            {
              wangid = { 0, 4, 0, 0, 0, 4, 0, 4 },
              tileid = 2445
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 4 },
              tileid = 2446
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 0 },
              tileid = 2447
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 0 },
              tileid = 2452
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 3 },
              tileid = 2453
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 3 },
              tileid = 2454
            },
            {
              wangid = { 0, 3, 0, 0, 0, 3, 0, 3 },
              tileid = 2455
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 3 },
              tileid = 2456
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 0 },
              tileid = 2457
            },
            {
              wangid = { 0, 5, 0, 2, 0, 2, 0, 2 },
              tileid = 2462
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 5 },
              tileid = 2463
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 5 },
              tileid = 2464
            },
            {
              wangid = { 0, 5, 0, 2, 0, 5, 0, 5 },
              tileid = 2465
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 5 },
              tileid = 2466
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 2 },
              tileid = 2467
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 0 },
              tileid = 2472
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 5 },
              tileid = 2473
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 5 },
              tileid = 2474
            },
            {
              wangid = { 0, 5, 0, 0, 0, 5, 0, 5 },
              tileid = 2475
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 5 },
              tileid = 2476
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 0 },
              tileid = 2477
            },
            {
              wangid = { 0, 1, 0, 0, 0, 1, 0, 1 },
              tileid = 2496
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2497
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2498
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2499
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 1 },
              tileid = 2500
            },
            {
              wangid = { 0, 0, 0, 1, 0, 0, 0, 0 },
              tileid = 2501
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2502
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2503
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2504
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 0 },
              tileid = 2505
            },
            {
              wangid = { 0, 0, 0, 4, 0, 0, 0, 0 },
              tileid = 2506
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2507
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2508
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2509
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 0 },
              tileid = 2510
            },
            {
              wangid = { 0, 4, 0, 0, 0, 4, 0, 4 },
              tileid = 2511
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2512
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2513
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2514
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 4 },
              tileid = 2515
            },
            {
              wangid = { 0, 0, 0, 3, 0, 0, 0, 0 },
              tileid = 2516
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2517
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2518
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2519
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 0 },
              tileid = 2520
            },
            {
              wangid = { 0, 3, 0, 0, 0, 3, 0, 3 },
              tileid = 2521
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2522
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2523
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2524
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 3 },
              tileid = 2525
            },
            {
              wangid = { 0, 2, 0, 0, 0, 2, 0, 2 },
              tileid = 2526
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 2 },
              tileid = 2527
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 2 },
              tileid = 2528
            },
            {
              wangid = { 0, 2, 0, 0, 0, 0, 0, 2 },
              tileid = 2529
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 2 },
              tileid = 2530
            },
            {
              wangid = { 0, 5, 0, 2, 0, 5, 0, 5 },
              tileid = 2531
            },
            {
              wangid = { 0, 5, 0, 2, 0, 2, 0, 5 },
              tileid = 2532
            },
            {
              wangid = { 0, 5, 0, 2, 0, 2, 0, 5 },
              tileid = 2533
            },
            {
              wangid = { 0, 5, 0, 2, 0, 2, 0, 5 },
              tileid = 2534
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 5 },
              tileid = 2535
            },
            {
              wangid = { 0, 0, 0, 5, 0, 0, 0, 0 },
              tileid = 2536
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2537
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2538
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2539
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 0 },
              tileid = 2540
            },
            {
              wangid = { 0, 5, 0, 0, 0, 5, 0, 5 },
              tileid = 2541
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2542
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2543
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2544
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 5 },
              tileid = 2545
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2560
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2564
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2565
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2569
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2570
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2571
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2572
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2573
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2574
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2575
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2579
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2580
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2581
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2582
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2583
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2584
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2585
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2589
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 2 },
              tileid = 2590
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 0 },
              tileid = 2594
            },
            {
              wangid = { 0, 2, 0, 2, 0, 5, 0, 5 },
              tileid = 2595
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 2 },
              tileid = 2599
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2600
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2604
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2605
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2609
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2624
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2628
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2629
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 1 },
              tileid = 2631
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2633
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2634
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2635
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2636
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2637
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2638
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2639
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2643
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2644
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2645
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2646
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2647
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2648
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2649
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2653
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 2 },
              tileid = 2654
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 0 },
              tileid = 2658
            },
            {
              wangid = { 0, 2, 0, 2, 0, 5, 0, 5 },
              tileid = 2659
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 2 },
              tileid = 2663
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2664
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 5 },
              tileid = 2666
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2668
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2669
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2673
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2688
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2692
            },
            {
              wangid = { 0, 1, 0, 1, 0, 0, 0, 0 },
              tileid = 2693
            },
            {
              wangid = { 0, 0, 0, 0, 0, 1, 0, 1 },
              tileid = 2697
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2698
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2699
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2700
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 4 },
              tileid = 2701
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2702
            },
            {
              wangid = { 0, 0, 0, 0, 0, 4, 0, 4 },
              tileid = 2703
            },
            {
              wangid = { 0, 4, 0, 4, 0, 0, 0, 0 },
              tileid = 2707
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2708
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2709
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2710
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 3 },
              tileid = 2711
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2712
            },
            {
              wangid = { 0, 0, 0, 0, 0, 3, 0, 3 },
              tileid = 2713
            },
            {
              wangid = { 0, 3, 0, 3, 0, 0, 0, 0 },
              tileid = 2717
            },
            {
              wangid = { 0, 0, 0, 0, 0, 2, 0, 2 },
              tileid = 2718
            },
            {
              wangid = { 0, 2, 0, 2, 0, 0, 0, 0 },
              tileid = 2722
            },
            {
              wangid = { 0, 2, 0, 2, 0, 5, 0, 5 },
              tileid = 2723
            },
            {
              wangid = { 0, 5, 0, 5, 0, 2, 0, 2 },
              tileid = 2727
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2728
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2732
            },
            {
              wangid = { 0, 0, 0, 0, 0, 5, 0, 5 },
              tileid = 2733
            },
            {
              wangid = { 0, 5, 0, 5, 0, 0, 0, 0 },
              tileid = 2737
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 1 },
              tileid = 2752
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2753
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2754
            },
            {
              wangid = { 0, 0, 0, 1, 0, 1, 0, 0 },
              tileid = 2755
            },
            {
              wangid = { 0, 1, 0, 1, 0, 1, 0, 0 },
              tileid = 2756
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 0 },
              tileid = 2757
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2758
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2759
            },
            {
              wangid = { 0, 1, 0, 0, 0, 0, 0, 1 },
              tileid = 2760
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 1 },
              tileid = 2761
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 0 },
              tileid = 2762
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2763
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2764
            },
            {
              wangid = { 0, 4, 0, 0, 0, 0, 0, 4 },
              tileid = 2765
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 4 },
              tileid = 2766
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 4 },
              tileid = 2767
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2768
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2769
            },
            {
              wangid = { 0, 0, 0, 4, 0, 4, 0, 0 },
              tileid = 2770
            },
            {
              wangid = { 0, 4, 0, 4, 0, 4, 0, 0 },
              tileid = 2771
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 0 },
              tileid = 2772
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2773
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2774
            },
            {
              wangid = { 0, 3, 0, 0, 0, 0, 0, 3 },
              tileid = 2775
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 3 },
              tileid = 2776
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 3 },
              tileid = 2777
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2778
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2779
            },
            {
              wangid = { 0, 0, 0, 3, 0, 3, 0, 0 },
              tileid = 2780
            },
            {
              wangid = { 0, 3, 0, 3, 0, 3, 0, 0 },
              tileid = 2781
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 2 },
              tileid = 2782
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 0 },
              tileid = 2783
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 0 },
              tileid = 2784
            },
            {
              wangid = { 0, 0, 0, 2, 0, 2, 0, 0 },
              tileid = 2785
            },
            {
              wangid = { 0, 2, 0, 2, 0, 2, 0, 0 },
              tileid = 2786
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 5 },
              tileid = 2787
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 2 },
              tileid = 2788
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 2 },
              tileid = 2789
            },
            {
              wangid = { 0, 2, 0, 5, 0, 5, 0, 2 },
              tileid = 2790
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 2 },
              tileid = 2791
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 0 },
              tileid = 2792
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2793
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2794
            },
            {
              wangid = { 0, 5, 0, 0, 0, 0, 0, 5 },
              tileid = 2795
            },
            {
              wangid = { 0, 0, 0, 0, 0, 0, 0, 5 },
              tileid = 2796
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 5 },
              tileid = 2797
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2798
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2799
            },
            {
              wangid = { 0, 0, 0, 5, 0, 5, 0, 0 },
              tileid = 2800
            },
            {
              wangid = { 0, 5, 0, 5, 0, 5, 0, 0 },
              tileid = 2801
            }
          }
        }
      },
      tilecount = 2816,
      tiles = {}
    },
    {
      name = "bandits",
      firstgid = 5265,
      class = "",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "mapobjects/bandit/bandits.png",
      imagewidth = 256,
      imageheight = 384,
      objectalignment = "bottom",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 8
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      wangsets = {},
      tilecount = 24,
      tiles = {
        {
          id = 0,
          type = "bandit-dagger"
        },
        {
          id = 1,
          type = "bandit-dagger"
        },
        {
          id = 2,
          type = "bandit-dagger"
        },
        {
          id = 3,
          type = "bandit-dagger"
        },
        {
          id = 4,
          type = "bandit-spear"
        },
        {
          id = 5,
          type = "bandit-spear"
        },
        {
          id = 6,
          type = "bandit-spear"
        },
        {
          id = 7,
          type = "bandit-spear"
        },
        {
          id = 8,
          type = "bandit-bow"
        },
        {
          id = 9,
          type = "bandit-bow"
        },
        {
          id = 10,
          type = "bandit-bow"
        },
        {
          id = 11,
          type = "bandit-bow"
        },
        {
          id = 12,
          type = "bandit-sling"
        },
        {
          id = 13,
          type = "bandit-sling"
        },
        {
          id = 14,
          type = "bandit-sling"
        },
        {
          id = 15,
          type = "bandit-sling"
        },
        {
          id = 16,
          type = "bandit-boss"
        },
        {
          id = 17,
          type = "bandit-boss"
        },
        {
          id = 18,
          type = "bandit-boss"
        },
        {
          id = 19,
          type = "bandit-boss"
        },
        {
          id = 20,
          type = "bandit-cave-door",
          objectGroup = {
            type = "objectgroup",
            draworder = "index",
            id = 2,
            name = "",
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
                name = "",
                type = "",
                shape = "polygon",
                x = 0,
                y = 48,
                width = 64,
                height = 16,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = 0, y = 16 },
                  { x = 64, y = 16 },
                  { x = 64, y = 0 }
                },
                properties = {
                  ["collidable"] = true
                }
              }
            }
          }
        }
      }
    },
    {
      name = "items",
      firstgid = 5289,
      class = "",
      tilewidth = 64,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "mapobjects/items.png",
      imagewidth = 256,
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
        width = 64,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 4,
      tiles = {
        {
          id = 0,
          type = "food-fish"
        },
        {
          id = 1,
          type = "food-bigfish"
        },
        {
          id = 2,
          type = "item-throwing-axe"
        },
        {
          id = 3,
          type = "item-stone"
        }
      }
    },
    {
      name = "cavedoor2-diagonal",
      firstgid = 5293,
      class = "",
      tilewidth = 64,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "sprites/bandit/cavedoor2-diagonal.png",
      imagewidth = 256,
      imageheight = 128,
      objectalignment = "topright",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 128
      },
      properties = {},
      wangsets = {},
      tilecount = 4,
      tiles = {
        {
          id = 1,
          type = "bandit-cave-door",
          objectGroup = {
            type = "objectgroup",
            draworder = "index",
            id = 2,
            name = "",
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
                name = "",
                type = "",
                shape = "polygon",
                x = 0,
                y = 64,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = 64, y = 64 },
                  { x = 80, y = 64 },
                  { x = 16, y = 0 }
                },
                properties = {
                  ["collidable"] = true
                }
              }
            }
          }
        },
        {
          id = 2,
          properties = {
            ["name"] = "collapse"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
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
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
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
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 4,
      name = "ceiling",
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
      chunks = {}
    },
    {
      type = "group",
      id = 14,
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
          draworder = "index",
          id = 7,
          name = "learnmovement",
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
              id = 21,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = 0,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 0, y = 160 },
                { x = 64, y = 96 },
                { x = 160, y = 96 },
                { x = 192, y = 64 },
                { x = 352, y = 64 },
                { x = 384, y = 96 },
                { x = 448, y = 96 },
                { x = 480, y = 64 },
                { x = 960, y = 64 },
                { x = 960, y = 0 }
              },
              properties = {
                ["bodyheight"] = 64,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 44,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = 874.667,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -106.667 },
                { x = 0, y = -10.6667 },
                { x = 960, y = -10.6667 },
                { x = 960, y = -42.6667 },
                { x = 384, y = -42.6667 },
                { x = 320, y = -106.667 },
                { x = 256, y = -106.667 },
                { x = 224, y = -74.6667 },
                { x = 160, y = -74.6667 },
                { x = 128, y = -42.6667 },
                { x = 64, y = -42.6667 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 27,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 240,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 480, y = 0 }
              },
              properties = {}
            },
            {
              id = 23,
              name = "",
              type = "",
              shape = "rectangle",
              x = 728,
              y = 224,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5292,
              visible = true,
              properties = {}
            },
            {
              id = 24,
              name = "",
              type = "",
              shape = "rectangle",
              x = 864,
              y = 168,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5292,
              visible = true,
              properties = {}
            },
            {
              id = 25,
              name = "",
              type = "",
              shape = "rectangle",
              x = 784,
              y = 136,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5289,
              visible = true,
              properties = {}
            },
            {
              id = 26,
              name = "",
              type = "",
              shape = "rectangle",
              x = 848,
              y = 248,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5290,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 8,
          name = "learnattack",
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
              id = 15,
              name = "",
              type = "",
              shape = "rectangle",
              x = 976,
              y = 136,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 50,
              name = "",
              type = "",
              shape = "rectangle",
              x = 400,
              y = 144,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 16,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1040,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 45,
              name = "",
              type = "",
              shape = "rectangle",
              x = 976,
              y = 200,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 47,
              name = "",
              type = "",
              shape = "rectangle",
              x = 400,
              y = 216,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 10,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1104,
              y = 112,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 49,
              name = "",
              type = "",
              shape = "rectangle",
              x = 464,
              y = 160,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 11,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1040,
              y = 120,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 46,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1104,
              y = 176,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 48,
              name = "",
              type = "",
              shape = "rectangle",
              x = 464,
              y = 232,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 9,
          name = "tolearnrunning",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 5
          },
          objects = {
            {
              id = 22,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 960,
              y = -32,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 96 },
                { x = 32, y = 96 },
                { x = 64, y = 64 },
                { x = 480, y = 64 },
                { x = 480, y = 0 },
                { x = 0, y = 0 }
              },
              properties = {
                ["bodyheight"] = 64,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 28,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1600,
              y = 736,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = -160, y = 32 },
                { x = -192, y = 32 },
                { x = -224, y = 64 },
                { x = -608, y = 64 },
                { x = -640, y = 96 },
                { x = -640, y = 128 },
                { x = -160, y = 128 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 29,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 720,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 240, y = 0 },
                { x = 480, y = -32 }
              },
              properties = {}
            },
            {
              id = 19,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1232,
              y = 96,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 36,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1296,
              y = 88,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 52,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1168,
              y = 104,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 54,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1104,
              y = 112,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 20,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1232,
              y = 192,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 35,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1296,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 51,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1168,
              y = 200,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            },
            {
              id = 53,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1104,
              y = 208,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5266,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 10,
          name = "learnrunning",
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
              id = 32,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1472,
              y = 88,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 56,
              name = "",
              type = "",
              shape = "rectangle",
              x = 928,
              y = 152,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 34,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1472,
              y = 152,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 55,
              name = "",
              type = "",
              shape = "rectangle",
              x = 928,
              y = 216,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 11,
          name = "tolearnthrowing",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 5
          },
          objects = {
            {
              id = 38,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1440,
              y = -160,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 128 },
                { x = 0, y = 192 },
                { x = 192, y = 192 },
                { x = 320, y = 320 },
                { x = 320, y = 480 },
                { x = 384, y = 544 },
                { x = 480, y = 544 },
                { x = 480, y = 128 }
              },
              properties = {
                ["bodyheight"] = 64,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 39,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1440,
              y = 768,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 0, y = 384 },
                { x = 480, y = 384 },
                { x = 480, y = 352 },
                { x = 96, y = 352 },
                { x = 32, y = 288 },
                { x = 32, y = 32 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 1,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 40,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1200,
              y = 112,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 288, y = 0 },
                { x = 384, y = 80 },
                { x = 464, y = 200 },
                { x = 480, y = 320 }
              },
              properties = {}
            },
            {
              id = 42,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1728,
              y = 320,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5292,
              visible = true,
              properties = {}
            },
            {
              id = 43,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1776,
              y = 376,
              width = 64,
              height = 32,
              rotation = 0,
              gid = 5292,
              visible = true,
              properties = {}
            },
            {
              id = 58,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1728,
              y = 56,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5278,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 59,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1696,
              y = 24,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5278,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 87,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1760,
              y = 88,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5278,
              visible = true,
              properties = {
                ["z"] = 64
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 13,
          name = "learnthrowing",
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
              id = 41,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1552,
              y = 280,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 61,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1936,
              y = 440,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 57,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1680,
              y = 280,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 90,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1888,
              y = 312,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5278,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 62,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1936,
              y = 504,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 89,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1840,
              y = 312,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5278,
              visible = true,
              properties = {
                ["z"] = 64
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 15,
          name = "tolearngrab",
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
              id = 63,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1920,
              y = 1120,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 0, y = 32 },
                { x = 480, y = 32 },
                { x = 480, y = -160 },
                { x = 448, y = -192 },
                { x = 256, y = 0 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 64,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1920,
              y = 352,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -160 },
                { x = 0, y = 32 },
                { x = 160, y = -128 },
                { x = 160, y = -160 }
              },
              properties = {
                ["bodyheight"] = 64,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 65,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2240,
              y = 480,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -288 },
                { x = 0, y = -256 },
                { x = 160, y = -96 },
                { x = 160, y = -288 }
              },
              properties = {
                ["bodyheight"] = 64,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 66,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1808,
              y = 432,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 160, y = 0 },
                { x = 256, y = -16 },
                { x = 352, y = -64 }
              },
              properties = {}
            },
            {
              id = 234,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2160,
              y = 232,
              width = 64,
              height = 128,
              rotation = 0,
              gid = 5296,
              visible = true,
              properties = {}
            },
            {
              id = 235,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2160,
              y = 232,
              width = 64,
              height = 128,
              rotation = 0,
              gid = 5294,
              visible = true,
              properties = {}
            },
            {
              id = 236,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2160,
              y = 232,
              width = 64,
              height = 128,
              rotation = 0,
              gid = 5293,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 16,
          name = "intoentryhall",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 3
          },
          objects = {
            {
              id = 67,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2048,
              y = -160,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 64 },
                { x = 0, y = 352 },
                { x = 32, y = 352 },
                { x = 32, y = 256 },
                { x = 160, y = 128 },
                { x = 352, y = 128 },
                { x = 352, y = 96 },
                { x = 416, y = 96 },
                { x = 416, y = 128 },
                { x = 480, y = 128 },
                { x = 480, y = 96 },
                { x = 544, y = 96 },
                { x = 544, y = 128 },
                { x = 608, y = 128 },
                { x = 608, y = 96 },
                { x = 672, y = 96 },
                { x = 672, y = 128 },
                { x = 736, y = 128 },
                { x = 736, y = 96 },
                { x = 800, y = 96 },
                { x = 800, y = 128 },
                { x = 992, y = 128 },
                { x = 1056, y = 192 },
                { x = 1056, y = 352 },
                { x = 1088, y = 352 },
                { x = 1088, y = 64 }
              },
              properties = {
                ["bodyheight"] = 512,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 68,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2240,
              y = 160,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 32, y = 0 },
                { x = 0, y = 32 },
                { x = 0, y = 64 },
                { x = 32, y = 96 },
                { x = 640, y = 96 },
                { x = 672, y = 64 },
                { x = 672, y = 32 },
                { x = 640, y = 0 },
                { x = 544, y = 0 },
                { x = 544, y = 32 },
                { x = 480, y = 32 },
                { x = 480, y = 0 },
                { x = 416, y = 0 },
                { x = 416, y = 32 },
                { x = 352, y = 32 },
                { x = 352, y = 0 },
                { x = 288, y = 0 },
                { x = 288, y = 32 },
                { x = 224, y = 32 },
                { x = 224, y = 0 },
                { x = 160, y = 0 },
                { x = 160, y = 32 },
                { x = 96, y = 32 },
                { x = 96, y = 0 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 69,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2160,
              y = 240,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 0, y = -64 },
                { x = 48, y = -144 },
                { x = 96, y = -192 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 22,
          name = "entryhall",
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
              id = 94,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2488,
              y = 144,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 106,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2552,
              y = -40,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 95,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2360,
              y = 144,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 105,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2424,
              y = -40,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 96,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2992,
              y = 80,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 97,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2616,
              y = 144,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 107,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2680,
              y = -40,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 98,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2744,
              y = 144,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 108,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2808,
              y = -40,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5274,
              visible = true,
              properties = {}
            },
            {
              id = 104,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2064,
              y = 48,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 192, y = 0 },
                { x = 816, y = 0 }
              },
              properties = {}
            },
            {
              id = 101,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2944,
              y = 24,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            },
            {
              id = 103,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3040,
              y = 136,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5270,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 17,
          name = "guardroom",
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
              id = 70,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2592,
              y = 192,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 512, y = 0 },
                { x = 576, y = 64 },
                { x = 736, y = 64 },
                { x = 832, y = 160 },
                { x = 1248, y = 160 },
                { x = 1248, y = 0 }
              },
              properties = {
                ["bodyheight"] = 512,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 71,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2688,
              y = 992,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 64, y = -224 },
                { x = 64, y = 64 },
                { x = 512, y = 64 },
                { x = 480, y = 32 },
                { x = 160, y = 32 },
                { x = 96, y = -32 },
                { x = 96, y = -128 },
                { x = 128, y = -160 },
                { x = 160, y = -160 },
                { x = 224, y = -224 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 78,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2880,
              y = 48,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 48, y = 48 },
                { x = 96, y = 136 },
                { x = 112, y = 256 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 18,
          name = "armory",
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
              id = 72,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 3168,
              y = 1024,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 32, y = 32 },
                { x = 0, y = 32 },
                { x = 0, y = 128 },
                { x = 672, y = 128 },
                { x = 672, y = 64 },
                { x = 640, y = 64 },
                { x = 608, y = 96 },
                { x = 224, y = 96 },
                { x = 192, y = 64 },
                { x = 64, y = 64 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 79,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2992,
              y = 304,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 608, y = 128 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 19,
          name = "messhall",
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
              id = 74,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 3840,
              y = 32,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = -320 },
                { x = 0, y = 320 },
                { x = 32, y = 288 },
                { x = 32, y = -224 },
                { x = 96, y = -288 },
                { x = 384, y = -288 },
                { x = 448, y = -224 },
                { x = 480, y = -224 },
                { x = 480, y = -320 }
              },
              properties = {
                ["bodyheight"] = 512,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 75,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 3840,
              y = 448,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 480, y = 128 },
                { x = 480, y = -448 },
                { x = 448, y = -416 },
                { x = 448, y = 64 },
                { x = 392, y = 128 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 81,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 3440,
              y = 432,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 160, y = 0 },
                { x = 640, y = 0 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 21,
          name = "messhall2",
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
              id = 93,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 3920,
              y = 432,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 160, y = 0 },
                { x = 160, y = -576 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 20,
          name = "arena",
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
              id = 76,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 4320,
              y = -320,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 0, y = 32 },
                { x = 0, y = 128 },
                { x = 32, y = 128 },
                { x = 64, y = 96 },
                { x = 416, y = 96 },
                { x = 448, y = 128 },
                { x = 480, y = 128 },
                { x = 480, y = 32 }
              },
              properties = {
                ["bodyheight"] = 512,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 77,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 4320,
              y = 256,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polygon = {
                { x = 32, y = 0 },
                { x = 0, y = -32 },
                { x = 0, y = 32 },
                { x = 480, y = 32 },
                { x = 480, y = -32 },
                { x = 448, y = 0 }
              },
              properties = {
                ["bodyheight"] = 32,
                ["bodysolid"] = true,
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 80,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 3920,
              y = -144,
              width = 0,
              height = 0,
              rotation = 0,
              visible = true,
              polyline = {
                { x = 160, y = 0 },
                { x = 640, y = 0 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 23,
          name = "boss",
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
              id = 231,
              name = "",
              type = "",
              shape = "rectangle",
              x = 4808,
              y = -104,
              width = 64,
              height = 64,
              rotation = 0,
              gid = 5283,
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
      id = 3,
      name = "notes",
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
          name = "",
          type = "",
          shape = "text",
          x = 320,
          y = 352,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Teach basic combat with first low-level enemies",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "text",
          x = 960,
          y = -160,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Introduce dodging enemy encouraging player to use run in combat",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "text",
          x = 1600,
          y = -160,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Teach long-range combat with stones to throw at slingers\nAvoid their stones then pick up and throw them back",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "text",
          x = 1920,
          y = -360,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Teach grabbing with guarding enemy and barrier broken only by thrown enemy",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "text",
          x = 2560,
          y = -360,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Entry hall with archers shooting from arrow slits",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "text",
          x = 2464,
          y = 480,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Guard room introducing mace enemies",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "text",
          x = 3360,
          y = 64,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Armory with mixed enemies and introducing throwable weapons",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "text",
          x = 3840,
          y = -416,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Mess hall with food, throwable and breakable furniture, stronger mix of enemies",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "text",
          x = 4320,
          y = -416,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Boss arena",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "text",
          x = 4800,
          y = -416,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "End room\n\nHolding cells with captured kids",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "text",
          x = 0,
          y = -128,
          width = 480,
          height = 128,
          rotation = 0,
          visible = true,
          text = "Teach movement - walking and running",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          valign = "bottom",
          properties = {}
        },
        {
          id = 109,
          name = "",
          type = "",
          shape = "text",
          x = 0,
          y = 192,
          width = 480,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 114,
          name = "",
          type = "",
          shape = "text",
          x = 480,
          y = 240,
          width = 480,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 117,
          name = "",
          type = "",
          shape = "text",
          x = 960,
          y = 208,
          width = 480,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 110,
          name = "",
          type = "",
          shape = "text",
          x = 192,
          y = 0,
          width = 160,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Vines",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 113,
          name = "",
          type = "",
          shape = "text",
          x = 512,
          y = 0,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Vines",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 115,
          name = "",
          type = "",
          shape = "text",
          x = 768,
          y = 0,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Vines",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 116,
          name = "",
          type = "",
          shape = "text",
          x = 1240,
          y = -32,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Vines",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 118,
          name = "",
          type = "",
          shape = "text",
          x = 1792,
          y = -32,
          width = 128,
          height = 320,
          rotation = 0,
          visible = true,
          text = "Tree, plants, flowers, bushes, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 112,
          name = "",
          type = "",
          shape = "text",
          x = 368,
          y = -16,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Plants",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 111,
          name = "",
          type = "",
          shape = "text",
          x = 64,
          y = 32,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Cave\nexit",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 119,
          name = "",
          type = "",
          shape = "text",
          x = 1920,
          y = 192,
          width = 128,
          height = 160,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 126,
          name = "",
          type = "",
          shape = "text",
          x = 2080,
          y = 192,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Door",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 127,
          name = "",
          type = "",
          shape = "text",
          x = 2080,
          y = -64,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Torches",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 120,
          name = "",
          type = "",
          shape = "text",
          x = 2272,
          y = 192,
          width = 128,
          height = 160,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 122,
          name = "",
          type = "",
          shape = "text",
          x = 2096,
          y = 280,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 124,
          name = "",
          type = "",
          shape = "text",
          x = 2192,
          y = 280,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 123,
          name = "",
          type = "",
          shape = "text",
          x = 2064,
          y = 264,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          text = "Small table",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 125,
          name = "",
          type = "",
          shape = "text",
          x = 2224,
          y = 264,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          text = "Small table",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 140,
          name = "",
          type = "",
          shape = "text",
          x = 2256,
          y = 248,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          text = "Barrel",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 141,
          name = "",
          type = "",
          shape = "text",
          x = 2080,
          y = 216,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          text = "Barrel",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 121,
          name = "",
          type = "",
          shape = "text",
          x = 2240,
          y = 416,
          width = 160,
          height = 160,
          rotation = 0,
          visible = true,
          text = "Flowers, bushes, plants, rocks",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 128,
          name = "",
          type = "",
          shape = "text",
          x = 2944,
          y = -64,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Torches",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 131,
          name = "",
          type = "",
          shape = "text",
          x = 2816,
          y = 304,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 129,
          name = "",
          type = "",
          shape = "text",
          x = 2336,
          y = 160,
          width = 512,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Torches between alcoves",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 130,
          name = "",
          type = "",
          shape = "text",
          x = 2336,
          y = -96,
          width = 512,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Torches between alcoves",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 132,
          name = "",
          type = "",
          shape = "text",
          x = 2816,
          y = 368,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 133,
          name = "",
          type = "",
          shape = "text",
          x = 2880,
          y = 368,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 134,
          name = "",
          type = "",
          shape = "text",
          x = 2880,
          y = 264,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 135,
          name = "",
          type = "",
          shape = "text",
          x = 2816,
          y = 264,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Stool",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 136,
          name = "",
          type = "",
          shape = "text",
          x = 3440,
          y = 304,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Weapon table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 137,
          name = "",
          type = "",
          shape = "text",
          x = 3568,
          y = 304,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Weapon table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 138,
          name = "",
          type = "",
          shape = "text",
          x = 3696,
          y = 304,
          width = 96,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Weapon table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 139,
          name = "",
          type = "",
          shape = "text",
          x = 3200,
          y = 256,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Anvil",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 145,
          name = "",
          type = "",
          shape = "text",
          x = 3264,
          y = 256,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Forge",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 143,
          name = "",
          type = "",
          shape = "text",
          x = 3168,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Hammer",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 144,
          name = "",
          type = "",
          shape = "text",
          x = 3168,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "TinyUnicode",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 146,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 288,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 216,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 128,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 222,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = -32,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 226,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = -192,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 211,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 416,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 215,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 256,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 221,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 96,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 229,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = -64,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          text = "Table",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 208,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 214,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 192,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 220,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 32,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 225,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = -128,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 210,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 480,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 213,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 320,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 219,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 160,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 228,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 0,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 209,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 256,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 218,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = 96,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 224,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = -64,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 227,
          name = "",
          type = "",
          shape = "text",
          x = 3904,
          y = -224,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 212,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 384,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 217,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 224,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 223,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = 64,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        },
        {
          id = 230,
          name = "",
          type = "",
          shape = "text",
          x = 4128,
          y = -96,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          text = "Bench",
          fontfamily = "Unifont",
          pixelsize = 32,
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          valign = "center",
          properties = {
            ["bordercolor"] = "#ffffffff"
          }
        }
      }
    }
  }
}
