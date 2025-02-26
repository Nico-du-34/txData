RegisterServerEvent('qs-smartphone:server:CancelCall')
AddEventHandler('qs-smartphone:server:CancelCall', function(ContactData)
    local src = source
    local Ply = GetPlayerFromPhone(ContactData?.TargetData?.number)
    if Ply == nil then
       Ply = GetPlayerFromPhone(tonumber(ContactData?.TargetData?.number))
    end
    if Config.Voice == 'salty' then
        if Ply ~= nil then
            TriggerClientEvent('qs-smartphone:client:CancelCall', Ply.PlayerData.source)
            exports['saltychat']:EndCall(Ply.PlayerData.source, src)
            exports['saltychat']:EndCall(src, Ply.PlayerData.source)
        end
    else
        if Ply ~= nil then
            TriggerClientEvent('qs-smartphone:client:CancelCall', Ply.PlayerData.source)
        end
    end
end)

RegisterServerEvent('qs-smartphone:server:AnswerCall')
AddEventHandler('qs-smartphone:server:AnswerCall', function(CallData)
    local src = source
    local Ply = GetPlayerFromPhone(CallData.TargetData.number)
    if Ply == nil then
        Ply = GetPlayerFromPhone(tonumber(CallData.TargetData.number))
    end
    if Config.Voice == 'salty' then
        if Ply ~= nil then
            exports['saltychat']:EstablishCall(Ply.PlayerData.source, src)
            exports['saltychat']:EstablishCall(src, Ply.PlayerData.source)
            TriggerClientEvent('qs-smartphone:client:AnswerCall', Ply.PlayerData.source)
        end
    else
        if Ply ~= nil then
            TriggerClientEvent('qs-smartphone:client:AnswerCall', Ply.PlayerData.source)
        end
    end
end)

if Config.Signal then
    RegisterServerCallback('qs-smartphone:server:GetCallState', function(source, cb, ContactData)
        local Target = GetPlayerFromPhone(ContactData.number)
        local player = GetPlayerFromIdFramework(source)
        
        if Target then
            local HavePhone = CheckPhone(Target.PlayerData.source)
            local targetEsx = GetPlayerFromIdFramework(Target.PlayerData.source)
            local battery = GetBatteryFromIdentifier(targetEsx.identifier)
            local GetTargetIsBlocked = MySQL.Sync.fetchAll('SELECT isBlocked FROM player_contacts WHERE identifier = ? AND number = ?', {
                ContactData.number,
                player.PlayerData.charinfo.phone
            })[1]
            GetTargetIsBlocked = GetTargetIsBlocked?.isBlocked
            GetTargetIsBlocked = GetTargetIsBlocked == 1
            ContactData.isBlocked = ContactData.isBlocked == 1
            
            if battery == 0 then 
                return 
                cb(true, true, true) 
            end
    
            if not HavePhone then 
                cb(false, false, notAvailable[ContactData.number])
            else
                if Calls[ContactData.number] ~= nil then
                    if Calls[ContactData.number].inCall then
                        cb(false, false, notAvailable[ContactData.number])
                    else
                        cb(true, true, notAvailable[ContactData.number] or lowSignalPlayers[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
                    end
                else
                    cb(true, true, notAvailable[ContactData.number] or lowSignalPlayers[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
                end
            end
        else 
            cb(false, false, notAvailable[ContactData.number] or lowSignalPlayers[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
        end
    end)
else
    RegisterServerCallback('qs-smartphone:server:GetCallState', function(source, cb, ContactData)
        local Target = GetPlayerFromPhone(ContactData.number)
        local player = GetPlayerFromIdFramework(source)
        
        if Target then
            local HavePhone = CheckPhone(Target.PlayerData.source)
            local targetEsx = GetPlayerFromIdFramework(Target.PlayerData.source)
            local battery = GetBatteryFromIdentifier(targetEsx.identifier)
            local GetTargetIsBlocked = MySQL.Sync.fetchAll('SELECT isBlocked FROM player_contacts WHERE identifier = ? AND number = ?', {
                ContactData.number,
                player.PlayerData.charinfo.phone
            })[1]
            GetTargetIsBlocked = GetTargetIsBlocked?.isBlocked
            GetTargetIsBlocked = GetTargetIsBlocked == 1
            ContactData.isBlocked = ContactData.isBlocked == 1
            
            if battery == 0 then 
                return 
                cb(true, true, true) 
            end
    
            if not HavePhone then 
                cb(false, false, notAvailable[ContactData.number])
            else
                if Calls[ContactData.number] ~= nil then
                    if Calls[ContactData.number].inCall then
                        cb(false, false, notAvailable[ContactData.number])
                    else
                        cb(true, true, notAvailable[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
                    end
                else
                    cb(true, true, notAvailable[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
                end
            end
        else 
            cb(false, false, notAvailable[ContactData.number] or (GetTargetIsBlocked or ContactData.isBlocked))
        end
    end)
end