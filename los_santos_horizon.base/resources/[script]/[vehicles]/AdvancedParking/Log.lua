
-- enable/disable different levels off logging to console
local LEVEL = {
	INFO	= true,
	WARNING	= true,
	ERROR	= true,
	DEBUG	= false
}

function Log(text, ...)
	if (LEVEL.INFO) then
		print(string.format(string.format("^5[INFO] %s^0", text), ...))
	end
end

function LogWarning(text, ...)
	if (LEVEL.WARNING) then
		print(string.format(string.format("^3[WARNING] %s^0", text), ...))
	end
end

function LogError(text, ...)
	if (LEVEL.ERROR) then
		print(string.format(string.format("^1[ERROR] %s^0", text), ...))
	end
end

function LogDebug(text, ...)
	if (LEVEL.DEBUG) then
		print(string.format(string.format("^0[DEBUG] %s^0", text), ...))
	end
end

local resName = GetCurrentResourceName()
if (IsDuplicityVersion()) then
	RegisterCommand(resName .. ":log", function(source, args, raw)
		if (#args <= 0 or type(args[1]) ~= "string") then
			print("Add a valid log level as an argument.")
			return
		end

		local lvl = args[1]:upper()
		if (LEVEL[lvl] == nil) then
			print("Log level " .. lvl .. " does not exist.")
			return
		end

		LEVEL[lvl] = not LEVEL[lvl]

		print("Log level " .. lvl .. " toggled to " .. tostring(LEVEL[lvl]))

		TriggerClientEvent(resName .. ":log", -1, lvl, LEVEL[lvl])
	end, true)
else
	RegisterNetEvent(resName .. ":log", function(lvl, value)
		LEVEL[lvl] = value
	end)
end
