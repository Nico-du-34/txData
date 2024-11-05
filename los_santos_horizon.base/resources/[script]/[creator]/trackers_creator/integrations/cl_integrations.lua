EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in sv_integrations.lua file
]]
function isAllowedForJobs(allowedJobs)
    if(not allowedJobs) then return true end

    local playerJob = Framework.getPlayerJob()

    if(allowedJobs[playerJob] == true) then
        return true
    elseif(allowedJobs[playerJob]) then
        local playerJobGrade = tostring( Framework.getPlayerJobGrade() )

        return allowedJobs[playerJob] and allowedJobs[playerJob][playerJobGrade]
    else
        return false
    end
end

-- Key that can be pressed to set the waypoint to the signal lost (default 74 = H)
SIGNAL_LOST_WAYPOINT_KEY = 74

-- How many seconds does the player have to set the waypoint to the signal lost
SECONDS_TO_SET_WAYPOINT_AFTER_SIGNAL_LOST = 5

-- Can players see their own blip
ALLOW_BLIP_ON_SELF = false