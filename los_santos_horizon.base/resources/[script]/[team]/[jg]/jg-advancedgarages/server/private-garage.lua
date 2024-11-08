-- Events
RegisterNetEvent('jg-advancedgarages:server:CreatePrivGarage', function(garageName, playerId, x, y, z, h)
  local src = source
  local type = "car"
  local distance = 10
  local citizenid = getCitizenIdFromServerId(playerId)

  if not citizenid then
    TriggerClientEvent('QBCore:Notify', src, "Le joueur n'est pas en ligne", 'error')
    return false
  end

  MySQL.Async.execute('INSERT INTO player_priv_garages SET citizenid = ?, name = ?, type = ?, x = ?, y = ?, z = ?, h = ?, distance = ?',
      {citizenid, garageName, type, x, y, z, h, distance})

  TriggerClientEvent("jg-advancedgarages:client:NewGarageAdded", playerId, garageName, type, x, y, z, h, distance)
  TriggerClientEvent('QBCore:Notify', src, "Garage Créé avec succès!")
end)

-- Callbacks

QBCore.Functions.CreateCallback('jg-advancedgarages:server:GarageNameExists', function(source, cb, garageName)
  local src = source

  MySQL.Async.fetchAll('SELECT * FROM player_priv_garages WHERE name = ?', {garageName}, function(result)
    if result[1] then
      return cb(true)
    end

    return cb(false)
  end)
end)

QBCore.Functions.CreateCallback('jg-advancedgarages:server:GetPrivateGarages', function(source, cb, citizenid)
  local src = source
  local garages = {}

  MySQL.Async.fetchAll('SELECT * FROM player_priv_garages WHERE citizenid = ?', {citizenid}, function(result)
    if result[1] then
      garages = result
    end

    cb(garages)
  end)
end)

-- Commands

QBCore.Commands.Add(Config.PrivGarageCreateCommand, "Créer un garage privé pour un joueur", {}, false, function(source, args)
  local src = source

  TriggerClientEvent("jg-advancedgarages:client:CreatePrivGarage", src)
end)
