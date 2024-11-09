Config = {}
Config.Interior = vector3(-73.87, -818.8, 285.0) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-65.45, -826.07, 285.59, 73.41) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-80.15, -827.21, 285.0, 304.92) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-67.25, -825.52, 285.59, 239.34) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = false -- Define if the player can delete the character or not
Config.customNationality = false -- Defines if Nationality input is custom of blocked to the list of Countries
Config.SkipSelection = true -- Skip the spawn selection and spawns the player at the last location

Config.DefaultNumberOfCharacters = 2 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}

-- vector4(-65.8, -825.99, 285.6, 67.14)