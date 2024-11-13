fx_version 'cerulean'
game 'gta5'
author 'CodeVerse'
description 'CodeV Report'
lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
} 

client_scripts{
    'client/client.lua',
}

server_scripts{
    'server/utils.lua',
    'server/server.lua',
}

ui_page 'ui/index.html'

files {
    'ui/**/*.*',
    'ui/*.*',
}