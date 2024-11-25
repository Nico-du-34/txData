fx_version 'adamant'

game 'gta5'

this_is_a_map 'yes'

Author 'Rfc_Mapping'
description 'Church'

version '1.0'

data_file 'AUDIO_GAMEDATA' 'audio/church_doors_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/church_mlo_game.dat'

files {
    'audio/church_doors_game.dat151.rel',
    'audio/church_mlo_game.dat151.rel'
}

client_script {
    "rfc_church_entitysets.lua"
}

dependency '/assetpacks'

escrow_ignore {
    "rfc_church_entitysets.lua"

}

lua54 'yes'
dependency '/assetpacks'