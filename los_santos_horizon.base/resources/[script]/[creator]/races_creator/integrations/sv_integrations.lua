-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = false

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

-- Distance tolerance when doing server side check about the current player distance with the checkpoint
-- Increase in case it happens that a checkpoint it's not "passed" when going too fast
DISTANCE_TOLERANCE = 30.0