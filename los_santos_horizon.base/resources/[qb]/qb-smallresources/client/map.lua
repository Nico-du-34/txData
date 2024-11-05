local wasmenuopen = false

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if IsPauseMenuActive() and not wasmenuopen then
            SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true) -- set unarmed
            TriggerEvent("Map:ToggleMap")
            wasmenuopen = true
        end
        if not IsPauseMenuActive() and wasmenuopen then
            Wait(500)
            TriggerEvent("Map:ToggleMap")
            wasmenuopen = false
        end
    end
end)

local holdingMap = false
local animName = "map"

RegisterNetEvent("Map:ToggleMap")
AddEventHandler("Map:ToggleMap", function()
    if not holdingMap then
        TriggerEvent('animations:client:EmoteCommandStart', {"map"})
        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        Citizen.Wait(500)
        holdingMap = true
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        holdingMap = false
    end
end)