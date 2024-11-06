local function IsPlayerAllowedToImpound(player)
  if #Config.ImpoundJobRestriction == 0 then
    return true
  end

  for _, value in ipairs(Config.ImpoundJobRestriction) do
    if value == player.PlayerData.job.type then
      return true
    end
  end

  return false
end

-- Events

RegisterNetEvent('jg-advancedgarages:server:ImpoundVehicle', function(plate, body, engine, fuel, impoundData)
  local src = source
  local vehicle = IsVehicleOwned(plate)

  if vehicle == nil then
    return false
  end

  local vehShared = QBCore.Shared.Vehicles[vehicle.vehicle]
  local player = QBCore.Functions.GetPlayer(src).PlayerData
  local impoundMetadata = {
    charname = player.charinfo.firstname .. " " .. player.charinfo.lastname,
    reason = impoundData.reason,
    retrieval_date = impoundData.retrievalDate,
    retrieval_cost = impoundData.retrievalCost
  }

  MySQL.Async.execute(
      'UPDATE player_vehicles SET impound = ?, impound_retrievable = ?, impound_data = ?, state = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
      {1, impoundData.retrievable, json.encode(impoundMetadata), 2, body, engine, fuel, plate})
  TriggerClientEvent('QBCore:Notify', src, "Véhicule mis en Fourriére avec succès")
end)

RegisterNetEvent('jg-advancedgarages:server:ImpoundTakeOutVehicle', function(plate, retrievalCost)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  if not IsPlayerAllowedToImpound(player) then
    player.Functions.RemoveMoney('bank', retrievalCost)
  end

  MySQL.Async.execute('UPDATE player_vehicles SET impound = ?, impound_data = ?, state = ? WHERE plate = ?', {0, "", 0, plate})
  TriggerClientEvent('QBCore:Notify', src, "Véhicule retiré de la Fourriére", 'success')
end)

RegisterNetEvent('jg-advancedgarages:server:ReturnToGarage', function(plate)
  local src = source

  local player = QBCore.Functions.GetPlayer(src)

  if IsPlayerAllowedToImpound(player) then
    MySQL.Async.execute('UPDATE player_vehicles SET impound = ?, impound_data = ?, state = ?, in_garage = ? WHERE plate = ?',
        {0, "", 1, 1, plate})
    TriggerClientEvent('QBCore:Notify', src, "Véhicule retourné au garage du propriétaire", 'success')
  end
end)

-- Callbacks

QBCore.Functions.CreateCallback('jg-advancedgarages:server:GetImpoundedVehicles', function(source, cb)
  local src = source
  local vehicles = {}
  local Player = QBCore.Functions.GetPlayer(src)
  local query = ""
  local args = {}

  if IsPlayerAllowedToImpound(Player) then
    query = 'SELECT * FROM player_vehicles WHERE impound = ?'
    args = {1}
  else
    query = 'SELECT * FROM player_vehicles WHERE (impound = ? AND impound_retrievable = ?) AND (citizenid = ? OR license = ?)'
    args = {1, 1, Player.PlayerData.citizenid, Player.PlayerData.job.type}
  end

  MySQL.Async.fetchAll(query, args, function(result)
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

QBCore.Commands.Add(Config.ImpoundCommand, "Mettre un véhicule a la Fourriére", {}, false, function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  if IsPlayerAllowedToImpound(Player) then
    TriggerClientEvent("jg-advancedgarages:client:ImpoundVehicle", src, true)
  else
    TriggerClientEvent('QBCore:Notify', src, "Vous n'êtes pas autorisé à saisir les véhicules", 'error')
  end
end)
