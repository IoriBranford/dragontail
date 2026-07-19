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
  nextlayerid = 90,
  nextobjectid = 940,
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
      name = "grassland",
      firstgid = 2449,
      filename = "tilesets/grassland.tsx",
      exportfilename = "tilesets/grassland.lua"
    },
    {
      name = "cavedoor2-diagonal",
      firstgid = 5265,
      filename = "sprites/bandit/cavedoor2-diagonal.tsx",
      exportfilename = "sprites/bandit/cavedoor2-diagonal.lua"
    },
    {
      name = "bushes",
      firstgid = 5269,
      filename = "tilesets/veg/grassland/bushes.tsx",
      exportfilename = "tilesets/veg/grassland/bushes.lua"
    },
    {
      name = "vegA1",
      firstgid = 5285,
      filename = "tilesets/veg/vegA1.tsx",
      exportfilename = "tilesets/veg/vegA1.lua"
    },
    {
      name = "tree2B_ss",
      firstgid = 5333,
      filename = "tilesets/veg/grassland/tree2B_ss.tsx",
      exportfilename = "tilesets/veg/grassland/tree2B_ss.lua"
    },
    {
      name = "tree3D_ss",
      firstgid = 5589,
      filename = "tilesets/veg/grassland/tree3D_ss.tsx",
      exportfilename = "tilesets/veg/grassland/tree3D_ss.lua"
    },
    {
      name = "tree2A_ss",
      firstgid = 5845,
      filename = "tilesets/veg/grassland/tree2A_ss.tsx",
      exportfilename = "tilesets/veg/grassland/tree2A_ss.lua"
    },
    {
      name = "vegA2",
      firstgid = 6101,
      filename = "tilesets/veg/vegA2.tsx",
      exportfilename = "tilesets/veg/vegA2.lua"
    },
    {
      name = "vegA3",
      firstgid = 6149,
      filename = "tilesets/veg/vegA3.tsx",
      exportfilename = "tilesets/veg/vegA3.lua"
    },
    {
      name = "vegA4",
      firstgid = 6197,
      filename = "tilesets/veg/vegA4.tsx",
      exportfilename = "tilesets/veg/vegA4.lua"
    },
    {
      name = "vegB1",
      firstgid = 6245,
      filename = "tilesets/veg/vegB1.tsx",
      exportfilename = "tilesets/veg/vegB1.lua"
    },
    {
      name = "vegB2",
      firstgid = 6293,
      filename = "tilesets/veg/vegB2.tsx",
      exportfilename = "tilesets/veg/vegB2.lua"
    },
    {
      name = "vegB3",
      firstgid = 6341,
      filename = "tilesets/veg/vegB3.tsx",
      exportfilename = "tilesets/veg/vegB3.lua"
    },
    {
      name = "vegC1",
      firstgid = 6389,
      filename = "tilesets/veg/vegC1.tsx",
      exportfilename = "tilesets/veg/vegC1.lua"
    },
    {
      name = "vegC2",
      firstgid = 6437,
      filename = "tilesets/veg/vegC2.tsx",
      exportfilename = "tilesets/veg/vegC2.lua"
    },
    {
      name = "vegC3",
      firstgid = 6485,
      filename = "tilesets/veg/vegC3.tsx",
      exportfilename = "tilesets/veg/vegC3.lua"
    },
    {
      name = "vegC4",
      firstgid = 6533,
      filename = "tilesets/veg/vegC4.tsx",
      exportfilename = "tilesets/veg/vegC4.lua"
    },
    {
      name = "barrelA",
      firstgid = 6581,
      filename = "sprites/containers/barrelA.tsx",
      exportfilename = "sprites/containers/barrelA.lua"
    },
    {
      name = "barrelB",
      firstgid = 6584,
      filename = "sprites/containers/barrelB.tsx",
      exportfilename = "sprites/containers/barrelB.lua"
    },
    {
      name = "crates",
      firstgid = 6587,
      filename = "sprites/containers/crates.tsx",
      exportfilename = "sprites/containers/crates.lua"
    },
    {
      name = "wall-torch",
      firstgid = 6593,
      filename = "sprites/banditcave/wall-torch.tsx",
      exportfilename = "sprites/banditcave/wall-torch.lua"
    },
    {
      name = "tables-hori",
      firstgid = 6596,
      filename = "sprites/banditcave/tables-hori.tsx",
      exportfilename = "sprites/banditcave/tables-hori.lua"
    },
    {
      name = "graffiti-skull-bones",
      firstgid = 6599,
      filename = "sprites/banditcave/graffiti-skull-bones.tsx",
      exportfilename = "sprites/banditcave/graffiti-skull-bones.lua"
    },
    {
      name = "dish-small",
      firstgid = 6613,
      filename = "sprites/weapons/dish-small.tsx",
      exportfilename = "sprites/weapons/dish-small.lua"
    },
    {
      name = "Meats A",
      firstgid = 6614,
      filename = "sprites/items/Meats A.tsx",
      exportfilename = "sprites/items/Meats A.lua"
    },
    {
      name = "Bread A",
      firstgid = 6669,
      filename = "sprites/items/Bread A.tsx",
      exportfilename = "sprites/items/Bread A.lua"
    },
    {
      name = "Cheese A",
      firstgid = 6677,
      filename = "sprites/items/Cheese A.tsx",
      exportfilename = "sprites/items/Cheese A.lua"
    },
    {
      name = "Forge A",
      firstgid = 6695,
      filename = "tilesets/Forge A.tsx",
      exportfilename = "tilesets/Forge A.lua"
    },
    {
      name = "Workbench, Smith",
      firstgid = 6823,
      filename = "sprites/banditcave/Workbench, Smith.tsx",
      exportfilename = "sprites/banditcave/Workbench, Smith.lua"
    },
    {
      name = "gamepad-buttons",
      firstgid = 6829,
      filename = "tilesets/ui/gamepad-buttons.tsx",
      exportfilename = "tilesets/ui/gamepad-buttons.lua"
    },
    {
      name = "keyboard-keys",
      firstgid = 6929,
      filename = "tilesets/ui/keyboard-keys.tsx",
      exportfilename = "tilesets/ui/keyboard-keys.lua"
    },
    {
      name = "Chair, Dining F",
      firstgid = 7201,
      filename = "sprites/banditcave/Chair, Dining F.tsx",
      exportfilename = "sprites/banditcave/Chair, Dining F.lua"
    },
    {
      name = "flamegaugefull",
      firstgid = 7217,
      filename = "tilesets/ui/flamegaugefull.tsx",
      exportfilename = "tilesets/ui/flamegaugefull.lua"
    },
    {
      name = "vegetables",
      firstgid = 7225,
      filename = "sprites/items/vegetables.tsx",
      exportfilename = "sprites/items/vegetables.lua"
    },
    {
      name = "axe",
      firstgid = 7232,
      filename = "sprites/bandit/axe.tsx",
      exportfilename = "sprites/bandit/axe.lua"
    },
    {
      name = "boss",
      firstgid = 7233,
      filename = "sprites/bandit/boss.tsx",
      exportfilename = "sprites/bandit/boss.lua"
    },
    {
      name = "bow",
      firstgid = 7234,
      filename = "sprites/bandit/bow.tsx",
      exportfilename = "sprites/bandit/bow.lua"
    },
    {
      name = "spear",
      firstgid = 7235,
      filename = "sprites/bandit/spear.tsx",
      exportfilename = "sprites/bandit/spear.lua"
    },
    {
      name = "sling",
      firstgid = 7236,
      filename = "sprites/bandit/sling.tsx",
      exportfilename = "sprites/bandit/sling.lua"
    },
    {
      name = "knife",
      firstgid = 7237,
      filename = "sprites/bandit/knife.tsx",
      exportfilename = "sprites/bandit/knife.lua"
    },
    {
      name = "throwing-axe",
      firstgid = 7238,
      filename = "sprites/weapons/throwing-axe.tsx",
      exportfilename = "sprites/weapons/throwing-axe.lua"
    },
    {
      name = "stone",
      firstgid = 7239,
      filename = "sprites/weapons/stone.tsx",
      exportfilename = "sprites/weapons/stone.lua"
    },
    {
      name = "Xbox",
      firstgid = 7240,
      filename = "tilesets/ui/Gamepad Spritesheets/Xbox.tsx",
      exportfilename = "tilesets/ui/Gamepad Spritesheets/Xbox.lua"
    },
    {
      name = "tree2B_ss_leaves",
      firstgid = 7260,
      filename = "sprites/grassland/tree2B_ss_leaves.tsx",
      exportfilename = "sprites/grassland/tree2B_ss_leaves.lua"
    },
    {
      name = "tree2B_ss_obj",
      firstgid = 7261,
      filename = "sprites/grassland/tree2B_ss.tsx",
      exportfilename = "sprites/grassland/tree2B_ss.lua"
    },
    {
      name = "tree2C_ss_leaves",
      firstgid = 7262,
      filename = "sprites/grassland/tree2C_ss_leaves.tsx",
      exportfilename = "sprites/grassland/tree2C_ss_leaves.lua"
    },
    {
      name = "tree2C_ss_obj",
      firstgid = 7263,
      filename = "sprites/grassland/tree2C_ss.tsx",
      exportfilename = "sprites/grassland/tree2C_ss.lua"
    },
    {
      name = "spikefruit-hanging",
      firstgid = 7264,
      filename = "sprites/weapons/spikefruit-hanging.tsx",
      exportfilename = "sprites/weapons/spikefruit-hanging.lua"
    },
    {
      name = "spikefruit-onground",
      firstgid = 7265,
      filename = "sprites/weapons/spikefruit-onground.tsx",
      exportfilename = "sprites/weapons/spikefruit-onground.lua"
    },
    {
      name = "lifefruit-hanging",
      firstgid = 7266,
      filename = "sprites/items/lifefruit-hanging.tsx",
      exportfilename = "sprites/items/lifefruit-hanging.lua"
    },
    {
      name = "lifefruit",
      firstgid = 7267,
      filename = "sprites/items/lifefruit.tsx",
      exportfilename = "sprites/items/lifefruit.lua"
    },
    {
      name = "bigstone",
      firstgid = 7268,
      filename = "sprites/weapons/bigstone.tsx",
      exportfilename = "sprites/weapons/bigstone.lua"
    },
    {
      name = "tallstone",
      firstgid = 7269,
      filename = "sprites/weapons/tallstone.tsx",
      exportfilename = "sprites/weapons/tallstone.lua"
    },
    {
      name = "pepper-plant",
      firstgid = 7270,
      filename = "sprites/items/pepper-plant.tsx",
      exportfilename = "sprites/items/pepper-plant.lua"
    },
    {
      name = "peppers-on-plant",
      firstgid = 7271,
      filename = "sprites/items/peppers-on-plant.tsx",
      exportfilename = "sprites/items/peppers-on-plant.lua"
    },
    {
      name = "muscle",
      firstgid = 7272,
      filename = "sprites/bandit/muscle-orange.tsx",
      exportfilename = "sprites/bandit/muscle-orange.lua"
    },
    {
      name = "cave-window",
      firstgid = 7273,
      filename = "tilesets/caves/semiblocked-tunnel.tsx",
      exportfilename = "tilesets/caves/semiblocked-tunnel.lua"
    },
    {
      name = "shield",
      firstgid = 7274,
      filename = "sprites/bandit/shield.tsx",
      exportfilename = "sprites/bandit/shield.lua"
    },
    {
      name = "crystal-spikes",
      firstgid = 7275,
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
      name = "floor",
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
          x = 40, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMAwgCBdG4BARBoYgEQaGCCg7WAQhHgmlQXIgNogGAMfFBi8="
        },
        {
          x = 60, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNAJBIkwMIRAcaQwhA5GEgOxw4UZGK4JEWceACNzBPs="
        },
        {
          x = -20, y = 0, width = 20, height = 12,
          data = "eJxjYBgFgwWECVPXPFER6ponJjKy3HdFiLrm0QIAAGnNAfY="
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJzNks1KQzEUhD+kiosKOUmeSMSVInjt7+OIFTcKrULbF3KpuBHxaWTICTcWV7oxMMw5k8zcJDfw+/Ee+zonuMp/CAPmjX+cYZa/53e5fGOe+n6aCiYJLnNf116YNd6aNcqwNIgG5v1DADPYRlg5CxvH2nWh9sqUV75kkA0e3SseS4/wHGAR4NjgwDVBvfjU4CbA0OAjwacVz77PX4cCZUiv/p/qhfNJgEODc4NlhM6zBo1He9lr9qM93DbzFQMre3mLMErwGkrmWud1rvVG92Pw5Ppqh7eNR3cfE1z4uV9CYeULd94HgzODe4MjK+uGrum/aY2gN9PpLXpdIW2iN9Do6qdeS99dI/7v4wulBUlD"
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJzNkktKBEEQRB8iLq3Kqt6px3Gli8HfqIgrz+Fv1JWfYWZARRwQzyGI+FuIGzeDhxEJKhsb8QA2BBkZGZnVXZ0LFSxV0M6wWEHO/PmsZFhzz0IFq7n0SVMuvi5PBYuqOf9IpVeeJlKG9wAnEeYMTiNMGhxHGGU4NvjM5b0E9ehs8eUK3twnqFdRs5r6q/OuQcvAMgwMLhJcJugZ9D0XVPtdH7inxnkqsa7vG+wGeIrwFSAnODQYs8IfY4mdAFMGQ4Nrg5sE0wYTBrMGzxF2AhzEMkv6uM8QlCs+ROgY7EXYSjCTYNPg1mDDynlP7un42XeuHfmMwwj7fsa9e5RfJRimMuchlG/YDj99Ql93pTvSfXh+adBr8IHznufi0tQzaOjKo8G8+f+zsgPvsfDo+ov2xODMc6HV4KMMwaAbYFX75bvX9l2so3ZStVoT5K95c3fr/f3vzzcAiWgS"
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJx9k9lKA0EQRc+LGyjT1RM/RwTxzT0aox8jSh4U3JdoYj5GQcUHdwTBnxHk0tVkQGLDpWqqu28tfQf+rrUyoeE4Mpg3+C7h2O2CwYH7wrj7g9ZXhFgmrJTQrCXu0wCjfnfOEm9R4a3XoKnzJWyqrhpsOI/2g4H5OcVeQv9uxlGAN4+fW0I3wrVDfjSYMDj2c+9uDw0Wc+8eM0v3Lg1uCygjPIRkha0CrmLKc+k9vQYYCXAS0izFof22QS/CkEHD+hzCVIC7ALMGu87fqNTf8dpVS69Sg7hkbwI8BtjxGoVp9+/9rPa3K7W3DFoBhg1m3M/9/QRoR7hQTtWhHmOK6Tuj6zaf077Q8diqeIvUW9aT3uhD87E0872i/37SiN5Vb/Lkb6l5fvv+iufoWdJtvYQN6aaWfFnFP2Nfu8pV1bQ0NxZSrmfnPouD9ay17hqu6jVDWl7yuHKJ97//I69J/+f2vf+3ImlG/Wouy3lertVfNux6Cg=="
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJyFk8tKgzEQhb+VLrT+maT4QoIXtGpFUZ9H3GirtfX6PCKI95X4OHKcCf7UhYFhkjOTM7fkq8CZwVeB1wRrCeYMzpNjneT2fhdK4d8ljmHjdyUvCXrm+HMDpw2sJ3hMYAV2unBQYLcLn/kvX+WpMkgwMhhFflVWEnwE9p5gM3LejxiHxePIvmHQMXhq5an8JNPxxLltXoNqSeb3ZVtNkM19eoFdGFya46p3aL9YlZsMV/ab66zBW3Bct2w/fBkWDRazxxfWNxhnuDG4NbgzuMpuG4bPQnCUDHuRzyDy6Yd/I6wVazDVV/Ww1zorV/FVzoliZ7jNXtc46hNWa+y06pdd+Li1Ly15SLBkvr+PWMtxPk4eUzzFHJ8xOGr8nnyOkvdiEr25VG7RI2ESYdVHWufqX30qrh5vxhs5Sf4nNKf6Ts5Cz0/1sc5Auv6jKvpLp+Gr/ldM+jx0fcea91bjM1kLLU7NRHOUzzdPSI1z"
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJzNkt1KAzEQRg+KiCDsTHbp23gnXqml/uvj1CqC1bZqse3rCAoitV4I4sOITDPLLpjeG/hIJsmeycy38L/HSQ57BewX1boeH7ssPs3hoIiyvbP8L+8rh5mAKtwrPNTmoPG81KrE+UZAFD4SvGkGPYGWcQKMFRoKeYCjULGunb0m8ObcQYK37veaCrsa8w4CPCoMnWd7U2e8ZnAl8C7p99kdq3VkjFDVauuRa6iwI/CSQV9jvU2BSYJn9ych1mfayKCt8JPBpcKSwqHnM5U97Uu63o7AhcCm98xk8ZPUYoWOn39q7M1sAW9sud2Dc//mWWBFYUsja7mWq+E9bdn/UqT7N/cqwJ37YLK1+W2yuPTePDI/Ul7YuPW3m8/m4XYW47mvPvcUut63ru99L+D9AnwoWOY="
        },
        {
          x = 20, y = 12, width = 20, height = 12,
          data = "eJzt0MENgCAQBdGRZJPdfoCa8CAN6QFrwoLsgfwjU8A7DOxWugy66d4Ng1foTYNP6BWH6jqvOZxC73Z4hJ66IyCFzssBJeAHfVsHFQ=="
        },
        {
          x = 40, y = 12, width = 20, height = 12,
          data = "eJytzstNQlEUBdCVKLCvE4GHrcjXJoxGa/CHhdCCP6zHCYKxHEMgkZn64k5u9rmTdQ4/56jivOKz4q296cMOs+28fu3Opn+bZZeLHovut7Hrz/7o7d56WnHZ2/TZzn+9b9rwr5n/s7faes3QCgklHKSe1w+DMAyjMA6TcFLTuwrX4SbchrswDfc1vYfwGJ7Cc3gJ8/Ba07PNIryHZViFj5reXmG/0Cg0C61CCqXU844L/cKgMCyMCuPCpKb3BQsqJIo="
        },
        {
          x = 60, y = 12, width = 20, height = 12,
          data = "eJzti0EKAkEMBOsmHtYkO/MnD6ujrIL6JxF/5VHFi8+RkBnYN8g2hKTS3UWhM9gZbA0Gg6fC1eCm8E0xg8DeYGXB3mneXWBReS1QJj2fYpFfGrwkflLzG4OHglZ+93BMcMpwzjCmYL8vGQ7V87/zNOu7ea336Zk1i3/VD2JoHZY="
        },
        {
          x = 80, y = 12, width = 20, height = 12,
          data = "eJztjMEJgDAMRd8EmpDu5EUstILiUi7mxZvjSEkPHuoGffBI+AlfFB5zT4WosCgMRYE4wlx/pjovgdtoks1dDZLBHnzfgufpc881Lx6h3dfpdPjlBS6fDlU="
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
      name = "wall",
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
          data = "eJxjYBgFo2AUMAwwkOJlYJDgY2C4yEOaPgA9SQEr"
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJztjkkKAjEURN9eU/0jTuiFXImKE3omlRYn9GZ6GQk2JJss7K3WpqAeBe9gUHhoGEw8jArYGewNXk1oCzqK3RX0BP3MNjYYuA/zglbChg7mgoViLwUrwTqzBYdN9ZsKZgnbOjgJzop9EVwFt8wWHO7VrxQcE/ZwfJ3g8Kzxy6WOwz/8bN49iR1R"
        },
        {
          x = 20, y = 0, width = 20, height = 12,
          data = "eJztyLcRgEAQBDBVsNFjCsMVhiuXIi5jXqFaGMIYpjCHVrglrGELeziKd4Yr3OEJb/G6zo98+T8XcQ=="
        },
        {
          x = 40, y = 0, width = 20, height = 12,
          data = "eJztjksKwkAQRN8FuiAy+eCtIiYRb6VEIx7LpacJzcysnIXLLPKgdv2qOghqQSNoBV3K1eAiqAwOxg9Hg1Bwz4JBMAomxQ7P2+Al6A1OFm/dzx2+V3JnwUPwFCyKHZ5v+ulmcE+/up87fK/k/sMn/ep+7sh7OztsiBVVvRnF"
        },
        {
          x = 60, y = 0, width = 20, height = 12,
          data = "eJztjk0Kg0AYQ98B/AKKVq+lWO21Wvy7lp5IhhkQXM1iFl0YCAlZhFcYSdUZ7Fm6v59BblAk4jwMWkvL+bWL8yXvKmQtaARlxOb6nXOQ9zvkKPgI+ojN9TvnIu855CrYBFPE5voj/koni4YapA=="
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJzljssKglAURdfczgZFK/wrwxf+VWEp/lUN+5oQutyhN7g4aU82bA7rLPivlAYnwVmQCwrBUX5z/TyE8QaDTtALakEjaOU316lBZtu8xWASzIJRcBc85DfXlcHFtj3fAT/XXL93oZ6/ZPXskni8W2S/V2TenvkAtmsSiQ=="
        },
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
          data = "eJztj0EKwlAMRN+AO+l1bN1Ir/NbN4Ue539deqeepgQTCN26KjgQMszwAoHzaPUJf9Hv9z7AILgL+rQt24CnoAiugptP9OaDNfXOzPpyU9qWdYK3oAoefrek3nywpsmZl3MtbcvG9P/id2vqa2JN7cD8xem1A/mRGUM="
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJzt0DkKAlEQhOGvAxN1ruMSuFxHnUTxOC6J6JEUTyOPeQMPRBAN9YcOKqiiuvgN7lgEw2AU9KPRy2AV1IVO1wtOqHHAGFtcNN4q2BX+Wdb74BAcC51uGlxxQyc456zUK3nn0fRs/ZusX7EOurnnIP+Vsqo3vK+Y5J7tDlXR61PWxQ7fZv3xxAPxaBoP"
        },
        {
          x = 60, y = 24, width = 20, height = 12,
          data = "eJztzzsORQAQRuFzWvbjUbAfl8Z+PLYqEo2Jm6AS8VVzuvnh2VqhExrh577vmIRZGITR/50IqZALhVCGO9v6rEqow4a4Z+0r+vDz0Z4Pr7YAJAQUQg=="
        },
        {
          x = 80, y = 24, width = 20, height = 12,
          data = "eJzt0c0KQXEUBPDfyccCz3OxwPNcbHie62OB5yELvI3UXy65OyllamrmTJ05dfgNzD60pxf0gw22OGCHRnDEGGs0gx7qwf6NrwULTIJpcMI55Rd049FV1lmFzxKXwSpoBe2UdYJxPLrKOq/weeIdg2CYstHt9lJXWRcVvkh8+knK5i/zP3wNVweaIZo="
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
      name = "onwall",
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
          x = 0, y = -12, width = 20, height = 12,
          data = "eJxjYBgFo2AUMNARLBahnlkAOgAAuA=="
        },
        {
          x = -20, y = 0, width = 20, height = 12,
          data = "eJxjYBi8YK7IQLtgFIwChkENAC+uALI="
        },
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJxbKsIABqYSDAzToexQCQaGJVD2KBgFo4Bh0AIAgjoC1w=="
        },
        {
          x = 80, y = 0, width = 20, height = 12,
          data = "eJxjYBgaYLoIhF4kwsAwB8qG0aNgFDCMUAAAbVACwg=="
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
          x = 0, y = 24, width = 20, height = 12,
          data = "eJxjYBgF9AJWTAwM1kwQtiUThA8CILFsRuLMsGVkYMiB6stlYmDIg7JBYiA+CIDE5hFp3ihgGNIAAHvpBRE="
        },
        {
          x = 20, y = 24, width = 20, height = 12,
          data = "eJxjYBgFlAArJggGAXtGysMylwmCQaCICuaNAoZhDQCmEgIK"
        },
        {
          x = 40, y = 24, width = 20, height = 12,
          data = "eJztzDkNgEAARcHR8U2SYABYAxwGOJRSQk22gTDVqx7v0eTq9tZPdaEPQygVfmOYwhyWCr81bGEPR4Xfz+eclJoJFA=="
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
          data = "eJxjYBi5IFyKgSFCioEhUoqBIUpqoF0zCkYBA8kAAOtsAcs="
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
          x = 80, y = 0, width = 20, height = 12,
          data = "eJxjYBgFo2Dogenc1DXvOpXNu8hJXfMEubCLAwCoPgJ6"
        },
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
      chunks = {
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJxjYBhZ4LoIA8MNEeqZ91yEgeEFFc37LsLA8IOK5rGLMlAViIsyMEhQ2cxRwEA2AABfdgZb"
        }
      }
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
      chunks = {
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJxjYBgFgwlcF2VguCFKPfOeizIwvKCied9FGRh+UNE8djEGBg4x6pnHMMIAAEXHBic="
        }
      }
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
      chunks = {
        {
          x = 0, y = 0, width = 20, height = 12,
          data = "eJzt0UkRgEAQBME0Me3f1B4GOGQgASL4TkqoorXvRphhhZ3/5Y5whivcYRSzWMWuPuPFA9KmC1M="
        }
      }
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
              y = 0,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = -96 },
                { x = 0, y = 288 },
                { x = 32, y = 288 },
                { x = 32, y = 160 },
                { x = 64, y = 128 },
                { x = 224, y = 128 },
                { x = 256, y = 96 },
                { x = 256, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["extrudeY"] = -64,
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
              y = 32,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = -192, y = -128 },
                { x = -192, y = 64 },
                { x = 1024, y = 64 },
                { x = 1056, y = 32 },
                { x = 1056, y = -128 }
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
              id = 513,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 416,
              y = 80,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 6833,
              visible = true,
              properties = {}
            },
            {
              id = 516,
              name = "Move",
              type = "",
              shape = "text",
              x = 376,
              y = 64,
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
            },
            {
              id = 514,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 56,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 541,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 72,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7240,
              visible = true,
              properties = {}
            },
            {
              id = 517,
              name = "Attack",
              type = "",
              shape = "text",
              x = 512,
              y = 48,
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
              id = 544,
              name = "Jump",
              type = "",
              shape = "text",
              x = 512,
              y = 64,
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
              id = 539,
              name = "",
              type = "",
              shape = "rectangle",
              x = 608,
              y = 56,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 543,
              name = "",
              type = "",
              shape = "rectangle",
              x = 608,
              y = 72,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7242,
              visible = true,
              properties = {}
            },
            {
              id = 540,
              name = "or",
              type = "",
              shape = "text",
              x = 584,
              y = 48,
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
              id = 542,
              name = "or",
              type = "",
              shape = "text",
              x = 584,
              y = 64,
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
              id = 622,
              name = "Direct",
              type = "",
              shape = "text",
              x = 648,
              y = 48,
              width = 192,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Aim all attacks\nwith    direction",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 519,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 688,
              y = 80,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 6833,
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
          properties = {
            ["donewhenenemiesleft"] = 4,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7244,
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
              gid = 7237,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
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
              gid = 7237,
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
              id = 637,
              name = "Direct",
              type = "",
              shape = "text",
              x = 840,
              y = 48,
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
              id = 639,
              name = "Direct",
              type = "",
              shape = "text",
              x = 1024,
              y = 56,
              width = 64,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Pummel",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
            {
              id = 689,
              name = "During grapple",
              type = "",
              shape = "text",
              x = 1008,
              y = 40,
              width = 168,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "During grapple",
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
              x = 1024,
              y = 72,
              width = 240,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Throw         +    direction",
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
              x = 816,
              y = 64,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 6833,
              visible = true,
              properties = {}
            },
            {
              id = 643,
              name = "joystick",
              type = "",
              shape = "rectangle",
              x = 1152,
              y = 88,
              width = 16,
              height = 16,
              rotation = 0,
              opacity = 1,
              gid = 6833,
              visible = true,
              properties = {}
            },
            {
              id = 640,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1088,
              y = 80,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 641,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1120,
              y = 80,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 642,
              name = "or",
              type = "",
              shape = "text",
              x = 1096,
              y = 72,
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
              gid = 7269,
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
            },
            {
              id = 686,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1088,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 687,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1120,
              y = 64,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 688,
              name = "or",
              type = "",
              shape = "text",
              x = 1096,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              id = 515,
              name = "sprintbutton",
              type = "",
              shape = "rectangle",
              x = 1384,
              y = 56,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7254,
              visible = true,
              properties = {}
            },
            {
              id = 518,
              name = "Run",
              type = "",
              shape = "text",
              x = 1288,
              y = 48,
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
              y = 48,
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
              y = 56,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7250,
              visible = true,
              properties = {}
            },
            {
              id = 678,
              name = "attackbutton",
              type = "",
              shape = "rectangle",
              x = 1392,
              y = 72,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 679,
              name = "Attack",
              type = "",
              shape = "text",
              x = 1288,
              y = 64,
              width = 128,
              height = 16,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "then Tackle",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
            },
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
              id = 680,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1424,
              y = 72,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 681,
              name = "or",
              type = "",
              shape = "text",
              x = 1400,
              y = 64,
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
            ["donewhenenemiesleft"] = 1
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 6900,
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
              gid = 6920,
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
              gid = 7136,
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
              id = 32,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1360,
              y = -8,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
              }
            },
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
              gid = 7235,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv",
                ["z"] = 64
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
              gid = 7235,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 700,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1688,
              y = 160,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
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
              gid = 6838,
              visible = false,
              properties = {}
            },
            {
              id = 239,
              name = "",
              type = "Boundary",
              shape = "polygon",
              x = 1440,
              y = 64,
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
                ["extrudeY"] = -64,
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
              gid = 7261,
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
              gid = 7260,
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
              gid = 7266,
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
              gid = 7266,
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
              gid = 6833,
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
              gid = 7267,
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
              gid = 7267,
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
              y = 32,
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
                { x = -64, y = 64 },
                { x = -64, y = -128 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = -1,
                ["extrudeY"] = -64,
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
              gid = 7265,
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
              gid = 7265,
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
              gid = 7265,
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
              gid = 7265,
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
              gid = 7263,
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
              gid = 7262,
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
              gid = 7264,
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
              gid = 7264,
              visible = true,
              properties = {
                ["propertiestable"] = "database/items-properties.csv",
                ["z"] = 68
              }
            },
            {
              id = 431,
              name = "During sprint",
              type = "",
              shape = "text",
              x = 1832,
              y = 40,
              width = 104,
              height = 48,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "During sprint throws ALL missiles",
              fontfamily = "Unifont",
              wrap = true,
              color = { 255, 255, 255 },
              properties = {}
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
              gid = 6833,
              visible = false,
              properties = {}
            },
            {
              id = 434,
              name = "Instruction",
              type = "",
              shape = "text",
              x = 1616,
              y = 80,
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
              y = 104,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 627,
              name = "",
              type = "",
              shape = "rectangle",
              x = 1680,
              y = 104,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 628,
              name = "or",
              type = "",
              shape = "text",
              x = 1656,
              y = 96,
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
              y = 192,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 0, y = 32 },
                { x = 176, y = 32 },
                { x = 176, y = -288 },
                { x = -128, y = -288 },
                { x = -128, y = -96 }
              },
              properties = {
                ["bodyinlayers"] = "Wall",
                ["color"] = "#80808080",
                ["drawz"] = 0,
                ["extrudeY"] = -64,
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 241 },
                ["exitpoint"] = { id = 244 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 240 },
                ["exitpoint"] = { id = 243 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 7244,
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
              gid = 6909,
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
              gid = 7010,
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
              gid = 7011,
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
              gid = 7012,
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
              gid = 7013,
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
              gid = 7135,
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
              gid = 7254,
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
              gid = 7244,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 242 },
                ["exitpoint"] = { id = 245 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 495 },
                ["exitpoint"] = { id = 496 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 497 },
                ["exitpoint"] = { id = 499 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              y = 128,
              width = 0,
              height = 0,
              rotation = 0,
              opacity = 1,
              visible = true,
              polygon = {
                { x = 144, y = -224 },
                { x = 144, y = 96 },
                { x = 480, y = 96 },
                { x = 512, y = 64 },
                { x = 512, y = -224 }
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
              id = 522,
              name = "Fireball",
              type = "",
              shape = "text",
              x = 2360,
              y = 176,
              width = 120,
              height = 32,
              rotation = 0,
              opacity = 1,
              visible = true,
              text = "Costs 1 or more fire meter",
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
              x = 2144,
              y = 192,
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
              x = 2144,
              y = 176,
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
              x = 2448,
              y = 200,
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
              x = 2448,
              y = 200,
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
              x = 2232,
              y = 184,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7244,
              visible = true,
              properties = {}
            },
            {
              id = 633,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2264,
              y = 184,
              width = 14,
              height = 14,
              rotation = 0,
              opacity = 1,
              gid = 7246,
              visible = true,
              properties = {}
            },
            {
              id = 634,
              name = "or",
              type = "",
              shape = "text",
              x = 2240,
              y = 176,
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
              gid = 7270,
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
              gid = 7271,
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
              id = 657,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2504,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 658 },
                ["exitpoint"] = { id = 659 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 673,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2552,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 674 },
                ["exitpoint"] = { id = 672 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 662,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2456,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 661 },
                ["exitpoint"] = { id = 660 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 665,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2408,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 664 },
                ["exitpoint"] = { id = 663 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 668,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2360,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 667 },
                ["exitpoint"] = { id = 666 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 671,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2312,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["entrypoint"] = { id = 670 },
                ["exitpoint"] = { id = 669 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
              }
            },
            {
              id = 658,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2440,
              y = 152,
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
              id = 674,
              name = "entrypoint",
              type = "",
              shape = "point",
              x = 2488,
              y = 152,
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
              }
            },
            {
              id = 659,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2536,
              y = 56,
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
              id = 672,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2584,
              y = 56,
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
              id = 660,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2488,
              y = 56,
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
              id = 663,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2440,
              y = 56,
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
              id = 666,
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
                ["z"] = 64
              }
            },
            {
              id = 669,
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
                ["z"] = 64
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
              y = 384,
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
                { x = 96, y = -96 },
                { x = 128, y = -64 },
                { x = 128, y = 0 },
                { x = 224, y = 0 },
                { x = 224, y = -480 }
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
              gid = 5268,
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
              gid = 5266,
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
              gid = 5265,
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
              x = 2992,
              y = 360,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6583,
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
              gid = 6583,
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
              x = 2984,
              y = 328,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6586,
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
              gid = 6586,
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
              gid = 6833,
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
              gid = 7244,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7274,
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
              x = 3024,
              y = 112,
              width = 128,
              height = 160,
              rotation = 0,
              opacity = 1,
              gid = 7261,
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
              x = 3024,
              y = 64,
              width = 128,
              height = 96,
              rotation = 0,
              opacity = 1,
              gid = 7260,
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 829 },
                ["exitpoint"] = { id = 831 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 835 },
                ["exitpoint"] = { id = 837 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              x = 2864,
              y = 88,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 828 },
                ["exitpoint"] = { id = 830 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
              }
            },
            {
              id = 830,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2864,
              y = 56,
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
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 834 },
                ["exitpoint"] = { id = 836 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 6838,
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
              gid = 6889,
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
              gid = 6909,
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
              gid = 7135,
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
              gid = 7010,
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
              gid = 7011,
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
              gid = 7012,
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
              gid = 7013,
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
              gid = 6834,
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
              gid = 7274,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7272,
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
              gid = 7272,
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
              x = 2864,
              y = 88,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 255 },
                ["exitpoint"] = { id = 256 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
              }
            },
            {
              id = 256,
              name = "exitpoint",
              type = "",
              shape = "point",
              x = 2864,
              y = 56,
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
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 258 },
                ["exitpoint"] = { id = 259 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["entrypoint"] = { id = 821 },
                ["exitpoint"] = { id = 820 },
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["itemtype"] = "food-fish",
                ["propertiestable"] = "database/bandits-properties.csv",
                ["recoverai"] = "enterAndAttackUntilEmpty",
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
                ["z"] = 64
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
              gid = 6838,
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
              gid = 6889,
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
              gid = 6909,
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
              gid = 7135,
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
              gid = 7010,
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
              gid = 7011,
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
              gid = 7012,
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
              gid = 7013,
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
              gid = 6834,
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
              y = 224,
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
                ["extrudeY"] = -64,
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
              gid = 7273,
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
              gid = 7273,
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
              gid = 7273,
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
              gid = 7273,
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
              gid = 7273,
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
                ["extrudeY"] = -64,
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
                ["extrudeY"] = -64,
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
              gid = 7234,
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
              id = 271,
              name = "",
              type = "",
              shape = "rectangle",
              x = 288,
              y = 960,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 309,
              name = "",
              type = "",
              shape = "rectangle",
              x = 384,
              y = 960,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
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
              gid = 7234,
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
              gid = 7234,
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
              gid = 7234,
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
              gid = 7234,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6586,
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
              gid = 6586,
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
              gid = 6586,
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
              gid = 6589,
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
              gid = 6589,
              visible = true,
              properties = {
                ["itemtype"] = "food-bigfish"
              }
            },
            {
              id = 310,
              name = "",
              type = "",
              shape = "rectangle",
              x = 480,
              y = 960,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 731,
              name = "",
              type = "",
              shape = "rectangle",
              x = 576,
              y = 960,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 732,
              name = "",
              type = "",
              shape = "rectangle",
              x = 672,
              y = 960,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
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
              gid = 6612,
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
              gid = 6605,
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
              gid = 6610,
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
              gid = 6604,
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
              gid = 6609,
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
              gid = 6603,
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
              gid = 6859,
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
              gid = 6879,
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
              gid = 7136,
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
              gid = 6834,
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
              gid = 7239,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7275,
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
              gid = 7278,
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
              gid = 7278,
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
              gid = 7278,
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
              gid = 7278,
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
              gid = 7278,
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
              gid = 7279,
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
              gid = 7279,
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
              gid = 7279,
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
              gid = 7279,
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
              gid = 7279,
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
              gid = 7279,
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
              gid = 7282,
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
              gid = 7282,
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
              gid = 7282,
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
              gid = 7282,
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
              gid = 7282,
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
              gid = 7282,
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
              gid = 7283,
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
              gid = 7283,
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
              gid = 7283,
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
              gid = 7283,
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
              gid = 7283,
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
              gid = 7283,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7303,
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
              gid = 7291,
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
              gid = 7291,
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
              gid = 7291,
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
              gid = 7291,
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
              gid = 7291,
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
              gid = 7291,
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
              gid = 7298,
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
              gid = 7298,
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
              gid = 7298,
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
              gid = 7240,
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
              gid = 7242,
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
              gid = 7254,
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
              gid = 7250,
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
                ["extrudeY"] = -64,
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
              gid = 7239,
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
              gid = 7239,
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
              gid = 7239,
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
              gid = 7239,
              visible = true,
              properties = {}
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
              gid = 7272,
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
              gid = 7235,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7235,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7235,
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
              gid = 7237,
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
              gid = 7235,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7235,
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
              gid = 7237,
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
              gid = 7235,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7272,
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
              gid = 6828,
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
              gid = 7238,
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
              gid = 7238,
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
              gid = 7238,
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
              gid = 6586,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6586,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6589,
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
              gid = 6613,
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
              gid = 6613,
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
              gid = 6622,
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
              gid = 6682,
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
              gid = 7272,
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
              gid = 7272,
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
              gid = 6826,
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
                ["extrudeY"] = -64,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7235,
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
              x = 1832,
              y = 1112,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7274,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7274,
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
            ["donewhenenemiesleft"] = 3
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
              gid = 6596,
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
              gid = 6598,
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
              gid = 6597,
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
              x = 2160,
              y = 1072,
              width = 96,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6596,
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
              gid = 6597,
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
              gid = 7201,
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
              gid = 7205,
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
              x = 2096,
              y = 1104,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7212,
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
              gid = 7208,
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
              gid = 7204,
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
              x = 2160,
              y = 1112,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7208,
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
              x = 2080,
              y = 912,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7209,
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
              gid = 7201,
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
              gid = 7205,
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
              gid = 7209,
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
              x = 1928,
              y = 912,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7236,
              visible = true,
              properties = {
                ["defaultattack"] = "sling-shot-until-empty",
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty"
              }
            },
            {
              id = 337,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2048,
              y = 920,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7236,
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
              x = 2160,
              y = 920,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7234,
              visible = true,
              properties = {
                ["defaultattack"] = "bow-shot-until-empty",
                ["initialai"] = "enterAndAttackUntilEmpty",
                ["recoverai"] = "enterAndAttackUntilEmpty"
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
              gid = 6613,
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
              gid = 6613,
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
              gid = 6613,
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
              gid = 6613,
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
              gid = 6681,
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
              gid = 6674,
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
              gid = 6623,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 366,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2016,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 367,
              name = "",
              type = "item-dish",
              shape = "rectangle",
              x = 2056,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
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
              gid = 6613,
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
              x = 2184,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
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
              x = 2136,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
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
              x = 2176,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 374,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2020,
              y = 930,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6622,
              visible = true,
              properties = {
                ["z"] = 18
              }
            },
            {
              id = 375,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2056,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7225,
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
              x = 2192,
              y = 928,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6623,
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
              gid = 6674,
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
              x = 2136,
              y = 1064,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7225,
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
              x = 2172,
              y = 1072,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6678,
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
              gid = 6682,
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
              gid = 6598,
              visible = true,
              properties = {
                ["extrudeY"] = -16
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
              gid = 7204,
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
              gid = 7212,
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
              gid = 6613,
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
              x = 1840,
              y = 1080,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 6613,
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
              gid = 6674,
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
              x = 1842,
              y = 1082,
              width = 32,
              height = 32,
              rotation = 0,
              opacity = 1,
              gid = 7225,
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
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 339,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 1744,
              y = 1040,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7237,
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
              x = 1672,
              y = 1080,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7237,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 340,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2256,
              y = 1040,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7237,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 512,
              name = "",
              type = "bandit-dagger",
              shape = "rectangle",
              x = 2336,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7237,
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
            ["donewhenenemiesleft"] = 4
          },
          objects = {
            {
              id = 342,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 1984,
              y = 1176,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7272,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 348,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2456,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
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
              x = 2256,
              y = 1016,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7274,
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
          id = 44,
          name = "messhall4",
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
              id = 343,
              name = "bandit-muscle",
              type = "bandit-muscle",
              shape = "rectangle",
              x = 2128,
              y = 1176,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7272,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 347,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 1744,
              y = 1056,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7274,
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
              y = 1184,
              width = 128,
              height = 128,
              rotation = 0,
              opacity = 1,
              gid = 7272,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 349,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 1584,
              y = 1048,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 350,
              name = "",
              type = "bandit-spear",
              shape = "rectangle",
              x = 2424,
              y = 1000,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7235,
              visible = true,
              properties = {
                ["propertiestable"] = "database/bandits-properties.csv"
              }
            },
            {
              id = 790,
              name = "",
              type = "bandit-shield",
              shape = "rectangle",
              x = 2288,
              y = 1008,
              width = 64,
              height = 64,
              rotation = 0,
              opacity = 1,
              gid = 7274,
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
              id = 933,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2368,
              y = 936,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 934,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2336,
              y = 928,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6595,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 939,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2432,
              y = 928,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6594,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 935,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2528,
              y = 920,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6595,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 936,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2560,
              y = 928,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6594,
              visible = true,
              properties = {
                ["z"] = 16
              }
            },
            {
              id = 937,
              name = "",
              type = "",
              shape = "rectangle",
              x = 2592,
              y = 928,
              width = 32,
              height = 48,
              rotation = 0,
              opacity = 1,
              gid = 6593,
              visible = true,
              properties = {
                ["z"] = 16
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
              gid = 7233,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7236,
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
              gid = 7236,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7235,
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
              gid = 7234,
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
              gid = 7234,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7274,
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
              gid = 7272,
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
              gid = 7272,
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
              gid = 7272,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7237,
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
              gid = 7236,
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
              gid = 7236,
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
              gid = 7234,
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
              gid = 7234,
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
                ["extrudeY"] = -64,
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
          opacity = 1,
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
          opacity = 1,
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
          opacity = 1,
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
          x = 2272,
          y = -232,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 2912,
          y = -232,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 2816,
          y = 608,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 3712,
          y = 192,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 4192,
          y = -288,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 4672,
          y = -288,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          x = 5152,
          y = -288,
          width = 480,
          height = 128,
          rotation = 0,
          opacity = 1,
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
          opacity = 1,
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
          id = 110,
          name = "",
          type = "",
          shape = "text",
          x = 192,
          y = 0,
          width = 160,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          opacity = 1,
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
          opacity = 1,
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
          x = 1232,
          y = 80,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          id = 127,
          name = "",
          type = "",
          shape = "text",
          x = 2080,
          y = -64,
          width = 160,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          id = 122,
          name = "",
          type = "",
          shape = "text",
          x = 2016,
          y = 112,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 2080,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          id = 128,
          name = "",
          type = "",
          shape = "text",
          x = 3216,
          y = 48,
          width = 160,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 3168,
          y = 432,
          width = 96,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 2728,
          y = 320,
          width = 512,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 2792,
          y = 0,
          width = 512,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 3168,
          y = 496,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 3232,
          y = 496,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 3232,
          y = 392,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 3168,
          y = 392,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          y = 432,
          width = 96,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 3920,
          y = 432,
          width = 96,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4048,
          y = 432,
          width = 96,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          y = 384,
          width = 64,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          y = 384,
          width = 64,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 416,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 256,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 96,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = -64,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 544,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 384,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 224,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 64,
          width = 128,
          height = 64,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 480,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 320,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 160,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 0,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 608,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 448,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 288,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 128,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 384,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 224,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = 64,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4256,
          y = -96,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 512,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 192,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
          x = 4480,
          y = 32,
          width = 128,
          height = 32,
          rotation = 0,
          opacity = 1,
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
