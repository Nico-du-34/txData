MissionsCreator = MissionsCreator or {}
local MINIGAME_NAME <const> = "datacrack"

---@param difficulty number @The difficulty level of the minigame range 1-3
---@return boolean @true on success, false on failure
MissionsCreator.minigames[MINIGAME_NAME] = function(difficulty)
    local resName = EXTERNAL_SCRIPTS_NAMES["datacrack"]
    
    if(GetResourceState(resName) ~= "started") then
        notifyClient("Check F8")
        print("^1To use the '" .. MINIGAME_NAME .. "' minigame, you need to ^2install and start it properly^1, you can change the script folder name in ^3integrations/sh_integrations.lua^1")
        print("^1FOLLOW THE SCRIPT INSTALLATION TUTORIAL TO FIND IT^7")
        return false
    end

    local promise = promise.new()

    TriggerEvent("datacrack:start", difficulty+1, function(result)
        promise:resolve(result)
    end)

    return Citizen.Await(promise)
end