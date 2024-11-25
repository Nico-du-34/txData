local QBCore = exports['qb-core']:GetCoreObject()
local isUIOpen = false
local function GetCardImagePath(cardId)
    -- Retourne le chemin de l'image dans qb-inventory avec le bon format de nom
    return "nui://qb-inventory/html/images/" .. cardId .. ".jpg" -- ou .png selon votre format d'image
end

RegisterNetEvent("Cards:Client:OpenPack")
AddEventHandler("Cards:Client:OpenPack", function() 
    RequestAnimDict("mp_arresting")
    while (not HasAnimDictLoaded("mp_arresting")) do
        Wait(0)
    end

    -- Jouer l'animation d'ouverture du pack
    TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 1, 0, false, false, false)
    
    local PedCoords = GetEntityCoords(PlayerPedId())
    local propcards = CreateObject(GetHashKey('prop_boosterpack_01'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
    AttachEntityToEntity(propcards, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.1, 0.1, 0.0, 70.0, 10.0, 90.0, false, false, false, false, 2, true)
    
    -- Afficher la barre de progression pour l'ouverture du pack
    QBCore.Functions.Progressbar("open_pack", "Ouvre un pack de booster...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()
        -- Terminé, jouer le son et donner l'élément
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "dealfour", 0.9) 
        Wait(4)
        DeleteEntity(propcards)  -- Supprimer l'objet du pack
        ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
        TriggerServerEvent('Cards:Server:RemoveItem')  -- Retirer l'item du joueur
        OpenBoosterPack()
        TriggerServerEvent('Cards:Server:RewardItem')  -- Récompenser le joueur avec une carte
    end)
end)

function OpenBoosterPack()
    if not isUIOpen then
        isUIOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "openBooster"
        })
    end
end

RegisterNetEvent('Cards:Client:CardChoosed')
AddEventHandler('Cards:Client:CardChoosed', function(card)
    -- Recevoir et afficher la carte choisie
    TriggerEvent('QBCore:Notify', 'Tu as reçu: ' .. card)
end)

RegisterNUICallback('cardflipped', function(data, cb)
    if isUIOpen then
        -- Gérer le retournement de la carte ici
        print("Carte retournée:", data.cardIndex + 1)
    end
    cb('ok')
end)

function CloseUI()
    if isUIOpen then
        isUIOpen = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "closeBooster"
        })
    end
end

RegisterNUICallback('closeui', function(data, cb)
    CloseUI()
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isUIOpen and IsControlJustReleased(0, 177) then -- Touche ECHAP
            CloseUI()
        end
    end
end)

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
