version '2.8' -- THIS IS THE SCRIPT VERSION

author 'jaksam1074'

shared_scripts {
    "shared/shared.lua"
}

client_scripts {
    -- Callbacks
    "utils/callbacks/cl_callbacks.lua",

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/cl_miscellaneous.lua",

    -- Integrations
    'integrations/cl_*.lua',
    'integrations/sh_*.lua',    

    -- Framework
    "utils/framework/sh_framework.lua",
    "utils/framework/cl_framework.lua",

    -- Settings
    "utils/settings/cl_settings.lua",

    -- Dialogs
    "utils/dialogs/**/cl_*.lua",

    -- Police
    "utils/police/cl_police.lua",

    -- Interaction points
    "utils/interaction_points/cl_interaction_points.lua",

    -- Locales
    "locales/*.lua",

    -- Script client files
    "client/main.lua",
    "client/menu.lua",
    "client/races.lua",
    "client/race_hud.lua",
    "client/player_races.lua",
    "client/race_creation.lua",
    "client/automatic_races.lua",
    "client/arcade.lua",
    "client/chase_race.lua",
}

server_scripts {
    -- Warnings
    "utils/warnings/sv_*.lua",

    -- Dependency
    '@mysql-async/lib/MySQL.lua',

    -- Callbacks
    "utils/callbacks/sv_callbacks.lua",
    
    -- Database
    "utils/database/database.lua",

    -- Integrations
    'integrations/sv_*.lua',
    'integrations/sh_*.lua',

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/sv_miscellaneous.lua",

    -- Framework
    "utils/framework/sh_framework.lua",
    "utils/framework/sv_framework.lua",

    -- Settings
    "utils/settings/sv_settings.lua",

    -- Dialogs
    "utils/dialogs/**/sv_*.lua",

    -- Police
    "utils/police/sv_police.lua",

    -- Interaction points
    "utils/interaction_points/sv_interaction_points.lua",

    -- Locales
    "locales/*.lua",

    -- Script server files
    "server/main.lua",
    "server/menu.lua",
    "server/races.lua",
    "server/player_records.lua",
    "server/chase_race.lua",
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    "html/menu_translations/*.json",
    "utils/dialogs/**/*.js",
    "utils/dialogs/**/*.css",

    -- Leaderboard
    "html/assets/css/*.css",
    "html/assets/js/*.js",
    "html/assets/images/icons/*.png",
    "html/assets/fonts/Akrobat/*.*",
    "html/assets/fonts/Gilroy/*.*",

}

data_file 'DLC_ITYP_REQUEST' 'stream/L1_1.ytyp' 

files {
    'stream/L1_1.ytyp',
    'stream/L1_1.ydr',
}

fx_version 'cerulean' -- (This is NOT the script version)
game 'gta5'

dependencies {
    '/onesync',
    '/server:4752',
}

lua54 'yes' 

escrow_ignore {
    -- Integration files
    "integrations/*.lua",

    -- Locales
    "locales/*.lua",

    -- Extra files
}
dependency '/assetpacks'