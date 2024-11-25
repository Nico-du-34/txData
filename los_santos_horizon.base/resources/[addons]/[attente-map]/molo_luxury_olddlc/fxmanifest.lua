fx_version 'bodacious'
games { 'gta5' }

this_is_a_map "yes"
lua54 'yes'
data_file 'AUDIO_GAMEDATA' 'audio/molo_cd_door_game.dat'


files {
  'audio/molo_cd_door_game.dat151.rel',

}

escrow_ignore {

  
  }

file "sp_manifest.ymt"
data_file "SCENARIO_POINTS_OVERRIDE_PSO_FILE" "sp_manifest.ymt"

server_script 'server.lua'
client_script 'client.lua'
dependency '/assetpacks'