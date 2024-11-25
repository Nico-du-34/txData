--[[local isInFront = false

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

RegisterNetEvent('vehiclepush:client:push', function(veh)
    if veh then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehPos = GetEntityCoords(veh)
        local dimension = GetModelDimensions(GetEntityModel(veh))
        local vehClass = GetVehicleClass(veh)
        if not IsEntityAttachedToEntity(ped, veh) and IsVehicleSeatFree(veh, -1) and GetVehicleEngineHealth(veh) <= Config.DamageNeeded and GetVehicleEngineHealth(veh) >= 0 then
            if vehClass ~= 13 or vehClass ~= 14 or vehClass ~= 15 or vehClass ~= 16 then
                NetworkRequestControlOfEntity(veh)
                if #(pos - vehPos) < 3.0 and not IsPedInAnyVehicle(ped, false) then
                    if #(vehPos + GetEntityForwardVector(veh) - pos) > #(vehPos + GetEntityForwardVector(veh) * -1 - pos) then
                        isInFront = false
                        AttachEntityToEntity(ped, veh, GetPedBoneIndex(ped, 6286), 0.0, dimension.y - 0.3, dimension.z + 1.0, 0.0, 0.0, 0.0, false, false, false, true, 0, true)
                    else
                        isInFront = true
                        AttachEntityToEntity(ped, veh, GetPedBoneIndex(ped, 6286), 0.0, dimension.y * -1 + 0.1, dimension.z + 1.0, 0.0, 0.0, 180.0, false, false, false, true, 0, true)
                    end
                    loadAnimDict('missfinale_c2ig_11')
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, false, false, false)
                    exports['qb-core']:DrawText(Lang:t('pushcar.stop_push'),'left')
                    while true do
                        Wait(0)
                        if IsDisabledControlPressed(0, 34) then
                            TaskVehicleTempAction(ped, veh, 11, 1000)
                        end

                        if IsDisabledControlPressed(0, 9) then
                            TaskVehicleTempAction(ped, veh, 10, 1000)
                        end

                        SetVehicleForwardSpeed(veh, isInFront and -1.0 or 1.0)

                        if HasEntityCollidedWithAnything(veh) then
                            SetVehicleOnGroundProperly(veh)
                        end

                        if IsControlJustPressed(0, 38) then
                            exports['qb-core']:HideText()
                            DetachEntity(ped, false, false)
                            StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                            FreezeEntityPosition(ped, false)
                            break
                        end
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    exports['qb-target']:AddTargetBone({'bonnet', 'boot'}, {
        options = {
            {
                icon = 'fas fa-wrench',
                label = 'Push Vehicle',
                action = function(entity)
                    TriggerEvent('vehiclepush:client:push', entity)
                end,
                distance = 1.3
            }
        }
    })
end)]]

local AttachEntityToEntity = AttachEntityToEntity
local GetEntityCoords = GetEntityCoords
local GetEntityModel = GetEntityModel
local GetVehicleEngineHealth = GetVehicleEngineHealth
local GetModelDimensions = GetModelDimensions
local GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords
local GetControlInstructionalButton = GetControlInstructionalButton
local NetworkGetEntityOwner = NetworkGetEntityOwner
local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId
local NetworkGetNetworkIdFromEntity = NetworkGetNetworkIdFromEntity
local SetVehicleForwardSpeed = SetVehicleForwardSpeed
local SetVehicleEngineOn = SetVehicleEngineOn
local SetVehicleBrake = SetVehicleBrake
local SetVehicleSteeringAngle = SetVehicleSteeringAngle
local DisableControlAction = DisableControlAction
local IsDisabledControlPressed = IsDisabledControlPressed
local TaskVehicleTempAction = TaskVehicleTempAction
local TaskPlayAnim = TaskPlayAnim
local IsEntityUpsidedown = IsEntityUpsidedown
local IsEntityAttachedToAnyVehicle = IsEntityAttachedToAnyVehicle
local IsEntityInAir = IsEntityInAir
local ped = cache.ped
local playerId = cache.playerId
local seat = cache.seat
local pushing, remotepush = false, false
local vehiclepushing, keybind = nil, nil
local uiThreadRunning = false
local uiOpen = false

