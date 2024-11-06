
-- returns all tuning of a vehicle
function GetVehicleTuning(vehicle)
	-- main colors
	local primaryColor, secondaryColor = GetVehicleColours(vehicle)
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

	-- custom colors
	local customPrimaryColor, customSecondaryColor
	if (GetIsVehiclePrimaryColourCustom(vehicle)) then
		local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
		customPrimaryColor = { r, g, b }
	end
	if (GetIsVehicleSecondaryColourCustom(vehicle)) then
		local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
		customSecondaryColor = { r, g, b }
	end

	-- tire smoke color
	r, g, b = GetVehicleTyreSmokeColor(vehicle)
	local tireSmokeColor = { r, g, b }

	-- neon lights color
	local r, g, b = GetVehicleNeonLightsColour(vehicle)
	local neonLightsColor = { r, g, b }
	local enabledNeonLights = {
		IsVehicleNeonLightEnabled(vehicle, 0),
		IsVehicleNeonLightEnabled(vehicle, 1),
		IsVehicleNeonLightEnabled(vehicle, 2),
		IsVehicleNeonLightEnabled(vehicle, 3),
	}

	return {
		-- 1
		GetVehicleNumberPlateText(vehicle),

		-- 2
		GetVehicleMods(vehicle),

		-- 3
		primaryColor,
		-- 4
		secondaryColor,
		-- 5
		pearlescentColor,
		-- 6
		wheelColor,
		-- 7
		customPrimaryColor,
		-- 8
		customSecondaryColor,
		-- 9
		GetVehicleInteriorColor(vehicle),
		-- 10
		GetVehicleDashboardColor(vehicle),
		-- 11
		tireSmokeColor,

		-- 12
		GetVehicleXenonLightsColour(vehicle),
		-- 13
		neonLightsColor,
		-- 14
		enabledNeonLights,

		-- 15
		GetVehicleExtras(vehicle),

		-- 16
		GetVehicleWheelType(vehicle),
		-- 17
		GetVehicleModVariation(vehicle, 23),
		-- 18
		GetVehicleModVariation(vehicle, 24),
		-- 19
		not GetVehicleTyresCanBurst(vehicle),
		-- 20
		(GetGameBuildNumber() >= 2372) and GetDriftTyresEnabled(vehicle),

		-- 21
		GetVehicleNumberPlateTextIndex(vehicle),

		-- 22
		GetVehicleWindowTint(vehicle),

		-- 23
		GetVehicleLivery(vehicle),

		-- 24
		GetVehicleRoofLivery(vehicle)
	}
end

-- apply all vehicle tuning
function SetVehicleTuning(vehicle, tuning)
	SetVehicleModKit(vehicle, 0)

	-- 16 wheelType
	SetVehicleWheelType(vehicle, tuning[16])

	-- 2 mods
	SetVehicleMods(vehicle, tuning[2], tuning[17], tuning[18])

	-- 3-4 primary/secondaryColor
	SetVehicleColours(vehicle, tuning[3], tuning[4])
	-- 5-6 pearlescent/wheelColor
	SetVehicleExtraColours(vehicle, tuning[5], tuning[6])
	-- 7 customPrimaryColor
	if (tuning[7]) then
		SetVehicleCustomPrimaryColour(vehicle, tuning[7][1], tuning[7][2], tuning[7][3])
	end
	-- 8 customSecondaryColor
	if (tuning[8]) then
		SetVehicleCustomSecondaryColour(vehicle, tuning[8][1], tuning[8][2], tuning[8][3])
	end
	-- 9 interiorColor
	SetVehicleInteriorColor(vehicle, tuning[9])
	-- 10 dashboardColor
	SetVehicleDashboardColor(vehicle, tuning[10])
	-- 11 tireSmokeColor
	SetVehicleTyreSmokeColor(vehicle, tuning[11][1], tuning[11][2], tuning[11][3])

	-- 12 xenonLightsColor
	SetVehicleXenonLightsColour(vehicle, tuning[12])
	-- 13 neonLightsColor
	SetVehicleNeonLightsColour(vehicle, tuning[13][1], tuning[13][2], tuning[13][3])
	-- 14 enabledNeonLights
	for i = 0, 3, 1 do
		SetVehicleNeonLightEnabled(vehicle, i, tuning[14][i + 1])
	end

	-- 15 extras
	SetVehicleExtras(vehicle, tuning[15])

	-- 19 bulletproofTires
	SetVehicleTyresCanBurst(vehicle, not tuning[19])
	-- 20 driftTires
	if (GetGameBuildNumber() >= 2372) then
		SetDriftTyresEnabled(vehicle, tuning[20])
	end

	-- 1 numberPlateText
	SetVehicleNumberPlateText(vehicle, tuning[1])
	-- 21 numberPlateTextIndex
	SetVehicleNumberPlateTextIndex(vehicle, tuning[21])
	-- 22 windowTint
	SetVehicleWindowTint(vehicle, tuning[22])
	-- 23 livery
	SetVehicleLivery(vehicle, tuning[23])
	-- 24 roofLivery
	SetVehicleRoofLivery(vehicle, tuning[24])
