
-- returns if any player is inside a given vehicle
function IsAnyPlayerInsideVehicle(vehicle, playerPeds)
	playerPeds = playerPeds or GetAllPlayerPeds()

	for i = 1, #playerPeds do
		local veh = GetVehiclePedIsIn(playerPeds[i], false)

		if (DoesEntityExist(veh) and veh == vehicle) then
			return true
		end
	end

	return false
end

-- return the id and distance of the closest player
function GetClosestPlayer(position, maxRadius, players, playerPedsWithHandles)
	local closestDistance	= maxRadius or 1000.0
	local closestPlayer		= nil

	for i = 1, #players do
		if (GetPlayerRoutingBucket(players[i]) == DEFAULT_BUCKET) then
			local distance = #(position - GetEntityCoords(playerPedsWithHandles[ players[i] ]))
			if (distance < closestDistance) then
				closestDistance	= distance
				closestPlayer	= players[i]
			end
		end
	end

	return closestPlayer, closestDistance
end

-- return all player peds associated to their player handles
function GetAllPlayerPedsWithHandles(players)
	local peds = {}

	for i = 1, #players do
		local ped = GetPlayerPed(players[i])
		peds[players[i]] = DoesEntityExist(ped) and ped or nil
	end

	return peds
end

-- returns all currently loaded player peds
function GetAllPlayerPeds()
	local playerPeds = {}

	local peds = GetAllPeds()
	for i = 1, #peds do
		if (DoesEntityExist(peds[i]) and IsPedAPlayer(peds[i])) then
			playerPeds[#playerPeds + 1] = peds[i]
		end
	end

	return playerPeds
end

-- return the ped of the closest player
function GetClosestPlayerPed(position, maxRadius)
	local closestDistance	= maxRadius or 1000.0
	local closestPlayerPed	= nil

	local playerPeds = GetAllPlayerPeds()
	for i = 1, #playerPeds do
		local distance = #(position - GetEntityCoords(playerPeds[i]))

		if (distance < closestDistance) then
			closestDistance		= distance
			closestPlayerPed	= playerPeds[i]
		end
	end

	return closestPlayerPed, closestDistance
end

-- Return an array with all identifiers - e.g. ids["license"] = license:xxxxxxxxxxxxxxxx
function GetPlayerIdentifiersSorted(playerServerId)
	local sortedIdentifiers = {}

	local identifiers = GetPlayerIdentifiers(playerServerId)

	for k, identifier in pairs (identifiers) do
		local i = identifier:find(":")
		sortedIdentifiers[identifier:sub(1, i - 1)] = identifier
	end

	return sortedIdentifiers
end

-- returns true if a player is active on the server with the specified license
function IsPlayerWithLicenseActive(license)
	local players = GetPlayers()

	for i = 1, #players do
		if (GetPlayerIdentifiersSorted(players[i])["license"] == license) then
			return true
		end
	end

	return false
end
