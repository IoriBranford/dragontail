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
  nextlayerid = 35,
  nextobjectid = 243,
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
          id = 8,
          name = "name",
          type = "",
          shape = "text",
          x = 192,
          y = 54,
          width = 96,
          height = 18,
          rotation = 0,
          opacity = 1,
          visible = false,
          text = "PAUSE",
          fontfamily = "Unifont",
          wrap = true,
          color = { 255, 255, 255 },
          halign = "center",
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "Gui.Cursor",
          shape = "rectangle",
          x = 124,
          y = 108,
          width = 64,
          height = 64,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["alignx"] = 0.5,
            ["aligny"] = 0,
            ["asetag"] = "Spit0",
            ["movesound"] = "../sounds/combat/arrowhit.mp3"
          }
        },
        {
          id = 216,
          name = "",
          type = "Gui.Cursor",
          shape = "rectangle",
          x = 32,
          y = 108,
          width = 64,
          height = 64,
          rotation = 180,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["alignx"] = -0.5,
            ["aligny"] = 0,
            ["asetag"] = "Spit0",
            ["movesound"] = "../sounds/combat/arrowhit.mp3"
          }
        },
        {
          id = 199,
          name = "START",
          type = "Gui.Button",
          shape = "text",
          x = 32,
          y = 90,
          width = 92,
          height = 36,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "FIGHT!",
          fontfamily = "Alita Brush",
          pixelsize = 32,
          wrap = true,
          color = { 224, 33, 33 },
          halign = "center",
          valign = "center",
          properties = {
            ["action"] = "unpauseGame",
            ["color2"] = "#ffffd8d8",
            ["frequency"] = 30,
            ["presssound"] = "../sounds/combat/firehit.mp3",
            ["selectanimation"] = "colorCycle"
          }
        },
        {
          id = 200,
          name = "START",
          type = "Gui.Button",
          shape = "text",
          x = 40,
          y = 126,
          width = 112,
          height = 36,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "OPTIONS",
          fontfamily = "Alita Brush",
          pixelsize = 32,
          wrap = true,
          color = { 224, 33, 33 },
          halign = "center",
          valign = "center",
          properties = {
            ["action"] = "openMenuMap",
            ["color2"] = "#ffffd8d8",
            ["frequency"] = 30,
            ["mapfile"] = "menu_options_simple.lua",
            ["menupath"] = "simple",
            ["presssound"] = "../sounds/combat/firehit.mp3",
            ["selectanimation"] = "colorCycle"
          }
        },
        {
          id = 201,
          name = "START",
          type = "Gui.Button",
          shape = "text",
          x = 48,
          y = 162,
          width = 100,
          height = 36,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "RETRY",
          fontfamily = "Alita Brush",
          pixelsize = 32,
          wrap = true,
          color = { 224, 33, 33 },
          halign = "center",
          valign = "center",
          properties = {
            ["action"] = "openMenu",
            ["color2"] = "#ffffd8d8",
            ["frequency"] = 30,
            ["guipath"] = "retrymenu",
            ["presssound"] = "../sounds/combat/firehit.mp3",
            ["selectanimation"] = "colorCycle"
          }
        },
        {
          id = 202,
          name = "START",
          type = "Gui.Button",
          shape = "text",
          x = 56,
          y = 198,
          width = 60,
          height = 36,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "END",
          fontfamily = "Alita Brush",
          pixelsize = 32,
          wrap = true,
          color = { 224, 33, 33 },
          halign = "center",
          valign = "center",
          properties = {
            ["action"] = "returnToTitle",
            ["color2"] = "#ffffd8d8",
            ["frequency"] = 30,
            ["presssound"] = "../sounds/combat/firehit.mp3",
            ["selectanimation"] = "colorCycle"
          }
        },
        {
          id = 217,
          name = "START",
          type = "Gui.Button",
          shape = "text",
          x = 64,
          y = 234,
          width = 24,
          height = 36,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "...",
          fontfamily = "Alita Brush",
          pixelsize = 32,
          wrap = true,
          color = { 224, 33, 33 },
          halign = "center",
          valign = "center",
          properties = {
            ["action"] = "openMenuMap",
            ["color2"] = "#ffffd8d8",
            ["frequency"] = 30,
            ["mapfile"] = "menu_debug.lua",
            ["menupath"] = "debugmenu",
            ["presssound"] = "../sounds/combat/firehit.mp3",
            ["selectanimation"] = "colorCycle"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 34,
      name = "retrymenu",
      class = "Gui.Menu",
      visible = true,
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
          id = 238,
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
          id = 239,
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
            ["action"] = "restartStage",
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 240,
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
            ["checkpoint"] = false,
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 241,
          name = "Cancel",
          type = "Gui.Button",
          shape = "text",
          x = 184,
          y = 153,
          width = 64,
          height = 18,
          rotation = 0,
          opacity = 1,
          visible = true,
          text = "Cancel",
          fontfamily = "Unifont",
          wrap = true,
          color = { 255, 255, 255 },
          properties = {
            ["action"] = "closeMenu",
            ["presssound"] = "../sounds/combat/firehit.mp3"
          }
        },
        {
          id = 242,
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
