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
  ['East Customs'] = {
    coords = vector3(866.34, -2123.75, 30.53),
    spawn = vector4(866.34, -2123.75, 30.53, 356.38),
    distance = 5,
    job = "eastcustom",
    type = "car"
  },
  ['Pawn Shop'] = {
    coords = vector3(441.92, -1489.68, 29.3),
    spawn = vector4(441.92, -1489.68, 29.3, 106.77),
    distance = 5,
    job = "pawnshop",
    type = "car"
  },
  ['Post\'OP'] = {
    coords = vector3(1205.1, -3194.07, 6.03),
    spawn = vector4(1205.1, -3194.07, 6.03, 188.21),
    distance = 5,
    job = "postop",
    type = "car"
  },
  ['Weazel News'] = {
    coords = vector3(-525.85, -888.09, 25.03),
    spawn = vector4(-525.85, -888.09, 25.03, 138.45),
    distance = 5,
    job = "reporter",
    type = "car"
  },
  ['Au Siecle d\'or'] = {
    coords = vector3(-182.98, 318.63, 97.8),
    spawn = vector4(-182.98, 318.63, 97.8, 174.71),
    distance = 5,
    job = "au_siecle_dor",
    type = "car"
  },
  ['Yellow Jack'] = {
    coords = vector3(2008.07, 3048.46, 47.21),
    spawn = vector4(2008.07, 3048.46, 47.21, 334.22),
    distance = 5,
    job = "yellowjack",
    type = "car"
  },
  ['Malibu Club'] = {
    coords = vector3(-861.2, -1219.49, 6.02),
    spawn = vector4(-861.2, -1219.49, 6.02, 308.88),
    distance = 5,
    job = "malibu",
    type = "car"
  },
  ['Bahamas Mamas'] = {
    coords = vector3(-1378.29, -584.39, 30.05),
    spawn = vector4(-1378.29, -584.39, 30.05, 35.11),
    distance = 5,
    job = "bahamas",
    type = "car"
  },
  ['Vanilla Unicorn'] = {
    coords = vector3(136.55, -1300.99, 29.22),
    spawn = vector4(136.55, -1300.99, 29.22, 211.92),
    distance = 5,
    job = "unicorn",
    type = "car"
  },
  ['Los Santos BurgerShot'] = {
    coords = vector3(-844.03, -787.35, 20.08),
    spawn = vector4(-844.03, -787.35, 20.08, 178.57),
    distance = 5,
    job = "lsburgershot",
    type = "car"
  },
  ['Sandy Shore BurgerShot'] = {
    coords = vector3(1446.77, 3593.29, 35.81),
    spawn = vector4(1446.77, 3593.29, 35.81, 110.63),
    distance = 5,
    job = "ssburgershot",
    type = "car"
  },
  ['MC Donald'] = {
    coords = vector3(116.23, 280.8, 109.97),
    spawn = vector4(116.23, 280.8, 109.97, 67.75),
    distance = 5,
    job = "mcdonald",
    type = "car"
  },
  ['Red Line Garage'] = {
    coords = vector3(959.66, -180.11, 73.52),
    spawn = vector4(959.66, -180.11, 73.52, 234.38),
    distance = 5,
    job = "redlinegarage",
    type = "car"
  },
  ['Benny\'s Original Motor Works'] = {
    coords = vector3(-242.72, -1313.89, 31.3),
    spawn = vector4(-242.72, -1313.89, 31.3, 180.88),
    distance = 5,
    job = "bennys",
    type = "car"
  },
  ['LS Customs'] = {
    coords = vector3(-364.55, -145.55, 38.29),
    spawn = vector4(-364.55, -145.55, 38.29, 23.52),
    distance = 5,
    job = "lscustom",
    type = "car"
  },
  ['Taxi'] = {
    coords = vector3(885.24, -149.31, 69.38),
    spawn = vector4(885.24, -149.31, 69.38, 146.62),
    distance = 5,
    job = "taxi",
    type = "car"
  },
  ['Dynasty 8'] = {
    coords = vector3(-712.97, 276.39, 84.41),
    spawn = vector4(-712.97, 276.39, 84.41, 290.41),
    distance = 5,
    job = "realestate",
    type = "car"
  },
  ['Gouvernement'] = {
    coords = vector3(-1321.05, -544.61, 20.8),
    spawn = vector4(-1321.05, -544.61, 20.8, 232.72),
    distance = 5,
    job = "gouv",
    type = "car"
  },
  ['EMS'] = {
    coords = vector3(362.92, -595.68, 28.67),
    spawn = vector4(362.92, -595.68, 28.67, 333.34),
    distance = 5,
    job = "ambulance",
    type = "car"
  },
  ['LSPD'] = {
    coords = vector3(12.08, -403.5, 39.44),
    spawn = vector4(12.08, -403.5, 39.44, 344.42),
    distance = 5,
    job = "police",
    type = "car"
  },
  ['Shérif'] = {
    coords = vector3(-460.25, 6042.17, 31.34),
    spawn = vector4(-460.25, 6042.17, 31.34, 138.81),
    distance = 5,
    job = "sherif",
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
