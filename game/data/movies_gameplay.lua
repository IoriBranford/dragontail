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
  nextlayerid = 6,
  nextobjectid = 2,
  properties = {
    ["runphase"] = "Dragontail.MoviePhase"
  },
  tilesets = {},
  layers = {
    {
      type = "group",
      id = 2,
      name = "victory",
      class = "Tiled.Movie",
      visible = true,
      opacity = 1,
      offsetx = -264,
      offsety = -153,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 255, 255, 255 },
      properties = {
        ["script"] = "Dragontail.Movie.RoseUppercut",
        ["swipesound"] = "sounds/combat/heavyswingandhit.ogg",
        ["voice"] = "sounds/player/victory2.mp3"
      },
      layers = {
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/09 Rose.png",
          id = 3,
          name = "Rose",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          tintcolor = { 255, 255, 255 },
          repeatx = false,
          repeaty = false,
          properties = {}
        },
        {
          type = "imagelayer",
          image = "sprites/ui/title/illust/10 swipe.png",
          id = 4,
          name = "swipe",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = -44,
          offsety = 9,
          parallaxx = 1,
          parallaxy = 1,
          tintcolor = { 255, 255, 255 },
          repeatx = false,
          repeaty = false,
          properties = {}
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 5,
          name = "direction",
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
              name = "Rosepath",
              type = "",
              shape = "polyline",
              x = 264,
              y = 153,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 180, y = 310.5 },
                { x = 148, y = 202.5 },
                { x = 100, y = 108 },
                { x = 44, y = 36 },
                { x = 0, y = 0 }
              },
              properties = {}
            }
          }
        }
      }
    }
  }
}
