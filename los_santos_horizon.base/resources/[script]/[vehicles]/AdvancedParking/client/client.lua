
-- script status on startup
local enabled = true

-- save last vehicle (and trailer) for identification when it got deleted
local lastVehicleIdentifier	= nil
local lastVehicleNetworkId	= nil
local lastVehiclePlate		= nil
local lastTrailerIdentifier	= nil
local lastTrailerNetworkId	= nil
local lastTrailerPlate		= nil

local trailer = nil

-- thread for saving vehicles a player interacted with
function StartSavingVehicles()
	CreateThread(function()
		Wait(10000)

		local isInVehicle = false
		local vehicle = nil

		while (enabled) do
			Wait(50)

			local playerPed = PlayerPedId()
			local inVeh = IsPedInAnyVehicle(playerPed)

			if (not isInVehicle and inVeh) then
				-- entered vehicle
				isInVehicle = true

				vehicle = GetVehiclePedIsIn(playerPed)

				EnteredVehicle(vehicle)
			elseif (isInVehicle and not inVeh) then
				-- left vehicle
				isInVehicle = false

				LeftVehicle(vehicle)

				vehicle = nil
			end

			if (isInVehicle) then
				local newVehicle = GetVehiclePedIsIn(playerPed)
				if (vehicle ~= newVehicle) then
					-- switched vehicles
					LeftVehicle(vehicle)
					EnteredVehicle(newVehicle)

					vehicle = newVehicle
				else
					lastVehicleIdentifier	= Entity(vehicle).state.ap_id
					lastVehiclePlate		= GetVehicleNumberPlateText(vehicle)
				end

				local hasTrailer, newTrailer = GetVehicleTrailerVehicle(vehicle)
				if (hasTrailer and not DoesEntityExist(trailer)) then
					-- trailer attached
					trailer = newTrailer

					if (not IsVehicleBlacklisted(trailer)) then
						UpdateVehicle(trailer)

						Entity(trailer).state:set("isAttached", NetworkGetNetworkIdFromEntity(vehicle), true)

						LogDebug("Attached trailer \"%s\"", GetVehicleNumberPlateText(trailer))
					end
				elseif (not hasTrailer and DoesEntityExist(trailer)) then
					-- trailer detached
					if (not IsVehicleBlacklisted(trailer)) then
						UpdateVehicle(trailer)

						Entity(trailer).state:set("isAttached", nil, true)

						LogDebug("Detached trailer \"%s\"", lastTrailerPlate)
					end

					trailer = nil

					lastTrailerIdentifier	= nil
					lastTrailerNetworkId	= nil
					lastTrailerPlate		= nil
				end

				if (DoesEntityExist(trailer)) then
					lastTrailerIdentifier	= Entity(trailer).state.ap_id
					lastTrailerNetworkId	= NetworkGetNetworkIdFromEntity(trailer)
					lastTrailerPlate		= GetVehicleNumberPlateText(trailer)
				end
			end
		end
	end)
end

-- when a player entered a vehicle
function EnteredVehicle(vehicle)
	if (not DoesEntityExist(vehicle) or not NetworkGetEntityIsNetworked(vehicle) or IsVehicleBlacklisted(vehicle)) then
		return
	end

	UpdateVehicle(vehicle)

	lastVehicleIdentifier	= Entity(vehicle).state.ap_id
	lastVehicleNetworkId	= NetworkGetNetworkIdFromEntity(vehicle)
	lastVehiclePlate		= GetVehicleNumberPlateText(vehicle)

	LogDebug("Entered vehicle \"%s\"", lastVehiclePlate)
end

-- when a player left a vehicle
function LeftVehicle(vehicle)
	if (not DoesEntityExist(vehicle) or not NetworkGetEntityIsNetworked(vehicle) or IsVehicleBlacklisted(vehicle)) then
		return
	end

	UpdateVehicle(vehicle)

	LogDebug("Left vehicle \"%s\"", lastVehiclePlate)

	lastVehicleIdentifier	= nil
	lastVehicleNetworkId	= nil
	lastVehiclePlate		= nil

	if (DoesEntityExist(trailer)) then
		UpdateVehicle(trailer)

		LogDebug("Left trailer \"%s\"", lastTrailerPlate)

		trailer = nil

		lastTrailerIdentifier	= nil
		lastTrailerNetworkId	= nil
		lastTrailerPlate		= nil
	end
