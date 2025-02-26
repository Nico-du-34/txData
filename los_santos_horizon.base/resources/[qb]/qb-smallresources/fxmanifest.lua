fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
author 'Kakarot'
description 'Various small code snippets compiled into one resource for ease of use'
version '1.4.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
    'config.vendingmachine.lua',
    "fixDeleteVehicle.lua"
}
server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'
data_file 'DLC_ITYP_REQUEST' 'stream/prop_car_airbag.ytyp'
files {
    'events.meta',
    'popgroups.ymt',
    'relationships.dat',
    'stream/prop_car_airbag.ytyp',
}
