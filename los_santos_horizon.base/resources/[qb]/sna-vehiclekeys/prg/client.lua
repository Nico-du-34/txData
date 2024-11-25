local KeyMasters = {}
local IsHotwiring = false
local Hotwired
local AlertSend = false
local usingAdvanced

local HwText
local EngShut
local HwVehicle
local HwVehiclePos
local HwVehiclePlate

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function AttemptPoliceAlert(type)
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            PoliceAlert(Lang:t('message.police', type))
        end
        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end

RegisterNetEvent('sna-vehiclekeys:client:ToggleEngine', function()
    local EngineOn = GetIsVehicleEngineRunning(GetVehiclePedIsIn(PlayerPedId()))
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

	ServerCallback('sna-vehiclekeys:server:HasKey', function(result)
        if result then
            if EngineOn then
                SetVehicleEngineOn(vehicle, false, false, true)
            else
                SetVehicleEngineOn(vehicle, true, false, true)
            end
        else
            if Hotwired == HwVehiclePlate then
                if EngineOn then
                    SetVehicleEngineOn(vehicle, false, false, true)
                else
                    SetVehicleEngineOn(vehicle, true, false, true)
                end                    
            end
        end
	end, GetPlate(vehicle))
end)

local function isBlacklistedVehicle(vehicle)
    local isBlacklisted = false
    for _,v in ipairs(Config.NoLockVehicles) do
        if GetHashKey(v) == GetEntityModel(vehicle) then
            isBlacklisted = true
            break;
        end
    end
    if Entity(vehicle).state.ignoreLocks or GetVehicleClass(vehicle) == 13 then isBlacklisted = true end
    return isBlacklisted
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

local function ToggleVehicleLocks(veh)
    if veh then
        if not isBlacklistedVehicle(veh) then
			ServerCallback('sna-vehiclekeys:server:HasKey', function(result)
				if result then
					local ped = PlayerPedId()
					local vehLockStatus = GetVehicleDoorLockStatus(veh)
	
					loadAnimDict("anim@mp_player_intmenu@key_fob@")
					TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false, false)
	
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
	
					NetworkRequestControlOfEntity(veh)
					if vehLockStatus == 1 then
						SetVehicleDoorsLocked(veh, 2)
						ShowNotification(Lang:t("message.vehicle_locked"), "success")   
					else
						SetVehicleDoorsLocked(veh, 1)
						ShowNotification(Lang:t("message.vehicle_unlocked"), "success")
					end
	
					SetVehicleLights(veh, 2)
					Wait(250)
					SetVehicleLights(veh, 1)
					Wait(200)
					SetVehicleLights(veh, 0)
					Wait(300)
					ClearPedTasks(ped)
				else
					ShowNotification(Lang:t("message.no_key"), 'error')
				end
			end, GetPlate(veh))
        else
            SetVehicleDoorsLocked(veh, 1)
        end
    end
end

local function LockpickDoor(isAdvanced)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle()

    if vehicle == nil or vehicle == 0 then return end
    --if HasKeys(QBCore.Functions.GetPlate(vehicle)) then return end
    if #(pos - GetEntityCoords(vehicle)) > 2.5 then return end
    if GetVehicleDoorLockStatus(vehicle) <= 0 then return end

    usingAdvanced = isAdvanced
    TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
end

function lockpickFinish(success)
    local vehicle = GetClosestVehicle()

    local chance = math.random()
    if success then
        GainStress(math.random(1, 4))
        
        lastPickedVehicle = vehicle

        ShowNotification(Lang:t("message.lockpicked"), 'success')
        SetVehicleDoorsLocked(vehicle, 1)

    else
        GainStress(math.random(1, 4))
        AttemptPoliceAlert("steal")
    end

    if usingAdvanced then
        if chance <= Config.RemoveLockpickAdvanced then
            TriggerServerEvent("sna-vehiclekeys:server:breakLockpick", "advancedlockpick")
        end
    else
        if chance <= Config.RemoveLockpickNormal then
            TriggerServerEvent("sna-vehiclekeys:server:breakLockpick", "lockpick")
        end
    end
end

local function Hotwire(vehicle, plate)
    local hotwireTime = math.random(Config.minHotwireTime, Config.maxHotwireTime)
    local ped = PlayerPedId()
    IsHotwiring = true

    SetVehicleAlarm(vehicle, true)
    SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
    Progressbar("hotwire_vehicle", Lang:t("message.hotwiring"), hotwireTime, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 16
    }, function() -- Done
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        GainStress(math.random(1, 4))
        if (math.random() <= Config.HotwireChance) then
			SetVehicleEngineOn(vehicle, true, false, true)
			Hotwired = plate
			IsHotwiring = false
        else
            ShowNotification(Lang:t("message.hotwiring_fail"), "error")
			Wait(Config.TimeBetweenHotwires)
			IsHotwiring = false
        end
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        IsHotwiring = false
    end)

    Wait(10000)
    AttemptPoliceAlert("steal")
