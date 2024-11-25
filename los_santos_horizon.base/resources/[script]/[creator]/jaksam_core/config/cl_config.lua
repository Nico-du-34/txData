

-- How many milliseconds the interaction points will be refreshed (higher time = slower but better performance)
INTERACTION_POINTS_REFRESH = 500

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in sv_config.lua file
]]
function isJobAllowed(allowedJobs)
    if(not allowedJobs) then return true end

    local playerJob = Framework.getPlayerJob()
    if(not allowedJobs[playerJob]) then return false end

    if(allowedJobs[playerJob] == true) then return true end

    local playerJobGrade = tostring( Framework.getPlayerJobGrade() )
    return allowedJobs[playerJob] and allowedJobs[playerJob][playerJobGrade]
end

-- How many seconds the blip for police alerts will remain in the map
BLIP_TIME_AFTER_POLICE_ALERT = 120