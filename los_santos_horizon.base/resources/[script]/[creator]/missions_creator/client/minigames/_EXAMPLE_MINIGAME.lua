-- Copy paste this file and remove the initial and final comments

--[[

MissionsCreator = MissionsCreator or {}
local MINIGAME_NAME <const> = "YOUR_MINIGAME_NAME"

---@param difficulty number @The difficulty level of the minigame range 1-3
---@return boolean @true on success, false on failure
MissionsCreator.minigames[MINIGAME_NAME] = function(difficulty)
    local resName = "MINIGAME_FOLDER_NAME"
    
    -- Just an example, the important part is to return true on success, false on failure
    local promise = promise.new()

    TriggerEvent("datacrack:start", difficulty+1, function(result)
        promise:resolve(result)
    end)

    return Citizen.Await(promise)
end

--]]