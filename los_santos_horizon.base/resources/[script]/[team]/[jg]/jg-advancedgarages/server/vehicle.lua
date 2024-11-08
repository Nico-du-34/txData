-- Events
RegisterNetEvent('jg-advancedgarages:server:ChangeVehiclePlate', function(curPlate, newPlate)
  local src = source

  MySQL.Async.execute('UPDATE player_vehicles SET plate = ? WHERE plate = ?', {newPlate, curPlate})
  TriggerClientEvent('QBCore:Notify', src, "Plaque de véhicule réglée sur " .. newPlate, 'success')
end)

RegisterNetEvent('jg-advancedgarages:server:DeleteVehicle', function(plate)
  local src = source

  MySQL.Async.execute('DELETE FROM player_vehicles WHERE plate = ?', {plate})
  TriggerClientEvent('QBCore:Notify', src, "Véhicule supprimé de la base de données " .. plate, 'success')
end)

-- Commands
QBCore.Commands.Add(Config.ChangeVehiclePlate, "Changer la plaque du véhicule (Admin only)", {}, false, function(source)
  local src = source

  TriggerClientEvent("jg-advancedgarages:client:ChangeVehiclePlate", src)
end, 'admin')

QBCore.Commands.Add(Config.DeleteVehicleFromDB, "Supprimer le véhicule de la base de données (Admin only)", {}, false, function(source)
  local src = source

  TriggerClientEvent("jg-advancedgarages:client:DeleteVehicle", src)
end, 'admin')
