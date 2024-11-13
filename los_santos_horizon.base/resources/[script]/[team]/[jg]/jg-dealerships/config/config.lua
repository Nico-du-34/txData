-----------------------------------------------------------------------------------
-- WAIT! Before editing this file manually, try our new easy configuration tool! --
--               https://configurator.jgscripts.com/dealerships                  --
-----------------------------------------------------------------------------------
Config = {}

-- Localisation
Config.Locale = "fr"
Config.NumberAndDateFormat = "fr-FR"
Config.Currency = "USD"
Config.SpeedUnit = "kph" -- or "mph"

-- Framework & Integrations
Config.Framework = "QBCore" -- or "QBCore", "Qbox", "ESX"
Config.FuelSystem = "cdn-fuel" -- or "LegacyFuel", "ps-fuel", "lj-fuel", "ox_fuel", "cdn-fuel", "hyon_gas_station", "okokGasStation", "nd_fuel", "myFuel", "ti_fuel", "none"
Config.VehicleKeys = "sna-vehiclekeys" -- or "qb-vehiclekeys", "MrNewbVehicleKeys", "jaksam-vehicles-keys", "qs-vehiclekeys", "mk_vehiclekeys", "wasabi_carlock", "cd_garage", "okokGarage", "t1ger_keys", "Renewed", "none"
Config.Notifications = "default" -- or "default", "okokNotify", "ox_lib", "ps-ui"
Config.DrawText = "qb-DrawText" -- or "jg-textui", "qb-DrawText", "okokTextUI", "ox_lib", "ps-ui"

-- Text UI prompts
Config.OpenShowroomPrompt = "[E] Ouvrir Showroom"
Config.OpenShowroomKeyBind = 38
Config.ViewInShowroomPrompt = "[E] Voir Showroom"
Config.ViewInShowroomKeyBind = 38
Config.OpenManagementPrompt = "[E] Gestion de concession"
Config.OpenManagementKeyBind = 38
Config.SellVehiclePrompt = "[E] Vendre un véhicule"
Config.SellVehicleKeyBind = 38

-- If you don't know what this means, don't touch this
-- If you know what this means, I do recommend enabling it but be aware you may experience reliability issues on more populated servers
-- Having significant issues? I beg you to just set it back to false before opening a ticket with us
-- Want to read my rant about server spawned vehicles? https://docs.jgscripts.com/advanced-garages/misc/why-are-you-not-using-createvehicleserversetter-by-default
Config.SpawnVehiclesWithServerSetter = false

-- Finance (to disable finance, you have to do it on a per-location basis with Config.DealershipLocations below)
Config.FinancePayments = 12
Config.FinanceDownPayment = 0.1 -- 0.1 means 10%
Config.FinanceInterest = 0.1 -- 0.1 means 10%
Config.FinancePaymentInterval = 12 -- in hours
Config.FinancePaymentFailedHoursUntilRepo = 1 -- in hours
Config.MaxFinancedVehiclesPerPlayer = 5

-- Little vehicle preview images in the garage UI - learn more/add custom images: https://docs.jgscripts.com/advanced-garages/vehicle-images
Config.ShowVehicleImages = false

-- Vehicle purchases
Config.PlateFormat = "1AA111AA" -- https://docs.jgscripts.com/dealerships/plate-format
Config.HideVehicleStats = true

-- Test drives
Config.TestDrivePlate = "LSH2024T" -- This is a plate seed so it'll be random every time (read: https://docs.jgscripts.com/dealerships/plate-format)
Config.TestDriveTimeSeconds = 120
Config.TestDriveNotInBucket = false -- Set to true for everyone to see the test driven vehicle (player is instanced by default)

-- Display vehicles (showroom)
Config.DisplayVehiclesPlate = "LSH2024"
Config.DisplayVehiclesHidePurchasePrompt = false

-- Dealership stock purchases
Config.DealerPurchasePrice = 0.8 -- 0.8 = Dealers pay 80% of vehicle price
Config.VehicleOrderTime = 15 -- in mins

-- Vehicle colour options (for purchases & display vehicles)
Config.VehicleColourOptions = {
  {label = "Noir", hex = "#000000"},
  {label = "Blanc", hex = "#ffffff"},
  {label = "Rouge", hex = "#e81416"},
  {label = "Orange", hex = "#ff7518"},
  {label = "Jaune", hex = "#ffbf00"},
  {label = "Vert", hex = "#79c314"},
  {label = "Bleu", hex = "#487de7"},
  {label = "Violet", hex = "#70369d"},
}

Config.Categories = {
  planes = "Avions",
  sportsclassics = "Classiques sportifs",
  sedans = "Berlines",
  compacts = "Compacts",
  motorcycles = "Motos",
  super = "Super",
  offroad = "Tout-terrain",
  helicopters = "Hélicoptères",
  coupes = "Coupés",
  muscle = "Muscle",
  boats = "Bateaux",
  vans = "Fourgons",
  sports = "Sport",
  suvs = "SUVs",
  commercial = "Commercial",
  cycles = "Cycles",
  industrial = "Industriel",
  emergency = "Urgence"
}


