
local SPAWN_TIMEOUT = 32000
local SPAWN_DISTANCE = 200

local math_floor = math.floor
local os_time = os.time
local os_difftime = os.difftime

if (not GetEntityFromStateBagName) then
	LogDebug("Function \"GetEntityFromStateBagName\" was not detected. Adding custom implementation...")

	GetEntityFromStateBagName = function(bagName)
		local entityIdString = bagName:gsub("entity:", "")
		local entityId = tonumber(entityIdString)
		if (not entityId) then return 0 end

		return NetworkGetEntityFromNetworkId(entityId)
	end
end

-- read all vehicles from the database
function CreateAndReadFromDB()
	-- auto-add table if not exists
	MySQL.Sync.execute(
		"CREATE TABLE IF NOT EXISTS `vehicle_parking` (" .. 
			"\n`id` varchar(16) NOT NULL, " .. 
			"\n`model` int(11) NOT NULL, " .. 
			"\n`type` varchar(16), " .. 
			"\n`status` text NOT NULL, " .. 
			"\n`tuning` text NOT NULL, " .. 
			"\n`stateBags` text NOT NULL, " .. 
			"\n`posX` float NOT NULL, " .. 
			"\n`posY` float NOT NULL, " .. 
			"\n`posZ` float NOT NULL, " .. 
			"\n`rotX` float NOT NULL, " .. 
			"\n`rotY` float NOT NULL, " .. 
			"\n`rotZ` float NOT NULL, " .. 
			"\n`lastUpdate` int(11) NOT NULL DEFAULT '0', " .. 
			"\nPRIMARY KEY (`id`)" .. 
		"\n)"
	)

	-- backwards compatibility with v3.9.1 and older
	local hasTypeColumn = MySQL.Sync.fetchScalar(
		"SELECT COUNT(*) FROM `INFORMATION_SCHEMA`.`COLUMNS` " .. 
			"\nWHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'vehicle_parking' AND `COLUMN_NAME` = 'type';"
	) > 0
	if (not hasTypeColumn) then
		MySQL.Sync.execute(
			"ALTER TABLE `vehicle_parking` " .. 
				"\nADD COLUMN `type` varchar(16)"
		)
	end

	local rows = MySQL.Sync.fetchAll(
		"SELECT `id`, `model`, `type`, `status`, `tuning`, `stateBags`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `lastUpdate` " .. 
		"\nFROM `vehicle_parking`"
	)

	Log("Found %s saved vehicles in vehicle_parking.", #rows)

	for i, row in ipairs(rows) do
		local tune = json.decode(row.tuning)
		if (row.model ~= nil and tune[1] ~= nil) then
			savedVehicles[row.id] = {
				handle			= nil,
				model			= row.model,
				type			= row.type,
				status			= json.decode(row.status),
				tuning			= tune,
				stateBags		= json.decode(row.stateBags),
				position		= vector3(row.posX, row.posY, row.posZ),
				rotation		= vector3(row.rotX, row.rotY, row.rotZ),
				lastUpdate		= row.lastUpdate,
				spawning		= false
			}
		else
			LogWarning("Vehicle \"%s\" does not have a model or plate associated with it. Deleting...", row.id)

			MySQL.Async.execute(
				"DELETE FROM `vehicle_parking` " .. 
				"WHERE `id` = @id", {
					['@id'] = row.id
				}
			)
		end
	end
end

-- deletes vehicles if they are in the world without being updated for too long
function CleanUp()
	local currentTime	= os_time()
	local threshold		= 3600 * Config.cleanUpThresholdTime
	local timeDiff		= os_difftime(currentTime, threshold)

	local toDelete = {}

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.lastUpdate < timeDiff or (Config.cleanUpExplodedVehicles and vehicleData.status[3] < -3999.0)) then
			toDelete[#toDelete + 1] = id
		end
	end

	for i, id in ipairs(toDelete) do
		if (savedVehicles[id].handle and DoesEntityExist(savedVehicles[id].handle)) then
			DeleteEntity(savedVehicles[id].handle)

			LogDebug("Deleted \"%s\" through cleanup.", id)
		end

		if (Config.storeOwnedVehiclesInGarage) then
			local isESX = GetResourceState("es_extended") == "started"
			local tableName	= isESX and "owned_vehicles" or "player_vehicles"
			local colName	= isESX and "stored" or "state"

			local plate = savedVehicles[id].tuning[1]:upper()
			MySQL.Async.execute(
				"UPDATE `" .. tableName .. "` SET `" .. colName .. "` = 1 " .. 
				"\nWHERE `plate` = @plate OR `plate` = @trimmedPlate", {
					['@plate'] = plate,
					['@trimmedPlate'] = Trim(plate)
				}
			)
		end

		savedVehicles[id] = nil
	end

	DeleteVehiclesFromDB(toDelete)

	Log("CleanUp complete. Deleted %s entries.", #toDelete)
end

-- add clean up tasks
if (Config.useCleanUpTask) then
	for i, time in ipairs(Config.cleanUpTimes) do
		AddTask(CleanUp, time.hour, time.minute)
	end
end

function StartMainLoop()
	-- main loop for spawning and updating vehicles
	CreateThread(function()
		while (true) do
			Wait(5000)

			local players = GetPlayers()
			if (#players > 0) then
				local playerPedsWithHandlers = GetAllPlayerPedsWithHandles(players)
				local playerPeds = GetAllPlayerPeds()

				SpawnVehicles(players, playerPedsWithHandlers)
				UpdateVehicles(players, playerPedsWithHandlers, playerPeds)
			end
		end
	end)
end

MySQL.ready(function()
	-- get all vehicle data sets
	CreateAndReadFromDB()

	-- clean up vehicle data
	CleanUp()

	-- start the spawning/updating
	StartMainLoop()
end)



-- handle removal of entities if not from AP itself
AddEventHandler("entityRemoved", function(entity)
	if (GetEntityType(entity) ~= 2) then return end

	local id = Entity(entity).state.ap_id
	if (not id or not savedVehicles[id]) then return end

	savedVehicles[id].position	= RoundVector3(GetEntityCoords(entity), 2)
	savedVehicles[id].rotation	= RoundVector3(GetEntityRotation(entity), 2)
	savedVehicles[id].handle	= nil
	savedVehicles[id].spawning	= false

	LogDebug("Vehicle \"%s\" was removed!", id)
end)

function GetLoadedVehiclesWithId(vehicles)
	local list = {}

	for i = 1, #vehicles do
		if (DoesEntityExist(vehicles[i]) and GetEntityRoutingBucket(vehicles[i]) == DEFAULT_BUCKET) then
			local state = Entity(vehicles[i]).state
			if (state and state.ap_id) then
				list[state.ap_id] = vehicles[i]
			end
		end
	end

	return list
end

-- try spawning vehicles
function SpawnVehicles(players, playerPedsWithHandlers)
	-- cache vehicles and players
	local vehicles	= GetAllVehicles()

	-- get vehicles that are already spawned by AP
	local loadedVehicles = GetLoadedVehiclesWithId(vehicles)

	-- check if any vehicle needs respawning
	for id, vehicleData in pairs(savedVehicles) do
		if (not vehicleData.spawning and vehicleData.handle == nil) then
			local loadedVehicle = loadedVehicles[id]
			if (loadedVehicle) then
				-- vehicle exists, add handle
				vehicleData.handle = loadedVehicle

				Entity(vehicleData.handle).state.ap_id = id

				LogDebug("Found vehicle \"%s\" at %s", id, RoundVector3(GetEntityCoords(vehicleData.handle), 2))
			elseif (GetClosestPlayer(vehicleData.position, SPAWN_DISTANCE, players, playerPedsWithHandlers)) then
				-- vehicle not found, spawn it when player is close
				CreateThread(function()
					SpawnVehicle(id, vehicleData)
				end)
			end
		end
	end
end

-- spawn a vehicle from its data
function SpawnVehicle(id, vehicleData)
	if (vehicleData.model == nil) then
		return
	end

	vehicleData.spawning = true

	local vehicle = nil
	if (vehicleData.type and CreateVehicleServerSetter) then
		vehicle = CreateVehicleServerSetter(vehicleData.model, vehicleData.type, vehicleData.position.x, vehicleData.position.y, vehicleData.position.z, vehicleData.rotation.z)
	else
		vehicle = CreateVehicle(vehicleData.model, vehicleData.position.x, vehicleData.position.y, vehicleData.position.z, vehicleData.rotation.z, true, true)
	end

	local timer = GetGameTimer()
	while (not DoesEntityExist(vehicle)) do
		Wait(0)

		if (timer + SPAWN_TIMEOUT < GetGameTimer()) then
			-- timeout
			LogWarning("Hit timeout while spawning vehicle \"%s\".", id)

			TriggerClientEvent("AP:deleteClientSideVehicle", -1, vehicleData.position)

			vehicleData.spawning = false

			return
		end
	end

	-- prevent NPCs in vehicles
	local ped = GetPedInVehicleSeat(vehicle, -1)
	if (ped and DoesEntityExist(ped) and not IsPedAPlayer(ped)) then
		LogDebug("Deleting an NPC that spawned in vehicle \"%s\"", id)

		DeleteEntity(ped)
	end

	if (DEFAULT_BUCKET ~= 0) then
		SetEntityRoutingBucket(vehicle, DEFAULT_BUCKET)
	end

	SetEntityCoords(vehicle, vehicleData.position.x, vehicleData.position.y, vehicleData.position.z)
	SetEntityRotation(vehicle, vehicleData.rotation.x, vehicleData.rotation.y, vehicleData.rotation.z)

	SetVehicleNumberPlateText(vehicle, vehicleData.tuning[1])
	SetVehicleDoorsLocked(vehicle, vehicleData.status[7])

	-- apply state bags
	local state = Entity(vehicle).state

	state.ap_id		= id
	state.ap_data	= { vehicleData.tuning, vehicleData.status }

	state.ap_spawned = false

	for bagName, bagData in pairs(vehicleData.stateBags) do
		state:set(bagName, bagData, true)
	end

	vehicleData.handle = vehicle

	LogDebug("Creating vehicle \"%s\" at %s", id, vehicleData.position)
end

-- update vehicles
function UpdateVehicles(players, playerPedsWithHandlers, playerPeds)
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle and DoesEntityExist(vehicleData.handle) and GetClosestPlayer(vehicleData.position, 150.0, players, playerPedsWithHandlers) and NetworkGetEntityOwner(vehicleData.handle) ~= -1) then
			TryUpdateVehicle(id, vehicleData, playerPeds)
		end
	end
end

local function IsInBounds(value, min, max)
	return value >= min and value <= max
end

-- check if update is necessary and update
function TryUpdateVehicle(id, vehicleData, playerPeds)
	local handle = vehicleData.handle

	if (IsAnyPlayerInsideVehicle(handle, playerPeds) or Entity(handle).state.isAttached) then return end

	local newPos = RoundVector3(GetEntityCoords(handle), 2)
	local newRot = RoundVector3(GetEntityRotation(handle), 2)

	local newLockStatus     = GetVehicleDoorLockStatus(handle)
	local newEngineHealth   = math_floor(GetVehicleEngineHealth(handle) * 10.0) * 0.1
	local newTankHealth     = math_floor(GetVehiclePetrolTankHealth(handle) * 10.0) * 0.1

	local status = vehicleData.status

	local posChange				= #(vehicleData.position - newPos) > 1.0
	local rotChange				= GetRotationDifference(vehicleData.rotation, newRot) > 15.0
	local lockChange			= false
	local engineHealthChange	= IsInBounds(newEngineHealth, -4000.0, 1000.0) and newEngineHealth + 5.0 < status[3]
	local tankHealthChange		= IsInBounds(newTankHealth, -1000.0, 1000.0) and newTankHealth + 5.0 < status[4]

	if ((newLockStatus == 0 or newLockStatus == 1) and (status[7] == 0 or status[7] == 1)) then
		-- don't register change
	elseif (newLockStatus ~= status[7]) then
		-- changed
		lockChange = true
	end

	if (posChange or rotChange or lockChange or engineHealthChange or tankHealthChange) then
		LogDebug("Reason for next update:")
		if (posChange) then				LogDebug("    - Position from %s to %s", vehicleData.position, newPos)	end
		if (rotChange) then				LogDebug("    - Rotation from %s to %s", vehicleData.rotation, newRot)	end
		if (lockChange) then			LogDebug("    - Lockstate from %s to %s", status[7], newLockStatus)		end
		if (engineHealthChange) then	LogDebug("    - Engine from %s to %s", status[3], newEngineHealth)		end
		if (tankHealthChange) then		LogDebug("    - Tank from %s to %s", status[4], newTankHealth)			end

		vehicleData.position = newPos
		vehicleData.rotation = newRot

		vehicleData.status[3] = newEngineHealth
		vehicleData.status[4] = newTankHealth
		vehicleData.status[7] = newLockStatus

		vehicleData.lastUpdate = os_time()

		UpdateVehicleInDB(id, vehicleData)
	end
end

-- triggered from client side to either update or insert a vehicle
RegisterNetEvent("AP:updateVehicle", function(networkId, model, tuning, status)
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (not DoesEntityExist(vehicle)) then
		LogDebug("Tried to save entity that does not exist on server side (yet)!")
		return
	end
	if (GetEntityRoutingBucket(vehicle) ~= DEFAULT_BUCKET) then
		LogDebug("Tried to save entity from a different routing bucket!")
		return
	end

	local id = Entity(vehicle).state.ap_id
	if (id and savedVehicles[id]) then
		-- already exists
		savedVehicles[id].status		= status
		savedVehicles[id].tuning		= tuning
		savedVehicles[id].position		= RoundVector3(GetEntityCoords(vehicle), 2)
		savedVehicles[id].rotation		= RoundVector3(GetEntityRotation(vehicle), 2)
		savedVehicles[id].lastUpdate	= os_time()

		UpdateVehicleInDB(id, savedVehicles[id])

		LogDebug("    Reason: Get in/out or manual update")
	else
		if (Config.preventDuplicateVehicles) then
			local oldId = GetVehicleIdentifierUsingPlate(tuning[1])
			if (oldId) then
				DeleteVehicleUsingIdentifier(oldId)
			end
		end

		-- does not exist
		id = GetNewVehicleIdentifier()

		Entity(vehicle).state.ap_id = id

		savedVehicles[id] = {
			handle		= vehicle,
			model		= model,
			type		= GetVehicleType(vehicle),
			status		= status,
			tuning		= tuning,
			stateBags	= {},
			position	= RoundVector3(GetEntityCoords(vehicle), 2),
			rotation	= RoundVector3(GetEntityRotation(vehicle), 2),
			lastUpdate	= os_time(),
			spawning	= false
		}

		InsertVehicleInDB(id)
	end
end)

-- insert vehicle into database
function InsertVehicleInDB(id)
	assert(id ~= nil and type(id) == "string", "Parameter \"id\" must be a string!")

	LogDebug("Inserting new vehicle \"%s\" into database", id)

	MySQL.Async.execute(
		"INSERT INTO vehicle_parking (`id`, `model`, `type`, `status`, `tuning`, `stateBags`, `posX`, `posY`, `posZ`, `rotX`, `rotY`, `rotZ`, `lastUpdate`) " .. 
		"\nVALUES (@id, @model, @type, @status, @tuning, @stateBags, @posX, @posY, @posZ, @rotX, @rotY, @rotZ, @lastUpdate)", {
			["@id"]			= id,
			["@model"]		= savedVehicles[id].model,
			["@type"]		= savedVehicles[id].type,
			["@status"]		= json.encode(savedVehicles[id].status, { indent = true }),
			["@tuning"]		= json.encode(savedVehicles[id].tuning, { indent = true }),
			["@stateBags"]	= json.encode(savedVehicles[id].stateBags, { indent = true }),
			["@posX"]		= savedVehicles[id].position.x,
			["@posY"]		= savedVehicles[id].position.y,
			["@posZ"]		= savedVehicles[id].position.z,
			["@rotX"]		= savedVehicles[id].rotation.x,
			["@rotY"]		= savedVehicles[id].rotation.y,
			["@rotZ"]		= savedVehicles[id].rotation.z,
			["@lastUpdate"]	= savedVehicles[id].lastUpdate
		}
	)
end

-- update vehicle in database
function UpdateVehicleInDB(id, vehicleData)
	assert(id ~= nil and type(id) == "string", "Parameter \"id\" must be a string!")

	LogDebug("Updating vehicle \"%s\" in database", id)

	MySQL.Async.execute(
		"UPDATE `vehicle_parking` " .. 
		"\nSET `status` = @status, " .. 
			"\n`tuning` = @tuning, " .. 
			"\n`stateBags` = @stateBags, " .. 
			"\n`posX` = @posX, `posY` = @posY, `posZ` = @posZ, " .. 
			"\n`rotX` = @rotX, `rotY` = @rotY, `rotZ` = @rotZ, " .. 
			"\n`lastUpdate` = @lastUpdate " .. 
		"\nWHERE `id` = @id", {
			["@id"]			= id,
			["@status"]		= json.encode(vehicleData.status, { indent = true }),
			["@tuning"]		= json.encode(vehicleData.tuning, { indent = true }),
			["@stateBags"]	= json.encode(vehicleData.stateBags, { indent = true }),
			["@posX"]		= vehicleData.position.x,
			["@posY"]		= vehicleData.position.y,
			["@posZ"]		= vehicleData.position.z,
			["@rotX"]		= vehicleData.rotation.x,
			["@rotY"]		= vehicleData.rotation.y,
			["@rotZ"]		= vehicleData.rotation.z,
			["@lastUpdate"] = vehicleData.lastUpdate
		}
	)
end

-- delete vehicle(s) from database
function DeleteVehiclesFromDB(...)
	local idList = {...}

	if (type(idList[1]) == "table") then
		idList = idList[1]
	end
	if (#idList == 0) then
		return
	end

	local str = json.encode(idList)
	str = str:sub(2, str:len() - 1)

	MySQL.Async.execute(
		"DELETE FROM `vehicle_parking` " .. 
		"\nWHERE `id` IN (" .. str .. ")"
	)
end

AddStateBagChangeHandler("ap_spawned", nil, function(bagName, key, value, _unused, replicated)
	if (not value) then return end

	local entity = GetEntityFromStateBagName(bagName)
	if (entity == 0) then return end

	local id = Entity(entity).state.ap_id
	if (not id or not savedVehicles[id]) then return end

	savedVehicles[id].spawning = false

	Entity(entity).state.ap_data = nil

	LogDebug("Setting tuning and status successful for \"%s\"", id)

	if (DoesEntityExist(savedVehicles[id].handle)) then
		TriggerEvent("AP:vehicleSpawned", savedVehicles[id].handle)
		TriggerClientEvent("AP:vehicleSpawned", -1, NetworkGetNetworkIdFromEntity(savedVehicles[id].handle))
	end
end)

-- delete vehicles that are still being spawned before actually stopping the resource
AddEventHandler("onResourceStop", function(name)
	if (name ~= GetCurrentResourceName()) then
		return
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.spawning and DoesEntityExist(vehicleData.handle)) then
			LogDebug("Deleted vehicle \"%s\" because it was still spawning", id)
			DeleteEntity(vehicleData.handle)
		end
	end
end)

-- loop to delete vehicles when using auto deleter
local AD = Config.autoDelete
if (AD.timer > 0) then
	CreateThread(function()
		while (true) do
			Wait(60000 * (AD.timer - AD.notificationTimes[1]))

			TriggerClientEvent("AP:showNotification", -1, AD.timeLeftNotification:format(AD.notificationTimes[1]))
			for i = 2, #AD.notificationTimes, 1 do
				Wait(60000 * (AD.notificationTimes[i - 1] - AD.notificationTimes[i]))
				TriggerClientEvent("AP:showNotification", -1, AD.timeLeftNotification:format(AD.notificationTimes[i]))
			end
			Wait(60000 * AD.notificationTimes[#AD.notificationTimes])

			TriggerClientEvent("AP:showNotification", -1, AD.deleteNotification)

			DeleteAllVehicles()
		end
	end)

	function DeleteAllVehicles()
		local time = GetGameTimer()

		local vehicles = GetAllVehicles()
		local deleted = 0
		local toDelete = {}

		for id, vehicleData in pairs(savedVehicles) do
			if (vehicleData.handle == nil) then
				table.insert(toDelete, id)

				savedVehicles[id] = nil
			end
		end

		for i, vehicle in ipairs(vehicles) do
			if (DoesEntityExist(vehicle) and not IsAnyPlayerInsideVehicle(vehicle)) then
				local closestPlayer, distance = GetClosestPlayerPed(GetEntityCoords(vehicle))
				if (closestPlayer == nil or distance > AD.distance) then
					local id = Entity(vehicle).state.ap_id
					if (id and savedVehicles[id]) then
						savedVehicles[id] = nil

						table.insert(toDelete, id)
					end

					DeleteEntity(vehicle)

					deleted = deleted + 1
				end
			end
		end

		DeleteVehiclesFromDB(toDelete)

		Log(string.format("Deleted %s/%s vehicles. Took %ssec", deleted, #vehicles, (GetGameTimer() - time) * 0.001))
	end
end

function DeleteVehicle(vehicle, keepInWorld)
	if (not DoesEntityExist(vehicle)) then
		return
	end

	DeleteVehicleUsingData(Entity(vehicle).state.ap_id, NetworkGetNetworkIdFromEntity(vehicle), GetVehicleNumberPlateText(vehicle), keepInWorld)
end
exports("DeleteVehicle", DeleteVehicle)

function DeleteVehicleUsingData(identifier, networkId, plate, keepInWorld)
	if (identifier == nil and networkId == nil and plate == nil) then
		LogWarning("Tried to delete vehicle without \"identifier\", \"networkId\" and \"plate\"!")
		return
	end

	LogDebug("Trying to delete using identifier \"%s\", networkId \"%s\", plate \"%s\"", identifier, networkId, plate)

	if (identifier and DeleteVehicleUsingIdentifier(identifier, keepInWorld)) then
		return
	end
	if (networkId and DeleteVehicleUsingNetworkId(networkId, keepInWorld)) then
		return
	end
	if (plate and DeleteVehicleUsingPlate(plate, keepInWorld)) then
		return
	end
end
exports("DeleteVehicleUsingData", DeleteVehicleUsingData)

-- delete vehicle from client side using identifier, network id or plate
RegisterNetEvent("AP:deleteVehicle", function(identifier, networkId, plate, keepInWorld)
	DeleteVehicleUsingData(identifier, networkId, plate, keepInWorld)
end)

-- delete vehicle using identifier
function DeleteVehicleUsingIdentifier(id, keepInWorld)
	LogDebug("Trying to delete using identifier \"%s\"", id)

	if (savedVehicles[id]) then
		if (not keepInWorld and savedVehicles[id].handle and DoesEntityExist(savedVehicles[id].handle)) then
			DeleteEntity(savedVehicles[id].handle)
		end

		local result, error = pcall(DeleteVehiclesFromDB, id)
		if (not result) then
			LogError("Error occured while calling \"DeleteVehiclesFromDB\" inside \"DeleteVehicleUsingIdentifier\"!")
			LogError("Full error: %s", error)
		end

		savedVehicles[id] = nil

		return true
	end

	return false
end

-- delete vehicle using network id
function DeleteVehicleUsingNetworkId(networkId, keepInWorld)
	LogDebug("Trying to delete using networkId \"%s\"", networkId)

	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (not DoesEntityExist(vehicle)) then
		return false
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle == vehicle) then
			if (not keepInWorld) then
				DeleteEntity(vehicle)
			end

			DeleteVehiclesFromDB(id)

			savedVehicles[id] = nil

			return true
		end
	end

	if (not keepInWorld) then
		DeleteEntity(vehicle)
	end

	return true
end

-- delete vehicle using plate
function DeleteVehicleUsingPlate(plate, keepInWorld)
	LogDebug("Trying to delete using plate \"%s\"", plate)

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.tuning[1] == plate or Trim(vehicleData.tuning[1]) == plate) then
			if (not keepInWorld and vehicleData.handle and DoesEntityExist(vehicleData.handle)) then
				DeleteEntity(vehicleData.handle)
			end

			DeleteVehiclesFromDB(id)

			savedVehicles[id] = nil

			return true
		end
	end

	if (not keepInWorld) then
		local vehicle = TryGetLoadedVehicleFromPlate(plate, GetAllVehicles())
		if (vehicle and DoesEntityExist(vehicle)) then
			DeleteEntity(vehicle)

			return true
		end
	end

	return false
end

-- update a vehicles state bags in database
function UpdateVehicleStateBagsInDB(id, stateBags)
	assert(id ~= nil and type(id) == "string", "Parameter \"id\" must be a string!")

	LogDebug("Updating vehicle state bags \"%s\" in database", id)

	MySQL.Async.execute(
		"UPDATE `vehicle_parking` " .. 
		"\nSET `stateBags` = @stateBags " .. 
		"\nWHERE `id` = @id", {
			["@id"]			= id,
			["@stateBags"]	= json.encode(stateBags, { indent = true })
		}
	)
end

-- state bag change handler for detecting changes on a vehicle
--   auto updates in the database if the last update was too long ago
AddStateBagChangeHandler(nil, nil, function(bagName, key, value, _unused, replicated)
	if (key:find("ap_")) then return end

	if (Config.ignoreStateBags) then
		for i = 1, #Config.ignoreStateBags do
			if (key:find(Config.ignoreStateBags[i])) then return end
		end
	end

	local entity = GetEntityFromStateBagName(bagName)
	if (entity == 0) then return end

	local id = Entity(entity).state.ap_id
	if (not id or not savedVehicles[id]) then return end

	if (savedVehicles[id].stateBags[key] == nil or not TableEquals(savedVehicles[id].stateBags[key], value)) then
		-- new state bag OR update
		savedVehicles[id].stateBags[key] = value

		if (Config.preventStateBagAutoUpdate) then
			for i = 1, #Config.preventStateBagAutoUpdate do
				if (key:find(Config.preventStateBagAutoUpdate[i])) then return end
			end
		end

		UpdateVehicleStateBagsInDB(id, savedVehicles[id].stateBags)

		LogDebug("    Reason: Updating entity state bag \"%s\" for \"%s\"", key, id)
	end
end)

-- forces a vehicle to update to the database
function ForceVehicleUpdateInDB(id)
	if (not id or not savedVehicles[id]) then
		return
	end

	savedVehicles[id].lastUpdate = os_time()
	UpdateVehicleInDB(id, savedVehicles[id])

	LogDebug("    Reason: Update forced for \"%s\"", id)
end
exports("ForceVehicleUpdateInDB", ForceVehicleUpdateInDB)

-- ensures a state bag is saved on the vehicle
function EnsureStateBag(vehicle, key)
	if (not DoesEntityExist(vehicle)) then return false end

	local state = Entity(vehicle).state
	if (not state[key]) then return false end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle == vehicle) then
			vehicleData.stateBags[key] = state[key]
			LogDebug("Ensuring state bag \"%s\" on vehicle \"%s\"", key, id)
			return true
		end
	end

	return false
end
exports("EnsureStateBag", EnsureStateBag)

-- returns a vehicle handle from a given state bag value
function GetVehicleFromStateBagValue(key, value)
	for id, vehicleData in pairs(savedVehicles) do
		if (TableEquals(vehicleData.stateBags[key], value)) then
			return vehicleData.handle
		end
	end

	return nil
end
exports("GetVehicleFromStateBagValue", GetVehicleFromStateBagValue)

-- returns all saved state bags from a vehicle
function GetStateBagsFromVehicle(vehicle)
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.handle == vehicle) then
			return vehicleData.stateBags
		end
	end

	return nil
end
exports("GetStateBagsFromVehicle", GetStateBagsFromVehicle)

-- returns all saved state bags from a vehicle with plate X
function GetStateBagsFromPlate(plate)
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.tuning[1] == plate) then
			return vehicleData.stateBags
		end
	end

	return nil
end
exports("GetStateBagsFromPlate", GetStateBagsFromPlate)

-- getting a vehicle position using its plate
function GetVehiclePosition(plate)
	assert(plate ~= nil and type(plate) == "string", "Parameter \"plate\" must be a string!")

	plate = plate:upper()

	local vehicles = GetAllVehicles()
	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle)) then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			if (plate == vehPlate or plate == Trim(vehPlate)) then
				return RoundVector3(GetEntityCoords(vehicle), 2)
			end
		end
	end

	for id, vehicleData in pairs(savedVehicles) do
		if (vehicleData.tuning and (plate == vehicleData.tuning[1] or plate == Trim(vehicleData.tuning[1]))) then
			return vehicleData.position
		end
	end

	return nil
