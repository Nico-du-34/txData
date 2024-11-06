-- Events
RegisterNetEvent("jg-advancedgarages:client:ImpoundVehicle", function()
  local vehicle = QBCore.Functions.GetClosestVehicle()

  if vehicle ~= 0 and vehicle then
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehpos = GetEntityCoords(vehicle)

    if #(pos - vehpos) < 5.0 then
      QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(veh)
        if veh.plate then
          SetNuiFocus(true, true)
          SendNUIMessage({
            type = "showImpoundForm",
            plate = veh.plate,
            currencySymbol = Config.CurrencySymbol
          })
        else
          QBCore.Functions.DeleteVehicle(vehicle)
        end
      end, QBCore.Functions.GetPlate(vehicle))
    else
      QBCore.Functions.Notify("Vous devez vous rapprocher du véhicule", "error", 3500)
    end
  else
    QBCore.Functions.Notify("Il n'y a pas de véhicules à proximité", "error", 3500)
  end
end)

RegisterNetEvent("jg-advancedgarages:client:ShowImpound", function(impoundId)
  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetImpoundedVehicles", function(result)
    if result == nil then
      QBCore.Functions.Notify("Il n'y a pas de véhicules dans la Fourriére", "error", 3500)
    else
      SetNuiFocus(true, true)
      SendNUIMessage({
        type = "showImpound",
        impoundId = impoundId,
        vehicles = result,
        isWhitelist = IsJobInList(Config.ImpoundJobRestriction, PlayerData.job.type),
        currencySymbol = Config.CurrencySymbol
      })
    end
  end)
end)

-- NUI Callbacks

RegisterNUICallback("impoundTakeOutVehicle", function(data, cb)
  local plate = data.plate
  local impound = Config.ImpoundLocations[data.impoundId]
  local coords = GetVehicleSpawnPoint(impound.spawn)

  if coords and plate then
    QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
      local retrivalCost = json.decode(vehicle.impound_data).retrieval_cost

      if not IsJobInList(Config.ImpoundJobRestriction, PlayerData.job.type) then
        if QBCore.Functions.GetPlayerData().money.bank < retrivalCost then
          QBCore.Functions.Notify("Vous n'avez pas assez d'argent dans votre banque", "error", 3500)
          return false
        end
      end

      QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        QBCore.Functions.SetVehicleProperties(veh, json.decode(vehicle.mods))
        SetVehicleNumberPlateText(veh, vehicle.plate)
        SetEntityHeading(veh, coords.w)
        VehicleSetFuel(veh, vehicle.fuel)
        doCarDamage(veh, vehicle)
        TriggerEvent("jg-advancedgarages:client:TakeOutVehicle:config", veh, vehicle)
        TriggerServerEvent('jg-advancedgarages:server:ImpoundTakeOutVehicle', vehicle.plate, retrivalCost)
        SetNuiFocus(false, false)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
      end, coords, true)
    end, plate)
  end

  cb(true)
end)

RegisterNUICallback("impoundReturnVehicle", function(data, cb)
  local plate = data.plate

  if plate then
    TriggerServerEvent('jg-advancedgarages:server:ReturnToGarage', plate)
  end

  cb(true)
end)

RegisterNUICallback("impoundVehicle", function(data, cb)
  local vehicle = QBCore.Functions.GetClosestVehicle()
  local bodyDamage = 1000
  local engineDamage = 1000
  local totalFuel = VehicleGetFuel(vehicle)

  if Config.SaveVehicleDamage then
    bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
  end

  if vehicle ~= 0 and vehicle then
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehpos = GetEntityCoords(vehicle)
    if #(pos - vehpos) < 5.0 then
      local plate = QBCore.Functions.GetPlate(vehicle)
      TriggerEvent("jg-advancedgarages:client:ImpoundVehicle:config", vehicle)
      TriggerServerEvent("jg-advancedgarages:server:ImpoundVehicle", plate, bodyDamage, engineDamage, totalFuel, data)
      DeleteVehicle(vehicle)
    end
  end

  cb(true)
end)

-- Threads

CreateThread(function()
  if Config.ImpoundShowBlips then
    for id, impound in pairs(Config.ImpoundLocations) do
      local blip = AddBlipForCoord(impound.coords.x, impound.coords.y, impound.coords.z)
      SetBlipSprite(blip, Config.ImpoundBlipId)
      SetBlipColour(blip, Config.ImpoundBlipColour)
      SetBlipScale(blip, Config.ImpoundBlipScale)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      if Config.ImpoundUniqueBlips then
        AddTextComponentString("Fourriére: " .. id)
      else
        AddTextComponentString("Fourriére")
      end
      EndTextCommandSetBlipName(blip)
    end
  end

  while true do
    local sleep = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for id, impound in pairs(Config.ImpoundLocations) do
      local dist = #(pos - impound.coords)

      if dist < impound.distance then
        if not IsPedInAnyVehicle(PlayerPedId()) then
          sleep = 0
          DrawText3D(pos.x, pos.y, pos.z + 1, Config.OpenImpoundPrompt)
          DrawMarker(23, pos.x, pos.y, pos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 27, 160, 0, 80, false, true, 1, nil, nil, false)
          if IsControlJustPressed(0, Config.OpenImpoundKeyBind) then
            TriggerEvent("jg-advancedgarages:client:ShowImpound", id)
          end
        end
      end
    end

    Wait(sleep)
  end
end)
