fx_version 'bodacious'
game 'gta5'

author 'molo modding'
description 'SEWER'
version '2.0.0'

this_is_a_map 'yes'
lua54 'yes'

client_script {
    'client/*.lua',
    'config.lua'
}

escrow_ignore {
    'config.lua'
}   '/models/exterior/*'
dependency '/assetpacks'