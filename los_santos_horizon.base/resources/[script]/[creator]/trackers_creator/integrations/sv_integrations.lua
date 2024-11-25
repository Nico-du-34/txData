-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in cl_integrations.lua file
]]
function isPlayerAllowedForJobs(playerId, allowedJobs)
    if(not allowedJobs) then return true end
    
    local playerJob = Framework.getPlayerJobName(playerId)

    if(allowedJobs[playerJob] == true) then
        return true
    elseif(allowedJobs[playerJob]) then
        local playerJobGrade = tostring( Framework.getPlayerJobGrade(playerId) )

        return allowedJobs[playerJob] and allowedJobs[playerJob][playerJobGrade]
    else
        return false
    end
end

-- Used if you enable the detailed blips sprites, when a player will be in a vehicle, the blip sprite will be the one defined here
DETAILED_BLIP_SPRITES = {
    ["car"] = 225,
    ["heli"] = 43,
    ["boat"] = 427,
    ["plane"] = 307,
}

-- If true, the script will use all the times the isPlayerAllowedForJobs defined above, in any case
FORCE_USE_OF_CUSTOM_PLAYER_ALLOWED_JOBS_FUNCTION = false

-- If true, the script will use a more expensive way to get the player character name
FORCE_USE_OF_CUSTOM_GET_PLAYER_CHARACTER_NAME_FUNCTION = false

-- If true, the script will use a more expensive way to know if a player has an item or not
FORCE_USE_OF_CUSTOM_ITEM_CHECK_FUNCTION = false

-- If true, the script will use a more expensive way to get the player identifier
FORCE_USE_OF_CUSTOM_PLAYER_IDENTIFIER_FUNCTION = false