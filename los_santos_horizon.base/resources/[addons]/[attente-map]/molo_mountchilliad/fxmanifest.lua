fx_version 'bodacious'
games { 'gta5' }
lua54 'yes'
this_is_a_map "yes"

client_script("cl_bounds.lua")

client_script {
    'client/*.lua',
    'config.lua'
}

dependency '/assetpacks'
dependency '/assetpacks'