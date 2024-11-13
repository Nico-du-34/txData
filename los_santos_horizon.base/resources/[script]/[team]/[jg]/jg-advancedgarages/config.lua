Config = {}

-- 3D Text Overlays
-- You can find a key binding control index here: https://docs.fivem.net/docs/game-references/controls/
-- The script is using control type 0 (PLAYER_CONTROL)
Config.OpenGarageKeyBind = 38
Config.OpenGaragePrompt = "[E] Garage"
Config.OpenImpoundKeyBind = 38
Config.OpenImpoundPrompt = "[E] Fourriére"
Config.InsertVehicleKeyBind = 38
Config.InsertVehiclePrompt = "[E] Rentrer le Véhicules"

-- General Config
Config.CurrencySymbol = "$"
Config.SaveVehicleDamage = true -- Setting this to false will restore the vehicles body and engine damage when putting it in a garage

-- Garages Config
Config.EnableTransfers = {
  betweenGarages = true,
  betweenPlayers = false
}
Config.GarageVehicleReturnCost = 2500
Config.GarageVehicleTransferCost = 2500
Config.GarageShowBlips = true
Config.GarageBlipId = 524
Config.GarageBlipColour = 63
Config.GarageBlipScale = 0.5
Config.GarageUniqueBlips = false
Config.GarageLocations = { -- IMPORTANT - Every garage name must be unique
  ['Parking Central'] = { -- If you change the name of this garage from Legion Square, you must change the default value of `garage_id` to the same name in the SQL table `players_vehicles`
    coords = vector3(221.58, -913.70, 29.60),
    spawn = vector4(212.84, -916.22, 29.02, 338.92),
    distance = 8,
    type = "car"
  },
  ['Parking Paleto'] = { -- If you change the name of this garage from Legion Square, you must change the default value of `garage_id` to the same name in the SQL table `players_vehicles`
    coords = vector3(-193.90, 6234.12, 31.50),
    spawn = vector4(-197.60, 6228.70, 30.89, 225.92),
    distance = 8,
    type = "car"
  },
  -- ['Islington South'] = {
  --   coords = vector3(273.0, -343.85, 44.91),
  --   spawn = vector4(270.75, -340.51, 44.92, 342.03),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Grove Street'] = {
  --   coords = vector3(14.66, -1728.52, 29.3),
  --   spawn = vector4(23.93, -1722.9, 29.3, 310.58),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Mirror Park'] = {
  --   coords = vector3(1032.84, -765.1, 58.18),
  --   spawn = vector4(1023.2, -764.27, 57.96, 319.66),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Beach'] = {
  --   coords = vector3(-1248.69, -1425.71, 4.32),
  --   spawn = vector4(-1244.27, -1422.08, 4.32, 37.12),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Great Ocean Highway'] = {
  --   coords = vector3(-2961.58, 375.93, 15.02),
  --   spawn = vector4(-2964.96, 372.07, 14.78, 86.07),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Sandy South'] = {
  --   coords = vector3(217.33, 2605.65, 46.04),
  --   spawn = vector4(216.94, 2608.44, 46.33, 14.07),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Sandy North'] = {
  --   coords = vector3(1878.44, 3760.1, 32.94),
  --   spawn = vector4(1880.14, 3757.73, 32.93, 215.54),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['North Vinewood Blvd'] = {
  --   coords = vector3(365.21, 295.65, 103.46),
  --   spawn = vector4(364.84, 289.73, 103.42, 164.23),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Grapeseed'] = {
  --   coords = vector3(1713.06, 4745.32, 41.96),
  --   spawn = vector4(1710.64, 4746.94, 41.95, 90.11),
  --   distance = 15,
  --   type = "car"
  -- },
  -- ['Paleto Bay'] = {
  --   coords = vector3(107.32, 6611.77, 31.98),
  --   spawn = vector4(110.84, 6607.82, 31.86, 265.28),
  --   distance = 15,
  --   type = "car"
  -- },
  ['Boats'] = {
    coords = vector3(-795.15, -1510.79, 1.6),
    spawn = vector4(-798.66, -1507.73, -0.47, 102.23),
    distance = 20,
    type = "sea"
  },
  ['Hangar'] = {
    coords = vector3(-1243.49, -3391.88, 13.94),
    spawn = vector4(-1258.4, -3394.56, 13.94, 328.23),
    distance = 20,
    type = "air"
  }
}

-- Private Garages
Config.PrivGarageCreateCommand = "createprivategarage"
Config.PrivGarageCreateJobRestriction = {"realestates"}

-- Job Garages
Config.JobGarageShowBlips = false
Config.JobGarageBlipId = 357
Config.JobGarageBlipColour = 0
Config.JobGarageBlipScale = 0.6
Config.JobGarageSetVehicleCommand = "setjobvehicle" -- admin only
Config.JobGarageRemoveVehicleCommand = "removejobvehicle" -- admin only
Config.JobGarageUniqueBlips = false
Config.JobGarageLocations = { -- IMPORTANT - Every garage name must be unique
  ['LSPD'] = {
    coords = vector3(12.31, -404.77, 39.44),
    spawn = vector4(13.65, -404.65, 38.93, 351.3),
    distance = 5,
    job = "police",
    type = "car"
  },
  ['SAMU'] = {
    coords = vector3(-1842.09, -320.3, 49.14),
    spawn = vector4(-1842.09, -320.3, 49.14, 70.95),
    distance = 5,
    job = "ambulance",
    type = "car"
  },
  ['Mechanic'] = {
    coords = vector3(157.86, -3005.9, 7.03),
    spawn = vector4(165.26, -3014.94, 5.9, 268.8),
    distance = 5,
    job = "mechanic",
    type = "car"
  },
  ['Brinks'] = {
    coords = vector3(-5.39, -671.05, 32.23),
    spawn = vector4(-5.39, -671.05, 32.23, 187.38),
    distance = 5,
    job = "brinks",
    type = "car"
  },
  ['Norauto'] = {
    coords = vector3(-356.72, -160.73, 38.5),
    spawn = vector4(-364.7, -147.05, 38.12, 30.24),
    distance = 5,
    job = "norauto",
    type = "car"
  }
}

-- Gang Garages
Config.GangGarageShowBlips = false
Config.GangGarageBlipId = 357
Config.GangGarageBlipColour = 0
Config.GangGarageBlipScale = 0.6
Config.GangGarageSetVehicleCommand = "setgangvehicle" -- admin only
Config.GangGarageRemoveVehicleCommand = "removegangvehicle" -- admin only
Config.GangGarageUniqueBlips = false
Config.GangGarageLocations = { -- IMPORTANT - Every garage name must be unique
  ['The Lost MC'] = {
    coords = vector3(439.18, -1518.48, 29.28),
    spawn = vector4(439.18, -1518.48, 29.28, 139.06),
    distance = 15,
    gang = "lostmc",
    type = "car"
  }
}

-- Impound
Config.ImpoundCommand = "fourriere"
Config.ImpoundJobRestriction = {"leo"}
Config.ImpoundShowBlips = true
Config.ImpoundBlipId = 317
Config.ImpoundBlipColour = 17
Config.ImpoundBlipScale = 0.7
Config.ImpoundUniqueBlips = false
Config.ImpoundLocations = { -- IMPORTANT - Every impound name must be unique
  ['Impound A'] = {
    coords = vector3(410.8, -1626.26, 29.29),
    spawn = vector4(408.44, -1630.88, 29.29, 136.88),
    distance = 15
  },
  ['Impound B'] = {
    coords = vector3(1649.71, 3789.61, 34.79),
    spawn = vector4(1643.66, 3798.36, 34.49, 216.16),
    distance = 15
  }
}

-- Staff Commands
Config.ChangeVehiclePlate = "vplate" -- admin only
Config.DeleteVehicleFromDB = "dvdb" -- admin only
