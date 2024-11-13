local garages = Config.GarageLocations

-- Events

RegisterNetEvent("jg-advancedgarages:client:ShowGarage", function(garageId)
  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetPlayers", function(allPlayers)
    local allGarages = {}
    local garage = garages[garageId]
    for k, v in pairs(garages) do
      if v.type == garage.type then
        table.insert(allGarages, k)
      end
    end

    QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetGarageVehicles", function(result)
      if result == nil then
        QBCore.Functions.Notify("Il n'y a pas de véhicules dans le garage", "error", 5000)
      else
        local vehicles = getVehiclesBasedOnGarageType(result, garage.type)

        SetNuiFocus(true, true)
        SendNUIMessage({
          type = "showGarage",
          vehicles = vehicles,
          garageId = garageId,
          garageType = garage.type,
          enableTransfers = Config.EnableTransfers,
          returnCost = (Config.GarageVehicleReturnCost == 0 and "FREE" or (Config.CurrencySymbol .. Config.GarageVehicleReturnCost)),
          transferCost = (Config.GarageVehicleTransferCost == 0 and "FREE" or (Config.CurrencySymbol .. Config.GarageVehicleTransferCost)),
          allGarages = allGarages,
          allPlayers = allPlayers
        })
      end
    end, garageId)
  end)
end)

RegisterNetEvent("jg-advancedgarages:client:InsertVehicle", function(garageId)
  local garage = garages[garageId]
  local ped = PlayerPedId()
  local curVeh = GetVehiclePedIsIn(ped)
  local vehClass = GetVehicleClass(curVeh)
  local plate = QBCore.Functions.GetPlate(curVeh)

  if garage.type == "air" and (vehClass ~= 15 and vehClass ~= 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules aériens dans ce garage", "error", 3500)
  elseif garage.type == "sea" and vehClass ~= 14 then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules marins dans ce garage", "error", 3500)
  elseif garage.type == "car" and (vehClass == 14 or vehClass == 15 or vehClass == 16) then
    return QBCore.Functions.Notify("Vous ne pouvez stocker que des types de véhicules de voiture dans ce garage", "error", 3500)
  end

  QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
    if vehicle.citizenid == PlayerData.citizenid then
      local bodyDamage = 1000
      local engineDamage = 1000
      local totalFuel = VehicleGetFuel(curVeh)

      if Config.SaveVehicleDamage then
        bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
        engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
      end

      TriggerEvent("jg-advancedgarages:client:InsertVehicle:config", curVeh, vehicle)
      TriggerServerEvent('jg-advancedgarages:server:GarageInsertVehicle', plate, totalFuel, engineDamage, bodyDamage, garageId)
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
        SetEntityCoords(ped, garage.coords.x, garage.coords.y, garage.coords.z)
      end

      QBCore.Functions.Notify("Véhicule stationné dans le garage", "primary", 4500)
    else
      QBCore.Functions.Notify("Vous ne possédez pas ce véhicule", "error", 3500)
    end
  end, plate)
end)

RegisterNetEvent("jg-advancedgarages:client:NewGarageAdded", function(name, type, x, y, z, h, distance)
  garages[name] = {
    coords = vector3(x, y, z),
    spawn = vector4(x, y, z, h),
    distance = distance,
    type = type
  }

  local blip = AddBlipForCoord(x, y, z)
  SetBlipSprite(blip, Config.GarageBlipId)
  SetBlipColour(blip, Config.GarageBlipColour)
  SetBlipScale(blip, 0.7)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Garage: " .. name)
  EndTextCommandSetBlipName(blip)
end)

-- NUI Callbacks

RegisterNUICallback("garageTakeOutVehicle", function(data, cb)
  local plate = data.plate
  local garage = garages[data.garageId]
  local coords = GetVehicleSpawnPoint(garage.spawn)

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
        TriggerServerEvent('jg-advancedgarages:server:GarageTakeOutVehicle', vehicle.plate, vehicle.in_garage)
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

RegisterNUICallback("garageTransferVehicle", function(data, cb)
  local plate = data.plate
  local curGarageId = data.curGarageId

  if plate then
    QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(vehicle)
      if vehicle.citizenid ~= PlayerData.citizenid then
        QBCore.Functions.Notify("Vehicle does not belong to you", "error", 5000)
      end

      if data.type == "garage" then
        if QBCore.Functions.GetPlayerData().money.bank < Config.GarageVehicleTransferCost then
          QBCore.Functions.Notify("Vous n'avez pas assez d'argent dans votre banque", "error", 5000)
          return false
        end
      end

      TriggerServerEvent('jg-advancedgarages:server:GarageTransferVehicle', vehicle.plate, data.type, data.garageId, data.playerId)

      TriggerEvent("jg-advancedgarages:client:ShowGarage", curGarageId)
    end, plate)
  end

  cb(true)
end)

-- Threads

CreateThread(function()
  while not PlayerData.citizenid do
    PlayerData = QBCore.Functions.GetPlayerData()
    Wait(500)
  end

  QBCore.Functions.TriggerCallback("jg-advancedgarages:server:GetPrivateGarages", function(privateGarages)
    for id, garage in pairs(privateGarages) do
      garages[garage.name] = {
        coords = vector3(garage.x, garage.y, garage.z),
        spawn = vector4(garage.x, garage.y, garage.z, garage.h),
        distance = garage.distance,
        type = garage.type
      }
    end

    if Config.GarageShowBlips then
      for id, garage in pairs(garages) do
        local blip = AddBlipForCoord(garage.coords.x, garage.coords.y, garage.coords.z)
        SetBlipSprite(blip, Config.GarageBlipId)
        SetBlipColour(blip, Config.GarageBlipColour)
        SetBlipScale(blip, Config.GarageBlipScale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        if Config.GarageUniqueBlips then
          AddTextComponentString("Garage: " .. id)
        else
          AddTextComponentString("Garage")
        end
        EndTextCommandSetBlipName(blip)
      end
    end

    while true do
      local sleep = 1000
      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)

      for id, garage in pairs(garages) do
        local dist = #(pos - garage.coords)

        if dist < garage.distance then
          if IsPedInAnyVehicle(PlayerPedId()) then
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.InsertVehiclePrompt)
            -- DrawMarker(22, pos.x, pos.y, pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.7, 0.7, 0.7, 160, 0, 5, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.InsertVehicleKeyBind) then
              TriggerEvent("jg-advancedgarages:client:InsertVehicle", id)
            end
          else
            sleep = 0
            DrawText3D(pos.x, pos.y, pos.z + 1, Config.OpenGaragePrompt) 
            -- DrawMarker(23, pos.x, pos.y, pos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 27, 160, 0, 80, false, true, 1, nil, nil, false)
            if IsControlJustPressed(0, Config.OpenGarageKeyBind) then
              TriggerEvent("jg-advancedgarages:client:ShowGarage", id)
            end
          end
        end
      end

      Wait(sleep)
    end
  end, PlayerData.citizenid)
end)


-- exports['qb-target']:AddCircleZone("garagepub", vector3(213.97, -806.72, 30.82), 1.5, {
--   name = "garagepub",
--   debugPoly = true,
-- }, {
--   options = {
--     {
--       type = "server",
--       event = "jg-advancedgarages:server:GetPrivateGarages",
--       label = 'Test',
--     }
--   },
--   distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
-- })