Config = {}
Config.Interior = vector3(-1279.32, -2345.68, 21.74) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1263.96, -2334.65, 14.12) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-1280.7, -2315.88, 18.35, 65.88) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-1274.67, -2310.75, 18.41, 150.55) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-1283.36, -2314.6, 18.47, 240.53) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not
Config.customNationality = false -- Defines if Nationality input is custom of blocked to the list of Countries
Config.SkipSelection = true -- Skip the spawn selection and spawns the player at the last location

Config.DefaultNumberOfCharacters = 5 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}