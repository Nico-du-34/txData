function VehicleGetFuel(vehicle)
  -- Configure the method of getting vehicle fuel level - this value is saved to DB
  return exports['cdn-fuel']:GetFuel(vehicle)
end

function VehicleSetFuel(vehicle, fuel)
  -- Configure the method of re-setting the vehicle fuel level - "fuel" is the saved value in the DB
  return exports['cdn-fuel']:SetFuel(vehicle, fuel)
end

RegisterNetEvent("jg-advancedgarages:client:InsertVehicle:config", function(vehicle, vehicleDbData)
  -- PARAMS:
  -- vehicle: Current vehicle FiveM native data
  -- vehicleDbData: The row of the owned vehicle from the datbase

  -- The following code will be run when the player inserts their vehicle (if the vehicle is owned; and passes all the checks)
  -- ADD CUSTOM CODE HERE

  local vehProperties = QBCore.Functions.GetVehicleProperties(vehicle)
end)

RegisterNetEvent("jg-advancedgarages:client:ImpoundVehicle:config", function(vehicle)
  -- PARAMS:
  -- vehicle: Current vehicle FiveM native data

  -- The following code will be run just before the vehicle is set to impounded in the DB, and before the entity is deleted
  -- ADD CUSTOM CODE HERE
end)

RegisterNetEvent("jg-advancedgarages:client:TakeOutVehicle:config", function(vehicle, vehicleDbData)
  -- PARAMS:
  -- vehicle: Vehicle FiveM native data
  -- vehicleDbData: The row of the owned vehicle from the datbase

  -- The following code will be run on garage take out in the vehicle spawn callback, so you set set vehicle options such as fuel, damage etc.
  -- ADD CUSTOM CODE HERE
end)