end
exports("GetVehiclePosition", GetVehiclePosition)

-- getting vehicle positions using more than one plate
function GetVehiclePositions(plates)
	for i, plate in ipairs(plates) do
		assert(plate ~= nil and type(plate) == "string", "Parameter \"plates\" must only contain strings!")
		plate = plate:upper()
	end

	local platePositions = {}

	-- check all loaded vehicles first
	local vehicles = GetAllVehicles()
	for i, vehicle in ipairs(vehicles) do
		if (DoesEntityExist(vehicle)) then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			local trimmedVehPlate = Trim(vehPlate)

			for j, plate in ipairs(plates) do
				if (plate == vehPlate or plate == trimmedVehPlate) then
					platePositions[plate] = RoundVector3(GetEntityCoords(vehicle), 2)

					break
				end
			end
		end
	end

	-- then search missing vehicles in APs saved vehicles
	for i, plate in ipairs(plates) do
		if (platePositions[plate] == nil) then
			for id, vehicleData in pairs(savedVehicles) do
				local trimmedVehPlate = Trim(vehicleData.tuning[1])

				if (vehicleData.tuning and (plate == vehicleData.tuning[1] or plate == trimmedVehPlate)) then
					platePositions[plate] = vehicleData.position

					break
				end
			end
		end
	end

	return platePositions
