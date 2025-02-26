fx_version 'bodacious'
games { 'gta5' }

author 'London Studios'
description 'A resource providing an average speed camera system'
version '1.0.0'

files {
    'stream/prop_speed_camera.ytyp'
}

client_scripts {
    'cl_averagespeed.lua',
}

server_scripts {
    'sv_averagespeed.lua',
}

shared_script 'config_averagespeed.lua'

data_file 'DLC_ITYP_REQUEST' 'stream/prop_speed_camera.ytyp'