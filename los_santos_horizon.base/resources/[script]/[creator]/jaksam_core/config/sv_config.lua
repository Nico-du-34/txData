-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = false

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in cl_config.lua file
]]
function IsPlayerJobAllowed(playerId, allowedJobs)
    if(not allowedJobs) then return true end
    
    local playerJob = Framework.getPlayerJobName(playerId)
    if(not allowedJobs[playerJob]) then return false end
    if(allowedJobs[playerJob] == true) then return true end

    local playerJobGrade = tostring( Framework.getPlayerJobGrade(playerId) )
    return allowedJobs[playerJob] and allowedJobs[playerJob][playerJobGrade]
end