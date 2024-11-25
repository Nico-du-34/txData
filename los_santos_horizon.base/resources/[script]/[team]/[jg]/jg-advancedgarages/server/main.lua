QBCore = exports['qb-core']:GetCoreObject()

function IsVehicleOwned(plate)
  local result = MySQL.Sync.fetchSingle('SELECT plate, vehicle FROM player_vehicles WHERE plate = ?', {plate})
  return result
end

function getCitizenIdFromServerId(playerId)
  local player = QBCore.Functions.GetQBPlayers()[playerId]

  if not player then
    return false
  end

  return player.PlayerData.citizenid
end

-- Callbacks

QBCore.Functions.CreateCallback("jg-advancedgarages:server:GetVehicle", function(source, cb, plate)
  local src = source
  local vehicle = {}
  local result = MySQL.Sync.fetchSingle('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
  if result ~= nil then
    vehicle = result
  end
  cb(vehicle)
end)

QBCore.Functions.CreateCallback("jg-advancedgarages:server:GetPlayers", function(source, cb)
  local src = source
  local players = {}

  for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
    table.insert(players, {
      id = k,
      name = v.PlayerData.charinfo.firstname .. " " .. v.PlayerData.charinfo.lastname
    })
  end

  cb(players)
end)
