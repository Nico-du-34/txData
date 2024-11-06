fx_version 'cerulean'
game 'common'

name 'vote'
description 'Vote plugin for Top-games.net/Top-serveurs.net platforms'
author 'Top-Games/Top-Serveurs'
version '3.0.1'
url 'https://github.com/Top-Serveurs/cfx-vote-plugin'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'vote.js',
    'server.lua',
}
