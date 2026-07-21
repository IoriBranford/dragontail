return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 200,
  height = 12,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 103,
  nextobjectid = 1063,
  backgroundcolor = { 64, 64, 64 },
  properties = {
    ["ceilingz"] = 256,
    ["runphase"] = "Dragontail.GamePhase"
  },
  tilesets = {
    {
      name = "caves",
      firstgid = 1,
      filename = "tilesets/caves/caves.tsx",
      exportfilename = "tilesets/caves/caves.lua"
    },
    {
      name = "cavedoor2-diagonal",
      firstgid = 2449,
      filename = "sprites/bandit/cavedoor2-diagonal.tsx",
      exportfilename = "sprites/bandit/cavedoor2-diagonal.lua"
    },
    {
      name = "barrelA",
      firstgid = 2453,
      filename = "sprites/containers/barrelA.tsx",
      exportfilename = "sprites/containers/barrelA.lua"
    },
    {
      name = "barrelB",
      firstgid = 2456,
      filename = "sprites/containers/barrelB.tsx",
      exportfilename = "sprites/containers/barrelB.lua"
    },
    {
      name = "crates",
      firstgid = 2459,
      filename = "sprites/containers/crates.tsx",
      exportfilename = "sprites/containers/crates.lua"
    },
    {
      name = "tables-hori",
      firstgid = 2465,
      filename = "sprites/banditcave/tables-hori.tsx",
      exportfilename = "sprites/banditcave/tables-hori.lua"
    },
    {
      name = "graffiti-skull-bones",
      firstgid = 2468,
      filename = "sprites/banditcave/graffiti-skull-bones.tsx",
      exportfilename = "sprites/banditcave/graffiti-skull-bones.lua"
    },
    {
      name = "dish-small",
      firstgid = 2482,
      filename = "sprites/weapons/dish-small.tsx",
      exportfilename = "sprites/weapons/dish-small.lua"
    },
    {
      name = "Meats A",
      firstgid = 2483,
      filename = "sprites/items/Meats A.tsx",
      exportfilename = "sprites/items/Meats A.lua"
    },
    {
      name = "Bread A",
      firstgid = 2538,
      filename = "sprites/items/Bread A.tsx",
      exportfilename = "sprites/items/Bread A.lua"
    },
    {
      name = "Cheese A",
      firstgid = 2546,
      filename = "sprites/items/Cheese A.tsx",
      exportfilename = "sprites/items/Cheese A.lua"
    },
    {
      name = "Forge A",
      firstgid = 2564,
      filename = "tilesets/Forge A.tsx",
      exportfilename = "tilesets/Forge A.lua"
    },
    {
      name = "Workbench, Smith",
      firstgid = 2692,
      filename = "sprites/banditcave/Workbench, Smith.tsx",
      exportfilename = "sprites/banditcave/Workbench, Smith.lua"
    },
    {
      name = "gamepad-buttons",
      firstgid = 2698,
      filename = "tilesets/ui/gamepad-buttons.tsx",
      exportfilename = "tilesets/ui/gamepad-buttons.lua"
    },
    {
      name = "keyboard-keys",
      firstgid = 2798,
      filename = "tilesets/ui/keyboard-keys.tsx",
      exportfilename = "tilesets/ui/keyboard-keys.lua"
    },
    {
      name = "Chair, Dining F",
      firstgid = 3070,
      filename = "sprites/banditcave/Chair, Dining F.tsx",
      exportfilename = "sprites/banditcave/Chair, Dining F.lua"
    },
    {
      name = "flamegaugefull",
      firstgid = 3086,
      filename = "tilesets/ui/flamegaugefull.tsx",
      exportfilename = "tilesets/ui/flamegaugefull.lua"
    },
    {
      name = "vegetables",
      firstgid = 3094,
      filename = "sprites/items/vegetables.tsx",
      exportfilename = "sprites/items/vegetables.lua"
    },
    {
      name = "boss",
      firstgid = 3101,
      filename = "sprites/bandit/boss.tsx",
      exportfilename = "sprites/bandit/boss.lua"
    },
    {
      name = "bow",
      firstgid = 3102,
      filename = "sprites/bandit/bow.tsx",
      exportfilename = "sprites/bandit/bow.lua"
    },
    {
      name = "spear",
      firstgid = 3103,
      filename = "sprites/bandit/spear.tsx",
      exportfilename = "sprites/bandit/spear.lua"
    },
    {
      name = "sling",
      firstgid = 3104,
      filename = "sprites/bandit/sling.tsx",
      exportfilename = "sprites/bandit/sling.lua"
    },
    {
      name = "knife",
      firstgid = 3105,
      filename = "sprites/bandit/knife.tsx",
      exportfilename = "sprites/bandit/knife.lua"
    },
    {
      name = "throwing-axe",
      firstgid = 3106,
      filename = "sprites/weapons/throwing-axe.tsx",
      exportfilename = "sprites/weapons/throwing-axe.lua"
    },
    {
      name = "stone",
      firstgid = 3107,
      filename = "sprites/weapons/stone.tsx",
      exportfilename = "sprites/weapons/stone.lua"
    },
    {
      name = "Xbox",
      firstgid = 3108,
      filename = "tilesets/ui/Gamepad Spritesheets/Xbox.tsx",
      exportfilename = "tilesets/ui/Gamepad Spritesheets/Xbox.lua"
    },
    {
      name = "tree2B_ss_leaves",
      firstgid = 3128,
      filename = "sprites/grassland/tree2B_ss_leaves.tsx",
      exportfilename = "sprites/grassland/tree2B_ss_leaves.lua"
    },
    {
      name = "tree2B_ss_obj",
      firstgid = 3129,
      filename = "sprites/grassland/tree2B_ss.tsx",
      exportfilename = "sprites/grassland/tree2B_ss.lua"
    },
    {
      name = "tree2C_ss_leaves",
      firstgid = 3130,
      filename = "sprites/grassland/tree2C_ss_leaves.tsx",
      exportfilename = "sprites/grassland/tree2C_ss_leaves.lua"
    },
    {
      name = "tree2C_ss_obj",
      firstgid = 3131,
      filename = "sprites/grassland/tree2C_ss.tsx",
      exportfilename = "sprites/grassland/tree2C_ss.lua"
    },
    {
      name = "spikefruit-hanging",
      firstgid = 3132,
      filename = "sprites/weapons/spikefruit-hanging.tsx",
      exportfilename = "sprites/weapons/spikefruit-hanging.lua"
    },
    {
      name = "spikefruit-onground",
      firstgid = 3133,
      filename = "sprites/weapons/spikefruit-onground.tsx",
      exportfilename = "sprites/weapons/spikefruit-onground.lua"
    },
    {
      name = "lifefruit-hanging",
      firstgid = 3134,
      filename = "sprites/items/lifefruit-hanging.tsx",
      exportfilename = "sprites/items/lifefruit-hanging.lua"
    },
    {
      name = "lifefruit",
      firstgid = 3135,
      filename = "sprites/items/lifefruit.tsx",
      exportfilename = "sprites/items/lifefruit.lua"
    },
    {
      name = "tallstone",
      firstgid = 3136,
      filename = "sprites/weapons/tallstone.tsx",
      exportfilename = "sprites/weapons/tallstone.lua"
    },
    {
      name = "pepper-plant",
      firstgid = 3137,
      filename = "sprites/items/pepper-plant.tsx",
      exportfilename = "sprites/items/pepper-plant.lua"
    },
    {
      name = "peppers-on-plant",
      firstgid = 3138,
      filename = "sprites/items/peppers-on-plant.tsx",
      exportfilename = "sprites/items/peppers-on-plant.lua"
    },
    {
      name = "muscle",
      firstgid = 3139,
      filename = "sprites/bandit/muscle-orange.tsx",
      exportfilename = "sprites/bandit/muscle-orange.lua"
    },
    {
      name = "cave-window",
      firstgid = 3140,
      filename = "tilesets/caves/semiblocked-tunnel.tsx",
      exportfilename = "tilesets/caves/semiblocked-tunnel.lua"
    },
    {
      name = "shield",
      firstgid = 3141,
      filename = "sprites/bandit/shield.tsx",
      exportfilename = "sprites/bandit/shield.lua"
    },
    {
      name = "castle_decoratives",
      firstgid = 3142,
      filename = "tilesets/castle/castle_decoratives.tsx",
      exportfilename = "tilesets/castle/castle_decoratives.lua"
    },
    {
      name = "stain",
      firstgid = 3398,
      filename = "sprites/vfx/stain.tsx",
      exportfilename = "sprites/vfx/stain.lua"
    },
    {
      name = "torch",
      firstgid = 3399,
      filename = "tilesets/castle/torch.tsx",
      exportfilename = "tilesets/castle/torch.lua"
    },
    {
      name = "desert-decorative2",
      firstgid = 3407,
      filename = "tilesets/sandy/desert-decorative2.tsx",
      exportfilename = "tilesets/sandy/desert-decorative2.lua"
    },
    {
      name = "desert",
      firstgid = 4431,
      filename = "tilesets/sandy/desert.tsx",
      exportfilename = "tilesets/sandy/desert.lua"
    },
    {
      name = "crystal-spikes",
      firstgid = 6501,
      filename = "sprites/banditcave/crystal-spikes.tsx",
      exportfilename = "sprites/banditcave/crystal-spikes.lua"
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
      name = "cavefloor",
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
          x = 20, y = 12, width = 20, height = 12,
          data = "eJzt0MENgCAQBdGRZJPdfoCa8CAN6QFrwoLsgfwjU8A7DOxWugy66d4Ng1foTYNP6BWH6jqvOZxC73Z4hJ66IyCFzssBJeAHfVsHFQ=="
        },
        {
          x = 40, y = 12, width = 20, height = 12,
          data = "eJzlzNtRwmAUBsCdgYTvWJAJFxtSMDbkBegIDfX4QgX/8MYWsDyWqbvvd7rzN9++PqxCQoWntH1DGMM6bMI27MJL4/ca3sI+HMJ7mMJH4/cZvsJ3+AnHcArnxs/NJfyGvzCHa+O3KJZFV/TFqkhR1fY9F0MxFutiU2yLXeP3D5ZkEmI="
        },
        {
          x = 0, y = 24, width = 20, height = 12,
          data = "eJzNkVsKwjAURM+HuU187Me24mM3CtouyA/RJakLkpBALiWN0i8LQ4Zpciczgf/97mb6uW942cQ7B0dX3j9z8FBn6rj/pjSNSs3bGtgZEIFDXCsBK0nfmwA942yhi/Ofymcu0BhYCqwEFhK41zxvTeDtDz347HrVvXhcMvkal/JJ5n+rsq9H+ilh6Ol73wzep3fpLt7vWvAZe6Mx5DJp5LzeA+3kwEatntBBCb3iHxdaZz4="
        },
        {
          x = 20, y = 24, width = 20, height = 12,
          data = "eJytkv1Kw0AQxH8om96K+jS2CKlUfRmtJfWFqtQ+Uj/eR4bemU0w9J8cDJdLcrMzswvjrDeHd4cfazHGGpvPssapw9Fgbef9kGvMUrdmwTa8f3CoHT4cFgbPBi8Gr/n7JME8wafDdICvYJb1VDm/uwpuK6gN7quzvr24Bu5/9fjlyxM0wVPBOsHOYJlgGXo18VZ3HfhiP3XvOpyf8n/H7EGZfF/wGiE/Ta9+6cOVt9pXvZkawjb4lc8/zwaP3s3vpqdzFc7luQmZi1u7+KVZWVzSozlTzqW38lZ4ojbxqWacu80/OUpP52xwMvgFElFmNQ=="
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJzdkgtOxDAMRAeWSPF9lu+F2F1IeyLEliu15TzokbHIGagUxbWdmfHnHNIlpLeQ3kNqIU0hzaF/+W1Fmop0E9JS+jlSs++T7bvouVfnPDr/HNJepIPzyMGPb3I+divSl+3d9ubz6p4/Vem59txW//QQa8a6mmsuUgx+9MM3+8DxYbx50AIXmHChgfq+a+c4mXN1LtrABwPfYhzezb7Zj2Y+8lfH2tCHizV81v5/P/QOjOo4PV4HnN06Mpbck2v/1cnb2n2LY8zmJeP28x5N4bpTI3HuB/cUe6vSreeKr1hn1pPvVvclfTl7sOgzMWbFbOjviIHGao7cQTDpCZzcaE4NxJMj9yz3AK1Z5w/t0GII"
        },
        {
          x = 60, y = 24, width = 20, height = 12,
          data = "eJzlkg1OAlEMhAfxxfY+ClHwPP7ieh+jATwSrucx33ae2XgFSV66bafTTov0v377Ji1SOjRpbNIppNeQzlM6NekhpV2rd2zSKio+2n9p0jbre5jF9rbDzN6ntErpq0lhXnCP1Ef5B+Ov3ecyC0MtD/6jcXA9ZXEvUzpL6Tlqtp1r4YZv9KP3d0hr6yM2uAb+hfFd9/hHX+c+2tJvHTX/R1TPSW9KV/4GdxPSZ1SM3b55x7sozMZYZqDPIWrWwTdBH7X4C8/OXu6sGe3LlG6ZpRWWvnDig/+9oXk6Fh56MQ+W2LQXY7ZRO+o5+pNjR70W/fSYbukYN3qPwrEb/P7/6DrJUTfpnN0fPcQuZvk+Kzlsev6uB84f8NlZ/Q=="
        },
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJzlkgtuwkAMRIfCSvZ9WlEB92kDKjlR1RKOBPQ81cuO1dyhkSzv+jOeHUf6X99rSO8pTU36aNJnSKeUzk2KkJ5SWqU0OHZr0neTLq33DM5zfzTpmNIxpF30PDFylWfGW0qblK7R8ciNTdpnn8f55vrR8+g7RPfY5BzcMWp/zJ346DuzRs9Yp7QzV6yw7guOhcs78C/Z+ybnucNnZQ/PyRjYI3rfwZwG11Ut78bDGW7ES3vO2+w4YIS5lvYX9z1bJ3DO5kbv2ns6RcdAr7Rm8CVGvvStd3Nm7/CFP3HuvJW5xaf2W1p9xd9eqdkbA7zSCT94zzNfW+k/e/cRJ4aHL7M4L/e/7J3/rcWO4fgLCJJfnw=="
        },
        {
          x = 0, y = 36, width = 20, height = 12,
          data = "eJxjYMAOFrKSjjM4cRhGpnmkAHL1jYJRwDCEAQC5IhNA"
        },
        {
          x = 20, y = 36, width = 20, height = 12,
          data = "eJxbyMrAsBCKR8EoGAUMQwoAAEfSAfM="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 94,
      name = "sandy",
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
          x = 0, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMJABnooxMLiIMzAIimOK/8Aijq7mmzgDg6s4xAwQLSDOwLBUgoHhK5JekLqf4gwM5VBxZ3EGBjeonJM4AwMAROENmg=="
        },
        {
          x = 20, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNAAPBVjYPguzsDwTAwhBuJ/E4fQguKkmXdanIHBU4KBgV+cgcEZigE9Kwh0"
        },
        {
          x = 40, y = -12, width = 20, height = 12,
          data = "eJzt0LsJgFAMRuGzgS+4f6axuKIrOYsTOYeFuIFoIxbGXrGwuQfSfgmBVOr/SsEmaAWFvllRsAtkEA3GD95tmcEUoBYcgjlc966C7oWfCxafwZ3Gd1QGvUHmv3jinmjXE38="
        },
        {
          x = -20, y = 0, width = 20, height = 12,
          data = "eJxjYBgFpAIhcQaG7+IMDD/EqRN2+eIMDCtFGRjYxKhj3lxxBgZjMQaGP4LUMW+eOAPDXjEGBh4que+JGAPDX3EGhkdUMo8BCkD+piYAuXOwAwCGDAwP"
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJzNkckuRFEQhr8NLWmC5pwq7RWsxcrYhIUXsRFiWHkMy+429QKxtTSlvYNg24bGUkSQSOXUjfsIblKp+m/VX/VXHYCSQJ9AQ2FK4VGg7PGbwItAr8CHwKfjPYVVhSGFd4GK92jF5OsKUWFHYFZhRqEjQjPCUUhxZ4Qut2u3Zu6fWVXgMEDBcZ5/HGArwlWE+wAnAc4idEfocTN8EaHo3rQtRQglGCnBaT/chT9+0fnnES4jrCjM+56vAgcKuwoPku5TcB1jAosRtgVGY+pl/JbAnO9v9dbPbrevsOm3Fk33Nn8b0uyL3A4W34TEsfkNr20LLPsbmR7DTwIbmt4oaNKwoDBsb+E7RNfQ8F3qrmtaoep4zfOm+Vmg5rlKrn7daw78nQ3XfJbpM22mqer7WR+zTL/dxXDF88Yf1KTfeKZnIHezsvdf8xltn2mzbQ/b7VtgUuBH4MvjcccWT+TyVptZ9j/zGe+/f7+H6HL/"
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJzNkUlOQ0EMRN8KEINYQNoG7sKUgeQ0hATBaUIG4BgEUJJDcADCvGUQICGr60s5Al8qfbddrrK7pwZNh0eDVYOKQdng3eBT54g/ZvKBqsGXQcdh3eHM4dhhlDLmEowTTBIsJJhXbqL8gnhj1Ub6F7yitpzgZgZ3JVhMsKLzteKhUOSGyhf1JdVeDNyh77DhcJXgNsG9wb5D2XP9waDk0HOYWkbwk+f7iv6O4i2HlnLBa6kvNPY861Yc6g4Dh7Z0wjM0TjzzqqpF75HDq0HPoKv3Cf9ng5p6zHN86Hmv6C92CJ2G+tbkdyluzFcS+nq7uuY50Bxl8c7lGToXurOBehuatSn/N4Mnyz6hGXHcR089sUtb3BP5xW5dedV1D9FX3FdN/qG9KV6cQ+tUc8ROMXfUdgy+Lf9/hF2DX+UDEQe2Z+KCF7mCHxr//fsDtaF7Yw=="
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJyNk8tOlFEQhL+NIHgjYf7uFh7DvQZhAB/ElQsdRHwaYERcyII3AC+Ar6CJOxNUvCwNJrowlVOTcaeTdPqc093V1dX/DAsWC74l/EiYSbgQMBkwETAV8CnhY8K9hNOApYR+ws+ExWz3c59VdxRwYtvr4EbAdMB+B68DLhr3mvs978b95I99Vt6LgMv2o/o3AXcD3nZwKeBqwPuu5U86Pu2aw4CXf9X3PetswUG0etm7DrYKVqvhjvpeMcargK+uGyY8cd6g2ttCwa7rhwXrBQ8dm6um4Z2CZ8595Lje1goeFFTBqfS0Vz/hn9mvFHxO+GKsXsHtgvvGVU3PPDbN47FjmnnXvLarzZo13u3APJS343PP/nrBcsFT5ysurIHz13wXrzm/K3/HnFc8q3RbMO6S4+IsjHVrFzXOmfVd8b5xVj1vuHZo3cSrK7iZzW7Zftv09ivhQzSc0X60B/UTN+ksP19tv/pf/Ou3lbBRrUZ6Smth6037kw7akbQT1//B03yaXd/E92wzS1dpJh3ES/3E9Q9KtXw6"
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJytkstOlkEMhp8VJzEEdNqC1+BFIPyoV4Oiwo2wwAWIp4VIWLNBxcM1IO7hRw5bwZ15037BuJPwJc3MfG2fvu3MhcOMw6FxLd+gwbDBmEOv2L8cxv1qvO1x+Gyw0eBewInnKv5s8Xv/wb9hsNUumfMBMwHTAUuR7JcBzx0min9ePVz805NsKmCvwX6DZYPJgMVI7lrAscPT0vvb4XbAgcORw51IexLwrsGQJU/xKwabDb4ZfDH4WqvOA7UOlQ3+FdP9e9+gHzAbqWmn+r47ARsGIwY3DUYNPpTvR8uz9p2/M8V8suxHzKliyvfRYNdyfgsBfc+ZfG9w6hmnvfo8c5gLeBGXZ83iUeTaL/5RzWqt7uRNwE9PvvoRw+s9KPd+wNuAVxUfkfm6B/2X3geRsdIkju55vTSojvziaS/e64rXuVc1pU1v5WFAq3rKf1yau9hDzzqqr5mJpZ6lWXNSL6onjdJnVV9vR2zpUk5XQ3m3IuvI9yxgNeAPG31zhg=="
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJzlkb0uRFEUhb9qGIQId58lHoSWYfAimikIQeMdNBoFBtF6AyJEPAIi0fmJn9JPKTtnTzIZuaF3k5W9z83Od/ZaB/7X95GyvkKfoakE09HXog6m33ldBhWD86jdBhehSltfNbj8A6/HoM/gxOA01NtWjwrYTDBm8B57P1g577qAJFgVrAh2BLNxfklwVcBNAbdF3r0a3DLmgWA4tCQYjX4yeK8Jji0z1w3OgrlV4n1Z8Ob3JWgKFpT/Pbu32PM+9uw3uEswbzBQ8j6PwVkTTLSxR5R5Jmj6TDA9z9aO7rvewawJ6oIZwbZgLzL0vgjvnoFz/a5WnuMGi/rpe1+wKzgUPKXs1ec8O+99ryHBnHLWPr9h+b0970YH7xtVR1Ip"
        },
        {
          x = 40, y = 12, width = 20, height = 12,
          data = "eJxjYMAPnogxMNiJMzD8FWdg+C3OwGAPxSD+HyiG8R3ECRg2CkbBKGCgJgAARqkJHQ=="
        },
        {
          x = 60, y = 12, width = 20, height = 12,
          data = "eJxzEGdgsIPiP+IMDA7iDAz2UAzi/4XK2UPZMHkHqDxML0z9KBgFo4CBbgAAHSALKA=="
        },
        {
          x = 80, y = 12, width = 20, height = 12,
          data = "eJztzsEJgDAQRNFfhM5Uo6ZHq7AIES96sAuxCxUkEPBuTkIeLAvDskwwXIbOENLchjNlcbfpZhcMNSyCXtAYKvPZZhgFk2AWrBm/okNv55DZrSj4gQeJShJC"
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 27,
      name = "onfloor",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -1.5
      },
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
      name = "cavewall",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -1
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 0, y = 12, width = 20, height = 12,
          data = "eJzt0MEBQDAUBcF5TQklISVJtOrqzvFPAXtYSilLaGENW77/2MMRztB/6F1hhBnuV+8BcdsFCw=="
        },
        {
          x = 20, y = 12, width = 20, height = 12,
          data = "eJzt0LkNwlAQBNA3AjmjHY7M7XCELocrox3HrgZ9fSpYUr9kNMFssKxW3YQ3hnDENszYpPahDw7tVjiFfXpvWbHgEq7hFs7pvWXFLjzCM7zC/ddbVozF3T++k60Lhg=="
        },
        {
          x = 0, y = 24, width = 20, height = 12,
          data = "eJztzjEKAkEUg+HvvUJlD6Ss4oGUVTyQYqNeyevI4EyzsIWdoD+EhJAi/B4dZsk8WSQ33PGo+pQt+mSdbJInVsEy3l5U6Gs3zm3bOGFIDskx6YJ9sKteVBhqN85tO/k3uATn6kWFa+3GuW3/+Dpe7ScTEw=="
        },
        {
          x = 20, y = 24, width = 20, height = 12,
          data = "eJztkEEKwkAMRd8HXYnXsdWFeJ22uih4nKl153VEd55G0mYgFHGhK8EPISGf98kMfK4rUAN3oAR6vlPOOgBr4Dbxj155nul93hlogLnGvM2LvIvdbr6gCN12D2AvqAQLwcor+zZn1lQ402jk6tBttxT0giTYem4VfJszO/yHMyfnutBttwvvbz03BT8F1tRNmL/4eT0B/lUgYA=="
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJztkEkKwkAQRV/hsFBzHaOCw3VM3CgeR40L0es4LBxOI0V+sIkoolsLmvyq7v/yqSVwBGKgbrAnPz7LgJN0F6jqvmKw0szvUx10d5DXtb+pGfSANdCRzzmJvrE4mbSzd0Bbfvdd1ccGHZ+X9Eb/WYlb5PfM7r0B48DTsrxPDFKDSUmfyZkT5fEcc+Vyb2SwCDxD9UvPYJCVdEPMi3JuxfJc7h1Zvr/CM1P/qvpiNu2xF2dFH3jfMQfBXqIg17c1DfbyK+tfPNUdagI0Fw=="
        },
        {
          x = 60, y = 24, width = 20, height = 12,
          data = "eJztzj0KAmEMhOEnoI3exz/Q++jaeB93tdADiYUeRxay8PFVClbiwJB3EgjDdzUPFsEyXeeBL7jijlHQ5rzlrp8ddkET7NN1HviBJ1YY55/+Z4Nz7vpbG3TBKV3ngSfBtOpf8izzu1oHm6p/ydvMn+hQ9S/5mPkvP60X5VQiTQ=="
        },
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJztz0sOAWEQBOCv47HAeTALnMdjw3m8FjgPscBtRPzizySzm1ippJKqrqSrm3oxx7DGfWcUWNa0bxgUwQFHXHBCK7hihj3a8f6jGe8byr4RbF7/BovghnvKHxjEtyvX/QrfT9wGu6ATdFPWC2bx7cr1tMJPEz8YBeOUTV63Z125Xlf4dWKOZcpWpfkffoYncpEjRg=="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 95,
      name = "desert_wall",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -1
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 40, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMAwgmCjCwDBJhIHBR5iBoVuENL0Af4kCSg=="
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJztkLENwkAUQ98O/lfBQgiCYBwIggHoWAKCYAAq2IYqzIC+/p1Ig5IB4saW7S+fDv7jabAUHC10JVgovCrzPHslKzgZrATrTqc12AkeFroWbBVenXmTvZL5rt+/DPaCQ6czSXAVvC10I7govCbzOXsl812//xjcBPdOZ5bi7Sn9dB981++nA/t9GLo7YoT/wBd3ZiVb"
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJzti8sNwkAQQ18PnuVEOdzy6QeSKtJEPiXklHJyoga02h1pBBUgxRfbz3Ir6AWdoBHsBpOVnFlb99yd9ZX71gV/CUbBIHgKToPDSh7CnruzsfL4dV8Em2AVzIJbgreVvIY9d2db5fHr/q1Hgnv65Zcu8Qf6AIAvIts="
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJztzrENwkAQRNHfw+6SQDkkCEM/xnTgQjB0YBLoBhJTA1oxJyNTAIlHWk0y73SVwd5gq24dbg53h4NB73B1fpKbSq5cK3M0qNXpB4eXQ2fwcHj6aHbqQbb+ul7mYnBSp18GrOLzjwhYxGgadW46uXJpp0m/0Vsl6xjNWT3dFDtnDn/MGzQtJUQ="
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJztkLENQkEMQ98OcWhgHBoEDASM8DuWAEaABraBBmZA0b/TnU6IhiuxZMVyLCsK9MXK4KJ+fVuDh/p1Hg0m3rdz7qVzEFwFSxu5TrP2Q+9VdvGznG87z4KnYGMjd2nWfuibyi5+lvPtnXfB1OFgI09p1n7ol8oufpbzLdxh4d/90LMPmT/4GW/I8igt"
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJxjYBhZYL8IA4O3MAT7IGF0/i4R4sx7K8LAUCkMwVVIGJ3/QoSBoZsIM6VFGRiWC0PwCiSMzhcTZWDYKULYnZ6ixPnDBaoO5E5i/U4sMKKyedR2o5godd0ICktqmucvyMDQIohdDgDSpxug"
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 96,
      name = "desert_wall_top",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -0.5
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = -20, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMAwx8FSMgcFZnIEBAAzTAVY="
        },
        {
          x = 0, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNAJOIszMLiKQ2gQdoFimBiI/R2KQWIweRAfRH+DskE0iA8AkMsLTA=="
        },
        {
          x = 20, y = -12, width = 20, height = 12,
          data = "eJztirENwCAQxDwC3e0DYf9tEkpkiSoDUL2ll+7uDUVRcIEe+AJPYATmObcVeH+bnlnXn47Z3d4CGzc3DNs="
        },
        {
          x = 40, y = -12, width = 20, height = 12,
          data = "eJztkMEJgEAMBKcDH0I21YigYkd2ZGHeQztQnxLuHn4EC7iBJcl+BgKVSoUPTsGoPC/BVPa79DEHwW7/frh6zuIwOxyCzaAXdIJk0Do0xRO+8IYn8r6jfwD2Dxcp"
        },
        {
          x = 60, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMBAATuIMDK7iDAzO4gwM36H0Nyj9TIz48IPpFRBnYFgpysBwRIyBgVMMwj4sxsCwSpSB4SsJZgIATWYMfw=="
        },
        {
          x = 80, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMAxC4CTOwOAqzsDgLM7A4CaOXQ0ALfgBbQ=="
        },
        {
          x = -20, y = 0, width = 20, height = 12,
          data = "eJxjYKAcCIkzMAiIMzA8E6eCYQwMDHPFGRiWSjAweEhQxzxhcQaG3+IMDI5Uch8M/KKyeaNgFDCQCABrgwXE"
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJztzsEJgDAMheF/CNtkmVpBD64jDqQL6Q7iGFURIQevigcP/eBBeIGQwcHooFWoFXqFRqFTCAKlQBRINm8C1a2P1iXL5GB2sHjYb/srh/BYsBur5xPFix+yjJ86ASSFFMw="
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJztisEJADAMAm8Lt0m6/0ppoBR8dYC+ciCCZwtCsAXtvilBCpZ9PFv533bpHoaBbxz/og4Z"
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJztjcsJgDAQRF8Pyk6qMUlFYsl+bnagCCIuIgji3TwY3mV3JgpWwSZo3LW4mAwGgzbALOgC5AC9QdSZ5M63vzcW30zuY3e05131sa9Q4Kfsa54QGg=="
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJztkE1qAlEQhL+tARGJr7vHi2QjRmGC55HMddy5kdwgoCIYr6C4U1zlACH4A+ExPcwIs8g+KXi8qlpUV3diMDGYBdgI7APsAvQE3g2eBEYGmfIr9BWOAnOBpcBKyuwHybM/FVoKLwqpwneFt2vmPHpm6j3fQtmz696HQEMgc712Hed8VfILnKTsufCeYwM12Ibci/mvrpuuEwOxfIep3fc8e8+DwEDhpuVf+JEPNefxVs/+LgrXmt1jz06NH2cVfpX/gz+FH/jeOUk="
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJytkr1KA0EUhb8mBhs14Nwzj2JjRNzgm6TQQpSAz5JCC63EZzDBykJ7JaTyrxAsNSQqyDJ3QdZmo3tgmGGY+ebcMxeq60ZwFmDRYFfMrSeDiSDzsSLYMegavAm2BK0S911pFPcmfi6fp4KDCC+C0wgNg3GANQOLsBp/+1wXtAWfgg/BhuDrx16xvje4MFhyf5m/syzouIdngwerVvtMsKnEvAuw534XDJqWMu3NmenMfXacdR5gFGBocGlw9Yc/KnzeBhg4p+25VK21rCPBq2A/pvz/q0dLHg8j9Gvg5cp7e7tG3rUgRDipiXes1DPlfv4Ggj49Qg=="
        },
        {
          x = 80, y = 12, width = 20, height = 12,
          data = "eJxjYCAdOIkzMAiIMzA8FGNgEBFnoBg8EWNgsBdnYPhHBbNGwShgGEEAAHjQBAg="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 4,
      name = "desert_wall_decor",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -0.4
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = -20, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNABvOelvpkAVmMA/Q=="
        },
        {
          x = 0, y = -12, width = 20, height = 12,
          data = "eJzt0DsVgEAMAMExQEIKjo6ff4/ggEdBmRGwxdJa89E9If75tQV7cARncL10s5iLKpZkJGvyAOJLAtM="
        },
        {
          x = 20, y = -12, width = 20, height = 12,
          data = "eJztybkRgEAAxDB1sCxwPP03SsIMJZCcQptpmvxslKOcZQ1b2PP9hCX0bVe5ywMz4QGM"
        },
        {
          x = 40, y = -12, width = 20, height = 12,
          data = "eJztyqkRwDAMADAt4PMlLcqKefaHnSC0yMKilOIno9GTJ3nz/mawgh2cuL8Pbd4CeA=="
        },
        {
          x = -20, y = 0, width = 20, height = 12,
          data = "eJxjYBi8oJ2XuuYtp7J5o2AUMAwwAADRswFJ"
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJztzMsNQVEUQNHVwDk3twBawAAj76EQvxEqQSWoUiImJBJzb4139j44BMegSdpkniySZXrqVfrVm0FlWBlVxoVJYVo4BefgEqySdbJJtsnu9ZtVmo/fN9fgFtzjt77T8UcecggLfw=="
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJztzLsNhFAUQ8HpwLox9MB/gf4bI0FCbE72JjyyzFsX+rAVv2Iv5rCENc9uCGOY7nYUZ/2dNU3jSxegfANB"
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJztzsENglAQBNDXwGaRu0INyslEGkRoBLUSizL/4AGiHfx3nM1M9nrgnFySITkmp7TxbpiCezAHS2zvXdIn7a5X3JLxR74Gj+AZvHZ7X+Wvqqr89QHlTAjr"
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJzt0TlOQgEYReFvAzd/gYWSwCa0UBJZDEini3CqBPYgQ8WwB6d92bySvEYq4qlPTnJzO8VZORqXxdUfeqMwDndhknb3Pjy0OI/hKTyHl/Da4r6FaZiFeeOdFxdFt9nzHhZhGVZhfaDXK/rFJmzDLuwb77q4KQZN7yN8hq/wHX4O9G6L4RH/+cdJ8QvCWhVe"
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJzt0r0JgEAAg9FvgSPE3+IEXcK7jR3FuWwsBU+xUPD1CSkC39QKOkGva7klwGxIhmyIgkEwC5IgC6JhcFnfGm7N/71M3H/wlNEwFX7oTGWoDc1B3wYb9gVq"
        },
        {
          x = 0, y = 12, width = 20, height = 12,
          data = "eJxjYBgFo4D2gI2JgYEdijmYKDfPkomBwQqKralgXg4TA0MuFOdRwTx6AQBZwgLR"
        },
        {
          x = 20, y = 12, width = 20, height = 12,
          data = "eJxjYBgFowACbjEwMFgyMTBYoWFrJvJCiJeRgSGHiYEhFw3nkWmeA+NoTDGgAQCb5wUs"
        },
        {
          x = 80, y = 12, width = 20, height = 12,
          data = "eJxjYCAdGAkyMBgLMjCYCJKheRSMglHAQC0AANQDAM0="
        },
        {
          x = 0, y = 24, width = 20, height = 12,
          data = "eJxjYBgF9AJWTAwM1kwQtiUThA8CILFsRuLMsGVkYMiB6stlYmDIg7JBYiA+CIDE5hFp3ihgGNIAAHvpBRE="
        },
        {
          x = 20, y = 24, width = 20, height = 12,
          data = "eJxjYBjZQI6XgYGJl4HhHw95+q2YIBgE7BkZGPR4GRiEeBkY+HjJMy+XCYJBoIiRgcGOTHNGAcOIAADTswQO"
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJztzKkNgEAARcHRvzYSGgC2AY4GOFpHgiZrIIx66vEeTa5ub/1UF/owhFLhN4YpzGGp8FvDFvZwVPj9fM4JjoUGSg=="
        },
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJzt0MsNQFAARNEzrysE9RAk1EOvGvBp4J3kbmcxVH0Ywhym0BTan7rCmPfv9nCFMyyF9aetcHzsVZUHNzy6CmE="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 102,
      name = "desert_wall_decor_infront",
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
          x = 80, y = 0, width = 20, height = 12,
          data = "eJxjYBgFo4C2gJ+fgUGAn4FBkJ865unzMzAY8DMwGFLJvKEMAENFARs="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 93,
      name = "bosscurtain",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = -16,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = -0.5
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJztzEkNgDAABMARsP6lcJW+yyUKD32QkHQEDMMfTWEOS1jDFkrYQ03f2cIRznCFOzyd1+ATL4n4Cy4="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 36,
      name = "onwall2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = 0.5
      },
      encoding = "base64",
      compression = "zlib",
      chunks = {
        {
          x = 0, y = 12, width = 20, height = 12,
          data = "eJxjYBgFowATXGZkYLgCxVcZKQ+hJYwMDEuheBkVzBsFDGAAAN/wBe0="
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJztz7kNgDAUBcFJeRVgaABwAxz990VM/kXkKWCl5WsKiRJzaGEJa0FzC3s4Qi/oneEKd3iKnofBj17KrQKS"
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 30,
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
          x = 0, y = 24, width = 20, height = 12,
          data = "eJxjYBhZIJfK5tlQ2bx8Kpu3iIGBYTEVzbvKwMBwjYrmpTIxMPBS0TxzBgYGBwYGBkcqmXeJgYGBmRHiTlYqmDsXat58qFtLGCDmsjBgDwceAnIAbYgI4g=="
        },
        {
          x = 20, y = 24, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNAJ8FLZPAAH0AAO"
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJztzKsNwDAQRMEBMXP6CfKnHxfrkkwMw47eSMtWj5SSgIoH5e4NtBo6PmwsjNufP/8Da8gCng=="
        },
        {
          x = 60, y = 24, width = 20, height = 12,
          data = "eJzt0DEKgDAQBdEX0Nh4ICu9j+iV9E7xQrKQIp3YZ+A3CzPF0ul0YMaAsS7/eEvrhjdhQ8ES98T+0VhrIxZuTlw4ceOpvaPpvjpZB00="
        },
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJxjYBgFo2D4AHYGBgZeKpo3n4GBwYGBgYGNSuaaMzAwFDMwMORAzWWFYnLNBgATxwJ0"
        },
        {
          x = 0, y = 36, width = 20, height = 12,
          data = "eJztzsENQEAUQMH5YTmpRxy1oydqWjQkYjtYBwdTwMtLQQoOTMjY0AYLeszq7Z7eiREJQ0Uvl8e1fN/tJuhefP79fNwF5G0H+w=="
        },
        {
          x = 60, y = 36, width = 20, height = 12,
          data = "eJztzDkNACAQAMFxxWMJNBEs4YgGAVdQ3rSbLDELFQcTDRsD/fUSfKWUfHEBis0EZw=="
        },
        {
          x = 80, y = 36, width = 20, height = 12,
          data = "eJxjYWRguMTAwMDKyMDAwsjAkM0wCkbBKGAYIgAA2lUBTg=="
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 24,
      name = "tree1",
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
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 200,
      height = 12,
      id = 25,
      name = "tree2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = 1.125
      },
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
      id = 26,
      name = "tree3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["drawz"] = 1.25
      },
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
          properties = {
            ["music"] = {
              "music/Skyhawk Beach intro.ogg",
              "music/Skyhawk Beach loop.ogg"
            },
            ["sequence"] = "introBanditStage"
          },
          objects = {
            {
              id = 21,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = -16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = -96 },
                { x = -32, y = 224 },
                { x = 32, y = 160 },
                { x = 64, y = 160 },
                { x = 96, y = 128 },
                { x = 224, y = 128 },
                { x = 256, y = 96 },
                { x = 256, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["extrudeY"] = -48,
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
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 320, y = 0 }
              },
              properties = {}
            },
            {
              id = 237,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 448,
              y = 16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -192, y = -128 },
                { x = -192, y = 64 },
                { x = -160, y = 64 },
                { x = -128, y = 96 },
                { x = -96, y = 64 },
                { x = 320, y = 64 },
                { x = 352, y = 96 },
                { x = 384, y = 64 },
                { x = 960, y = 64 },
                { x = 992, y = 96 },
                { x = 1056, y = 32 },
                { x = 1056, y = -128 }
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
              id = 513,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 416,
              y = 64,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = true,
              properties = {}
            },
            {
              id = 516,
              name = "Move",
              type = "",
              shape = "text",
              x = 376,
              y = 48,
              width = 32,
              height = 18,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Move",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 97,
          name = "attacktutor",
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
              id = 1053,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 552,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 1054,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 552,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3108,
              visible = true,
              properties = {}
            },
            {
              id = 1055,
              name = "Attack",
              type = "",
              shape = "text",
              x = 488,
              y = 40,
              width = 48,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Attack",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 1056,
              name = "Jump",
              type = "",
              shape = "text",
              x = 488,
              y = 56,
              width = 48,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Jump",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 1057,
              name = "",
              type = "",
              shape = "rectangle",
              x = 584,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 1058,
              name = "",
              type = "",
              shape = "rectangle",
              x = 584,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3110,
              visible = true,
              properties = {}
            },
            {
              id = 1059,
              name = "or",
              type = "",
              shape = "text",
              x = 560,
              y = 40,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 1060,
              name = "or",
              type = "",
              shape = "text",
              x = 560,
              y = 56,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
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
          properties = {
            ["titlebarcuecard"] = "ATTACK"
          },
          objects = {
            {
              id = 15,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 816,
              y = 192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 795,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 968,
              y = 168,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 794,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 872,
              y = 136,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 793,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 920,
              y = 248,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 792,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 96,
              y = 152,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 48,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 72,
              y = 344,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 101,
          name = "attacktutor2",
          class = "",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 1061,
              name = "Direct",
              type = "",
              shape = "text",
              x = 656,
              y = 40,
              width = 192,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Aim attacks\nwith",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 1062,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 696,
              y = 72,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 46,
          name = "+knives",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["titlebarcuecard"] = "GRAB ATTACK & THROW"
          },
          objects = {
            {
              id = 487,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 416,
              y = 336,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 799,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 296,
              y = 200,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 11,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 816,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 488,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 688,
              y = 344,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 520,
              name = "Grab",
              type = "",
              shape = "text",
              x = 584,
              y = 48,
              width = 144,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "MOVE INTO ENEMY to GRAB then",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 527,
              name = "Grab",
              type = "",
              shape = "text",
              x = 584,
              y = 64,
              width = 128,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "DIRECTION + ATTACK to THROW",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 526,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 72,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = false,
              properties = {}
            },
            {
              id = 797,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 408,
              y = -8,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 48
              }
            },
            {
              id = 798,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 704,
              y = -8,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 48
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 98,
          name = "grabtutor",
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
              id = 637,
              name = "Direct",
              type = "",
              shape = "text",
              x = 864,
              y = 40,
              width = 128,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Walk into large\nbody to grapple",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 638,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 840,
              y = 56,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = true,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 60,
          name = "learngrabandthrow",
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
              id = 635,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 560,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 480, y = 0 }
              },
              properties = {}
            },
            {
              id = 647,
              name = "tall-stone",
              type = "tall-stone",
              shape = "rectangle",
              x = 1120,
              y = 152,
              width = 48,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 3136,
              visible = true,
              properties = {
                ["propertiestable"] = "database/objects-properties.csv",
                ["respawnpoint"] = { id = 654 }
              }
            },
            {
              id = 654,
              name = "rockrespawnpoint",
              type = "",
              shape = "point",
              x = 1040,
              y = 0,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 176
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 99,
          name = "grabtutor2",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["time"] = 60
          },
          objects = {
            {
              id = 639,
              name = "Direct",
              type = "",
              shape = "text",
              x = 1032,
              y = 56,
              width = 152,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Pummel        only",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 685,
              name = "Direct",
              type = "",
              shape = "text",
              x = 1032,
              y = 40,
              width = 240,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Throw         aimed with",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 643,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 1232,
              y = 56,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = true,
              properties = {}
            },
            {
              id = 640,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1096,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 641,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1128,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 642,
              name = "or",
              type = "",
              shape = "text",
              x = 1104,
              y = 40,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 686,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1096,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 687,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1128,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 688,
              name = "or",
              type = "",
              shape = "text",
              x = 1104,
              y = 56,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 61,
          name = "+knives",
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
              id = 648,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 760,
              y = 208,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 649,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 736,
              y = 232,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 650,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 712,
              y = 112,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 802,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 712,
              y = 208,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 651,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 712,
              y = 160,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 801,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 712,
              y = 256,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 652,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 760,
              y = 160,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 653,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 736,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 19,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 784,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 20,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 736,
              y = 136,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 100,
          name = "sprinttutor",
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
              id = 515,
              name = "sprintbutton",
              type = "",
              shape = "rectangle",
              x = 1384,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3122,
              visible = true,
              properties = {}
            },
            {
              id = 518,
              name = "Run",
              type = "",
              shape = "text",
              x = 1288,
              y = 40,
              width = 48,
              height = 18,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Sprint",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 538,
              name = "or",
              type = "",
              shape = "text",
              x = 1360,
              y = 40,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 537,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1352,
              y = 48,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3118,
              visible = true,
              properties = {}
            },
            {
              id = 678,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1352,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 679,
              name = "Attack",
              type = "",
              shape = "text",
              x = 1288,
              y = 56,
              width = 128,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Tackle",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 680,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1384,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 681,
              name = "or",
              type = "",
              shape = "text",
              x = 1360,
              y = 56,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 64,
          name = "tolearnsprint",
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
              id = 682,
              name = "Attack",
              type = "",
              shape = "text",
              x = 1304,
              y = -32,
              width = 128,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "During sprint",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 690,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1040,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 160, y = 0 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 10,
          name = "learnsprint",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 2,
            ["time"] = 60
          },
          objects = {
            {
              id = 697,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1464,
              y = 128,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 803,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1472,
              y = 240,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 425,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1200,
              y = 336,
              width = 264,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Hold to sprint after fast enemies",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 426,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1176,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2769,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 428,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1312,
              y = 336,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2789,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 452,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1344,
              y = 336,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3005,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 66,
          name = "learnsprint2",
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
              id = 261,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1040,
              y = -8,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 48
              }
            },
            {
              id = 960,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1200,
              y = -24,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 48
              }
            },
            {
              id = 699,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 672,
              y = 176,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 90,
          name = "learnsprint3",
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
              id = 956,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1464,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 957,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 928,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 958,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 672,
              y = 176,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 9,
          name = "learnitems",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 5,
            ["titlebarcuecard"] = "RUNNING KICK"
          },
          objects = {
            {
              id = 430,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2016,
              y = 224,
              width = 192,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Steer while sprinting",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 429,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1992,
              y = 240,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2707,
              visible = false,
              properties = {}
            },
            {
              id = 239,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1440,
              y = 48,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 64, y = -160 },
                { x = 64, y = 0 },
                { x = 96, y = 0 },
                { x = 96, y = -160 }
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
              id = 596,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 1520,
              y = 88,
              width = 128,
              height = 160,
              rotation = 0,
              opacity = 1,
              gid = 3129,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 600 },
                ["fruit2"] = { id = 601 },
                ["leaves"] = { id = 597 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 597,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1520,
              y = 40,
              width = 128,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 3128,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 64
              }
            },
            {
              id = 600,
              name = "",
              type = "food-lifefruit-hanging",
              shape = "rectangle",
              x = 1488,
              y = 40,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 3134,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 60
              }
            },
            {
              id = 601,
              name = "",
              type = "food-lifefruit-hanging",
              shape = "rectangle",
              x = 1552,
              y = 28,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 3134,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 68
              }
            },
            {
              id = 602,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1352,
              y = -80,
              width = 112,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Move into item to pick up",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 603,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1832,
              y = 64,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = false,
              properties = {}
            },
            {
              id = 604,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1464,
              y = -80,
              width = 104,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Food restores lost health",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 606,
              name = "",
              type = "food-lifefruit",
              shape = "rectangle",
              x = 1504,
              y = 112,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 3135,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv"
              }
            },
            {
              id = 607,
              name = "",
              type = "food-lifefruit",
              shape = "rectangle",
              x = 1528,
              y = 120,
              width = 20,
              height = 20,
              rotation = 0,
              opacity = 1,
              gid = 3135,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv"
              }
            },
            {
              id = 807,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1200,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 160, y = 0 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 42,
          name = "tolearnthrowingweapons",
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
              id = 483,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1424,
              y = 336,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = -64, y = -192 },
                { x = 416, y = -192 }
              },
              properties = {}
            },
            {
              id = 38,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1984,
              y = 16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -448, y = -128 },
                { x = -448, y = 32 },
                { x = -384, y = 96 },
                { x = -256, y = 96 },
                { x = -224, y = 64 },
                { x = -96, y = 64 },
                { x = -96, y = -128 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["extrudeY"] = -48,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 530,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 1776,
              y = 160,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3133,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 532,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 1808,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3133,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 533,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 1832,
              y = 136,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3133,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 534,
              name = "",
              type = "item-spikefruit",
              shape = "rectangle",
              x = 1744,
              y = 144,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3133,
              visible = true,
              properties = {
                ["propertiestable"] = "database/projectiles-properties.csv"
              }
            },
            {
              id = 590,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 1784,
              y = 120,
              width = 128,
              height = 160,
              rotation = 0,
              opacity = 1,
              gid = 3131,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["fruit1"] = { id = 592 },
                ["fruit2"] = { id = 593 },
                ["fruit3"] = { id = 0 },
                ["fruit4"] = { id = 0 },
                ["leaves"] = { id = 591 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 591,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1784,
              y = 72,
              width = 128,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 3130,
              visible = true,
              properties = {
                ["asetag"] = "*",
                ["z"] = 64
              }
            },
            {
              id = 592,
              name = "",
              type = "item-spikefruit-hanging",
              shape = "rectangle",
              x = 1760,
              y = 72,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3132,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 593,
              name = "",
              type = "item-spikefruit-hanging",
              shape = "rectangle",
              x = 1816,
              y = 60,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3132,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 68
              }
            },
            {
              id = 432,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1936,
              y = 128,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = false,
              properties = {}
            },
            {
              id = 434,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1616,
              y = 72,
              width = 104,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Throw missile",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 626,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1648,
              y = 96,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 627,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1680,
              y = 96,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 628,
              name = "or",
              type = "",
              shape = "text",
              x = 1656,
              y = 88,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 785,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2048,
              y = 176,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 32, y = 64 },
                { x = 64, y = 32 },
                { x = 192, y = 32 },
                { x = 192, y = -288 },
                { x = -160, y = -288 },
                { x = -160, y = -96 },
                { x = -128, y = -64 },
                { x = -96, y = -64 }
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
          id = 48,
          name = "learnthrowingweapons",
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
              name = "",
              type = "",
              shape = "rectangle",
              x = 2064,
              y = -24,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 241 },
                ["exitpoint"] = { id = 244 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 59,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2112,
              y = 24,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 240 },
                ["exitpoint"] = { id = 243 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 240,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2016,
              y = 120,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 241,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 1968,
              y = 72,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 243,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2144,
              y = -8,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 244,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2064,
              y = -24,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 433,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1912,
              y = 160,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = false,
              properties = {}
            },
            {
              id = 435,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2200,
              y = 260,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2778,
              visible = false,
              properties = {}
            },
            {
              id = 453,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2192,
              y = 224,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2879,
              visible = false,
              properties = {}
            },
            {
              id = 454,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2208,
              y = 224,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2880,
              visible = false,
              properties = {}
            },
            {
              id = 455,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2224,
              y = 224,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2881,
              visible = false,
              properties = {}
            },
            {
              id = 456,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2240,
              y = 224,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2882,
              visible = false,
              properties = {}
            },
            {
              id = 457,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2232,
              y = 260,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3004,
              visible = false,
              properties = {}
            },
            {
              id = 468,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1984,
              y = 160,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3122,
              visible = false,
              properties = {}
            },
            {
              id = 470,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1976,
              y = 152,
              width = 40,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "+",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 471,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2008,
              y = 160,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = false,
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 28,
          name = "+knives",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 6
          },
          objects = {
            {
              id = 246,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1488,
              y = 240,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 248,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1472,
              y = 176,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 250,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1568,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 253,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1568,
              y = 160,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 11,
          name = "+shooter",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 6
          },
          objects = {
            {
              id = 87,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2104,
              y = 16,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 242 },
                ["exitpoint"] = { id = 245 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 242,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2008,
              y = 112,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 245,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2120,
              y = 0,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 494,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2056,
              y = 0,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 495 },
                ["exitpoint"] = { id = 496 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 498,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2152,
              y = 32,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 497 },
                ["exitpoint"] = { id = 499 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 495,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 1976,
              y = 80,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 497,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2040,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 496,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2088,
              y = -32,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 499,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2152,
              y = 32,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 50,
          name = "+spears",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 501,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2096,
              y = 264,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 810,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2096,
              y = 264,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 13,
          name = "+spears",
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
              type = "bandit-spear",
              shape = "rectangle",
              x = 1576,
              y = 208,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 62,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2096,
              y = 280,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 62,
          name = "tolearnfireball",
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
              id = 655,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2080,
              y = 112,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 160, y = -224 },
                { x = 160, y = 96 },
                { x = 192, y = 128 },
                { x = 224, y = 96 },
                { x = 256, y = 96 },
                { x = 288, y = 128 },
                { x = 320, y = 96 },
                { x = 480, y = 96 },
                { x = 512, y = 64 },
                { x = 512, y = -224 }
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
              id = 522,
              name = "Fireball",
              type = "",
              shape = "text",
              x = 2120,
              y = 168,
              width = 120,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "With 1 or more fire meter ",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 656,
              name = "Fireball",
              type = "",
              shape = "text",
              x = 2208,
              y = 312,
              width = 136,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Hold then release",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 698,
              name = "Fireball",
              type = "",
              shape = "text",
              x = 2208,
              y = 296,
              width = 136,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Fireballs",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 523,
              name = "flame1",
              type = "",
              shape = "rectangle",
              x = 2208,
              y = 192,
              width = 30,
              height = 6,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["color"] = "#ffffd000"
              }
            },
            {
              id = 525,
              name = "flamebox",
              type = "",
              shape = "rectangle",
              x = 2208,
              y = 192,
              width = 30,
              height = 6,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["color"] = "#00000000",
                ["linecolor"] = "#ffffffff",
                ["roundcorners"] = 1
              }
            },
            {
              id = 632,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 2296,
              y = 304,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = true,
              properties = {}
            },
            {
              id = 633,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2328,
              y = 304,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3114,
              visible = true,
              properties = {}
            },
            {
              id = 634,
              name = "or",
              type = "",
              shape = "text",
              x = 2304,
              y = 296,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {}
            },
            {
              id = 675,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1840,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 160, y = 96 },
                { x = 480, y = 96 }
              },
              properties = {}
            },
            {
              id = 676,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2320,
              y = 248,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3137,
              visible = true,
              properties = {
                ["item"] = { id = 677 },
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 677,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2320,
              y = 248,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3138,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 1
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 63,
          name = "learnfireball",
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
              id = 662,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2392,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 661 },
                ["exitpoint"] = { id = 660 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 665,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2344,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 664 },
                ["exitpoint"] = { id = 663 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 668,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2296,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 667 },
                ["exitpoint"] = { id = 666 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 671,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2248,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 670 },
                ["exitpoint"] = { id = 669 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 661,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2392,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 664,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2344,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 667,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2296,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 670,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2248,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 660,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2392,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 663,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2344,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 666,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2296,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 669,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2248,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 949,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2056,
              y = 360,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 950,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2232,
              y = 448,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 953,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2480,
              y = 448,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 955,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2592,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 15,
          name = "meetshields",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 65,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2880,
              y = 368,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -288, y = -480 },
                { x = -288, y = -192 },
                { x = 0, y = -192 },
                { x = 32, y = -160 },
                { x = 64, y = -160 },
                { x = 96, y = -128 },
                { x = 96, y = -64 },
                { x = 128, y = -32 },
                { x = 128, y = 16 },
                { x = 224, y = 16 },
                { x = 224, y = -480 }
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
              id = 66,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2480,
              y = 240,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = -160, y = 0 },
                { x = 320, y = 0 }
              },
              properties = {}
            },
            {
              id = 234,
              name = "darknessinside",
              type = "",
              shape = "rectangle",
              x = 2912,
              y = 224,
              width = 64,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 2452,
              visible = true,
              properties = {
                ["drawz"] = -0.25,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 235,
              name = "exitdoor",
              type = "",
              shape = "rectangle",
              x = 2912,
              y = 224,
              width = 64,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 2450,
              visible = true,
              properties = {
                ["opensnextroomimmediately"] = true
              }
            },
            {
              id = 236,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2912,
              y = 224,
              width = 64,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 2449,
              visible = true,
              properties = {
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 267,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2976,
              y = 352,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2455,
              visible = true,
              properties = {
                ["itemtype"] = ""
              }
            },
            {
              id = 270,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2832,
              y = 208,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2455,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 268,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2968,
              y = 320,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 269,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2864,
              y = 216,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = "mana-peppers"
              }
            },
            {
              id = 529,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2984,
              y = 120,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2702,
              visible = false,
              properties = {}
            },
            {
              id = 521,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 2976,
              y = 160,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3112,
              visible = false,
              properties = {}
            },
            {
              id = 503,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2896,
              y = 240,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 812,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2944,
              y = 304,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 308,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2920,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 608,
              name = "",
              type = "fruit-tree",
              shape = "rectangle",
              x = 3176,
              y = 72,
              width = 128,
              height = 160,
              rotation = 0,
              opacity = 1,
              gid = 3129,
              visible = true,
              properties = {
                ["leaves"] = { id = 609 },
                ["propertiestable"] = "database/objects-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 609,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3176,
              y = 24,
              width = 128,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 3128,
              visible = true,
              properties = {
                ["z"] = 128
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 88,
          name = "meetshields2",
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
              id = 827,
              name = "",
              type = "bandit-sling",
              shape = "rectangle",
              x = 2960,
              y = 72,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 829 },
                ["exitpoint"] = { id = 831 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 829,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2952,
              y = 160,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 831,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2960,
              y = 40,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 833,
              name = "",
              type = "bandit-sling",
              shape = "rectangle",
              x = 3056,
              y = 184,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 835 },
                ["exitpoint"] = { id = 837 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 835,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2976,
              y = 184,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 837,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3128,
              y = 192,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 56,
          name = "meetshields3",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 6
          },
          objects = {
            {
              id = 562,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2544,
              y = 272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 563,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2544,
              y = 344,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 815,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2376,
              y = 256,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 816,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2408,
              y = 280,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 817,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2384,
              y = 320,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 818,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2408,
              y = 360,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 74,
          name = "meetshields4",
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
              id = 826,
              name = "",
              type = "bandit-bow",
              shape = "rectangle",
              x = 2912,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 828 },
                ["exitpoint"] = { id = 830 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 828,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2912,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 830,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2912,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 832,
              name = "",
              type = "bandit-bow",
              shape = "rectangle",
              x = 3056,
              y = 240,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 834 },
                ["exitpoint"] = { id = 836 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 834,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2992,
              y = 232,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 836,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3128,
              y = 240,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 838,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2984,
              y = 144,
              width = 144,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Move into an enemy or barrel to grab",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 839,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2960,
              y = 168,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2707,
              visible = false,
              properties = {}
            },
            {
              id = 840,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3008,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2758,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 841,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2944,
              y = 320,
              width = 224,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Then hold    toward the door\nand tap    to throw",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 842,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2936,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2778,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 843,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2960,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3004,
              visible = false,
              properties = {}
            },
            {
              id = 844,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3008,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2879,
              visible = false,
              properties = {}
            },
            {
              id = 845,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3024,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2880,
              visible = false,
              properties = {}
            },
            {
              id = 846,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3040,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2881,
              visible = false,
              properties = {}
            },
            {
              id = 847,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3056,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2882,
              visible = false,
              properties = {}
            },
            {
              id = 848,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3024,
              y = 336,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2703,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 89,
          name = "meetshields5",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 1
          },
          objects = {
            {
              id = 307,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2544,
              y = 312,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 561,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2504,
              y = 256,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 813,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2496,
              y = 360,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 54,
          name = "unlockdoor",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["exitdoor"] = { id = 235 },
            ["sequence"] = "unlockDoorToNextArea"
          },
          objects = {}
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 76,
          name = "meetmuscle",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 1
          },
          objects = {
            {
              id = 704,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 2928,
              y = 240,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["holdstrength"] = 180,
                ["initialai"] = "muscle-grab2",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 825,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 2960,
              y = 272,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["holdstrength"] = 180,
                ["initialai"] = "muscle-grab2",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 29,
          name = "meetmuscle2",
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
              id = 254,
              name = "",
              type = "bandit-sling",
              shape = "rectangle",
              x = 2912,
              y = 88,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 255 },
                ["exitpoint"] = { id = 256 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 255,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2912,
              y = 152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 256,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2912,
              y = 56,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 257,
              name = "",
              type = "bandit-sling",
              shape = "rectangle",
              x = 3056,
              y = 240,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 258 },
                ["exitpoint"] = { id = 259 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 819,
              name = "",
              type = "bandit-bow",
              shape = "rectangle",
              x = 3056,
              y = 160,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 821 },
                ["exitpoint"] = { id = 820 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 48
              }
            },
            {
              id = 258,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2992,
              y = 232,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 821,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2960,
              y = 168,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 259,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3128,
              y = 248,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 820,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3128,
              y = 168,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 48
              }
            },
            {
              id = 436,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2984,
              y = 144,
              width = 144,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Move into an enemy or barrel to grab",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 437,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2960,
              y = 168,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2707,
              visible = false,
              properties = {}
            },
            {
              id = 438,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3008,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2758,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 439,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2944,
              y = 320,
              width = 224,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Then hold    toward the door\nand tap    to throw",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 440,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2936,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2778,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 458,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2960,
              y = 352,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3004,
              visible = false,
              properties = {}
            },
            {
              id = 459,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3008,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2879,
              visible = false,
              properties = {}
            },
            {
              id = 460,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3024,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2880,
              visible = false,
              properties = {}
            },
            {
              id = 461,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3040,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2881,
              visible = false,
              properties = {}
            },
            {
              id = 462,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3056,
              y = 152,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2882,
              visible = false,
              properties = {}
            },
            {
              id = 466,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3024,
              y = 336,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2703,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 68,
          name = "entercave",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = -1
          },
          objects = {
            {
              id = 465,
              name = "exittrigger",
              type = "Trigger",
              shape = "polygon",
              x = 2912,
              y = 216,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -8 },
                { x = 32, y = -8 },
                { x = 64, y = 24 },
                { x = 64, y = 56 }
              },
              properties = {
                ["action"] = "startSequence",
                ["color"] = "#80008000",
                ["drawz"] = -0.125,
                ["extrudeY"] = -48,
                ["initialai"] = "triggerToUse",
                ["script"] = "Dragontail.Character.Trigger",
                ["sequence"] = "playerExitToNextArea",
                ["usesleft"] = 1
              }
            },
            {
              id = 260,
              name = "camerawarpwhendone",
              type = "",
              shape = "point",
              x = 240,
              y = 1008,
              width = 0,
              height = 0,
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
          id = 22,
          name = "entryhall",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["checkpoint"] = true,
            ["donewhenenemiesleft"] = 999,
            ["sequence"] = "playerEnterArea",
            ["titlebarcuecard"] = "RUN"
          },
          objects = {
            {
              id = 705,
              name = "",
              type = "",
              shape = "rectangle",
              x = 336,
              y = 960,
              width = 96,
              height = 112,
              rotation = 0,
              opacity = 1,
              gid = 3140,
              visible = true,
              properties = {}
            },
            {
              id = 706,
              name = "",
              type = "",
              shape = "rectangle",
              x = 432,
              y = 960,
              width = 96,
              height = 112,
              rotation = 0,
              opacity = 1,
              gid = 3140,
              visible = true,
              properties = {}
            },
            {
              id = 707,
              name = "",
              type = "",
              shape = "rectangle",
              x = 528,
              y = 960,
              width = 96,
              height = 112,
              rotation = 0,
              opacity = 1,
              gid = 3140,
              visible = true,
              properties = {}
            },
            {
              id = 708,
              name = "",
              type = "",
              shape = "rectangle",
              x = 624,
              y = 960,
              width = 96,
              height = 112,
              rotation = 0,
              opacity = 1,
              gid = 3140,
              visible = true,
              properties = {}
            },
            {
              id = 709,
              name = "",
              type = "",
              shape = "rectangle",
              x = 720,
              y = 960,
              width = 96,
              height = 112,
              rotation = 0,
              opacity = 1,
              gid = 3140,
              visible = true,
              properties = {}
            },
            {
              id = 104,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 176,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 64, y = 0 },
                { x = 704, y = 0 }
              },
              properties = {
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 67,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 0,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 64, y = 0 },
                { x = 64, y = 112 },
                { x = 160, y = 112 },
                { x = 192, y = 144 },
                { x = 312, y = 144 },
                { x = 312, y = 0 }
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
              id = 713,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -104,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -8,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 728,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -8,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -8,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 730,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 88,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -8,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 726,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -200,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -8,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 723,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -296,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -8,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 715,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -296,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff",
                ["z"] = 40
              }
            },
            {
              id = 724,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -200,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff",
                ["z"] = 40
              }
            },
            {
              id = 725,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -104,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff",
                ["z"] = 40
              }
            },
            {
              id = 727,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -8,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff",
                ["z"] = 40
              }
            },
            {
              id = 729,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 88,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 608, y = 96 },
                { x = 608, y = 112 },
                { x = 656, y = 112 },
                { x = 656, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff",
                ["z"] = 40
              }
            },
            {
              id = 714,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -256,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 616, y = 96 },
                { x = 616, y = 112 },
                { x = 664, y = 112 },
                { x = 664, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 720,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -160,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 616, y = 96 },
                { x = 616, y = 112 },
                { x = 664, y = 112 },
                { x = 664, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 721,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = -64,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 616, y = 96 },
                { x = 616, y = 112 },
                { x = 664, y = 112 },
                { x = 664, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 722,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 32,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 616, y = 96 },
                { x = 616, y = 112 },
                { x = 664, y = 112 },
                { x = 664, y = 96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 68,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 320,
              y = 1088,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -320, y = -224 },
                { x = -320, y = 128 },
                { x = 0, y = 128 },
                { x = -32, y = 96 },
                { x = -64, y = 96 },
                { x = -96, y = 64 },
                { x = -160, y = 64 },
                { x = -192, y = 32 },
                { x = -224, y = 32 },
                { x = -288, y = -32 },
                { x = -288, y = -112 },
                { x = -256, y = -144 },
                { x = -256, y = -224 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 298,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 944,
              y = 768,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -200, y = 0 },
                { x = -200, y = 208 },
                { x = -176, y = 208 },
                { x = -144, y = 176 },
                { x = 48, y = 176 },
                { x = 80, y = 144 },
                { x = 144, y = 144 },
                { x = 176, y = 176 },
                { x = 176, y = 0 }
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
              type = "",
              shape = "rectangle",
              x = 336,
              y = 928,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["ammo"] = 0,
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 273 },
                ["exitpoint"] = { id = 555 },
                ["facedegrees"] = 90,
                ["initialai"] = "enterAndPrepareBowAmbush"
              }
            },
            {
              id = 273,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 336,
              y = 944,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 555,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 336,
              y = 840,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 556,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 432,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 274,
              name = "",
              type = "",
              shape = "rectangle",
              x = 432,
              y = 920,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["ammo"] = 0,
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 275 },
                ["exitpoint"] = { id = 556 },
                ["facedegrees"] = 90,
                ["initialai"] = "enterAndPrepareBowAmbush"
              }
            },
            {
              id = 275,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 432,
              y = 936,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 280,
              name = "",
              type = "",
              shape = "rectangle",
              x = 528,
              y = 912,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["ammo"] = 0,
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 281 },
                ["exitpoint"] = { id = 557 },
                ["facedegrees"] = 270,
                ["initialai"] = "enterAndPrepareBowAmbush"
              }
            },
            {
              id = 282,
              name = "",
              type = "",
              shape = "rectangle",
              x = 624,
              y = 904,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["ammo"] = 0,
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 283 },
                ["exitpoint"] = { id = 558 },
                ["facedegrees"] = 270,
                ["initialai"] = "enterAndPrepareBowAmbush"
              }
            },
            {
              id = 281,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 528,
              y = 936,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 283,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 624,
              y = 936,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 286,
              name = "",
              type = "",
              shape = "rectangle",
              x = 720,
              y = 896,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["ammo"] = 0,
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 287 },
                ["exitpoint"] = { id = 559 },
                ["facedegrees"] = 90,
                ["initialai"] = "enterAndPrepareBowAmbush"
              }
            },
            {
              id = 287,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 720,
              y = 936,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 299,
              name = "",
              type = "",
              shape = "rectangle",
              x = 984,
              y = 976,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 306,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1040,
              y = 992,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {}
            },
            {
              id = 892,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1048,
              y = 928,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "item-throwing-axe"
              }
            },
            {
              id = 300,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1008,
              y = 1008,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = ""
              }
            },
            {
              id = 894,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1016,
              y = 968,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = "mana-peppers"
              }
            },
            {
              id = 304,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1056,
              y = 1016,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = ""
              }
            },
            {
              id = 893,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1096,
              y = 1024,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 891,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1024,
              y = 944,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "food-bigfish"
              }
            },
            {
              id = 351,
              name = "",
              type = "",
              shape = "rectangle",
              x = 232,
              y = 1036,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 354,
              name = "",
              type = "",
              shape = "rectangle",
              x = 234,
              y = 1045,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 355,
              name = "",
              type = "",
              shape = "rectangle",
              x = 210,
              y = 1068,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2479,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 356,
              name = "",
              type = "",
              shape = "rectangle",
              x = 208,
              y = 1076,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2473,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 357,
              name = "",
              type = "",
              shape = "rectangle",
              x = 253.66,
              y = 996,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2478,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 358,
              name = "",
              type = "",
              shape = "rectangle",
              x = 248,
              y = 1001.66,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2472,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 442,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 2304,
              y = 224,
              width = 304,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = false,
              text = "Hold    and a direction\nto sprint past archers",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 443,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2344,
              y = 240,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2728,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 444,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2368,
              y = 240,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2748,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 445,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2392,
              y = 240,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3005,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 467,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2496,
              y = 240,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2703,
              visible = false,
              properties = {
                ["drawz"] = 2
              }
            },
            {
              id = 552,
              name = "",
              type = "item-stone",
              shape = "rectangle",
              x = 784,
              y = 984,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3107,
              visible = true,
              properties = {}
            },
            {
              id = 557,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 528,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 558,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 624,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 559,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 720,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 564,
              name = "",
              type = "",
              shape = "rectangle",
              x = 320,
              y = 988,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 621,
              name = "",
              type = "",
              shape = "rectangle",
              x = 584,
              y = 988,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 615,
              name = "",
              type = "",
              shape = "rectangle",
              x = 320,
              y = 1024,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["bloodyanimation"] = 180,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 771,
              name = "",
              type = "",
              shape = "rectangle",
              x = 616,
              y = 1032,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 180,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 579,
              name = "",
              type = "",
              shape = "rectangle",
              x = 384,
              y = 1048,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 770,
              name = "",
              type = "",
              shape = "rectangle",
              x = 680,
              y = 1056,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 745,
              name = "",
              type = "",
              shape = "rectangle",
              x = 352,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 769,
              name = "",
              type = "",
              shape = "rectangle",
              x = 648,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6501,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 32,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 565,
              name = "",
              type = "",
              shape = "rectangle",
              x = 704,
              y = 1012,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6504,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 35,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 578,
              name = "",
              type = "",
              shape = "rectangle",
              x = 304,
              y = 1112,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6504,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 35,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 768,
              name = "",
              type = "",
              shape = "rectangle",
              x = 600,
              y = 1120,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6504,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 35,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 750,
              name = "",
              type = "",
              shape = "rectangle",
              x = 384,
              y = 1104,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6504,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 35,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 767,
              name = "",
              type = "",
              shape = "rectangle",
              x = 680,
              y = 1112,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6504,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 35,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 566,
              name = "",
              type = "",
              shape = "rectangle",
              x = 432,
              y = 988,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 620,
              name = "",
              type = "",
              shape = "rectangle",
              x = 696,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 577,
              name = "",
              type = "",
              shape = "rectangle",
              x = 376,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 766,
              name = "",
              type = "",
              shape = "rectangle",
              x = 672,
              y = 1072,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 744,
              name = "",
              type = "",
              shape = "rectangle",
              x = 344,
              y = 1104,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 765,
              name = "",
              type = "",
              shape = "rectangle",
              x = 640,
              y = 1112,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6505,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 36,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 567,
              name = "",
              type = "",
              shape = "rectangle",
              x = 344,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 619,
              name = "",
              type = "",
              shape = "rectangle",
              x = 616,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 576,
              name = "",
              type = "",
              shape = "rectangle",
              x = 408,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 764,
              name = "",
              type = "",
              shape = "rectangle",
              x = 704,
              y = 1104,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 749,
              name = "",
              type = "",
              shape = "rectangle",
              x = 416,
              y = 1040,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 763,
              name = "",
              type = "",
              shape = "rectangle",
              x = 712,
              y = 1048,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6508,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 39,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 568,
              name = "",
              type = "",
              shape = "rectangle",
              x = 384,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 618,
              name = "",
              type = "",
              shape = "rectangle",
              x = 656,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 575,
              name = "",
              type = "",
              shape = "rectangle",
              x = 424,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 761,
              name = "",
              type = "",
              shape = "rectangle",
              x = 720,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 748,
              name = "",
              type = "",
              shape = "rectangle",
              x = 432,
              y = 1032,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 760,
              name = "",
              type = "",
              shape = "rectangle",
              x = 728,
              y = 1040,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6509,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 40,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 569,
              name = "",
              type = "",
              shape = "rectangle",
              x = 552,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 574,
              name = "",
              type = "",
              shape = "rectangle",
              x = 376,
              y = 1032,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 758,
              name = "",
              type = "",
              shape = "rectangle",
              x = 672,
              y = 1040,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 772,
              name = "",
              type = "",
              shape = "rectangle",
              x = 728,
              y = 1000,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 741,
              name = "",
              type = "",
              shape = "rectangle",
              x = 344,
              y = 1072,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 757,
              name = "",
              type = "",
              shape = "rectangle",
              x = 640,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 616,
              name = "",
              type = "",
              shape = "rectangle",
              x = 304,
              y = 1048,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 756,
              name = "",
              type = "",
              shape = "rectangle",
              x = 600,
              y = 1056,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6529,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 60,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 570,
              name = "",
              type = "",
              shape = "rectangle",
              x = 472,
              y = 996,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 573,
              name = "",
              type = "",
              shape = "rectangle",
              x = 416,
              y = 1120,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 747,
              name = "",
              type = "",
              shape = "rectangle",
              x = 424,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 754,
              name = "",
              type = "",
              shape = "rectangle",
              x = 720,
              y = 1072,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 617,
              name = "",
              type = "",
              shape = "rectangle",
              x = 312,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 753,
              name = "",
              type = "",
              shape = "rectangle",
              x = 608,
              y = 1072,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6517,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 48,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 571,
              name = "",
              type = "",
              shape = "rectangle",
              x = 512,
              y = 988,
              width = 40,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6524,
              visible = true,
              properties = {
                ["bloodyanimation"] = 55,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 746,
              name = "",
              type = "",
              shape = "rectangle",
              x = 408,
              y = 1080,
              width = 40,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6524,
              visible = true,
              properties = {
                ["attackdegrees"] = 180,
                ["bloodyanimation"] = 55,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 751,
              name = "",
              type = "",
              shape = "rectangle",
              x = 704,
              y = 1088,
              width = 40,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6524,
              visible = true,
              properties = {
                ["attackdegrees"] = 0,
                ["bloodyanimation"] = 55,
                ["propertiestable"] = "database/objects-properties.csv"
              }
            },
            {
              id = 733,
              name = "Attack",
              type = "",
              shape = "text",
              x = 16,
              y = 1064,
              width = 128,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "During sprint",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 734,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 120,
              y = 1096,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3108,
              visible = true,
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 735,
              name = "Jump",
              type = "",
              shape = "text",
              x = 32,
              y = 1088,
              width = 72,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Long jump",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 736,
              name = "",
              type = "",
              shape = "rectangle",
              x = 152,
              y = 1096,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3110,
              visible = true,
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 737,
              name = "or",
              type = "",
              shape = "text",
              x = 128,
              y = 1088,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 738,
              name = "sprintbutton",
              type = "",
              shape = "rectangle",
              x = 168,
              y = 1072,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3122,
              visible = true,
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 739,
              name = "or",
              type = "",
              shape = "text",
              x = 144,
              y = 1064,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "OR",
              fontfamily = "TinyUnicode",
              wrap = true,
              color = { 255, 255, 255 },
              halign = "center",
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 740,
              name = "",
              type = "",
              shape = "rectangle",
              x = 136,
              y = 1072,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 3118,
              visible = true,
              properties = {
                ["drawz"] = 100
              }
            },
            {
              id = 787,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1184,
              y = 880,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -64, y = -112 },
                { x = -64, y = 64 },
                { x = 160, y = 64 },
                { x = 192, y = 32 },
                { x = 192, y = -112 }
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
              id = 548,
              name = "",
              type = "item-stone",
              shape = "rectangle",
              x = 840,
              y = 976,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3107,
              visible = true,
              properties = {}
            },
            {
              id = 549,
              name = "",
              type = "item-stone",
              shape = "rectangle",
              x = 864,
              y = 952,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3107,
              visible = true,
              properties = {}
            },
            {
              id = 553,
              name = "",
              type = "item-stone",
              shape = "rectangle",
              x = 832,
              y = 952,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3107,
              visible = true,
              properties = {}
            },
            {
              id = 550,
              name = "",
              type = "item-stone",
              shape = "rectangle",
              x = 808,
              y = 960,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 3107,
              visible = true,
              properties = {}
            },
            {
              id = 977,
              name = "",
              type = "",
              shape = "rectangle",
              x = 888,
              y = 896,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 978,
              name = "",
              type = "",
              shape = "rectangle",
              x = 890,
              y = 905,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 979,
              name = "",
              type = "",
              shape = "rectangle",
              x = 917.66,
              y = 904,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2478,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 980,
              name = "",
              type = "",
              shape = "rectangle",
              x = 912,
              y = 909.66,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2472,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 981,
              name = "",
              type = "",
              shape = "rectangle",
              x = 946,
              y = 896,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2479,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 982,
              name = "",
              type = "",
              shape = "rectangle",
              x = 944,
              y = 904,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2473,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 984,
              name = "",
              type = "",
              shape = "rectangle",
              x = 832,
              y = 944,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 988,
              name = "",
              type = "",
              shape = "rectangle",
              x = 840,
              y = 920,
              width = 64,
              height = 64,
              rotation = 90,
              opacity = 1,
              gid = 1073745222,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 989,
              name = "",
              type = "",
              shape = "rectangle",
              x = 808,
              y = 944,
              width = 64,
              height = 64,
              rotation = -90,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 986,
              name = "",
              type = "",
              shape = "rectangle",
              x = 816,
              y = 904,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 987,
              name = "",
              type = "",
              shape = "rectangle",
              x = 800,
              y = 936,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 990,
              name = "",
              type = "",
              shape = "rectangle",
              x = 320,
              y = 1104,
              width = 64,
              height = 64,
              rotation = -90,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1031,
              name = "",
              type = "",
              shape = "rectangle",
              x = 720,
              y = 1096,
              width = 64,
              height = 64,
              rotation = -90,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 991,
              name = "",
              type = "",
              shape = "rectangle",
              x = 552,
              y = 992,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 992,
              name = "",
              type = "",
              shape = "rectangle",
              x = 424,
              y = 1016,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1009,
              name = "",
              type = "",
              shape = "rectangle",
              x = 344,
              y = 984,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 1073745222,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 993,
              name = "",
              type = "",
              shape = "rectangle",
              x = 392,
              y = 1064,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1030,
              name = "",
              type = "",
              shape = "rectangle",
              x = 640,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 994,
              name = "",
              type = "",
              shape = "rectangle",
              x = 696,
              y = 992,
              width = 64,
              height = 64,
              rotation = 90,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 31,
          name = "entryhall2",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 4,
            ["titlebarcuecard"] = "LV2 FIREBALL"
          },
          objects = {
            {
              id = 547,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1080,
              y = 832,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["entrypoint"] = { id = 895 },
                ["initialai"] = "enterAndDropDown",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 885,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 848,
              y = 1200,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 917,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 792,
              y = 1304,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 916,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 776,
              y = 1232,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 886,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 704,
              y = 1224,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 895,
              name = "",
              type = "",
              shape = "point",
              x = 1080,
              y = 952,
              width = 0,
              height = 0,
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
          id = 84,
          name = "entryhall3",
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
              id = 101,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1208,
              y = 1096,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 884,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1336,
              y = 1064,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 510,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1304,
              y = 1120,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 883,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1272,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 881,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1168,
              y = 1136,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 882,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1144,
              y = 1072,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 83,
          name = "entryhall4",
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
              id = 902,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 816,
              y = 1248,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 910,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1136,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 912,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1280,
              y = 1128,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 901,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 720,
              y = 1200,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 903,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 704,
              y = 1320,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 909,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1160,
              y = 1192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 86,
          name = "entryhall5",
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
              id = 913,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 768,
              y = 1344,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 915,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1352,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 911,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 872,
              y = 1264,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 914,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1272,
              y = 1272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 900,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1224,
              y = 1192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 904,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1072,
              y = 1192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 906,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1136,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 905,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 736,
              y = 1200,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 926,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 792,
              y = 856,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["entrypoint"] = { id = 927 },
                ["initialai"] = "enterAndDropDown",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            },
            {
              id = 927,
              name = "",
              type = "",
              shape = "point",
              x = 832,
              y = 992,
              width = 0,
              height = 0,
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
          id = 18,
          name = "toforge",
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
              id = 79,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 976,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = -96, y = 0 },
                { x = 288, y = 0 }
              },
              properties = {}
            },
            {
              id = 317,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1216,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 160, y = -96 },
                { x = 160, y = 48 },
                { x = 176, y = 48 },
                { x = 208, y = 16 },
                { x = 240, y = 16 },
                { x = 272, y = 48 },
                { x = 384, y = 48 },
                { x = 384, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -256,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 385,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1376,
              y = 912,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 16 },
                { x = 8, y = 32 },
                { x = 24, y = 40 },
                { x = 48, y = 48 },
                { x = 80, y = 48 },
                { x = 104, y = 40 },
                { x = 120, y = 32 },
                { x = 128, y = 16 },
                { x = 128, y = -32 },
                { x = 0, y = -32 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -10,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 393,
              name = "",
              type = "forge-fire",
              shape = "ellipse",
              x = 3712,
              y = -80,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = false,
              properties = {
                ["originx"] = 8,
                ["originy"] = 8,
                ["z"] = 16
              }
            },
            {
              id = 395,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1344,
              y = 944,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 2697,
              visible = true,
              properties = {
                ["bodyinlayers"] = "Wall",
                ["extrudeY"] = -48
              }
            },
            {
              id = 418,
              name = "",
              type = "item-throwing-axe",
              shape = "rectangle",
              x = 1396,
              y = 930,
              width = 48,
              height = 48,
              rotation = 330,
              opacity = 1,
              gid = 3106,
              visible = true,
              properties = {}
            },
            {
              id = 419,
              name = "",
              type = "item-throwing-axe",
              shape = "rectangle",
              x = 1440,
              y = 942,
              width = 48,
              height = 48,
              rotation = 270,
              opacity = 1,
              gid = 3106,
              visible = true,
              properties = {}
            },
            {
              id = 420,
              name = "",
              type = "item-throwing-axe",
              shape = "rectangle",
              x = 1480,
              y = 932,
              width = 48,
              height = 48,
              rotation = 225,
              opacity = 1,
              gid = 3106,
              visible = true,
              properties = {}
            },
            {
              id = 614,
              name = "",
              type = "forge-fire",
              shape = "point",
              x = 1440,
              y = 888,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 888,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1272,
              y = 984,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = ""
              }
            },
            {
              id = 889,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1304,
              y = 968,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "item-throwing-axe",
                ["z"] = 32
              }
            },
            {
              id = 305,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1216,
              y = 976,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 301,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1300,
              y = 992,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2458,
              visible = true,
              properties = {
                ["itemtype"] = ""
              }
            },
            {
              id = 302,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1152,
              y = 976,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "mana-peppers"
              }
            },
            {
              id = 890,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1176,
              y = 984,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {
                ["itemtype"] = "food-fish"
              }
            },
            {
              id = 303,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1328,
              y = 1008,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {}
            },
            {
              id = 921,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1256,
              y = 968,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2461,
              visible = true,
              properties = {}
            },
            {
              id = 922,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1300,
              y = 960,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 34
              }
            },
            {
              id = 923,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1272,
              y = 952,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 34
              }
            },
            {
              id = 924,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1275,
              y = 952,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2491,
              visible = true,
              properties = {
                ["z"] = 36
              }
            },
            {
              id = 925,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1296,
              y = 968,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2551,
              visible = true,
              properties = {
                ["z"] = 36
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 53,
          name = "forge",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 2,
            ["time"] = 5
          },
          objects = {
            {
              id = 505,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1264,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 96, y = 0 }
              },
              properties = {}
            },
            {
              id = 384,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1560,
              y = 1048,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["entrypoint"] = { id = 784 },
                ["initialai"] = "enterAndGetProjectile",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 919,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1624,
              y = 984,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["entrypoint"] = { id = 920 },
                ["initialai"] = "enterAndGetProjectile",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 784,
              name = "",
              type = "",
              shape = "point",
              x = 1456,
              y = 976,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 920,
              name = "",
              type = "",
              shape = "point",
              x = 1520,
              y = 952,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 394,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1536,
              y = 928,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 2695,
              visible = true,
              properties = {
                ["bodyinlayers"] = "Wall",
                ["extrudeY"] = -48
              }
            },
            {
              id = 932,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1328,
              y = 1280,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 272, y = -160 },
                { x = 208, y = -96 },
                { x = 432, y = -96 },
                { x = 368, y = -160 }
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
          id = 73,
          name = "forge2",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 397,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1616,
              y = 1016,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 928,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1640,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 507,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1832,
              y = 984,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 930,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1824,
              y = 1112,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 87,
          name = "forge3",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 6
          },
          objects = {
            {
              id = 398,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1144,
              y = 1200,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 931,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1280,
              y = 1272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 929,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1440,
              y = 1272,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 506,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1560,
              y = 1192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 35,
          name = "forge4",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["titlebarcuecard"] = "LV2 REVENGE"
          },
          objects = {
            {
              id = 610,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1104,
              y = 1016,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 611,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1024,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 612,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 976,
              y = 1096,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 613,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1064,
              y = 1096,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "index",
          id = 19,
          name = "messhall",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 8
          },
          objects = {
            {
              id = 81,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1360,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 640, y = 0 }
              },
              properties = {}
            },
            {
              id = 74,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1760,
              y = 1184,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 128, y = -416 },
                { x = 128, y = -304 },
                { x = 480, y = -304 },
                { x = 480, y = -416 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -256,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 318,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1920,
              y = 928,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2465,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 319,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2040,
              y = 936,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2467,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 321,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2008,
              y = 1096,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2466,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 322,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2144,
              y = 1088,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2465,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 323,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2160,
              y = 936,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2466,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 324,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2008,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3070,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 325,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2120,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3074,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 326,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2080,
              y = 1120,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3081,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 329,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2040,
              y = 1136,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3077,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 330,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1952,
              y = 1120,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3073,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 331,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2080,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3077,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 332,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2088,
              y = 896,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3078,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 333,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2200,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3070,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 334,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1896,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3074,
              visible = true,
              properties = {}
            },
            {
              id = 335,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1960,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3078,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 336,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2160,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 16
              }
            },
            {
              id = 337,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2064,
              y = 920,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty"
              }
            },
            {
              id = 338,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2176,
              y = 928,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 16
              }
            },
            {
              id = 359,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1896,
              y = 920,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 362,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1992,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 360,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1936,
              y = 920,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 361,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2032,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 363,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1896,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2550,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 364,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1936,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2543,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 365,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2000,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2492,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 367,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2016,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 368,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2144,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 369,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1920,
              y = 920,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 372,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2016,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 373,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2124,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 375,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2016,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3094,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 376,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1928,
              y = 920,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2492,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 377,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2144,
              y = 936,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2543,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 381,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2016,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3094,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 379,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2120,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2547,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 382,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2029,
              y = 1096,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2551,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 320,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1824,
              y = 1088,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 2467,
              visible = true,
              properties = {
                ["extrudeY"] = -16
              }
            },
            {
              id = 366,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1824,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 327,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1808,
              y = 1128,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3073,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 328,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1888,
              y = 1112,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3081,
              visible = true,
              properties = {
                ["extrudeY"] = -12
              }
            },
            {
              id = 370,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1802,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 371,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 1848,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2482,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 378,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1800,
              y = 1088,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2543,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 374,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1828,
              y = 1082,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 2491,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 380,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1850,
              y = 1082,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3094,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 788,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1632,
              y = 880,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = -112 },
                { x = -32, y = 32 },
                { x = 64, y = 128 },
                { x = 128, y = 128 },
                { x = 256, y = 0 },
                { x = 256, y = -112 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -256,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 962,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2096,
              y = 968,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 965,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2112,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 963,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2128,
              y = 992,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 966,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2136,
              y = 1024,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "guardForever",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 1010,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2000,
              y = 920,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80211414",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1011,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1856,
              y = 1112,
              width = 64,
              height = 64,
              rotation = -90,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80211414",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1015,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2152,
              y = 1104,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 1073745222,
              visible = true,
              properties = {
                ["color"] = "#80211414",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1041,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2120,
              y = 928,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 1073745222,
              visible = true,
              properties = {
                ["color"] = "#80211414",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1016,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1992,
              y = 1128,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80293426",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1012,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1728,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80293426",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1014,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1864,
              y = 944,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80293426",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1013,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2208,
              y = 888,
              width = 64,
              height = 64,
              rotation = 90,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80293426",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1043,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "polygon",
              x = 2000,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = -640, y = 0 },
                { x = -304, y = 0 },
                { x = 0, y = -64 }
              },
              properties = {}
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 33,
          name = "messhall2",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["cameraboundary"] = { id = 1042 },
            ["donewhenenemiesleft"] = 5
          },
          objects = {
            {
              id = 339,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1688,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 968,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1720,
              y = 1024,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 511,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1640,
              y = 1048,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 967,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1584,
              y = 1104,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 340,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2256,
              y = 1040,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 512,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2336,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 1042,
              name = "",
              type = "CameraBoundary",
              shape = "rectangle",
              x = 1760,
              y = 800,
              width = 480,
              height = 352,
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
          id = 45,
          name = "messhall3",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["cameraboundary"] = { id = 1042 },
            ["donewhenenemiesleft"] = 6
          },
          objects = {
            {
              id = 342,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1984,
              y = 1192,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 348,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2256,
              y = 976,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 970,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1736,
              y = 1040,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 789,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2264,
              y = 1008,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 969,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1720,
              y = 1072,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 971,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1520,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 972,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2448,
              y = 984,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 44,
          name = "messhall4",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["cameraboundary"] = { id = 1042 }
          },
          objects = {
            {
              id = 343,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 2128,
              y = 1192,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 347,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1744,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 974,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1696,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 341,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1848,
              y = 1192,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 349,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1712,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 973,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1664,
              y = 1064,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 350,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2304,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 975,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2360,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 790,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2264,
              y = 992,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 976,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2320,
              y = 968,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
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
          properties = {
            ["musicfade"] = 2
          },
          objects = {
            {
              id = 80,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2320,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = -320, y = 0 },
                { x = 160, y = 0 }
              },
              properties = {}
            },
            {
              id = 946,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2272,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = -128 },
                { x = -32, y = 16 },
                { x = 32, y = 80 },
                { x = 352, y = 80 },
                { x = 416, y = 144 },
                { x = 448, y = 144 },
                { x = 448, y = -128 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -256,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 947,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2272,
              y = 1152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = 0 },
                { x = -32, y = 192 },
                { x = 416, y = 192 },
                { x = 416, y = 0 },
                { x = 384, y = -32 },
                { x = 352, y = -32 },
                { x = 320, y = -64 },
                { x = 160, y = -64 },
                { x = 128, y = -32 },
                { x = 0, y = -32 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 995,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2352,
              y = 896,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 996,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2400,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 997,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2456,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 998,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2504,
              y = 896,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 999,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2528,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1000,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2592,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1044,
              name = "cameraboundary",
              type = "CameraBoundary",
              shape = "polygon",
              x = 2000,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 0 },
                { x = 480, y = 0 },
                { x = 0, y = -64 }
              },
              properties = {}
            },
            {
              id = 1045,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2328,
              y = 896,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1046,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2560,
              y = 904,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1047,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2330,
              y = 905,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1048,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2562,
              y = 913,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1049,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2485.66,
              y = 896,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2478,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1050,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2480,
              y = 901.66,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2472,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1051,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2434,
              y = 904,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2479,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1052,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2432,
              y = 912,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2473,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 67,
          name = "toboss",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["checkpoint"] = true,
            ["musicfade"] = 2
          },
          objects = {
            {
              id = 702,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2272,
              y = 864,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = -128 },
                { x = -32, y = 16 },
                { x = 32, y = 80 },
                { x = 352, y = 80 },
                { x = 416, y = 144 },
                { x = 448, y = 144 },
                { x = 448, y = -128 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -256,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 76,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2720,
              y = 896,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -160 },
                { x = 0, y = 112 },
                { x = 32, y = 80 },
                { x = 864, y = 80 },
                { x = 864, y = -160 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 313,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2720,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -160 },
                { x = 0, y = 80 },
                { x = 144, y = 80 },
                { x = 144, y = -160 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -128,
                ["linecolor"] = "#80ffffff",
                ["z"] = 64
              }
            },
            {
              id = 536,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 3152,
              y = 832,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -160 },
                { x = 0, y = 80 },
                { x = 216, y = 80 },
                { x = 216, y = -160 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -128,
                ["linecolor"] = "#80ffffff",
                ["z"] = 64
              }
            },
            {
              id = 703,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 2320,
              y = 1008,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 160, y = 0 },
                { x = 640, y = 0 }
              },
              properties = {}
            },
            {
              id = 77,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 2272,
              y = 1152,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -32, y = 0 },
                { x = -32, y = 192 },
                { x = 416, y = 192 },
                { x = 416, y = 0 },
                { x = 384, y = -32 },
                { x = 352, y = -32 },
                { x = 320, y = -64 },
                { x = 160, y = -64 },
                { x = 128, y = -32 },
                { x = 0, y = -32 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 1001,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2352,
              y = 896,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1002,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2400,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1003,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2456,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1004,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2504,
              y = 896,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1005,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2528,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1006,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2592,
              y = 904,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 3404,
              visible = true,
              properties = {}
            },
            {
              id = 1017,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3016,
              y = 1008,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#801d0f0f",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1018,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2832,
              y = 984,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80530909",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1019,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3128,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80530909",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1032,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2992,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80530909",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1020,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2912,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3398,
              visible = true,
              properties = {
                ["color"] = "#80530909",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1021,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2776,
              y = 1096,
              width = 64,
              height = 64,
              rotation = -90,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#801d0f0f",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1022,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3120,
              y = 968,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3221228870,
              visible = true,
              properties = {
                ["color"] = "#801d0f0f",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1023,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3248,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 90,
              opacity = 1,
              gid = 2147487046,
              visible = true,
              properties = {
                ["color"] = "#80280000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1024,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2800,
              y = 936,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1025,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2802,
              y = 945,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1026,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2829.66,
              y = 936,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2478,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1027,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2824,
              y = 941.66,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2472,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1028,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2778,
              y = 928,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2479,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1029,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2776,
              y = 936,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2473,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1033,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2328,
              y = 896,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1039,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2560,
              y = 904,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 2481,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1034,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2330,
              y = 905,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1040,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2562,
              y = 913,
              width = 16,
              height = 16,
              rotation = 345,
              opacity = 1,
              gid = 2474,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1035,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2485.66,
              y = 896,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2478,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1036,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2480,
              y = 901.66,
              width = 16,
              height = 16,
              rotation = 45,
              opacity = 1,
              gid = 2472,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1037,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2434,
              y = 904,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2479,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            },
            {
              id = 1038,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2432,
              y = 912,
              width = 16,
              height = 16,
              rotation = 15,
              opacity = 1,
              gid = 2473,
              visible = true,
              properties = {
                ["color"] = "#80aa0000",
                ["drawz"] = -0.5,
                ["shadowcolor"] = "#00000000"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 23,
          name = "boss",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["music"] = {
              1.2,
              "music/Jazz Hole loop.ogg"
            },
            ["titlebarcuecard"] = "AVOID BOSS ENTRY ATTACK"
          },
          objects = {
            {
              id = 231,
              name = "",
              type = "bandit-boss",
              shape = "rectangle",
              x = 3216,
              y = 1032,
              width = 192,
              height = 192,
              rotation = 0,
              opacity = 1,
              gid = 3101,
              visible = true,
              properties = {
                ["facedegrees"] = 180,
                ["initialai"] = "bandit-boss-first-charge",
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 72,
          name = "help1",
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
              id = 778,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2696,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 849,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 3216,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 779,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2696,
              y = 1104,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 850,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 3216,
              y = 1128,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 80,
          name = "help2",
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
              id = 860,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2584,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 867,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2704,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 862,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 3320,
              y = 1024,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 870,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 3216,
              y = 1064,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 859,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2640,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 861,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 3368,
              y = 1112,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 69,
          name = "help3",
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
              id = 403,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2896,
              y = 856,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 404 },
                ["exitpoint"] = { id = 405 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 775,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3088,
              y = 848,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 774 },
                ["exitpoint"] = { id = 776 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 404,
              name = "",
              type = "",
              shape = "point",
              x = 2896,
              y = 904,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 774,
              name = "",
              type = "",
              shape = "point",
              x = 3088,
              y = 904,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 405,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2896,
              y = 800,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 776,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3088,
              y = 800,
              width = 0,
              height = 0,
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
          id = 70,
          name = "help4",
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
              id = 777,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 3232,
              y = 1032,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 853,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2688,
              y = 1072,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 858,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 3008,
              y = 856,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 82,
          name = "help5",
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
              id = 874,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 3440,
              y = 1112,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 875,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2704,
              y = 1088,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 877,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2496,
              y = 1008,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 876,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 3224,
              y = 1016,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3103,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 37,
          name = "help6",
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
              id = 400,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2928,
              y = 848,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 401 },
                ["exitpoint"] = { id = 402 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "mana-peppers",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 406,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3120,
              y = 856,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 407 },
                ["exitpoint"] = { id = 408 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-bigfish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 401,
              name = "",
              type = "",
              shape = "point",
              x = 2928,
              y = 904,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 407,
              name = "",
              type = "",
              shape = "point",
              x = 3120,
              y = 904,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 402,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2928,
              y = 800,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 408,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3120,
              y = 800,
              width = 0,
              height = 0,
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
          id = 71,
          name = "help7",
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
              id = 781,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2688,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 854,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2688,
              y = 992,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 782,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 3232,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 855,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 3232,
              y = 992,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3141,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 81,
          name = "help8",
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
              id = 580,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 3008,
              y = 856,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 58,
          name = "help9",
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
              id = 856,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 3216,
              y = 1064,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 857,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 2696,
              y = 1048,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3139,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 32,
      name = "unused",
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
          id = 41,
          name = "tolearnitems",
          class = "Room",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["donewhenenemiesleft"] = 3,
            ["titlebarcuecard"] = "RUNNING TACKLE"
          },
          objects = {
            {
              id = 482,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 1680,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polyline = {
                { x = 0, y = 0 },
                { x = 96, y = 0 }
              },
              properties = {}
            },
            {
              id = 490,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2008,
              y = 192,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 491,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2088,
              y = 256,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 492,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2000,
              y = 280,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3105,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 524,
              name = "flamecharge1",
              type = "",
              shape = "rectangle",
              x = 2334,
              y = 194,
              width = 30,
              height = 6,
              rotation = 0,
              opacity = 1,
              visible = false,
              properties = {
                ["color"] = "#ffffffff"
              }
            }
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 38,
          name = "+slingers",
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
              id = 409,
              name = "",
              type = "",
              shape = "rectangle",
              x = 5040,
              y = -40,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 412 },
                ["exitpoint"] = { id = 415 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "mana-peppers",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 411,
              name = "",
              type = "",
              shape = "rectangle",
              x = 5136,
              y = -8,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 3104,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 414 },
                ["exitpoint"] = { id = 417 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 412,
              name = "",
              type = "",
              shape = "point",
              x = 5040,
              y = 40,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 414,
              name = "",
              type = "",
              shape = "point",
              x = 5136,
              y = 40,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 415,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 5040,
              y = -64,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {}
            },
            {
              id = 417,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 5136,
              y = -64,
              width = 0,
              height = 0,
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
          id = 55,
          name = "oldentryhallarchers",
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
              id = 291,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3264,
              y = -48,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 294 },
                ["exitpoint"] = { id = 296 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 292,
              name = "",
              type = "",
              shape = "rectangle",
              x = 3264,
              y = -16,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 3102,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 293 },
                ["exitpoint"] = { id = 295 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 293,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 3216,
              y = 48,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 294,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 3312,
              y = 48,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 295,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3248,
              y = -16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              properties = {
                ["z"] = 64
              }
            },
            {
              id = 296,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 3280,
              y = -16,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
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
              x = 2944,
              y = 320,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
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
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -48,
                ["linecolor"] = "#80ffffff"
              }
            },
            {
              id = 78,
              name = "camerapath",
              type = "CameraPath",
              shape = "polyline",
              x = 3264,
              y = 144,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
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
        }
      }
    }
  }
}
