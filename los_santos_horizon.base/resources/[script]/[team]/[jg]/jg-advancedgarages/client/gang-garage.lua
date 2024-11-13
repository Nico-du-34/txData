-- Events
RegisterNetEvent("jg-advancedgarages:client:ShowGangGarage", function(gangGarageId)
  local gangGarage = Config.GangGarageLocations[gangGarageId]

  if not gangGarage then
    return false
  end

  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetGangGarageVehicles", function(result)
    if result == nil then
      QBCore.Functions.Notify("Il n'y a pas de véhicules dans le garage", "error", 5000)
    else
      local vehicles = getVehiclesBasedOnGarageType(result, gangGarage.type)

      SetNuiFocus(true, true)
      SendNUIMessage({
        type = "showGarage",
        gangGarage = true,
        vehicles = vehicles,
        garageId = gangGarageId,
        garageType = gangGarage.type,
        returnCost = Config.CurrencySymbol .. Config.GarageVehicleReturnCost,
        enableTransfers = {
          betweenGarages = false,
          betweenPlayers = false
        }
      })
    end
  end, gangGarage.gang)
end)

RegisterNetEvent("jg-advancedgarages:client:GangGarageInsertVehicle", function(gangGarageId)
  local gangGarage = Config.GangGarageLocations[gangGarageId]
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local vehClass = GetVehicleClass(curVeh)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if gangGarage.type == "air" and (vehClass ~= 15 and vehClass ~= 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules aériens dans ce garage", "error", 3500)
  elseif gangGarage.type == "sea" and vehClass ~= 14 then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules marins dans ce garage", "error", 3500)
  elseif gangGarage.type == "car" and (vehClass == 14 or vehClass == 15 or vehClass == 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules de voiture dans ce garage", "error", 3500)
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.license == gangGarage.gang then
      local bodyDamage = 1000
      local engineDamage = 1000
      local totalFuel = VehicleGetFuel(curVeh)

      if Config.SaveVehicleDamage then
        bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
        engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
      end

      TriggerEvent("jg-advancedgarages:client:InsertVehicle:config", curVeh, vehicle)
      TriggerServerEvent('jg-advancedgarages:server:GangGarageInsertVehicle', plate, totalFuel, engineDamage, bodyDamage)
      TriggerServerEvent('sna-vehiclekeys:server:RemoveKey', plate, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))))

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
        SetEntityCoords(ped, gangGarage.coords.x, gangGarage.coords.y, gangGarage.coords.z)
      end

      QBCore.Functions.Notify("Véhicule stationné dans le garage", "primary", 4500)
    else
      QBCore.Functions.Notify("Ceci n'est pas un vehicle" .. gangGarage.gang .. ".", "error", 3500)
    end
  end, plate)
end)

RegisterNetEvent("jg-advancedgarages:client:SetGangVehicle", function(gangName)
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if not gangName or not QBCore.Shared.Gangs[gangName] then
    QBCore.Functions.Notify("Vous n'avez pas fourni de gang valide", "error", 3500)
    return false
  end

  if not plate then
    QBCore.Functions.Notify("Vous n'êtes pas assis dans un véhicule bruh tf vous pensez que Gon arrive?", "error", 3500)
    return false
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.citizenid == PlayerData.citizenid then
      TriggerServerEvent('jg-advancedgarages:server:SetGangVehicle', gangName, vehicle.plate)
      QBCore.Functions.Notify("Véhicule ajouté au garage: " .. gangName .. " !", "success", 3500)
    else
      QBCore.Functions.Notify("Vous devez d'abord posséder ce véhicule", "error", 3500)
    end
  end, plate)
end)

RegisterNetEvent("jg-advancedgarages:client:RemoveGangVehicle", function(playerId)
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if not plate then
    QBCore.Functions.Notify("Vous n'êtes pas dans un véhicule", "error", 3500)
    return false
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.license and vehicle.plate then
      TriggerServerEvent('jg-advancedgarages:server:RemoveGangVehicle', playerId, vehicle.plate)
    else
      QBCore.Functions.Notify("Ce véhicule n'est pas propriétaire", "error", 3500)
    end
  end, plate)
end)

-- NUI Callbacks

RegisterNUICallback("gangGarageTakeOutVehicle", function(data, cb)
  local plate = data.plate
  local garage = Config.GangGarageLocations[data.garageId]
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
        TriggerServerEvent('jg-advancedgarages:server:GangGarageTakeOutVehicle', vehicle.plate, vehicle.in_garage)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        -- TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent('sna-vehiclekeys:server:BuyVehicle', plate, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))))
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

  if Config.GangGarageShowBlips then
    for id, garage in pairs(Config.GangGarageLocations) do
      if garage.gang == PlayerData.gang.name then
        local blip = AddBlipForCoord(garage.coords.x, garage.coords.y, garage.coords.z)
        SetBlipSprite(blip, Config.GangGarageBlipId)
        SetBlipColour(blip, Config.GangGarageBlipColour)
        SetBlipScale(blip, Config.GangGarageBlipScale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        if Config.GangGarageUniqueBlips then
          AddTextComponentString("Gang Garage: " .. id)
        else
          AddTextComponentString("Gang Garage")
        end
        EndTextCommandSetBlipName(blip)
      end
    end
  end

  while true do
    local sleep = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for id, garage in pairs(Config.GangGarageLocations) do
      local dist = #(pos - garage.coords)

      if PlayerData.gang and garage.gang == PlayerData.gang.name then
        if dist < garage.distance then
          if IsPedInAnyVehicle(PlayerPedId()) then
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.InsertVehiclePrompt)
            DrawMarker(22, pos.x, pos.y, pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.7, 0.7, 0.7, 160, 0, 5, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.InsertVehicleKeyBind) then
              TriggerEvent("jg-advancedgarages:client:GangGarageInsertVehicle", id)
            end
          else
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.OpenGaragePrompt)
            DrawMarker(23, pos.x, pos.y, pos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 27, 160, 0, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.OpenGarageKeyBind) then
              TriggerEvent("jg-advancedgarages:client:ShowGangGarage", id)
            end
          end
        end
      end
    end

    Wait(sleep)
  end
end)