end

local function GetVehicleInDirection(coordFromOffset, coordToOffset)
    local ped = PlayerPedId()
    local coordFrom = GetOffsetFromEntityInWorldCoords(ped, coordFromOffset.x, coordFromOffset.y, coordFromOffset.z)
    local coordTo = GetOffsetFromEntityInWorldCoords(ped, coordToOffset.x, coordToOffset.y, coordToOffset.z)

    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, ped, 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

-- If in vehicle returns that, otherwise tries 3 different raycasts to get the vehicle they are facing.
-- Raycasts picture: https://i.imgur.com/FRED0kV.png
local function GetVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    local RaycastOffsetTable = {
        { ['fromOffset'] = vector3(0.0, 0.0, 0.0), ['toOffset'] = vector3(0.0, 20.0, -10.0) }, -- Waist to ground 45 degree angle
        { ['fromOffset'] = vector3(0.0, 0.0, 0.7), ['toOffset'] = vector3(0.0, 10.0, -10.0) }, -- Head to ground 30 degree angle
        { ['fromOffset'] = vector3(0.0, 0.0, 0.7), ['toOffset'] = vector3(0.0, 10.0, -20.0) }, -- Head to ground 15 degree angle
    }

    local count = 0
    while vehicle == 0 and count < #RaycastOffsetTable do
        count = count + 1
        vehicle = GetVehicleInDirection(RaycastOffsetTable[count]['fromOffset'], RaycastOffsetTable[count]['toOffset'])
    end

    if not IsEntityAVehicle(vehicle) then vehicle = nil end
    return vehicle
end

RegisterKeyMapping('togglelocks', 'Toggle Vehicle Locks', 'keyboard', 'L')
RegisterCommand('togglelocks', function()
    ToggleVehicleLocks(GetVehicle())
end)

RegisterKeyMapping('engine', Lang:t("info.engine"), 'keyboard', 'G')
RegisterCommand('engine', function()
    TriggerEvent("sna-vehiclekeys:client:ToggleEngine")
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    LockpickDoor(isAdvanced)
end)

function CreateNpc()
    RequestModel(Config.KeyMasterModel)
    while not HasModelLoaded(Config.KeyMasterModel) do
        Wait(5)
    end

    for k, location in pairs(Config.KeyMasterLocations) do
        local index = #KeyMasters + 1
        KeyMasters[index] = {}
        KeyMasters[index].ped = CreatePed(4, GetHashKey(Config.KeyMasterModel), location.x, location.y, location.z, location.w, false, false)
        SetEntityAsMissionEntity(KeyMasters[index].ped, true, true)
        SetPedHearingRange(KeyMasters[index].ped, 0.0)
        SetPedSeeingRange(KeyMasters[index].ped, 0.0)
        SetPedAlertness(KeyMasters[index].ped, 0.0)
        SetPedFleeAttributes(KeyMasters[index].ped, 0, 0)
        SetBlockingOfNonTemporaryEvents(KeyMasters[index].ped, true)
        SetPedCombatAttributes(KeyMasters[index].ped, 46, true)
        SetPedFleeAttributes(KeyMasters[index].ped, 0, 0)
        --TaskStartScenarioInPlace(KeyMasters[index].ped, Scenario, 0, true)
        SetEntityInvincible(KeyMasters[index].ped, true)
        SetEntityCanBeDamaged(KeyMasters[index].ped, false)
        SetEntityProofs(KeyMasters[index].ped, true, true, true, true, true, true, 1, true)
        FreezeEntityPosition(KeyMasters[index].ped, true)
        SetEntityAsMissionEntity(KeyMasters[index].ped, true, true)

        AddTargetEntity(KeyMasters[index].ped, {
            options = {
                {
                    Type = "client",
                    event = "sna-vehiclekeys:client:GiveKeyMenu",
                    icon = "fas fa-car",
                    label = Lang:t("info.givekey"),
                    targeticon = 'fas fa-car-side' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                },
                {
                    Type = "client",
                    event = "sna-vehiclekeys:client:ResetLocksMenu",
                    icon = "fas fa-car",
                    label = Lang:t("info.resetlocks"),
                    targeticon = 'fas fa-car-side' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                }
            },
            distance = 1.0
        })
        KeyMasters[index].blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(KeyMasters[index].blip, 134)
        SetBlipColour(KeyMasters[index].blip, 3)
        --SetBlipScale(KeyMasters[index].blip, 0.8)
        SetBlipDisplay(KeyMasters[index].blip, 4)
        SetBlipAsShortRange(KeyMasters[index].blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Lang:t('info.blip'))
        EndTextCommandSetBlipName(KeyMasters[index].blip)
                
    end
