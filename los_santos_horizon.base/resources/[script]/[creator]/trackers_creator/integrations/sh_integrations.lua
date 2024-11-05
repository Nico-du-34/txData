--[[
    If you have a different script name for the following ones, change it to your one
    Example:

    EXTERNAL_SCRIPTS_NAMES = {
        ["es_extended"] = "mygamemode_extended",
    }
]]

EXTERNAL_SCRIPTS_NAMES = {
    ["es_extended"] = "es_extended",
    ["qb-core"] = "qb-core",

    -- If you don't use these inventories, don't touch
    ["ox_inventory"] = "ox_inventory",
    ["qs-inventory"] = "qs-inventory",
}

--[[
    The shared object of the framework will refresh each X seconds. If for any reason you don't want it to refresh, set to nil
]] 
SECONDS_TO_REFRESH_SHARED_OBJECT = nil

--[[
    Available options: default, qs-inventory, ox-inventory      (they MUST be between double quotes "")
]]
INVENTORY_TO_USE = "default"
