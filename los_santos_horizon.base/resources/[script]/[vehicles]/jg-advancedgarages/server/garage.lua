-- Events
RegisterNetEvent('jg-advancedgarages:server:GarageTransferVehicle', function(plate, type, garageId, playerId)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  if type == "player" then
    local citizenid = getCitizenIdFromServerId(playerId)

    if not citizenid then
      TriggerClientEvent('QBCore:Notify', src, "Le joueur n'est pas en ligne", 'error')
      return false
    end

    MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {citizenid, plate})
    TriggerClientEvent('QBCore:Notify', playerId, "Vous avez reçu un véhicule avec la plaque: " .. plate, 'success')
  end

  if type == "garage" then
    player.Functions.RemoveMoney('bank', Config.GarageVehicleTransferCost)

    MySQL.Async.execute('UPDATE player_vehicles SET garage_id = ? WHERE plate = ?', {garageId, plate})
  end

  TriggerClientEvent('QBCore:Notify', src, "Véhicule transféré avec succès", 'success')
end)

RegisterNetEvent('jg-advancedgarages:server:GarageTakeOutVehicle', function(plate, inGarage)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  if inGarage == 0 then
    player.Functions.RemoveMoney('bank', Config.GarageVehicleReturnCost)
  end

  MySQL.Async.execute('UPDATE player_vehicles SET in_garage = ? WHERE plate = ?', {0, plate})
end)

RegisterNetEvent('jg-advancedgarages:server:GarageInsertVehicle', function(plate, fuel, engine, body, garageId)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  MySQL.Async.execute('UPDATE player_vehicles SET in_garage = ?, garage_id = ?, fuel = ?, engine = ?, body = ? WHERE plate = ?',
      {1, garageId, fuel, engine, body, plate})
end)

-- Callbacks

QBCore.Functions.CreateCallback('jg-advancedgarages:server:GetGarageVehicles', function(source, cb, garage)
  local src = source
  local vehicles = {}
  local Player = QBCore.Functions.GetPlayer(src)

  MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND job_vehicle = ?', {Player.PlayerData.citizenid, 0},
      function(result)
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