end
exports("GetVehiclePositions", GetVehiclePositions)

-- callbacks for client side getting of vehicle position(s)
local CB = exports["kimi_callbacks"]
CB:Register("AP:getVehiclePosition", function(source, plate)
	return GetVehiclePosition(plate)
end)
CB:Register("AP:getVehiclePositions", function(source, plates)
	return GetVehiclePositions(plates)
end)

-- callback when saving only owned vehicles
if (Config.saveOnlyOwnedVehicles) then
	CB:Register("AP:isOwned", function(source, plate)
		assert(plate ~= nil and type(plate) == "string", "Parameter \"plate\" must be a string!")

		plate = plate:upper()

		local tableName = (GetResourceState("es_extended") == "started") and "owned_vehicles" or "player_vehicles"
		local results = MySQL.Sync.fetchAll(
			"SELECT `plate` " .. 
			"FROM `" .. tableName .. "` " .. 
			"WHERE `plate` = @plate OR `plate` = @trimmedPlate", {
				['@plate']			= plate,
				['@trimmedPlate']	= Trim(plate)
			}
		)

		return #results > 0
	end)
end

-- command to delete ALL vehicles from the database table. Needs to be executed twice for security reason.
local deleteSavedVehicles = false
RegisterCommand("deleteSavedVehicles", function(source, args, raw)
	if (deleteSavedVehicles) then
		MySQL.Async.execute("DELETE FROM `vehicle_parking`")

		savedVehicles = {}

		Log("Deleted all vehicles from the vehicle_parking table.")
	else
		Log("Are you sure that you want to delete all vehicles from the parking list?\nIf yes, execute the command a second time!")
	end

	deleteSavedVehicles = not deleteSavedVehicles
end, true)

