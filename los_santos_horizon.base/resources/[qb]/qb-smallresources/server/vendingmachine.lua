local QBCore = exports['qb-core']:GetCoreObject()



RegisterNetEvent('tc-vending-chargeDrink', function(drink, cash, label)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        if Player.Functions.GetMoney('cash') >= cash then
           Player.Functions.AddItem(drink, 1)
           TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[drink], "add")
           Player.Functions.RemoveMoney('cash', cash)
           TriggerClientEvent('QBCore:Notify', src, 'Vous avez achetée ' ..label.. ' pour $' ..cash, 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Vous n\'avez pas assez d\'argent, vous avez besoin $' ..cash, 'error')
        end

end)

