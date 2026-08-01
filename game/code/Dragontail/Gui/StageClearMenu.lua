local Menu = require "Gui.Menu"
local Account = require "System.Account"

local StageClearMenu = class(Menu)

function StageClearMenu:spawn()
    Menu.spawn(self)
    local accounttype = Account.type
    if accounttype then
        local website = self.itchWEBSITE
        local rate = self["itchRate & Comment"]
        website.visible = false
        rate.visible = false

        website = self[accounttype.."WEBSITE"]
        rate = self[accounttype.."Rate & Comment"]
        if website then
            website.visible = true
        end
        if rate then
            rate.visible = true
        end
    end
end

return StageClearMenu