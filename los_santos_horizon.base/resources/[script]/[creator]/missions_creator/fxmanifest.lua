version '1.7' -- THIS IS THE SCRIPT VERSION

author 'jaksam1074'

shared_scripts {
    "shared/shared.lua"
}

client_scripts {
    -- Callbacks
    "@jaksam_core/src/callbacks/cl_callbacks.lua",

    -- Integrations
    '@jaksam_core/config/cl_config.lua',
    '@jaksam_core/config/sh_config.lua',

    -- Miscellaneous
    "@jaksam_core/src/miscellaneous/sh_miscellaneous.lua",
    "@jaksam_core/src/miscellaneous/cl_miscellaneous.lua",

    -- Framework
    "@jaksam_core/src/framework/sh_framework.lua",
    "@jaksam_core/src/framework/cl_framework.lua",

    -- Settings
    "@jaksam_core/src/settings/cl_settings.lua",

    -- Dialogs
    "utils/dialogs/**/cl_*.lua",

    -- Police
    "@jaksam_core/src/police/cl_police.lua",

    -- Interaction points
    "@jaksam_core/src/interaction_points/cl_interaction_points.lua",

    -- Scaleforms
    "@jaksam_core/src/scaleform/cl_scaleform.lua",

    -- Locales
    "locales/*.lua",

    -- Script client files
    "client/menu.lua",
    "client/utils.lua",
    "client/missions.lua",
    "client/entities.lua",
    "client/tasks_list.lua",
    "client/tracker.lua",
    "client/tasks/*.lua",
    "client/actions/*.lua",
    "client/minigames/*.lua",
}

server_scripts {
    -- Dependency
    '@mysql-async/lib/MySQL.lua',

    -- Callbacks
    "@jaksam_core/src/callbacks/sv_callbacks.lua",
    
    -- Integrations
    '@jaksam_core/config/sv_config.lua',
    '@jaksam_core/config/sh_config.lua',

    -- Database
    "utils/database/database.lua",

    -- Miscellaneous
    "@jaksam_core/src/miscellaneous/sh_miscellaneous.lua",
    "@jaksam_core/src/miscellaneous/sv_miscellaneous.lua",

    -- Framework
    "@jaksam_core/src/framework/sh_framework.lua",
    "@jaksam_core/src/framework/sv_framework.lua",

    -- Settings
    "@jaksam_core/src/settings/sv_settings.lua",

    -- Dialogs
    "utils/dialogs/**/sv_*.lua",

    -- Police
    "@jaksam_core/src/police/sv_police.lua",

    -- Interaction points
    "@jaksam_core/src/interaction_points/sv_interaction_points.lua",

    -- Locales
    "locales/*.lua",

    -- Script server files
    "server/main.lua",
    "server/utils.lua",
    "server/templates_manager.lua",
    "server/played_missions.lua",
    "server/missions.lua",
    "server/lobby.lua",
    "server/entities.lua",
    "server/events.lua",
    "server/tracker.lua",
    "server/statistics.lua",
    "server/tasks/*.lua",
    'audio/*.*',
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/index.js',
    'html/todo_list.js',
    'html/index.css',
    'html/assets/**/*.*',
    "html/menu_translations/*.json",
    "utils/dialogs/**/*.js",
    "utils/dialogs/**/*.css",
    'audio/*.*',
}

fx_version 'cerulean' -- (This is NOT the script version)
game 'gta5'

dependencies {
    '/onesync',
    '/server:4752',
    'jaksam_core'
}

lua54 'yes' 

escrow_ignore {
    -- Locales
    "locales/*.lua",

    -- Extra files
    "client/minigames/*.lua"
}
dependency '/assetpacks'