-- render entity scorched (trigger with networkId of the vehicle and false when repairing)
RegisterServerEvent("AP:renderScorched", function(networkId, scorched)
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (DoesEntityExist(vehicle)) then
		TriggerClientEvent("AP:renderScorched", -1, networkId, scorched)
	end
end)



function UpdatePlate(networkId, newPlate, oldPlate)
	if (networkId == nil) then
		LogError("\"networkId\" was nil while trying to update a plate!")
		return
	end
	if (newPlate == nil or newPlate:len() > 8) then
		LogError("\"newPlate\" was nil or too long while trying to update a plate!")
		return
	end

	-- format plates
	newPlate = Trim(newPlate:upper())
	if (oldPlate) then
		oldPlate = Trim(oldPlate:upper())
	end

	-- change plate on vehicle
	local vehicle = NetworkGetEntityFromNetworkId(networkId)
	if (DoesEntityExist(vehicle)) then
		SetVehicleNumberPlateText(vehicle, newPlate)

		local found = false
		while (not found) do
			Wait(0)

			found = Trim(GetVehicleNumberPlateText(vehicle)) == newPlate
		end

		newPlate = GetVehicleNumberPlateText(vehicle)
	end

	-- search for plate
	for id, vehicleData in pairs(savedVehicles) do
		if (vehicle == vehicleData.handle) then
			local old = vehicleData.tuning[1]
			vehicleData.tuning[1] = newPlate

			UpdateVehicleInDB(id, vehicleData)

			LogDebug("    Reason: Updating plate from \"%s\" to \"%s\"", old, newPlate)

			return
		end
	end

	-- search for plate by using oldPlate
	if (oldPlate) then
		newPlate = FillPlateWithSpaces(newPlate)

		for id, vehicleData in pairs(vehicles) do
			if (Trim(vehicleData.tuning[1]) == oldPlate) then
				vehicleData.tuning[1] = newPlate

				UpdateVehicleInDB(id, vehicleData)

				LogDebug("    Reason: Updating plate from \"%s\" to \"%s\"", oldPlate, newPlate)

				return
			end
		end
	end

	LogDebug("No vehicle found to change plate to \"%s\" failed.", newPlate)
end
exports("UpdatePlate", UpdatePlate)

RegisterNetEvent("AP:updatePlate", function(networkId, newPlate)
	UpdatePlate(networkId, newPlate)
end)



if (Config.aggressiveAntiDupe) then
	CreateThread(function()
		while (true) do
			Wait(5000)

			local vehicles = GetAllVehicles()
			local platesWithVehicles = {}

			for i = 1, #vehicles do
				if (DoesEntityExist(vehicles[i]) and GetEntityRoutingBucket(vehicles[i]) == DEFAULT_BUCKET) then
					local plate = GetVehicleNumberPlateText(vehicles[i])

					if (platesWithVehicles[plate] == nil) then
						platesWithVehicles[plate] = {}
					end

					platesWithVehicles[plate][#platesWithVehicles[plate] + 1] = vehicles[i]
				end
			end

			for plate, vehicleHandles in pairs(platesWithVehicles) do
				if (#vehicleHandles > 1) then
					local id = GetVehicleIdentifierUsingPlate(plate)
					if (id) then
						DeleteVehicleUsingIdentifier(id)
					end
				end
			end
		end
	end)
end
