fx_version 'cerulean'
game 'gta5'
name 'GenScripts Pause Menu'
scriptname 'genscripts_pausemenu'
version '1.1.0'
description 'GENSCRIPTS PAUSE MENU'
author 'keremu'
discord 'https://discord.gg/genscripts'
website 'https://gen.tebex.io/'
tutorial 'https://genscripts.gitbook.io/gen-scripts/'
lua54 'yes'

shared_scripts {
    "config.lua",
    "locales/*.lua",
}

client_scripts {
	'client/client.lua',
}

server_scripts {
    "server_config.lua",
    "server/server.lua",
    -- "server/version_check.lua"
}

ui_page "src/html/ui.html"

files {
    'src/html/ui.html',
    'src/**/*'
}
    
escrow_ignore {
	"server/database.lua",
    "config.lua",
    "server_config.lua",
    "locales/*.lua"
}

dependency '/assetpacks'
dependency '/assetpacks'