end

local function DeleteNpc()
    for k, v in pairs(KeyMasters) do
        if DoesEntityExist(v.ped) then
            DeletePed(v.ped)
        end
    end
end

local function KeyMenu(type)
    local items = {}
	ServerCallback('sna-vehiclekeys:server:GetPlayerVehicles', function(vehicles)
        if vehicles then
            for k, v in pairs(vehicles) do
                local fullname = GetLabelText(GetDisplayNameFromVehicleModel(v.model))
                local price
                local event
                if type == "give" then
                    price = Config.KeyPrice
                    event = "sna-vehiclekeys:server:GiveKey"
                else
                    price = Config.ResetPrice
                    event = "sna-vehiclekeys:server:ChangeLocks"
                end
                items[#items+1] = {
                    id = k+1,
                    header = Lang:t('info.'..type..'keyitem', fullname, v.plate),
                    txt = price,
                    params = {
                        isServer = true,
                        event = event,
                        args = {
                            plate = v.plate,
                            model = fullname,
                        }
                    }
                }
            end
        end
        OpenMenu("Keymaster", Lang:t("info."..type.."keyheader"), items)
	end)	
end

-- Events
-- Backwards Compatibility ONLY -- Remove at some point --
RegisterNetEvent('qb-vehiclekeys:client:SetOwner', function(plate)
    TriggerServerEvent('sna-vehiclekeys:server:GiveTempKey', Trim(plate))
end)
-- Backwards Compatibility ONLY -- Remove at some point --

RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    TriggerServerEvent('sna-vehiclekeys:server:GiveTempKey', Trim(plate))
end)

RegisterNetEvent('sna-vehiclekeys:client:BuyVehicle', function(plate, model)
    TriggerServerEvent('sna-vehiclekeys:server:BuyVehicle', Trim(plate), GetLabelText(GetDisplayNameFromVehicleModel(model)))
end)

RegisterNetEvent('sna-vehiclekeys:client:GiveKeyMenu', function(data)
	KeyMenu("give")
end)

RegisterNetEvent('sna-vehiclekeys:client:ResetLocksMenu', function(data)
	KeyMenu("reset")
end)

-- Handlers
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        CreateNpc()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteNpc()
    end
end)

-----------------------
----   Threads     ----
-----------------------
CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            HwVehicle = GetVehiclePedIsIn(ped)
            HwVehiclePlate = GetPlate(HwVehicle)

            ServerCallback('sna-vehiclekeys:server:HasKey', function(result)
                if not result then
                    if GetPedInVehicleSeat(HwVehicle, -1) == ped and not isBlacklistedVehicle(HwVehicle) and Hotwired ~= HwVehiclePlate then
                        EngShut = true
                    else
                        EngShut = false
                    end
                    if GetPedInVehicleSeat(HwVehicle, -1) == ped and not IsHotwiring and Hotwired ~= HwVehiclePlate then
                        HwVehiclePos = GetOffsetFromEntityInWorldCoords(HwVehicle, 0.0, 1.0, 0.5)
                        HwText = true
                    else
                        HwText = false
                    end
                else
                    EngShut = false
                    HwText = false
                end
            end, HwVehiclePlate)
        else
            HwText = false
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 300

		if HwText then
			sleep = 0
			DrawText3D(HwVehiclePos.x, HwVehiclePos.y, HwVehiclePos.z, Lang:t("info.hotwire"))
			if IsControlJustPressed(0, 74) and not IsHotwiring then
				Hotwire(HwVehicle, HwVehiclePlate)
			end
		end
		if EngShut then
			sleep = 0
			SetVehicleEngineOn(HwVehicle, false, false, true)
		end
		Wait(sleep)
    end
end)

CreateThread(function()
    if Config.LockpickNPCCars then
        while true do
            local sleep = 100
            local ped = PlayerPedId()
            local entering = GetVehiclePedIsTryingToEnter(ped)
            if entering ~= 0 then
                local status = GetVehicleDoorLockStatus(entering)
                if status == 7 then
                    SetVehicleDoorsLocked(entering, 2)
                    sleep = 2000
                end
            end
            Wait(sleep)
        end
    end
end)