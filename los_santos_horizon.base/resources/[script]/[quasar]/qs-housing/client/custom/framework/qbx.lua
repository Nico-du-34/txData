if Config.Framework ~= 'qbx' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(playerData)
    IsLoggedIn = true
    GetHouseObjects()
    Wait(1000)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    IsLoggedIn = false
    CurrentHouseData = {}
    DeleteBlips()
end)

function TriggerServerCallback(name, cb, ...) -- Sadly have to keep this for compatibility
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

function GetPlayerData()
    return exports.qbx_core:GetPlayerData()
end

function GetIdentifier()
    return GetPlayerData().citizenid
end

function GetJobName()
    return GetPlayerData()?.job?.name
end

function GetPlayers()
    return GetActivePlayers()
end

function GetVehicleProperties(vehicle)
    return lib.getVehicleProperties(vehicle)
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawTextBoard(x, y, z, text)
    SetTextScale(0.45, 0.45)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(0, 0, 0, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function DrawGenericText(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(0.40, 0.00)
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'inform'
        })
    end
    if type == 'error' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'error'
        })
    end
    if type == 'success' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'success'
        })
    end
end
