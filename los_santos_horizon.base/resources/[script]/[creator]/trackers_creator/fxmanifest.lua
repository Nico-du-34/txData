version '1.8' -- THIS IS THE SCRIPT VERSION

author 'jaksam1074'

client_scripts {
    -- Callbacks
    "utils/callbacks/cl_callbacks.lua",

    -- Integrations
    'integrations/cl_*.lua',
    'integrations/sh_*.lua',

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/cl_miscellaneous.lua",

    -- Framework
    "utils/framework/sh_framework.lua",
    "utils/framework/cl_framework.lua",

    -- Settings
    "utils/settings/cl_settings.lua",

    -- Dialogs
    "utils/dialogs/**/cl_*.lua",

    -- Locales
    "locales/*.lua",

    -- Script client files
    "client/main.lua",
    "client/menu.lua",
    "client/trackers.lua",
    "client/private_trackers.lua",
}

server_scripts {
    -- Warnings
    "utils/warnings/sv_*.lua",

    -- Dependency
    '@mysql-async/lib/MySQL.lua',

    -- Callbacks
    "utils/callbacks/sv_callbacks.lua",

    -- Integrations
    'integrations/sv_*.lua',
    'integrations/sh_*.lua',
    
    -- Database
    "utils/database/database.lua",

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

    -- Locales
    "locales/*.lua",

    -- Script server files
    "server/main.lua",
    "server/menu.lua",
    "server/trackers.lua",
    "server/items.lua",
    "server/jobs.lua",
    "server/char_name.lua",
    "server/private_tracker.lua",
    "server/identifier.lua",
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    "html/menu_translations/*.json",
    "utils/dialogs/**/*.js",
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