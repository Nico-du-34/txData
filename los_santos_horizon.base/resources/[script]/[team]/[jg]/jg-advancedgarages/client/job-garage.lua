-- Events
RegisterNetEvent("jg-advancedgarages:client:ShowJobGarage", function(jobGarageId)
  local jobGarage = Config.JobGarageLocations[jobGarageId]

  if not jobGarage then
    return false
  end

  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetJobGarageVehicles", function(result)
    if result == nil then
      QBCore.Functions.Notify("Il n'y a pas de véhicules dans le garage", "error", 5000)
    else
      local vehicles = getVehiclesBasedOnGarageType(result, jobGarage.type)

      SetNuiFocus(true, true)
      SendNUIMessage({
        type = "showGarage",
        jobGarage = true,
        vehicles = vehicles,
        garageId = jobGarageId,
        garageType = jobGarage.type,
        returnCost = Config.CurrencySymbol .. Config.GarageVehicleReturnCost,
        enableTransfers = {
          betweenGarages = false,
          betweenPlayers = false
        }
      })
    end
  end, jobGarage.job)
end)

RegisterNetEvent("jg-advancedgarages:client:JobGarageInsertVehicle", function(jobGarageId)
  local jobGarage = Config.JobGarageLocations[jobGarageId]
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local vehClass = GetVehicleClass(curVeh)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if jobGarage.type == "air" and (vehClass ~= 15 and vehClass ~= 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules aériens dans ce garage", "error", 3500)
  elseif jobGarage.type == "sea" and vehClass ~= 14 then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules marins dans ce garage", "error", 3500)
  elseif jobGarage.type == "car" and (vehClass == 14 or vehClass == 15 or vehClass == 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules de voiture dans ce garage", "error", 3500)
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.license == jobGarage.job then
      local bodyDamage = 1000
      local engineDamage = 1000
      local totalFuel = VehicleGetFuel(curVeh)

      if Config.SaveVehicleDamage then
        bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
        engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
      end

      TriggerEvent("jg-advancedgarages:client:InsertVehicle:config", curVeh, vehicle)
      TriggerServerEvent('jg-advancedgarages:server:JobGarageInsertVehicle', plate, totalFuel, engineDamage, bodyDamage)

      -- Take player(s) out of vehicle
      for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(curVeh, i)
        if seat then
          TaskLeaveVehicle(seat, curVeh, 0)
        end
      end

      SetVehicleDoorsLocked(curVeh)
      Wait(1500)
      QBCore.Functions.DeleteVehicle(curVeh)

      -- If plane, helicopter or boat TP ped to the garage location away from the vehicle
      if vehClass == 14 or vehClass == 15 or vehClass == 16 then
        SetEntityCoords(ped, jobGarage.coords.x, jobGarage.coords.y, jobGarage.coords.z)
      end

      QBCore.Functions.Notify("Véhicule stationné dans le garage", "primary", 4500)
    else
      QBCore.Functions.Notify("Ceci n'est pas un véhicule " .. jobGarage.job .. ".", "error", 3500)
    end
  end, plate)
end)

RegisterNetEvent("jg-advancedgarages:client:SetJobVehicle", function(jobName)
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if not jobName or not QBCore.Shared.Jobs[jobName] then
    QBCore.Functions.Notify("Vous n'avez pas fourni d'emploi valide", "error", 3500)
    return false
  end

  if not plate then
    QBCore.Functions.Notify("Vous n'êtes pas assis dans un véhicule bruh tf, vous pensez que Gon arrive?", "error", 3500)
    return false
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.citizenid == PlayerData.citizenid then
      TriggerServerEvent('jg-advancedgarages:server:SetJobVehicle', jobName, vehicle.plate)
      QBCore.Functions.Notify("Véhicule ajouté au garage" .. jobName .. " !", "success", 3500)
    else
      QBCore.Functions.Notify("Vous devez d'abord posséder ce véhicule", "error", 3500)
    end
  end, plate)
end)

RegisterNetEvent("jg-advancedgarages:client:RemoveJobVehicle", function(playerId)
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if not plate then
    QBCore.Functions.Notify("Vous n'êtes pas dans un véhicule", "error", 3500)
    return false
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.license and vehicle.plate then
      TriggerServerEvent('jg-advancedgarages:server:RemoveJobVehicle', playerId, vehicle.plate)
    else
      QBCore.Functions.Notify("Ce véhicule n'est pas propriétaire", "error", 3500)
    end
  end, plate)
end)

-- NUI Callbacks

RegisterNUICallback("jobGarageTakeOutVehicle", function(data, cb)
  local plate = data.plate
  local garage = Config.JobGarageLocations[data.garageId]
  local coords = garage.spawn

  if coords and plate then
    QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
      if vehicle.in_garage == 0 then
        if QBCore.Functions.GetPlayerData().money.bank < Config.GarageVehicleReturnCost then
          QBCore.Functions.Notify("Vous n'avez pas assez d'argent dans votre banque", "error", 5000)
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
        TriggerServerEvent('jg-advancedgarages:server:JobGarageTakeOutVehicle', vehicle.plate, vehicle.in_garage)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
      end, coords, true)
    end, plate)
  end

  SetNuiFocus(false, false)
  cb(true)
end)

-- Threads

CreateThread(function()
  while not PlayerData.citizenid do
    PlayerData = QBCore.Functions.GetPlayerData()
    Wait(500)
  end

  if Config.JobGarageShowBlips then
    for id, garage in pairs(Config.JobGarageLocations) do
      if garage.job == PlayerData.job.name then
        local blip = AddBlipForCoord(garage.coords.x, garage.coords.y, garage.coords.z)
        SetBlipSprite(blip, Config.JobGarageBlipId)
        SetBlipColour(blip, Config.JobGarageBlipColour)
        SetBlipScale(blip, Config.JobGarageBlipScale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        if Config.JobGarageUniqueBlips then
          AddTextComponentString("Job Garage: " .. id)
        else
          AddTextComponentString("Job Garage")
        end
        EndTextCommandSetBlipName(blip)
      end
    end
  end

  while true do
    local sleep = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for id, garage in pairs(Config.JobGarageLocations) do
      local dist = #(pos - garage.coords)

      if PlayerData.job and garage.job == PlayerData.job.name then
        if dist < garage.distance then
          if IsPedInAnyVehicle(PlayerPedId()) then
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.InsertVehiclePrompt)
            DrawMarker(22, pos.x, pos.y, pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.7, 0.7, 0.7, 160, 0, 5, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.InsertVehicleKeyBind) then
              TriggerEvent("jg-advancedgarages:client:JobGarageInsertVehicle", id)
            end
          else
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.OpenGaragePrompt)
            DrawMarker(23, pos.x, pos.y, pos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 27, 160, 0, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.OpenGarageKeyBind) then
              TriggerEvent("jg-advancedgarages:client:ShowJobGarage", id)
            end
          end
        end
      end
    end

    Wait(sleep)
  end
end)
