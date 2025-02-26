Config = {}

-- Which translation you wish to use ?
Config.Locale = "en"

Config.Framework = {
    -- 0 = standalone
    -- 1 = esx
    -- 2 = qbcore
    Active = 2,

    -- esx
    ESX_SHARED_OBJECT = "esx:getSharedObject",

    -- es_extended resource name
    ES_EXTENDED_NAME = "es_extended",

    -------

    -- qbcore
    QBCORE_SHARED_OBJECT = "QBCore:GetObject",

    -- qb-core resource name
    QB_CORE_NAME = "qb-core",

    -- should the script look it self for framework?
    AutoCheck = true,
}

Config.Society = "society"

-- Key settings
Config.keyToOpenTicketMenu = "E"
Config.keyToOpenComputer = "E"

-- Marker for buying ticket            vector4(-1290.19, -298.395, 36.050, 203.0)
Config.Arcade = {
    {
        NPC = {
            position = vector3(-1290.19, -298.395, 35.050),
            heading = 203.0,
            model = "ig_claypain",
        },
        blip = {
            position = vector3(-1290.19, -298.395, 35.050),
            blipId = 521,
            scale = 0.4,
            color = 0,
            name = "Arcade house",
            shortRange = true,
            enable = true,
        },
        marker = {
            markerPosition = vector3(-1289.93, -298.917, 35.050),
            markerType = 23,
            options = {
                scale = { x = 1.0, y = 1.0, z = 1.0 },
                color = { r = 255, g = 255, b = 255, a = 125 },
            }
        },
    },
}

-- ticket price, and time in arcade.
Config.ticketPrice = {
    [1] = {
        label = _U("bronz"),
        price = 1000,
        time = 10, -- in minutes
    },
    [2] = {
        label = _U("silver"),
        price = 2000,
        time = 20, -- in minutes
    },
    [3] = {
        label = _U("gold"),
        price = 3000,
        time = 30, -- in minutes
    },
    [4] = {
        label = _U("Platinum"),
        price = 5000,
        time = 60, -- in minutes
    },
}

-- is arcade payed ?
Config.enableGameHouse = true

-- do not change unless you know what you're doing
Config.GPUList = {
    ETX2080 = "ETX2080",
    ETX1050 = "ETX1050",
    ETX660 = "ETX660",
}

Config.CPUList = {
    U9_9900 = "U9_9900",
    U9_9900 = "U9_9900",
    U3_6300 = "U3_6300",
    BENTIUM = "BENTIUM",
}

Config.MyList = {
    {
        name = "name",
        link = "bleh",
    },
}

-- game list for retro machine
Config.RetroMachine = {
    {
        name = "Pacman",
        link = "http://xogos.robinko.eu/PACMAN/",
    },
    {
        name = "Tetris",
        link = "http://xogos.robinko.eu/TETRIS/",
    },
    {
        name = "Ping Pong",
        link = "http://xogos.robinko.eu/PONG/",
    },
    {
        name = "DOOM",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
    },
    {
        name = "Duke Nukem 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    },
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },
}

-- game list for gaming machine
Config.GamingMachine = {
    {
        name = "Slide a Lama",
        link = "http://lama.robinko.eu/fullscreen.html",
    },
    {
        name = "Uno",
        link = "https://duowfriends.eu/",
    },
    {
        name = "Ants",
        link = "http://ants.robinko.eu/fullscreen.html",
    },
    {
        name = "FlappyParrot",
        link = "http://xogos.robinko.eu/FlappyParrot/",
    },
    {
        name = "Zoopaloola",
        link = "http://zoopaloola.robinko.eu/Embed/fullscreen.html"
    }
}

-- game list for super computer
Config.SuperMachine = {}

for i = 1, #Config.RetroMachine do
    table.insert(Config.SuperMachine, Config.RetroMachine[i])
end

for i = 1, #Config.GamingMachine do
    table.insert(Config.SuperMachine, Config.GamingMachine[i])
end

-- computer list in world
Config.computerList = {
    --- lunapark retro machine
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = false,

        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList.ETX1050,
        computerCPU = Config.CPUList.U9_9900,

        markerType = 31,
        position = vector3(-1286.44, -303.106, 36.050),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    ----
    -- Retro machines
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,

        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList.ETX1050,
        computerCPU = Config.CPUList.U9_9900,

        markerType = 31,
        position = vector3(-1292.92, -306.887, 36.648),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Gaming computers
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,

        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList.ETX1050,
        computerCPU = Config.CPUList.U9_9900,

        markerType = 42,
        position = vector3(-1279.42, -302.216, 36.050),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,

        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList.ETX1050,
        computerCPU = Config.CPUList.U9_9900,

        markerType = 42,
        position = vector3(-1275.35, -299.004, 36.050),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,

        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList.ETX1050,
        computerCPU = Config.CPUList.U9_9900,

        markerType = 42,
        position = vector3(-1285.56, -296.166, 36.050),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },

}

-- dont change, dont touch this.
Framework = {
    STANDALONE = 0,
    ESX = 1,
    QBCORE = 2,
}