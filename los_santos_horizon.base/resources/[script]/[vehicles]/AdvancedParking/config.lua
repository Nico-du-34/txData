
Config = {}

-- [EXPERIMENTAL] Do not change unless you know what you are doing!
--   This changes the default routing bucket where the script will detect and spawn vehicles.
Config.routingBucket = 0

-- set this to false if you do not want entities render as scorched when they are completely broken
Config.renderScorched = true

-- this controls when a vehicle will be removed from the database table when calling the cleanup 
-- function (in hours; so 24 * 7 = one week)
Config.cleanUpThresholdTime = 24 * 7

-- set this to true if you also want the cleanup running at a certain time of day
Config.useCleanUpTask = false
-- only used when useCleanUpTask is set to true (you can define more by copy pasting one entry)
Config.cleanUpTimes = {
	{ hour = 3, minute = 0 },
}

-- Delete exploded vehicles upon cleanup
Config.cleanUpExplodedVehicles = false



-- If set to true, it will delete outside vehicles with the same plate on update
--   This is just a compatibility feature. You should still properly edit your scripts to prevent
--   duplicate vehicles in the first place.
Config.preventDuplicateVehicles = true

-- another anti dupe setting. This will aggressively delete any vehicles that have been saved by AP 
-- and another vehicle with the same plate is detected anywhere
--   Do not use this setting unless there is no other way around. I will not give any support about 
--   missing vehicles, vehicles being randomly deleted etc when this is set to true.
Config.aggressiveAntiDupe = false

-- only save vehicles that are owned (only works with ESX or QB by default)
Config.saveOnlyOwnedVehicles = false

-- set this to true to automatically store vehicles in the garage upon cleanup (only works with ESX 
-- or QB by default)
Config.storeOwnedVehiclesInGarage = false



-- comma separated list of vehicle classes that you do not want to save
-- ids can be found here: https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.classesBlacklist = {
	21 --[[Trains]],
}

-- other vehicles that you do not want to save can be inserted here (use `MODELNAME` when you put 
-- them in there)
Config.vehiclesBlacklist = {
	--`blista`,
	--`firetruk`,
	--`adder`,
}

-- any plates from vehicles you do not want to save, go here (not case sensitive and can use 
-- partial strings)
Config.platesBlacklist = {
	--"XYZ 404 ",
	--"xyz 404",
	--"mech",
}

-- ignore these state bags from being saved altogether (can include partial strings)
Config.ignoreStateBags = {}

-- prevent auto updates of these state bags and only save them on full update to database (can 
-- include partial strings)
Config.preventStateBagAutoUpdate = {}


-- Control if vehicles should be deleted automatically every X minutes (this can be useful for 
-- large servers with a lot of players and especially with a lot of (unoptimized) modded vehicles)
Config.autoDelete = {
	-- in minutes; 0 if you do not want to use it
	timer = 0,

	-- only vehicles that are more than X meters away from a player
	distance = 25.0,

	-- when the notifications should be shown before the despawning
	-- needs to be in descending order in minutes and lower than Config.deleteTimer
	notificationTimes = { 5, 3, 2, 1 },

	-- notification to show players before deleting vehicles
	-- (use %s as placeholder for time left in minutes)
	timeLeftNotification = "Vehicles will be deleted in %s minutes.",

	-- notification to show players when deleting vehicles
	deleteNotification = "Deleting vehicles..."
}
