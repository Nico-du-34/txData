QBCore = exports['qb-core']:GetCoreObject()
local PersonalMenu = Config.PersonalMenu
local SubInteractionMenu = Config.SubInteractionMenu
local SubClothingMenu = Config.SubClothingMenu


function openPersonalMenu()
    local src = source
    local PlayerData = QBCore.Functions.GetPlayerData()
    local Menu = { { icon = "fas fa-list", header = "Menu Personnel - "..PlayerData.charinfo.firstname..", "..PlayerData.charinfo.lastname.."<br> Travail: "..PlayerData.job.label.." - "..PlayerData.job.grade.name.."<br> CID : "..PlayerData.citizenid, isMenuHeader = true } } 
    for _, option in ipairs(PersonalMenu) do
        Menu[#Menu + 1] = { icon = option.icon, header = option.header, txt = option.label, params = { event = option.event } }
    end
    exports['qb-menu']:openMenu(Menu)
end

function openSubInteractionMenu()
    local Menu1 = { { icon = "fas fa-person", header = "Interaction - Menu Personnel", isMenuHeader = true } }
    for _, option in ipairs(SubInteractionMenu) do
        Menu1[#Menu1 + 1] = { icon = option.icon, header = option.header, txt = option.label, params = { event = option.event } }
    end
    exports['qb-menu']:openMenu(Menu1)
end
function openSubClothingMenu()
    local Menu2 = { { icon = "fas fa-shirt", header = "Vètements - Menu Personnel", isMenuHeader = true } }
    for _, option in ipairs(SubClothingMenu) do
        Menu2[#Menu2 + 1] = { icon = option.icon, header = option.header, txt = option.label, params = { event = option.event } }
    end
    exports['qb-menu']:openMenu(Menu2)
end








RegisterCommand("openPersonalMenu", function()
    openPersonalMenu()
end)
RegisterNetEvent("qb-jobmenu:client:backtomenuperso",function()
    openPersonalMenu()
end)

RegisterNetEvent("qb-jobmenu:client:openSubInteractionMenu",function()
    openSubInteractionMenu()
end)
RegisterNetEvent("qb-jobmenu:client:openSubClothingMenu",function()
    openSubClothingMenu()
end)






RegisterKeyMapping('openPersonalMenu', 'Open Personal Menu', 'keyboard', 'F5')