if Config.TextUI then
    if not Config.target then
        uiOpen = false
        local function uiThread()
            if uiThreadRunning then return end
            uiThreadRunning = true
            while uiThreadRunning do
                local sleep = 200
                if pushing then
                    sleep = 500
                    if uiOpen then
                        lib.hideTextUI()
                        uiOpen = false
                    end
                else
                    local coords = GetEntityCoords(ped)
                    local vehicle = lib.getClosestVehicle(coords, 5.0, false)
                    if not vehicle then
                        if uiOpen then
                            lib.hideTextUI()
                            uiOpen = false
                        end
                    else
                        local model = GetEntityModel(vehicle)
                        if Config.blacklist[model] then
                            if uiOpen then
                                lib.hideTextUI()
                                uiOpen = false
                            end
                        else
                            local health = GetVehicleEngineHealth(vehicle) <= Config.healthMin and true or false
                            if health then
                                local flipped = IsEntityUpsidedown(vehicle) and true or false
                                if not flipped then
                                    local min, max = GetModelDimensions(model)
                                    local size = max - min
                                    local bonnet = #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (size.y / 2), 0.0)) < 1.45 and true or false
                                    local trunk = #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (-size.y / 2), 0.0)) < 1.45 and true or false
                                    if trunk or bonnet then
                                        if not uiOpen then
                                            lib.showTextUI(string.format('Press [%s] Pour pousser le véhicule', GetControlInstructionalButton(0, joaat('+' .. keybind.name) | 0x80000000, true):sub(3)))
                                            uiOpen = true
                                        end
                                    else
                                        if uiOpen then
                                            lib.hideTextUI()
                                            uiOpen = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                Wait(sleep)
            end
            if uiOpen then
                lib.hideTextUI()
                uiOpen = false
            end
        end
        CreateThread(uiThread)

        lib.onCache('vehicle', function(value)
            if value then
                uiThreadRunning = false
            else
                CreateThread(uiThread)
            end
        end)
    end
end

local function startTurn(netid, direction)
    if direction ~= 'left' and direction ~= 'right' then return end
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    SetVehicleSteeringAngle(vehicle, direction == 'left' and 30.0 or direction == 'right' and -30.0)
end
RegisterNetEvent('OT_pushvehicle:startTurn', startTurn)

local function stopTurn(netid)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    SetVehicleSteeringAngle(vehicle, 0.0)
end
RegisterNetEvent('OT_pushvehicle:stopTurn', stopTurn)

local function startMove(netid, direction, pedid)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    local remoteped = NetworkGetEntityFromNetworkId(pedid)
    remotepush = true
    while remotepush do
        Wait(0)
        if IsEntityInAir(vehicle) or IsEntityUpsidedown(vehicle) or IsEntityAttachedToAnyVehicle(remoteped) == false then
            remotepush = false
            return TriggerServerEvent('OT_pushvehicle:detach', netid)
        end
        local owner = NetworkGetEntityOwner(vehicle)
        if owner ~= playerId then
            remotepush = false
            return TriggerServerEvent('OT_pushvehicle:updateOwner', netid, direction)
        end
        SetVehicleEngineOn(vehicle, false, true, true)
        SetVehicleBrake(vehicle, false)
        SetVehicleForwardSpeed(vehicle, direction == 'trunk' and 1.1 or -1.1)
        if owner == playerId and seat == -1 then
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 35, true)
            if IsDisabledControlPressed(0, 34) then
                TaskVehicleTempAction(ped, vehicle, 11, 1000)
            elseif IsDisabledControlPressed(0, 35) then
                TaskVehicleTempAction(ped, vehicle, 10, 1000)
            end
        end
    end
end
RegisterNetEvent('OT_pushvehicle:startMove', startMove)

local function stopMove()
    remotepush = false
end
RegisterNetEvent('OT_pushvehicle:stopMove', stopMove)

local function GetNetworkIdFromEntity(vehicle)
    if not DoesEntityExist(vehicle) then
        return nil
    end

    if not NetworkGetEntityIsNetworked(vehicle) then
        return nil
    end

    return NetworkGetNetworkIdFromEntity(vehicle)
end

local function startPushing(vehicle)
    if LocalPlayer.state.intrunk then return end
    local health = GetVehicleEngineHealth(vehicle) <= Config.healthMin and true or false
    if not health then return end
    local flipped = IsEntityUpsidedown(vehicle) and true or false
    if flipped then return end
    local min, max = GetModelDimensions(GetEntityModel(vehicle))
    local size = max - min
    local coords = GetEntityCoords(ped)
    local closest = #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (size.y / 2), 0.0)) < #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (-size.y / 2), 0.0)) and 'bonnet' or #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (size.y / 2), 0.0)) > #(coords - GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (-size.y / 2), 0.0)) and 'trunk'
    local veh = GetNetworkIdFromEntity(vehicle)
    if veh == nil then return end
    local start = lib.callback.await('OT_pushvehicle:startPushing', 500, veh, closest)
    if start then
        vehiclepushing = vehicle
        pushing = true
        AttachEntityToEntity(ped, vehicle, 0, 0.0, closest == 'trunk' and min.y - 0.6 or -min.y + 0.4, closest == 'trunk' and min.z + 1.1 or max.z / 2, 0.0, 0.0, closest == 'trunk' and 0.0 or 180.0, 0.0, false, false, true, 0, true)
        lib.requestAnimDict('missfinale_c2ig_11')
        TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 1.5, 1.5, -1, 35, 0, false, false, false)
    end
