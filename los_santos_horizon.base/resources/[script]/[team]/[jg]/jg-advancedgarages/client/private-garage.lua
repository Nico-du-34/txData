-- Events
RegisterNetEvent("jg-advancedgarages:client:CreatePrivGarage", function()
  if not IsJobInList(Config.PrivGarageCreateJobRestriction, PlayerData.job.name) then
    QBCore.Functions.Notify("Vous n'êtes pas autorisé à utiliser cette commande", "error", 3500)
    return false
  end

  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetPlayers", function(allPlayers)
    SetNuiFocus(true, true)
    SendNUIMessage({
      type = "showPrivGarageCreator",
      allPlayers = allPlayers
    })
  end)
end)

-- NUI Callbacks

RegisterNUICallback("createPrivGarage", function(data, cb)
  if not IsJobInList(Config.PrivGarageCreateJobRestriction, PlayerData.job.name) then
    QBCore.Functions.Notify("Vous n'êtes pas autorisé à faire ça", "error", 3500)
    return false
  end

  local garageName = data.garageName
  local playerId = data.playerId
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local h = GetEntityHeading(ped)

  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GarageNameExists", function(garageExists)
    if garageExists then
      QBCore.Functions.Notify("Le nom de garage existe déjà", "error", 3500)
      cb({
        error = true,
        msg = "Le nom de garage existe déjà"
      })
      return false
    end

    TriggerServerEvent("jg-advancedgarages:server:CreatePrivGarage", garageName, playerId, pos.x, pos.y, pos.z, h)
    cb({
      error = false
    })
  end, garageName)
end)
