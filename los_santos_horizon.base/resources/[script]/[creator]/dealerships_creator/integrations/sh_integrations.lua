--[[
    If you have a different script name for the following ones, change it to your one
    Example:

    EXTERNAL_SCRIPTS_NAMES = {
        ["es_extended"] = "mygamemode_extended",
    }
]]

EXTERNAL_SCRIPTS_NAMES = {
    -- Main frameworks
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
    ["doors_creator"] = "doors_creator", -- Only doors creator is supported
    ["vehicles_keys"] = "vehicles_keys" -- jaksam's vehicles keys
}

--[[
    Change it to a plate you want to automatically create random plates the way you prefer

    Examples of random plates with EXAMPLE_PLATE = "CX521YD"
        - XC111EW
        - SI849TW
    Examples of random plates with EXAMPLE_PLATE = "CBZ 629"
        - EGP 015
        - VHS 687
    Examples of random plates with EXAMPLE_PLATE = "72 QT 15"
        - 63 VD 85
        - 27 AC 66
]]
EXAMPLE_PLATE = "1AB234CD"

-- Edit here your police jobs
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["sheriff"] = true,
}

-- Separator for values like $12.553.212 (default it's the dot '.')
PRICES_SEPARATOR = "."

--[[
    The shared object of the framework will refresh each X seconds. If for any reason you don't want it to refresh, set to nil
]] 
SECONDS_TO_REFRESH_SHARED_OBJECT = nil