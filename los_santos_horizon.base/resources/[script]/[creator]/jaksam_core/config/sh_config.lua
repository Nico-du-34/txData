-- Edit ONLY right side when needed. Do NOT touch left side for ANY reason
EXTERNAL_SCRIPTS_NAMES = {
    -- Main framework
    ["es_extended"] = "es_extended",
    ["qb-core"] = "qb-core",

    -- External inventories
    ["ox_inventory"] = "ox_inventory",
    ["qs-inventory"] = "qs-inventory",
    
    -- Society money management scripts
    ["esx_addonaccount"] = "esx_addonaccount",
    ["qb-management"] = "qb-management",
    ["qb-banking"] = "qb-banking",

    -- Other
    ["vehicles_keys"] = "vehicles_keys", -- jaksam's Vehicles Keys
    ["doors_creator"] = "doors_creator", -- jaksam's Doors Creator

    -- Minigames
    ["datacrack"] = "datacrack", -- Datacrack minigame, credits: https://github.com/utkuali/datacrack
    ["utk_fingerprint"] = "utk_fingerprint", -- Fingerprint minigame, credits: https://github.com/utkuali/Finger-Print-Hacking-Game
    ["ultra-keypackhack"] = "ultra-keypackhack", -- Memory minigame, credits: https://github.com/ultrahacx/ultra-keypackhack
}

-- Edit ONLY right side when needed. Do NOT touch left side for ANY reason
EXTERNAL_EVENTS_NAMES = {
    -- ESX ones
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
    ["esx_addonaccount:getSharedAccount"] = "esx_addonaccount:getSharedAccount",
}
-- Edit here your police jobs
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["sheriff"] = true,
}

-- Separator for values like $12.553.212 (default it's the dot '.')
PRICES_SEPARATOR = "."

-- The shared object of the framework will refresh each X seconds. If for any reason jobs or any framework stuff is not loading in the scripts, set a number (example, 20)
SECONDS_TO_REFRESH_SHARED_OBJECT = nil