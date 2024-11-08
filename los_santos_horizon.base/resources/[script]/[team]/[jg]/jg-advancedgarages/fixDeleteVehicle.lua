
if (GetCurrentResourceName() == "AdvancedParking") then
	print([[
		Please check the installation documentation for AdvancedParking at https://docs.kiminaze.de on how to use this file.
		Do not start this file inside AdvancedParking itself!
	]])
	return
end

-- replaces DeleteEntity native on client and server side
local DeleteEntityOriginal = DeleteEntity
DeleteEntity = function(entity)
	if (not DoesEntityExist(entity)) then return end

	if (GetEntityType(entity) ~= 2) then
		DeleteEntityOriginal(entity)
		return
	end

	exports["AdvancedParking"]:DeleteVehicle(entity)
end

-- replaces DeleteVehicle native on client side
if (not IsDuplicityVersion()) then
	DeleteVehicle = function(vehicle)
		exports["AdvancedParking"]:DeleteVehicle(vehicle)
	end
end