Config.DealershipLocations = {
  ["mosley"] = {
    type = "owned", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-24.55, -1660.5, 29.49),
      size = 1
    },
    openManagement = {
      coords = vector3(-7.73, -1652.01, 29.25),
      size = 1
    },
    sellVehicle = {
      coords = vector3(-13.79, -1669.45, 29.48),
      size = 1
    },
    purchaseSpawn = vector4(-3.13, -1665.58, 28.71, 201.8),
    testDriveSpawn = vector4(-2719.48, 3269.88, 32.2, 239.42),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0, 270.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {
      "sportsclassics",
      "sedans",
      "compacts",
      "super",
      "offroad",
      "coupes",
      "muscle",
      "vans",
      "sports",
      "suvs",
      "commercial",
      "cycles",
      "industrial",
    },
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 326,
      color = 2,
      scale = 0.6
    },
    enableSellVehicle = false, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableFinance = false,
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    disableShowroomPurchase = true,
    job = "mosley", -- Owned dealerships only
    directSaleDistance = 5,
  },
  ["cardealer"] = {
    type = "owned", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-795.03, -210.41, 37.08),
      size = 1
    },
    openManagement = {
      coords = vector3(-807.55, -207.52, 37.09),
      size = 1
    },
    sellVehicle = {
      coords = vector3(-781.09, -227.87, 37.08),
      size = 1
    },
    purchaseSpawn = vector4(-775.46, -224.76, 36.51, 209.37),
    testDriveSpawn = vector4(-2719.48, 3269.88, 32.2, 239.42),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0, 270.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {
      "sportsclassics",
      "sedans",
      "compacts",
      "super",
      "offroad",
      "coupes",
      "muscle",
      "vans",
      "sports",
      "suvs",
      "commercial",
      "cycles",
      "industrial",
    },
    enableSellVehicle = false, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = false,
    hideBlip = false,
    blip = {
      id = 523,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    disableShowroomPurchase = true,
    job = "cardealer", -- Owned dealerships only
    directSaleDistance = 5,
  },
  ["exotic"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-871.93, -198.27, 37.84),
      size = 1
    },
    openManagement = {
      coords = vector3(-878.01, -196.48, 37.84),
      size = 1
    },
    sellVehicle = {
      coords = vector3(-877.68, -177.76, 37.9),
      size = 1
    },
    purchaseSpawn = vector4(-859.35, -191.14, 37.09, 209.98),
    testDriveSpawn = vector4(-2719.48, 3269.88, 32.2, 239.42),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0, 270.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {"motorcycles"},
    enableSellVehicle = false, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = false,
    hideBlip = false,
    blip = {
      id = 523,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    -- disableShowroomPurchase = true,
    -- job = "exotic", -- Owned dealerships only
    -- directSaleDistance = 5,
  },
  ["concess"] = {
    type = "owned", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-2198.91, -404.04, 14.23),
      size = 1
    },
    openManagement = {
      coords = vector3(-2217.07, -390.5, 19.76),
      size = 1
    },
    sellVehicle = {
      coords = vector3(-2212.74, -388.49, 14.23),
      size = 1
    },
    purchaseSpawn = vector4(-2207.89, -384.28, 14.22, 50.91),
    testDriveSpawn = vector4(-2719.48, 3269.88, 32.2, 239.42),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0, 270.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {
      "sportsclassics",
      "sedans",
      "compacts",
      "super",
      "offroad",
      "coupes",
      "muscle",
      "vans",
      "sports",
      "suvs",
      "commercial",
      "cycles",
      "industrial",
    },
    enableSellVehicle = false, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = true,
    hideBlip = false,
    blip = {
      id = 523,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    disableShowroomPurchase = true,
    job = "concess", -- Owned dealerships only
    directSaleDistance = 5,
  },
  ["boats"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-739.55, -1333.75, 1.6),
      size = 5
    },
    openManagement = {
      coords = vector3(-731.37, -1310.35, 5.0),
      size = 5
    },
    sellVehicle = {
      coords = vector3(-714.42, -1340.01, -0.18),
      size = 5
    },
    purchaseSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    testDriveSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    camera = {
      name = "Sea",
      coords = vector4(-808.28, -1491.19, -0.47, 113.53),
      positions = {7.5, 12.0, 15.0, 12.0}
    },
    categories = {"boats"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 410,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
  ["air"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(-1623.0, -3151.56, 13.99),
      size = 5
    },
    openManagement = {
      coords = vector3(-1637.78, -3177.94, 13.99),
      size = 5
    },
    sellVehicle = {
      coords = vector3(-1654.9, -3147.58, 13.99),
      size = 5
    },
    purchaseSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    testDriveSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    camera = {
      name = "Air",
      coords = vector4(-1267.0, -3013.14, -48.5, 310.96),
      positions = {12.0, 15.0, 20.0, 15.0}
    },
    categories = {"planes", "helicopters"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 423,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
  ["truck"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = {
      coords = vector3(1214.37, -3204.53, 6.03),
      size = 5
    },
    openManagement = {
      coords = vector3(1184.45, -3179.27, 7.1),
      size = 5
    },
    sellVehicle = {
      coords = vector3(1196.75, -3205.31, 6.0),
      size = 5
    },
    purchaseSpawn = vector4(1196.75, -3205.31, 6.0, 91.12),
    testDriveSpawn = vector4(1196.75, -3205.31, 6.0, 91.12),
    camera = {
      name = "Truck",
      coords = vector4(-1267.0, -3013.14, -48.5, 310.96),
      positions = {7.5, 12.0, 15.0, 12.0}
    },
    categories = {"vans", "commercial", "industrial"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = true,
    hideBlip = false,
    blip = {
      id = 477,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
}

-- Commands
Config.MyFinanceCommand = "myfinance"
Config.DirectSaleCommand = "directsale"
Config.DealerAdminCommand = "dealeradmin"

-- Nerd options
Config.RemoveGeneratorsAroundDealership = 60.0
Config.AutoRunSQL = true
Config.ReturnToPreviousRoutingBucket = false
Config.HideWatermark = false
Config.Debug = false