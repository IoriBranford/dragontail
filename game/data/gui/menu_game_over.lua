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
  nextlayerid = 34,
  nextobjectid = 238,
  properties = {
    ["draworder"] = 100
  },
  tilesets = {
    {
      name = "firespit",
      firstgid = 1,
      filename = "../sprites/ui/firespit.tsx",
      exportfilename = "../sprites/ui/firespit.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 27,
      name = "menu",
      class = "Gui.Menu",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 206,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 90,
          width = 208,
          height = 90,
          rotation = 0,
          opacity = 1,
          visible = true,
          properties = {
            ["color"] = "#e0641013",
            ["linecolor"] = "#ffff6161",
            ["roundcorners"] = 2
          }
        },
        {
          id = 207,
          name = "Restart checkpoint",
          type = "Gui.Button",
          shape = "text",
          x = 184,
          y = 99,
          width = 144,
          height = 18,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "Last checkpoint",
          fontfamily = "Unifont",
          wrap = true,
          color = { 255, 255, 255 },
          properties = {
            ["action"] = "restartStageCheckpoint",
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 208,
          name = "Restart stage",
          type = "Gui.Button",
          shape = "text",
          x = 184,
          y = 126,
          width = 144,
          height = 18,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "Stage start",
          fontfamily = "Unifont",
          wrap = true,
          color = { 255, 255, 255 },
          properties = {
            ["action"] = "restartStage",
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 209,
          name = "Cancel",
          type = "Gui.Button",
          shape = "text",
          x = 184,
          y = 153,
          width = 136,
          height = 18,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "Back to title",
          fontfamily = "Unifont",
          wrap = true,
          color = { 255, 255, 255 },
          properties = {
            ["action"] = "returnToTitle",
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 210,
          name = "",
          type = "Gui.Cursor",
          shape = "rectangle",
          x = 152,
          y = 108,
          width = 64,
          height = 64,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["alignx"] = -1,
            ["aligny"] = 0,
            ["asetag"] = "Spit0",
            ["movesound"] = "../sounds/combat/arrowhit.mp3"
          }
        }
      }
    }
  }
}