end

-- update vehicle on server side
function UpdateVehicle(vehicle)
	if (not DoesEntityExist(vehicle) or not NetworkGetEntityIsNetworked(vehicle)) then
		return
	end

	local networkId	= NetworkGetNetworkIdFromEntity(vehicle)
	local model		= GetEntityModel(vehicle)
	local tuning	= GetVehicleTuning(vehicle)
	local status	= GetVehicleStatus(vehicle)

	TriggerServerEvent("AP:updateVehicle", networkId, model, tuning, status)

	LogDebug("Updating vehicle \"%s\"", tuning[1])
end
exports("UpdateVehicle", UpdateVehicle)

-- setting tuning
AddStateBagChangeHandler("ap_data", nil, function(bagName, key, value, _unused, replicated)
	if (bagName:find("entity") == nil or value == nil) then
		return
	end

	local networkIdString = bagName:gsub("entity:", "")
	local networkId = tonumber(networkIdString)
	if (WaitUntilEntityWithNetworkIdExists(networkId, 5000)) then
		local vehicle = NetworkGetEntityFromNetworkId(networkId)

		if (WaitUntilPlayerEqualsEntityOwner(vehicle, 5000)) then
			SetVehicleTuning(vehicle, value[1])
			SetVehicleStatus(vehicle, value[2])

			Entity(vehicle).state:set("ap_spawned", true, true)

			LogDebug("Setting tuning and status successful for \"%s\"", value[1][1])
		end
	end
end)
function WaitUntilEntityWithNetworkIdExists(networkId, timeout)
	local threshold = GetGameTimer() + timeout

	while (not NetworkDoesEntityExistWithNetworkId(networkId) and GetGameTimer() < threshold) do
		Wait(0)
	end

	return NetworkDoesEntityExistWithNetworkId(networkId)
end
function WaitUntilPlayerEqualsEntityOwner(entityHandle, timeout)
	local threshold = GetGameTimer() + timeout

	while (DoesEntityExist(entityHandle) and NetworkGetEntityOwner(entityHandle) ~= PlayerId() and GetGameTimer() < threshold) do
		Wait(0)
	end

	return DoesEntityExist(entityHandle) and NetworkGetEntityOwner(entityHandle) == PlayerId()
end

function GetClosestClientSideVehicle(position, maxRadius)
	local dist = maxRadius
	local closestVehicle = nil

	for i, vehicle in ipairs(GetGamePool("CVehicle")) do
		local tempDist = #(GetEntityCoords(vehicle) - position)
		if (tempDist < dist and not NetworkGetEntityIsNetworked(vehicle)) then
			dist = tempDist
			closestVehicle = vehicle
		end
	end

	return closestVehicle
end

-- setting scorched status 
RegisterNetEvent("AP:renderScorched", function(networkId, scorched)
	if (not NetworkDoesEntityExistWithNetworkId(networkId)) then
		return
	end

	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (not DoesEntityExist(vehicle)) then return end

	SetEntityRenderScorched(vehicle, scorched)
end)

-- workaround for server side CreateVehicle spawning non-networked vehicles for clients
RegisterNetEvent("AP:deleteClientSideVehicle", function(position)
	DeleteVehicleEasy(GetClosestClientSideVehicle(position, 5.0))
end)



-- notification for delete timer
function ShowNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	return DrawNotification(false, true)
end
RegisterNetEvent("AP:showNotification", function(text)
	ShowNotification(text)
end)

-- enables/disables the client sending enter/left events
function Enable(enable)
	assert(enable ~= nil and type(enable) == "boolean", "Parameter \"enable\" must be a bool!")

	enabled = enable

	if (enabled) then
		StartSavingVehicles()
	end
end
exports("Enable", Enable)

-- enable the script
Enable(enabled)



-- register spawn event
RegisterNetEvent("AP:vehicleSpawned")
