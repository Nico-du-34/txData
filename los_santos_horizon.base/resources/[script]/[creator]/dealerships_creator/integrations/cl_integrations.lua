EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

INTERACTION_POINTS_REFRESH = 500

--[[
    You can define the images folder here, for example you can use your inventory images folder. Note, the images MUST be .webp
]]
IMAGES_PATH = "nui://dealerships_creator/_vehicles_images"

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is down to you)
    If you edit this, you WILL have also to edit the function in sv_integrations.lua file
]]
function isJobAllowed(allowedJobs)
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

-- How many seconds the blip for police alerts will remain in the map
BLIP_TIME_AFTER_POLICE_ALERT = 120