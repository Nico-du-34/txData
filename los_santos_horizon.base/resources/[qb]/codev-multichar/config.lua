Config = {
    Framework = "qb", -- qb - esx
    Locale = "en",
    Slots = 3,
    PayedSlots = 2,
    UseQbApartments = false,
    TebexLink = "https://atiysu.tebex.io/category/2281274",
    SpawnCoords = vector3(-1264.54, -2335.17, 14.12), -- if you dont want to use qb-apartments
    
    ClothingMenuExport = function ()
        return TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    end,
    
    ClothingExport = function (clothingData, ped)
        return TriggerEvent('qb-clothing:client:loadPlayerClothing', clothingData, ped)
    end,

    OnLoad = function (source, playerData, lastCoords, firstSpawn)
        return TriggerClientEvent('codev-multichar:qb:spawnLastLocation', source, lastCoords, firstSpawn)
    end,

    Notify = function (msg)
        if Config.Framework == "qb" then
            Framework.Functions.Notify(msg, "error", 5000)
        else
            Framework.ShowNotification(msg)
        end
    end
}