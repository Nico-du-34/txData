-- Events
RegisterNetEvent("jg-advancedgarages:client:ChangeVehiclePlate", function()
  local ped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(ped)

  if vehicle ~= 0 and vehicle then
    QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(veh)
      if veh.plate then
        SetNuiFocus(true, true)
        SendNUIMessage({
          type = "showChangeVehiclePlate",
          plate = veh.plate
        })
      else
        QBCore.Functions.Notify("Le véhicule n'appartient pas à un joueur", "error", 3500)
      end
    end, QBCore.Functions.GetPlate(vehicle))
  else
    QBCore.Functions.Notify("Vous n'êtes pas assis dans un véhicule", "error", 3500)
  end
end)

RegisterNetEvent("jg-advancedgarages:client:DeleteVehicle", function()
  local ped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(ped)
  local plate = QBCore.Functions.GetPlate(vehicle)

  if vehicle ~= 0 and vehicle then
    QBCore.Functions.TriggerCallback('jg-advancedgarages:server:GetVehicle', function(veh)
      if veh.plate then
        TriggerServerEvent('jg-advancedgarages:server:DeleteVehicle', plate)
        DeleteVehicle(vehicle)
      else
        QBCore.Functions.Notify("Le véhicule n'appartient pas à un joueur", "error", 3500)
      end
    end, plate)
  else
    QBCore.Functions.Notify("Vous n'êtes pas assis dans un véhicule", "error", 3500)
  end
end)

-- NUI Callbacks

RegisterNUICallback("changeVehiclePlate", function(data, cb)
  local curPlate = data.curPlate
  local newPlate = data.newPlate
  local ped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(ped)

  if curPlate and newPlate then
    SetVehicleNumberPlateText(vehicle, newPlate)
    TriggerEvent("vehiclekeys:client:SetOwner", newPlate)
    TriggerServerEvent('jg-advancedgarages:server:ChangeVehiclePlate', curPlate, newPlate)
  end

  cb(true)
end)
