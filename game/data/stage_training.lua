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
  nextlayerid = 20,
  nextobjectid = 114,
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
      name = "Dress Form",
      firstgid = 2085,
      filename = "sprites/training/Dress Form.tsx",
      exportfilename = "sprites/training/Dress Form.lua"
    },
    {
      name = "tree1b-trunk",
      firstgid = 2097,
      filename = "sprites/sandy/tree1b-trunk.tsx",
      exportfilename = "sprites/sandy/tree1b-trunk.lua"
    },
    {
      name = "tree1b-crown",
      firstgid = 2098,
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
            ["drawz"] = -5
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
              data = "eJydk9lNg0EMhL8HdlxIwiGohggQVEAZUAUiHCIpAOiCHICogDKSCAQSsuxIvOEfS/uy2vGMZ7xQr57gRtA36BkcWAcwcC44MVgIXgVzdcOfCd4E1wr+z474geBbsJ3ab//Bv2MwVczwVcQvG6wa3Kf2mUL7wOq87tWeBdYzOLI6/35yuvebFh56j5Hq/B8Kz44ttBwaPG50830s2LWYw7W/F/BPv3y7Sx9ch/t/2v7G9zMnfz/MvbnK/RsV5n8QXDR4EUwyty2DZ8VdpS5b9HAP/e+scgc9k2p5j0WDpeK4ds+wWsP0cc29Pj8vAUBR"
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJxNk0tvjVEUhh+stXaQYOAfUKXmEokY+AXo0TKsDhDXoalLJUwkjITiH7SltBPp0OU0JOYM/AfloIm8WevLOaO99/r2ftd7WV8v4EPAvga/Ak61PE80GGtwrtbDDZ4FfAqYbPA3YBBwsMFmQC/gc8DTqvUj8Q41eF/r84D1gD/19mfAeIMvARsB/4RtsGRwzXN9ZXDdoWcwH/Ak4ED1111x0v53wILBPYNdDg8djjjcBB47XBnB6BePbzbUIKwzBncNzhpMG6wYvKnzo8IQl0VLrBOe2hfqrd7cNrjgucqz6Qa3DN4W3h2DWeC4Z395ovuXHC57+iTvB+XHRukVznrdFZ+p6qnery016c5UywxfVKaDyka1Xmnd6bDdU+uN0rVUOJuVoTL6WB5LqziMF+5ehwmH3Q7fDV5uHWrv/FB+Vz056t7oe/Xf4TBX/sobadecaBaOFjd5crF80cxpnqRPvp0HvpKY/RGui6Vprvbd/GgVH+31/X6DBzV74qtvqi8Xny538ejOym7G4Z3DSoPVNsz+pKcH4qr8uvoe1Rvsb+nbbEvv1UfzoBnatgXWPGdC3kuTPOg8Fd7pltmvWr5VH/2LuqfZPFaa5btyVF2+K3fNofzrOP2w/Gc0a/8BjQiE7A=="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJxdk0tvj1EQxn/ezJwTJFj4CFKXrYhYsJDYurTVlpUi7toGEdvWZd0utYmEILFStGUhFSxERZrwBbDwBcSlFYk8mXnjH4vJOTM5c3ue5ywU2FSht8KhCosFpgpsrHH2VFjONwMVDlT4VeC1w6TDhgo9Bo/SHhtM5/28hz/s/+K6Dzk8MXhQIj7icM1g1uCpwZzBGQ877XDKI/7MYL7ChQZ2ecz3x+CFw7ms22vw0OKufvInS+w2ajBgMO7wxWChwIzBVYNXDluJOgcNvhlsz7rDWWs6Z50HPht01Zjjq+o6TNSY5bDDcYf7wDbi3OewV288aqv/7wLXDW5YvD/hcKkJO5J5e5qwlQ4fgU8WM5/14EP7VIfLxLzjFQaB58CdBjzneOkRvwusdbhVwk52YDvzH/7CvT3nkp/Z7L1UYLN0Y1FnNONvCtwu8K6ENhbbdxW21NCVNCVOumvg+L0Elj8LvC3wvkTecvqqI07VayrjPwr0V+hLrQ0lT9Jcqz/5rY10cKk6qrkkXTiscvhAaFD7C1Phdixj8vdLHw5HCc5aXUk7yu3v2H+HeEgud3pgI3zvARMyj7n1B3ZLT6lHaVT7KcaK4GPM4GaB9ampQY9e6qsc9dJMwrEv81c7rHFY54Gx/qc0dgW42ERcvGvev9CxhwA="
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
              data = "eJztzj1Kg1EQheGHMHM/XIZFdmFtaSNaC0GIIrqGIFprIfYuwKggSSXiGrR1Ef7VcrlfsNJeyIEXZs6ZGWYSHAfPuBrwgpNgKzhI7oLb4DA5Dc6z+UfZ/O2OSTAP1pKn5DXYSM6SHYw6dpP1AQ9YSVaTx2TY8VXajVlw37Oox8leT/Uq+/mTvSUf9ZfCTeE9mRY+k82u3b/o80VWdyq1/03Xpc1WLv+YW2op/1jfQWgpsg=="
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
          id = 17,
          name = "onground",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["drawz"] = -4
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJxjYBgFIKDPzsBgwI4aFv/ZiA+bWHYGhjg0/ejgKhsDwzUsZhqyMzAYIellYscux8zOwMCCxY54dgaGBBx245MbBQwjHgAApzEGjQ=="
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
            ["drawz"] = -3
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = -16, y = 0, width = 16, height = 16,
              data = "eJztz7sNg0AUBdEjXIMbAeN6wO4HA90g8SmHNkheuMFu4IzJJhhdXW5u/k+NBi+04XtB36HHB9/wkn7ADyOm8KXK71dssXmEnwV96v/zkd+n/r/z8+T/GRf+MxMX"
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJzNkU1qAkEQhT+rrmCOYQxi1kKEXCI/aFxHDMk5HHVrNvEUcWGy1o05hV7BjUSKqcGCGYOSjQ+apuj309RLgCHQAupAAnT8tIFv4AuoAdfOG/r7raZ3K3CM/6qAQEmgofDkmprzjNMHppLeA882v98SfChcClQFnoNXV/f/s8y16+ue+aZQEVgq3As8CIyD17v7m9+nwAiYea5lThTuBLaW6ZgHr4X7m99K0nz7y9ozf4KuCBv3N7+ywkXgx8xjcKPQPFET0VN4+Yc+QxJ6y3oSyc+23yLE3rKeriQ/236LEHvLenqU/Hxov8sjevsLp/Z2btgBmBo6TQ=="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJylkrsNAjEQRN/ttkAb/EVMIXyEIIaEOqABSOgCiWsAErqgBhIEcmDd2sKBzyNtMCuNPGu9vQIClYCY+Vbh3vudwoZGF4WeQF9gYKYr4d77s8JVmvxTYS6wEFiamUm49/6h8DL5j+ufobdCJzMT61AW51aY3xb2PxXm7/q/U4oZ66cKa2AMjKJOKWasd+84BifAKuqUYsZ6945n8Njyds9g3ebzDIP2/lwNo/tz5Rh29/8AZAYoag=="
            },
            {
              x = 32, y = 0, width = 16, height = 16,
              data = "eJztzzsRgDAABcHVFIIfPn4C+IFgDQ+vYybXb3GMRnkTKmaUwK/YsGMJ/IETF1rgH3S8uAP/9/8PHiUMGw=="
            },
            {
              x = -16, y = 16, width = 16, height = 16,
              data = "eJzty7sVgCAQAMGpScF6BDuyHj+tkVwB+Exvsg2WORduPHijN/MWrCio0eeHf0dDxxGdUvLLAMKOB2E="
            },
            {
              x = 16, y = 16, width = 16, height = 16,
              data = "eJxjYCAPxDMwMOxhIB8YMjAwGFGg34KBgSGBgTLQR6H+UTAKGIY4AAAp9wKl"
            },
            {
              x = 32, y = 16, width = 16, height = 16,
              data = "eJzty0EBgCAQALBlUuij0Ae0j2I1M3hf2X83Bh5cvluRkLEE/o6Cii3wOw6caIE/TX7sBVN1B4k="
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
            ["drawz"] = -2
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
              data = "eJztzbkNgDAQRcHh8LoqqoUOgDKgCPpAIrDJyUg80uplf2maxk/2YIvSMZhT6VdT5s5cwZE4E2sw1M23748u6OstiQes2As4"
            },
            {
              x = -16, y = 0, width = 16, height = 16,
              data = "eJzV07EuREEUxvFfc868yBLxDsQzbIRNJN6HXkSERiVoFHbRigiVR8ATKChEQm7u3Wjn3s7XnGb+5//NJEO/nATT5DV4yZ4wdpLtZBZ8lP78VnIVvAWrA/yz5KfjVwbwTXaT22BtIP8cXCc3A/n/ms/gPDnLv1mbg+AieUqWC4fJe9Sx98FdtNy4sFAYFTYq/aNksbBU2Cwcde7LCn7e+ztb73q2O2rd4+Qh2Wv+SzApHCenyVfF/Rv+sTvf9Gjebd5/P/gF+UUrDw=="
            },
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJztkLsJAkEQhr/kn00NDksxF+3B1A68SizAxNMSFATFJrQDA8UShPPFuBuI0eFm4gfDDLM7/zyKAB2DMkDb4Cg4KMalwVnQNRgl6xusBLVgJriEaK0AU8HGYG1wFdwEd0Gl+FYl3ZNgYLxYCgqDnsE45T7ZCfaK3vUegmH663qu7T19nibMBdtUX7/F39C0568yydx/kXH7P2TzBHlRIJI="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJztkLsNgFAQw9wka1CwEQvBFAiWgCH4zIWuo84rwb0VK/DzVVZl3i24BL0zfzR0hqHBPwRn2L8ZdsMc+kV9kO4Xi9r2iyn8793wAK0BC2g="
            },
            {
              x = 32, y = 0, width = 16, height = 16,
              data = "eJxjYBgFQxn8YqVM/0o2BoajFJhxio2BQZ6NfP3a7AwMh1nJ98c5NgaG32wMDGFkuuErGwODKjsDgy+Z+r+zQXALmfpBdsPCYBYZYfCVlYHhLxsDwzc2BoZqMtwAAG/0ENU="
            },
            {
              x = -16, y = 16, width = 16, height = 16,
              data = "eJztzrEJgDAURdHb/JdVxF3cySWC4gY2Fi4RsXAbG0EQiZWFGGwscppX3c+HZ4NgNSgclA4WgTeYjNdqwS7YFPte0CX0weIP/tpZUIkkrUFjcc8bqf39n/FDn2X8xAHb6hIZ"
            },
            {
              x = 16, y = 16, width = 16, height = 16,
              data = "eJxjYCAPzGRlYPjJSqZmBgaGGawMDF8p0H+MlYHhCAX6VdgYGLTZKXP/JwrsHwWjgGEQAABQpQa4"
            },
            {
              x = 32, y = 16, width = 16, height = 16,
              data = "eJw7wsrAMJ+NgWEOGwNDCxsDyWA2GwPDTDYGhkh2BoZqMvSD9J1kY2D4yMrAsIkM/T/YGBhOsZFnNwh8YoVgcuweBaOAYYgDAKQHDI4="
            }
          }
        },
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 30,
          height = 15,
          id = 16,
          name = "bottomwall",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["drawz"] = 1
          },
          encoding = "base64",
          compression = "zlib",
          chunks = {
            {
              x = 0, y = 0, width = 16, height = 16,
              data = "eJxjYBgFAwmSGBgYLBkYGLjJ1L+PgYFhAtQMKzLtN2JgYDBhYGCYyMDAwA7FrAwMDCxQDGJzkOm+UcAwqAEAgjAD6Q=="
            },
            {
              x = 16, y = 0, width = 16, height = 16,
              data = "eJxjYBgFQw3spkCvOQMDgwUWcS4GBgY2KGZnYGBgQeLDxFihevdSYP8oYBhUAADG1AJf"
            },
            {
              x = -16, y = 16, width = 16, height = 16,
              data = "eJxjYBi6wHKgHTAKRgHD0AYAviQAOg=="
            },
            {
              x = 0, y = 16, width = 16, height = 16,
              data = "eJxjYBhYYDXA9o+CUcAwggEAzwAAOw=="
            },
            {
              x = 16, y = 16, width = 16, height = 16,
              data = "eJxjYBh6wHygHTAKRgHD8AAAuVQAOA=="
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
            },
            {
              id = 103,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 96,
              y = -128,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -96, y = 128 },
                { x = -96, y = 336 },
                { x = -32, y = 336 },
                { x = 32, y = 272 },
                { x = 32, y = 128 }
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
              id = 102,
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
                { x = 128, y = -32 },
                { x = 128, y = 112 },
                { x = 160, y = 112 },
                { x = 192, y = 80 },
                { x = 256, y = 80 },
                { x = 288, y = 112 },
                { x = 352, y = 112 },
                { x = 352, y = -32 }
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
              id = 101,
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
                { x = 352, y = 112 },
                { x = 384, y = 144 },
                { x = 448, y = 144 },
                { x = 448, y = -32 },
                { x = 352, y = -32 }
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
              id = 100,
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
                { x = 544, y = 48 },
                { x = 896, y = 48 },
                { x = 928, y = 80 },
                { x = 960, y = 80 },
                { x = 960, y = -32 },
                { x = 512, y = -32 },
                { x = 512, y = 80 }
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
              id = 95,
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
                { x = 608, y = 256 },
                { x = 576, y = 288 },
                { x = 576, y = 304 },
                { x = 608, y = 336 },
                { x = 896, y = 336 },
                { x = 896, y = 256 }
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
              id = 98,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 320,
              y = 0,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 256 },
                { x = 576, y = 288 },
                { x = 576, y = 368 },
                { x = 640, y = 432 },
                { x = 640, y = 256 }
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
              id = 99,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 320,
              y = -176,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 288 },
                { x = 608, y = 432 },
                { x = 672, y = 432 },
                { x = 672, y = 288 }
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
              x = 568,
              y = 224,
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
              x = 888,
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
              x = 792,
              y = 216,
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
              x = 752,
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
              x = 688,
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
              x = 568,
              y = -16,
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
              x = 888,
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
              x = 792,
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
              id = 36,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 752,
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
              x = 688,
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
              x = 416,
              y = 216,
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
              x = 392,
              y = 240,
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
              x = 424,
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
              id = 26,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 432,
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
              id = 27,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 408,
              y = 234,
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
              gid = 2097,
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
              gid = 2097,
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
              gid = 2097,
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
              x = 408,
              y = 186,
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
              gid = 2098,
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
              gid = 2098,
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
              gid = 2098,
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
              x = 392,
              y = 190,
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
              x = 424,
              y = 184,
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
              gid = 2097,
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
              gid = 2098,
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
              id = 104,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 64,
              y = 208,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = -64, y = 0 },
                { x = -64, y = 224 },
                { x = 0, y = 160 },
                { x = 64, y = 160 },
                { x = 64, y = 80 },
                { x = 0, y = 16 }
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
              id = 106,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -64,
              y = 352,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 64, y = 0 },
                { x = -64, y = 0 },
                { x = -64, y = 272 },
                { x = 64, y = 272 }
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
              id = 107,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1024,
              y = 352,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -64, y = 272 },
                { x = 64, y = 272 },
                { x = 64, y = 0 },
                { x = -64, y = 0 }
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
              id = 105,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 192,
              y = 208,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 128, y = 80 },
                { x = -64, y = 80 },
                { x = -64, y = 160 },
                { x = 128, y = 160 },
                { x = 160, y = 128 },
                { x = 160, y = 112 }
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
              id = 108,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 448,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -144 },
                { x = 0, y = 96 },
                { x = 8, y = 96 },
                { x = 8, y = -144 }
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
              id = 109,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 504,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -144 },
                { x = 0, y = 96 },
                { x = 8, y = 96 },
                { x = 8, y = -144 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -48,
                ["linecolor"] = "#80ffffff"
              }
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
              visible = false,
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
              visible = false,
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
              visible = false,
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
            },
            {
              id = 110,
              name = "backtostart",
              type = "Trigger",
              shape = "polygon",
              x = 472,
              y = 168,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 8, y = 24 },
                { x = -8, y = 40 },
                { x = 0, y = 40 },
                { x = 0, y = 56 },
                { x = 16, y = 56 },
                { x = 16, y = 40 },
                { x = 24, y = 40 }
              },
              properties = {
                ["action"] = "returnToTitle",
                ["color"] = "#00000000",
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["linecolor"] = "#ffff5555"
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
              visible = false,
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
              visible = false,
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
            },
            {
              id = 85,
              name = "",
              type = "training-target",
              shape = "rectangle",
              x = 64,
              y = 144,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2086,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 91 },
                ["z"] = 48
              }
            },
            {
              id = 89,
              name = "",
              type = "training-target",
              shape = "rectangle",
              x = 200,
              y = 56,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2086,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 93 },
                ["z"] = 48
              }
            },
            {
              id = 87,
              name = "",
              type = "training-target",
              shape = "rectangle",
              x = 360,
              y = 88,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2086,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 96 },
                ["z"] = 48
              }
            },
            {
              id = 86,
              name = "",
              type = "training-target2",
              shape = "rectangle",
              x = 120,
              y = 96,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2092,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 92 },
                ["z"] = 48
              }
            },
            {
              id = 90,
              name = "",
              type = "training-target2",
              shape = "rectangle",
              x = 280,
              y = 80,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2092,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 94 },
                ["z"] = 48
              }
            },
            {
              id = 88,
              name = "",
              type = "training-target2",
              shape = "rectangle",
              x = 400,
              y = 120,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2092,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 97 },
                ["z"] = 48
              }
            },
            {
              id = 81,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 248,
              y = 216,
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
              id = 112,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 264,
              y = 224,
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
              id = 78,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 216,
              y = 200,
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
              id = 111,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 248,
              y = 192,
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
              id = 77,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 224,
              y = 224,
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
              id = 80,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 240,
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
              id = 113,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 200,
              y = 224,
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
              id = 79,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 232,
              y = 210,
              width = 64,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 2097,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 0 },
                ["fruit2"] = { id = 0 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 83 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 83,
              name = "",
              type = "",
              shape = "rectangle",
              x = 232,
              y = 162,
              width = 64,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2098,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 48
              }
            },
            {
              id = 91,
              name = "",
              type = "",
              shape = "point",
              x = 64,
              y = -64,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
              }
            },
            {
              id = 92,
              name = "",
              type = "",
              shape = "point",
              x = 120,
              y = -112,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
              }
            },
            {
              id = 93,
              name = "",
              type = "",
              shape = "point",
              x = 200,
              y = -152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
              }
            },
            {
              id = 94,
              name = "",
              type = "",
              shape = "point",
              x = 280,
              y = -128,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
              }
            },
            {
              id = 96,
              name = "",
              type = "",
              shape = "point",
              x = 360,
              y = -120,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
              }
            },
            {
              id = 97,
              name = "",
              type = "",
              shape = "point",
              x = 400,
              y = -88,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 256
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
              visible = false,
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
              x = -240,
              y = 288,
              width = 1440,
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
              visible = false,
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
