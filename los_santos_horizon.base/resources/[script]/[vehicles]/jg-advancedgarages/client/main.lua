QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
  PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
  PlayerData.job = job
end)

-- General functions

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(0, 102, 164, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x, y, z, 0)
  DrawText(0.0, 0.0)
  local factor = (string.len(text)) / 370
  DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
  ClearDrawOrigin()
end

function IsJobInList(jobs, job)
  if #jobs == 0 then
    return true
  end

  for _, value in ipairs(jobs) do
    if value == job then
      return true
    end
  end

  return false
end

function doCarDamage(currentVehicle, veh)
  local smash = false
  local damageOutside = false
  local damageOutside2 = false
  local engine = veh.engine + 0.0
  local body = veh.body + 0.0

  if engine < 200.0 then
    engine = 200.0
  end
  if engine > 1000.0 then
    engine = 950.0
  end
  if body < 150.0 then
    body = 150.0
  end
  if body < 950.0 then
    smash = true
  end
  if body < 920.0 then
    damageOutside = true
  end
  if body < 920.0 then
    damageOutside2 = true
  end

  Citizen.Wait(100)
  SetVehicleEngineHealth(currentVehicle, engine)

  if smash then
    SmashVehicleWindow(currentVehicle, 0)
    SmashVehicleWindow(currentVehicle, 1)
    SmashVehicleWindow(currentVehicle, 2)
    SmashVehicleWindow(currentVehicle, 3)
    SmashVehicleWindow(currentVehicle, 4)
  end

  if damageOutside then
    SetVehicleDoorBroken(currentVehicle, 1, true)
    SetVehicleDoorBroken(currentVehicle, 6, true)
    SetVehicleDoorBroken(currentVehicle, 4, true)
  end

  if damageOutside2 then
    SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
  end

  if body < 1000 then
    SetVehicleBodyHealth(currentVehicle, 985.1)
  end
end

function GetVehiclesInArea(coords, maxDistance)
  local entities = QBCore.Functions.GetVehicles()

  local nearbyEntities = {}
  coords = vector3(coords.x, coords.y, coords.z)

  for k, entity in pairs(entities) do
    local distance = #(coords - GetEntityCoords(entity))
    if distance <= maxDistance then
      nearbyEntities[#nearbyEntities + 1] = entity
    end
  end

  return nearbyEntities
end

function GetVehicleSpawnPoint(baseSpawnCoords)
  local blocked = true
  local iterations = 1
  local spawnPoint = baseSpawnCoords

  while iterations <= 10 and blocked do
    if #GetVehiclesInArea(spawnPoint, 2.5) == 0 then
      return spawnPoint
    end

    local newX = spawnPoint.x
    local newY = spawnPoint.y

    if (spawnPoint.w >= 0 and spawnPoint.w <= 45) or (spawnPoint.w >= 315 and spawnPoint.w <= 360) then
      newY = newY + 5
    end
    if spawnPoint.w >= 46 and spawnPoint.w <= 135 then
      newX = newX - 5
    end
    if spawnPoint.w >= 136 and spawnPoint.w <= 225 then
      newY = newY - 5
    end
    if spawnPoint.w >= 226 and spawnPoint.w <= 314 then
      newX = newX + 5
    end

    spawnPoint = vector4(newX, newY, spawnPoint.z, spawnPoint.w)
    iterations = iterations + 1
  end

  return spawnPoint
end

function getVehiclesBasedOnGarageType(vehicles, garageType)
  local filteredVehicles = {}

  for k, v in pairs(vehicles) do
    local vehicle = QBCore.Shared.Vehicles[v.vehicle]
    if vehicle then
      if garageType == "air" then
        if vehicle.category == "helicopters" or vehicle.category == "planes" then
          table.insert(filteredVehicles, v)
        end
      elseif garageType == "sea" then
        if vehicle.category == "boats" then
          table.insert(filteredVehicles, v)
        end
      elseif garageType == "car" then
        if vehicle.category ~= "helicopters" and vehicle.category ~= "planes" and vehicle.category ~= "boats" then
          table.insert(filteredVehicles, v)
        end
      end
    end
  end

  return filteredVehicles
end

-- NUI Callbacks

RegisterNUICallback("close", function(data, cb)
  SetNuiFocus(false, false)
  cb(true)
end)
