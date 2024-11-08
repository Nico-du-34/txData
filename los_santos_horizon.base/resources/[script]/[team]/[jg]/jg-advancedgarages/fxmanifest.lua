fx_version 'cerulean'
game 'gta5'


shared_scripts {'config.lua', "fixDeleteVehicle.lua"}

client_scripts {'@CircleZone/client.lua', 'client/main.lua', 'config-client.lua', 'client/impound.lua', 'client/garage.lua', 'client/job-garage.lua',
                'client/gang-garage.lua', 'client/private-garage.lua', 'client/vehicle.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'server/main.lua', 'server/impound.lua', 'server/garage.lua', 'server/job-garage.lua',
                'server/gang-garage.lua', 'server/private-garage.lua', 'server/vehicle.lua'}

ui_page 'html/index.html'

files {'html/index.html', 'html/bootstrap.css', 'html/js/main.js', 'html/js/impound.js', 'html/js/garage.js', 'html/js/private-garage.js',
       'html/js/vehicle.js'}


lua54 'yes'