end

local function stopPushing()
    TriggerServerEvent('OT_pushvehicle:stopPushing', NetworkGetNetworkIdFromEntity(vehiclepushing))
    vehiclepushing = nil
    pushing = false
    DetachEntity(ped, true, false)
    ClearPedTasks(ped)
end
RegisterNetEvent('OT_pushvehicle:detach', stopPushing)

keybind = lib.addKeybind({
    name = 'pushvehicle',
    description = 'Pousser le véhicule en panne',
    defaultKey = Config.PushKey,
    onPressed = function(self)
        if Config.target then return end
        if pushing then return end
        local vehicle = lib.getClosestVehicle(GetEntityCoords(ped), 4, false)
        if not vehicle or not NetworkGetEntityIsNetworked(vehicle) then return end
        startPushing(vehicle)
    end,
    onReleased = function(self)
        if Config.target then return end
        if not vehiclepushing then return end
        stopPushing()
    end
})

lib.addKeybind({
    name = 'pushvehicle_left',
    description = 'Tourner à gauche',
    defaultKey = Config.TurnLeftKey,
    onPressed = function(self)
        if not pushing then return end
	if LocalPlayer.state.intrunk then return end
        TriggerServerEvent('OT_pushvehicle:startTurn', NetworkGetNetworkIdFromEntity(vehiclepushing), 'left')
    end,
    onReleased = function(self)
        if not pushing then return end
        TriggerServerEvent('OT_pushvehicle:stopTurn', NetworkGetNetworkIdFromEntity(vehiclepushing))
    end
})

lib.addKeybind({
    name = 'pushvehicle_right',
    description = 'Tournez à droite',
    defaultKey = Config.TurnRightKey,
    onPressed = function(self)
        if not pushing then return end
	if LocalPlayer.state.intrunk then return end
        TriggerServerEvent('OT_pushvehicle:startTurn', NetworkGetNetworkIdFromEntity(vehiclepushing), 'right')
    end,
    onReleased = function(self)
        if not pushing then return end
        TriggerServerEvent('OT_pushvehicle:stopTurn', NetworkGetNetworkIdFromEntity(vehiclepushing))
    end
})

if Config.target then
	local options = {
		{
			name = 'startPushing',
			icon = "fa-solid fa-truck-arrow-right",
			label = 'Pousser le Véhicule',
			onSelect = function(data)
				startPushing(data.entity)
			end,
			action = function(entity)
				startPushing(entity)
			end,
			canInteract = function(entity)
		if LocalPlayer.state.intrunk then return false end
                if pushing then return false end
                local health = GetVehicleEngineHealth(entity) <= Config.healthMin and true or false
                if not health then return false end
                local flipped = IsEntityUpsidedown(entity) and true or false
                if flipped then return false end
				return true
			end
		},
        {
			name = 'stopPushing',
			label = 'Arrêtez de pousser',
			onSelect = function(data)
				stopPushing()
			end,
			action = function(entity)
				stopPushing()
			end,
			canInteract = function(entity)
                if not pushing then return false end
				return true
			end
		}
	}
	local targetSystem = string.lower(Config.targetSystem)
	if targetSystem == 'qtarget' then
		if Config.Usebones then
			exports[targetSystem]:AddTargetBone({'boot', 'bonnet'}, {
				options = options,
				distance = 3
			})
		else
			exports[targetSystem]:Vehicle({
				options = options,
				distance = 3
			})
		end
	elseif targetSystem == 'ox_target' then
		if Config.Usebones then
			for i = 1, #options do
				options[i].bones = { 'bonnet', 'boot' }
			end
			exports[targetSystem]:addGlobalVehicle(options)
		else
			exports[targetSystem]:addGlobalVehicle(options)
		end
	elseif targetSystem == 'qb-target' then
		if Config.Usebones then
			exports[targetSystem]:AddTargetBone({'boot', 'bonnet'}, {
				options = options,
				distance = 3
			})
		else
			exports[targetSystem]:AddGlobalVehicle({
				options = options,
				distance = 3
			})
		end
	end
end

lib.onCache('ped', function(value)
    ped = value
end)

lib.onCache('seat', function(value)
    seat = value
end)