end

-- returns true if tuning was successful
function CheckTuningSuccess(vehicle, tuning, status)
	if (GetVehicleNumberPlateText(vehicle) ~= tuning[1]) then
		return false
	end

	return true
end

-- returns the status values of a vehicle
function GetVehicleStatus(vehicle)
	local fuelLevel = 65.0
	if (GetResourceState("myFuel") == "started") then
		fuelLevel = exports["myFuel"]:GetFuel(vehicle)
	elseif (GetResourceState("cdn-fuel") == "started") then
		fuelLevel = exports["cdn-fuel"]:GetFuel(vehicle)
	else
		fuelLevel = GetVehicleFuelLevel(vehicle)
	end
	fuelLevel = math.floor(fuelLevel * 10.0) / 10.0

	return {
		-- 1 entity health
		math.max(math.min(GetEntityHealth(vehicle), 1000), 0),
		-- 2 body health
		math.floor(math.max(math.min(GetVehicleBodyHealth(vehicle), 1000.0), 0.0) * 10.0) / 10.0,
		-- 3 engine health
		math.floor(math.max(math.min(GetVehicleEngineHealth(vehicle), 1000.0), -4000.0) * 10.0) / 10.0,
		-- 4 petrol tank health
		math.floor(math.max(math.min(GetVehiclePetrolTankHealth(vehicle), 1000.0), -1000.0) * 10.0) / 10.0,

		-- 5 dirt level
		math.floor(GetVehicleDirtLevel(vehicle) * 10.0) / 10.0,
		-- 6 fuel level
		fuelLevel,

		-- 7 lock status
		GetVehicleDoorLockStatus(vehicle),

		-- 8 tire states
		GetVehicleTireStates(vehicle),
		-- 9 door states
		GetVehicleDoorStates(vehicle),
		-- 10 window states
		GetVehicleWindowStates(vehicle),
	}
end
-- apply all vehicle status values
function SetVehicleStatus(vehicle, status)
	-- 1 entity health
	SetEntityHealth(vehicle, math.floor(status[1]))
	-- 2 body health
	SetVehicleBodyHealth(vehicle, status[2] * 1.0)
	-- 3 engine health
	SetVehicleEngineHealth(vehicle, status[3] * 1.0)
	-- 4 petrol tank health
	SetVehiclePetrolTankHealth(vehicle, status[4] * 1.0)

	if (Config.renderScorched and (status[3] < -3999.0 or status[4] < -999.0)) then
		TriggerServerEvent("AdvancedParking:renderScorched", NetworkGetNetworkIdFromEntity(vehicle), true)
	end

	-- 5 dirt level
	SetVehicleDirtLevel(vehicle, status[5] * 1.0)
	-- 6 fuel level
	if (GetResourceState("myFuel") == "started") then
		exports["myFuel"]:SetFuel(vehicle, status[6] * 1.0)
	elseif (GetResourceState("cdn-fuel") == "started") then
		exports["cdn-fuel"]:SetFuel(vehicle, status[6] * 1.0)
	else
		SetVehicleFuelLevel(vehicle, status[6] * 1.0)
	end

	-- 7 lock status
	SetVehicleDoorsLocked(vehicle, status[7])

	-- 8 tire states
	SetVehicleTireStates(vehicle, status[8])
	-- 9 door states
	SetVehicleDoorStates(vehicle, status[9])
	-- 10 window states
	SetVehicleWindowStates(vehicle, status[10])
end



-- returns all non-stock vehicle mods
function GetVehicleMods(vehicle)
	local mods = {}

	for i = 0, 49, 1 do
		-- TODO check for 17, 19, 21 -- toggle or normal mods? -- currently not possible
		if (i == 18 or i == 20 or i == 22) then
			if (IsToggleModOn(vehicle, i)) then
				table.insert(mods, { 
					-- 1 index
					i, 
					-- 2 isToggledOn
					true 
				})
			end
		else
			local modIndex = GetVehicleMod(vehicle, i)
			if (modIndex ~= -1) then
				table.insert(mods, { 
					-- 1 index
					i, 
					-- 2 modIndex
					modIndex 
				})
			end
		end
	end

	return mods
