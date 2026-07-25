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
  nextlayerid = 14,
  nextobjectid = 6,
  properties = {
    ["runphase"] = "Dragontail.MoviePhase"
  },
  tilesets = {
    {
      name = "title",
      firstgid = 1,
      filename = "sprites/ui/title.tsx",
      exportfilename = "sprites/ui/title.lua"
    }
  },
  layers = {
    {
      type = "group",
      id = 10,
      name = "TitleHit",
      class = "Tiled.Movie",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["hitsound"] = "sounds/combat/heavyswingandhit.ogg",
        ["script"] = "Dragontail.Movie.Title"
      },
      layers = {
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
              x = 520,
              y = 36,
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
        },
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
          offsetx = 0,
          offsety = 0,
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
              offsetx = -20,
              offsety = -148.5,
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
              offsetx = -68,
              offsety = -112.5,
              parallaxx = 1,
              parallaxy = 1,
              repeatx = false,
              repeaty = false,
              properties = {}
            },
            {
              type = "group",
              id = 12,
              name = "Rose",
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
                  type = "imagelayer",
                  image = "sprites/ui/title/illust/09 Rose.png",
                  id = 4,
                  name = "Rose",
                  class = "",
                  visible = true,
                  opacity = 1,
                  offsetx = -88,
                  offsety = -121.5,
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
                  offsetx = -156,
                  offsety = -117,
                  parallaxx = 1,
                  parallaxy = 1,
                  repeatx = false,
                  repeaty = false,
                  properties = {}
                }
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 11,
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
              id = 3,
              name = "Rose of",
              type = "Gui.Button",
              shape = "text",
              x = 16,
              y = 112.5,
              width = 136,
              height = 49.5,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "ROSE of",
              fontfamily = "The Rumor",
              pixelsize = 48,
              wrap = true,
              color = { 224, 33, 33 },
              halign = "center",
              valign = "bottom",
              properties = {
                ["action"] = "restartStage",
                ["color2"] = "#ffffd8d8",
                ["frequency"] = 30,
                ["selectanimation"] = "colorCycle"
              }
            },
            {
              id = 4,
              name = "Dragontail",
              type = "Gui.Button",
              shape = "text",
              x = 32,
              y = 162,
              width = 196,
              height = 49.5,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "DRAGONTAIL",
              fontfamily = "The Rumor",
              pixelsize = 48,
              wrap = true,
              color = { 224, 33, 33 },
              halign = "center",
              valign = "bottom",
              properties = {
                ["action"] = "restartStage",
                ["color2"] = "#ffffd8d8",
                ["frequency"] = 30,
                ["selectanimation"] = "colorCycle"
              }
            },
            {
              id = 5,
              name = "Rising Tide 4",
              type = "Gui.Button",
              shape = "text",
              x = 48,
              y = 216,
              width = 144,
              height = 36,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Rising Tide 4",
              fontfamily = "The Rumor",
              pixelsize = 32,
              wrap = true,
              color = { 224, 33, 33 },
              halign = "center",
              valign = "bottom",
              properties = {
                ["action"] = "restartStage",
                ["color2"] = "#ffffd8d8",
                ["frequency"] = 30,
                ["selectanimation"] = "colorCycle"
              }
            }
          }
        }
      }
    }
  }
}
