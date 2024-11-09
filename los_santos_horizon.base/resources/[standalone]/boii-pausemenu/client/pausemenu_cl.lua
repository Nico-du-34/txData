-- Variables globales
local mapOpen = false
local menuOpen = false

-- Thread principal pour gérer les touches
Citizen.CreateThread(function()
    while true do
        Wait(1)
        SetPauseMenuActive(false)
        
        -- Gestion de la touche ESC (touche 200)
        if IsControlJustPressed(0, 200) then
            if not IsPauseMenuActive() then
                if menuOpen then
                    -- Si le menu est ouvert, on le ferme
                    ClosePause()
                    menuOpen = false
                elseif mapOpen then
                    -- Si la carte est ouverte, on la ferme
                    CloseMap()
                    mapOpen = false
                else
                    -- Sinon on ouvre le menu
                    TriggerEvent("boii-pausemenu:OpenMenu")
                    menuOpen = true
                end
            end
        end
    end
end)

-- Event pour ouvrir le menu
RegisterNetEvent("boii-pausemenu:OpenMenu")
AddEventHandler("boii-pausemenu:OpenMenu", function()
    TransitionToBlurred(1000)
    SetNuiFocus(true, true)
    SendNUIMessage({
        open = true
    })
    menuOpen = true
end)

-- Callback pour écouter la touche ESC depuis le NUI
RegisterNUICallback('exit', function(data, cb)
    ClosePause()
    menuOpen = false
    cb('ok')
end)

-- Callback pour fermer le menu
RegisterNUICallback('Close', function(data)
    ClosePause()
    menuOpen = false
end)

-- Callback pour les paramètres
RegisterNUICallback('Settings', function(data)
    ClosePause()
    menuOpen = false
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
end)

RegisterNUICallback('Map', function(data)
    ClosePause()
    menuOpen = false
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
end)

RegisterNUICallback('Keyboard', function(data)
    ClosePause()
    menuOpen = false
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_KEYMAPPING_MENU'), 0, -1)
end)

-- Callback pour déconnecter le joueur
RegisterNUICallback('DropPlayer', function(data)
    TriggerServerEvent('boii-pausemenu:DropPlayer')
end)

-- Callback pour envoyer un rapport
RegisterNUICallback('NewReport', function(data)
    local NewReport = {
        fname = data.fname,
        lname = data.lname,
        reporttype = data.reporttype,
        subject = data.subject,
        description = data.description
    }
    TriggerServerEvent('boii-pausemenu:SendReport', NewReport)
end)

-- Fonction pour fermer le menu
function ClosePause()
    TransitionFromBlurred(1000)
    SetNuiFocus(false, false)
    SendNUIMessage({
        open = false
    })
    menuOpen = false
end

-- Commande pour la carte
RegisterCommand("map", function()
    mapOpen = not mapOpen
end)