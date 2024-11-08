fx_version 'cerulean'
game 'gta5'

files {
    "audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc",
    'data/**/*.meta',
    'data/**/*.xml',
    'data/**/*.dat',
    'data/**/*.ytyp'
}

-- data_file "AUDIO_SYNTHDATA" "audioconfig/lg125mnsrybently_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/strm3e30_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/strm3e30_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_strm3e30"
data_file "AUDIO_GAMEDATA" "audioconfig/strm156_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/strm156_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_strm156"
data_file "AUDIO_GAMEDATA" "audioconfig/w211_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/w211_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_w211"
data_file "AUDIO_GAMEDATA" "audioconfig/ta122s58_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/ta122s58_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_ta122s58"
data_file "AUDIO_GAMEDATA" "audioconfig/m5cracklemod_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/m5cracklemod_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_m5cracklemod"

data_file 'HANDLING_FILE'            'data/**/handling*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'    'data/**/vehiclelayouts*.meta'
data_file 'VEHICLE_METADATA_FILE'    'data/**/vehicles*.meta'
data_file 'CARCOLS_FILE'            'data/**/carcols*.meta'
data_file 'VEHICLE_VARIATION_FILE'    'data/**/carvariations*.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/**/*unlocks.meta'
data_file 'PTFXASSETINFO_FILE' 'data/**/ptfxassetinfo.meta'

client_scripts {
    'vehicle_names.lua',
}