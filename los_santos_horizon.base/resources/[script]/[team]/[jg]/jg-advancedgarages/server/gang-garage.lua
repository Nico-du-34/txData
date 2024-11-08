-- Events
RegisterNetEvent('jg-advancedgarages:server:GangGarageTakeOutVehicle', function(plate, inGarage)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  if inGarage == 0 then
    player.Functions.RemoveMoney('bank', Config.GarageVehicleReturnCost)
  end

  MySQL.Async.execute('UPDATE player_vehicles SET in_garage = ? WHERE plate = ?', {0, plate})
end)

RegisterNetEvent('jg-advancedgarages:server:GangGarageInsertVehicle', function(plate, fuel, engine, body)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  MySQL.Async.execute('UPDATE player_vehicles SET in_garage = ?, fuel = ?, engine = ?, body = ? WHERE plate = ?',
      {1, fuel, engine, body, plate})
end)

RegisterNetEvent('jg-advancedgarages:server:SetGangVehicle', function(gangName, plate)
  MySQL.Async.execute('UPDATE player_vehicles SET license = ?, job_vehicle = ?, gang_vehicle = ? WHERE plate = ?', {gangName, 0, 1, plate})
end)

RegisterNetEvent('jg-advancedgarages:server:RemoveGangVehicle', function(playerId, plate)
  local src = source
  local player = QBCore.Functions.GetPlayer(tonumber(playerId))

  if not player then
    TriggerClientEvent('QBCore:Notify', src, "Le joueur n'est pas en ligne", 'error')
    return false
  end

  MySQL.Async.execute('UPDATE player_vehicles SET license = ?, citizenid = ?, gang_vehicle = ? WHERE plate = ?',
      {player.PlayerData.license, player.PlayerData.citizenid, 0, plate})

  TriggerClientEvent('QBCore:Notify', src, "Véhicule transféré à " .. player.PlayerData.charinfo.firstname, 'success')
  TriggerClientEvent('QBCore:Notify', playerId, "Vous avez reçu un véhicule avec la plaque: " .. plate, 'success')
end)

-- Callbacks

QBCore.Functions.CreateCallback('jg-advancedgarages:server:GetGangGarageVehicles', function(source, cb, gang)
  local src = source
  local vehicles = {}
  -- local Player = QBCore.Functions.GetPlayer(src)

  MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE license = ? AND gang_vehicle = ?', {gang, 1}, function(result)
    if result[1] then
      for i, vehicle in pairs(result) do
        vehicles[i] = vehicle

        local vehShared = QBCore.Shared.Vehicles[vehicle.vehicle]
        if vehShared then
          vehicles[i].vehicleLabel = vehShared.brand .. " " .. vehShared.name
        else
          vehicles[i].vehicleLabel = vehicle.vehicle
        end
      end
    end
    cb(vehicles)
  end)
end)

-- Commands

QBCore.Commands.Add(Config.GangGarageSetVehicleCommand, "Ajouter le véhicule actuel à un garage de gangs", {{
  name = "gang",
  help = "Gang name"
}}, false, function(source, args)
  local src = source
  local gangName = args[1]

  TriggerClientEvent("jg-advancedgarages:client:SetGangVehicle", src, gangName)
end, 'admin')

QBCore.Commands.Add(Config.GangGarageRemoveVehicleCommand, "Remettre un véhicule de gang au joueur détenu", {{
  name = "id",
  help = "ID du joueur du nouveau propriétaire"
}}, false, function(source, args)
  local src = source
  local playerId = args[1]

  TriggerClientEvent("jg-advancedgarages:client:RemoveGangVehicle", src, playerId)
end, 'admin')
