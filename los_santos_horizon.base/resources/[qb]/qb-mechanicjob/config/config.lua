Config = {}
Config.RequireJob = true                       -- do you need a mech job to use parts?
Config.FuelResource = 'cdn-fuel'             -- supports any that has a GetFuel() and SetFuel() export

Config.PaintTime = 5                           -- how long it takes to paint a vehicle in seconds
Config.ColorFavorites = false                  -- add your own colors to the favorites menu (see bottom of const.lua)

Config.NitrousBoost = 1.8                      -- how much boost nitrous gives (want this above 1.0)
Config.NitrousUsage = 0.1                      -- how much nitrous is used per frame while holding key

-- Config.UseDistance = true                      -- enable/disable saving vehicle distance
-- Config.UseDistanceDamage = true                -- damage vehicle engine health based on vehicle distance
-- Config.UseWearableParts = true                 -- enable/disable wearable parts
-- Config.WearablePartsChance = 1                 -- chance of wearable parts being damaged while driving if enabled
-- Config.WearablePartsDamage = math.random(1, 2) -- how much wearable parts are damaged when damaged if enabled
-- Config.DamageThreshold = 25                    -- how worn a part needs to be or below to apply an effect if enabled
-- Config.WarningThreshold = 50                   -- how worn a part needs to be to show a warning color in toolbox if enabled

Config.UseDistance = true                      -- Activer le suivi de la distance
Config.UseDistanceDamage = true                -- Activer les dégâts au moteur en fonction de la distance
Config.UseWearableParts = true                 -- Activer la gestion des pièces d'usure
Config.WearablePartsChance = 75                -- Probabilité de dommages après chaque collision (50%)
Config.WearablePartsDamage = math.random(50, 150) -- Dommages modérés (entre 10 et 30 points d'usure par choc)
Config.DamageThreshold = 50                    -- Effets lorsque les pièces sont usées à 50%
Config.WarningThreshold = 80                   -- Avertissement à 80% de dégâts

-- Mètres parcourus avant d'infliger des dégâts
Config.MinimalMetersForDamage = {             
    { min = 5000,  max = 10000, damage = 10 },
    { min = 15000, max = 20000, damage = 20 },
    { min = 25000, max = 30000, damage = 30 },
}


-- Config.MinimalMetersForDamage = {              -- unused if Config.UseDistanceDamage is false
--     { min = 5000,  max = 10000, damage = 10 },
--     { min = 15000, max = 20000, damage = 20 },
--     { min = 25000, max = 30000, damage = 30 },
-- }

Config.WearableParts = { -- unused if Config.UseWearableParts is false (feel free to add/remove parts)
    radiator = { label = Lang:t('menu.radiator_repair'), maxValue = 100, repair = { steel = 2 } },
    axle = { label = Lang:t('menu.axle_repair'), maxValue = 100, repair = { aluminum = 2 } },
    brakes = { label = Lang:t('menu.brakes_repair'), maxValue = 100, repair = { copper = 2 } },
    clutch = { label = Lang:t('menu.clutch_repair'), maxValue = 100, repair = { copper = 2 } },
    fuel = { label = Lang:t('menu.fuel_repair'), maxValue = 100, repair = { plastic = 2 } },
}

Config.Shops = {
    bennys = {
        managed = true,
        shopLabel = 'Benny\'s Motorworks',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-233.92, -1328.05, 31.3),
        duty = vector3(0.0, 0.0, 0.0),
        stash = vector3(0.0, 0.0, 0.0),
        paint = vector3(-191.85, -1315.02, 31.27),
        vehicles = {
            withdraw = vector3(0, 0, 0),
            spawn = vector4(0.0, 0.0, 0.0, 0.0),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
    },
    redlinegarage = {
        managed = true,
        shopLabel = 'Red Line Garage',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-233.92, -1328.05, 31.3),
        duty = vector3(0.0, 0.0, 0.0),
        stash = vector3(0.0, 0.0, 0.0),
        paint = vector3(955.28, -189.35, 72.8),
        vehicles = {
            withdraw = vector3(0, 0, 0),
            spawn = vector4(0.0, 0.0, 0.0, 0.0),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
    },
    lscustom = {
        managed = true,
        shopLabel = 'Los Santos Customs',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-350.93, -125.0, 39.01),
        duty = vector3(0.0, 0.0, 0.0),
        stash = vector3(0.0, 0.0, 0.0),
        paint = vector3(-313.24, -143.89, 39.01),
        vehicles = {
            withdraw = vector3(0, 0, 0),
            spawn = vector4(0.0, 0.0, 0.0, 0.0),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
    },
    eastcustom = {
        managed = true,
        shopLabel = 'East Customs',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(867.29, -2112.12, 30.45),
        duty = vector3(0.0, 0.0, 0.0),
        stash = vector3(0.0, 0.0, 0.0),
        paint = vector3(888.03, -2101.4, 30.47),
        vehicles = {
            withdraw = vector3(0, 0, 0),
            spawn = vector4(0.0, 0.0, 0.0, 0.0),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
    },
}