end
-- apply all vehicle mods
function SetVehicleMods(vehicle, mods, customFrontWheels, customRearWheels)
	for i, mod in ipairs(mods) do
		local id	= mod[1]
		local value	= mod[2]

		-- TODO check for 17, 19, 21 -- toggle or normal mods? -- currently not possible
		if (id == 18 or id == 20 or id == 22) then
			ToggleVehicleMod(vehicle, id, value)
		else
			SetVehicleMod(vehicle, id, value, (id == 24) and customRearWheels or customFrontWheels)
		end
	end
end

-- returns all vehicle extras
function GetVehicleExtras(vehicle)
	local extras = {}

	for i = 0, 20, 1 do
		if (DoesExtraExist(vehicle, i)) then
			if (IsVehicleExtraTurnedOn(vehicle, i)) then
				table.insert(extras, { 
					-- 1 index
					i, 
					-- 2 isToggledOn
					0 
				})
			else
				table.insert(extras, { 
					-- 1 index
					i, 
					-- 2 isToggledOn
					1 
				})
			end
		end
	end

	return extras
end
-- apply all vehicle extras
function SetVehicleExtras(vehicle, extras)
	for i, extra in ipairs(extras) do
		SetVehicleExtra(vehicle, extra[1], extra[2])
	end
end

-- returns all tire states
function GetVehicleTireStates(vehicle)
	local burstTires = {}

	for i = 0, 5, 1 do
		if (IsVehicleTyreBurst(vehicle, i, true)) then
			table.insert(burstTires, { 
				-- 1 index
				i, 
				-- 2 isBurst
				true 
			})
		elseif (IsVehicleTyreBurst(vehicle, i, false)) then
			table.insert(burstTires, { 
				-- 1 index
				i, 
				-- 2 isBurst
				false 
			})
		end
	end

	return burstTires
end
-- apply all tire states
function SetVehicleTireStates(vehicle, tireStates)
	for i, tireState in ipairs(tireStates) do
		SetVehicleTyreBurst(vehicle, tireState[1], tireState[2], 1000.0)
	end
end

-- returns all door states
function GetVehicleDoorStates(vehicle)
	local doorStates = {}

	for i = 0, 7, 1 do
		if (GetIsDoorValid(vehicle, i)) then
			table.insert(doorStates, {
				-- 1 index
				i,
				-- 2 missing
				IsVehicleDoorDamaged(vehicle, i),
				-- 3 angle (unused, causes problems)
				--GetVehicleDoorAngleRatio(vehicle, i)
			})
		end
	end

	return doorStates
end
-- apply all door states
function SetVehicleDoorStates(vehicle, doorStates)
	for i, doorState in ipairs(doorStates) do
		if (doorState[2]) then
			SetVehicleDoorBroken(vehicle, doorState[1], true)
		--elseif (doorState[3] > 0.0) then
		--	SetVehicleDoorControl(vehicle, doorState[1], 1000, doorState[3])
		end
	end
end

-- returns all window states
function GetVehicleWindowStates(vehicle)
	if (AreAllVehicleWindowsIntact(vehicle)) then
		return {}
	end

	local windowStates = {}

	for i = 0, 13, 1 do
		if (not IsVehicleWindowIntact(vehicle, i)) then
			table.insert(windowStates, i)
		end
	end

	return windowStates
end
-- apply all window states
function SetVehicleWindowStates(vehicle, windowStates)
	for i, windowState in ipairs(windowStates) do
		SmashVehicleWindow(vehicle, windowState)
	end
end



-- returns true if vehicle is blacklisted and should not be saved
function IsVehicleBlacklisted(vehicle)
	-- check class
	local class = GetVehicleClass(vehicle)
	for i, blacklisted in ipairs(Config.classesBlacklist) do
		if (class == blacklisted) then
			return true
		end
	end

	-- check model
	local modelHash = GetEntityModel(vehicle)
	for i, blacklisted in ipairs(Config.vehiclesBlacklist) do
		if (modelHash == blacklisted) then
			return true
		end
	end

	-- check plate
	local plate = GetVehicleNumberPlateText(vehicle)
	for i, blacklisted in ipairs(Config.platesBlacklist) do
		if (plate:find(blacklisted:upper())) then
			return true
		end
	end

	-- check ownership with ESX or QB
	if (Config.saveOnlyOwnedVehicles and not exports["kimi_callbacks"]:Trigger("AP:isOwned", plate)) then
		return true
	end

	return false
end
