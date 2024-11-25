-- Default requirement and all credits to: https://forum.cfx.re/t/release-casino-keypad-hacking-minigame-memory-minigame/4800359 (https://github.com/ultrahacx/ultra-keypackhack)

-- the left number is the difficulty
local SETTINGS <const> = {
    [1] = { lives = 6, time = 170 },
    [2] = { lives = 3, time = 110 },
    [3] = { lives = 1, time = 60 }
}

MissionsCreator = MissionsCreator or {}
local MINIGAME_NAME <const> = "memory_game"

---@param difficulty number @The difficulty level of the minigame range 1-3
---@return boolean @true on success, false on failure
MissionsCreator.minigames[MINIGAME_NAME] = function(difficulty)
    local resName = EXTERNAL_SCRIPTS_NAMES["ultra-keypackhack"]

    if(GetResourceState(resName) ~= "started") then
        notifyClient("Check F8")
        print("^1To use the memory minigame, you need ^3ultra-keypackhack^1 to be ^2installed and started^1, you can change the script folder name in ^3integrations/sh_integrations.lua^1")
        print("^1FOLLOW THE SCRIPT INSTALLATION TUTORIAL TO FIND IT^7")
        return false
    end

    local promise = promise.new()

    TriggerEvent("ultra-keypadhack", SETTINGS[difficulty].lives, SETTINGS[difficulty].time, function(result)
        promise:resolve(result == 1) -- 1 means successful, other numbers have different reasons
    end)

    return Citizen.Await(promise)
end