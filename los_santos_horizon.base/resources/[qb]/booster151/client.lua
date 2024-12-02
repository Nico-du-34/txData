local QBCore = exports['qb-core']:GetCoreObject()
local isUIOpen = false
local receivedCards = {}

RegisterNetEvent("Cards:Client:OpenPack")
AddEventHandler("Cards:Client:OpenPack", function() 
    RequestAnimDict("mp_arresting")
    while (not HasAnimDictLoaded("mp_arresting")) do
        Wait(0)
    end

    -- Animation
    TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 1, 0, false, false, false)
    
    local PedCoords = GetEntityCoords(PlayerPedId())
    local propcards = CreateObject(GetHashKey('prop_boosterpack_01'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
    AttachEntityToEntity(propcards, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.1, 0.1, 0.0, 70.0, 10.0, 90.0, false, false, false, false, 2, true)
    
    QBCore.Functions.Progressbar("open_pack", "Ouvre un pack de booster...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "dealfour", 0.9) 
        Wait(4)
        DeleteEntity(propcards)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('Cards:Server:CompleteCardOpen')
    end)
end)

RegisterNetEvent('Cards:Client:ShowCards')
AddEventHandler('Cards:Client:ShowCards', function(cards)
    if not isUIOpen then
        print("Cartes reçues:", json.encode(cards)) -- Debug
        receivedCards = cards
        isUIOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openBooster",
            cards = cards
        })
    end
end)

RegisterNUICallback('cardflipped', function(data, cb)
    if isUIOpen and receivedCards[data.cardIndex + 1] then
        local cardId = receivedCards[data.cardIndex + 1]
        print("Carte retournée:", cardId) -- Debug
        TriggerEvent('QBCore:Notify', 'Tu as reçu: ' .. cardId)
    end
    cb('ok')
end)

RegisterNUICallback('closeui', function(data, cb)
    if isUIOpen then
        isUIOpen = false
        SetNuiFocus(false, false)
        receivedCards = {}
    end
    cb('ok')
end)

-- QBTarget pour le shop de cartes
CreateThread(function()
    exports['qb-target']:AddCircleZone('pokemonbox1', vector3(2748.14, 3482.92, 55.61), 0.5, {
        name = 'pokemonbox1',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = "Classeur Pokemon 50$",
            icon = 'fas fa-book',
            type = "command",
            event = "givepokemonbox",
        } },
        distance = 2.0
    })
end)