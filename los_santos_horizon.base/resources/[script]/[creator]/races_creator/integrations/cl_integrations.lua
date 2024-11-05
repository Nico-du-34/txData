EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

INTERACTION_POINTS_REFRESH = 1000

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

-- How many seconds the blip for police alerts will remain in the map
BLIP_TIME_AFTER_POLICE_ALERT = 120

-- How long the user has to keep pressed the restart to checkpoint button
LAST_CHECKPOINT_BUTTON_SECONDS = 1.5

-- When you change a key here, you'll have to edit the translation file as well
KEYS = {
    INTERACT = 38, -- Key used to interact (example "join the race")
    SOLO_RACE = 73, -- Key to start solo race (default X - 47)
    FIRST_OPTION = 157, -- Key for a first option (default 1 - 157)
    SECOND_OPTION = 158, -- Key for a second option (default 2 - 158)
    THIRD_OPTION = 160, -- Key for a third option (default 3 - 160)
    FOURTH_OPTION = 164, -- Key for a fourth option (default 4 - 164)
    FIFTH_OPTION = 165, -- Key for a fifth option (default 5 - 165)
    PREVIOUS_RACE = 174, -- Key for previous race (default left arrow - 174)
    NEXT_RACE = 175, -- Key for next race (default right arrow - 175)
    EXIT = 200, -- Key to exit (default esc - 200)
    CONFIRM = 176, -- Key to confirm (default enter - 176)
    INVITE = 76, -- Key to invite (default spacebar - 76)
    DELETE = 194, -- Key to delete player race (default backspace - 194)
    RESTART = 20, -- Key to restart
}

-- Duration in seconds of the effects in arcade mode
ARCADE_EFFECTS_DURATION = {
    tyreBurst = 5,
    speedBoost = 10,
    slower = 5,
    randomSteerings = 10,
    blindness = 5,
    noCollisions = 15,
    lowGravity = 5,
    visualShaking = 10,
    invertedControls = 15,
    disableBrakes = 8,
}

-- Here you can define your own vehicles classes by following the example
CUSTOM_VEHICLES_CLASSES = {

    ["off_road_sanchez"] = {
        label = "Off-road & sanchez",
        vehicles = {
            [ GetHashKey("sanchez") ] = true,
            [ GetHashKey("sanchez2") ] = true,
        },
        standardClasses = { -- Standard classes IDs can be found here: https://wiki.gtanet.work/index.php?title=Vehicle_Classes
            ["9"] = true, -- Off-road
        }
    },

    ["monster_trucks"] = {
        label = "Monster trucks",
        vehicles = {
            [ GetHashKey("monster") ] = true,
            [ GetHashKey("marshall") ] = true,
            [ GetHashKey("monster3") ] = true,
            [ GetHashKey("monster4") ] = true,
            [ GetHashKey("monster5") ] = true,
        },
        standardClasses = { -- Standard classes IDs can be found here: https://wiki.gtanet.work/index.php?title=Vehicle_Classes
            
        }
    },
}


--[[
    Default progressbar color (must be a hex code). Examples:
    "#0fffef" - Light blue
    "#ff0f0f" - Red
    "#0f0fff" - Blue
]]
DEFAULT_PROGRESSBAR_COLOR = "#ff7300"