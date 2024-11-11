--[[local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local myPed = GetPlayerPed(-1)
        if IsPedInMeleeCombat(myPed) then
            if GetEntityHealth(myPed) < 115 then
                SetPlayerInvincible(PlayerId(), true)
                SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
                -- ShowNotification("~r~Vous êtes KO!")
                QBCore.Functions.Notify("Vous êtes KO!")
                wait = 15
                knockedOut = true
                SetEntityHealth(myPed, 116)
            end
        end
        if knockedOut == true then
            SetPlayerInvincible(PlayerId(), true)
            DisablePlayerFiring(PlayerId(), true)
            SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
            ResetPedRagdollTimer(myPed)
            
            if wait >= 0 then
                count = count - 1
                if count == 0 then
                    count = 60
                    wait = wait - 1
                    SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
                end
            else
                SetPlayerInvincible(PlayerId(), false)
                knockedOut = false
            end
        end
    end
end)

-- function ShowNotification(text)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawNotification(false, false)
-- end]]
local QBCore = exports['qb-core']:GetCoreObject()
local knockedOut = false
local wait = 5
local count = 10

CreateThread(function()
    while true do
        Wait(1)
        local myPed = PlayerPedId()
        PlayerData = QBCore.Functions.GetPlayerData(source)
        if IsPedInMeleeCombat(myPed) and not (PlayerData.metadata["inlaststand"] or PlayerData.metadata["isdead"]) then
            if GetEntityHealth(myPed) < 130  then
                SetPlayerInvincible(PlayerId(), true)
                SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
                QBCore.Functions.Notify('Tu es KO !', 'error', 7500)
                wait = 5
                knockedOut = true
            end
        end
        if knockedOut then
            SetPlayerInvincible(PlayerId(), true)
            DisablePlayerFiring(PlayerId(), true)
            SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
            ResetPedRagdollTimer(myPed)
            Wait(100)
            DoScreenFadeOut(200)
            if wait >= 0 then
                count = count - 1
                if count == 0 then
                    count = 10
                    wait = wait - 1
                    SetEntityHealth(myPed, GetEntityHealth(myPed)+2)
                end
            else
                Wait(100)
                DoScreenFadeIn(200)
                SetPlayerInvincible(PlayerId(), false)
                knockedOut = false
            end
        end
    end
end)