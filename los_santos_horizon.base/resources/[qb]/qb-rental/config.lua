Config = {}
Config.locale = 'fr'

Config.vehicleList = {
    { name = "Panto", model = "panto", price = 100, needLicense = false},
    { name = "Asea", model = "asea", price = 150, needLicense = true },
    { name = "Blista", model = "blista", price = 200 , needLicense = true},
}

Config.locations = {
    {
        id = 1,
        spawnPed = vector4(-1232.69, -2341.55, 14.09, 250.73),
        spawns = {
            vector4(-1227.42, -2341.18, 13.34, 241.28),
            vector4(-1225.32, -2338.35, 13.34, 240.01),
            vector4(-1223.59, -2335.31, 13.34, 241.19),
            vector4(-1221.94, -2331.97, 13.34, 241.1),
        }
    },
    {
        id = 2,
        spawnPed = vector4(-1273.94, -566.12, 29.76, 306.59),
        spawns = {
            vector4(-1259.14, -576.73, 27.8, 220.9),
            vector4(-1263.41, -571.81, 28.25, 220.98),
            vector4(-1266.97, -567.72, 28.62, 221.0),
            vector4(-1270.95, -563.14, 29.04, 221.01),
        }
    }
    -- {
    --     id = 3,
    --     spawnPed = vector4(-1279.27, -424.1, 34.27, 310.12),
    --     spawns = {
    --         vector4(-1272.84, -419.68, 33.74, 214.13),
    --         vector4(-1306.65, -408.93, 34.65, 300.59),
    --         vector4(-1285.25, -428.51, 34.35, 212.86),
    --         vector4(-1291.47, -400.54, 35.63, 299.69),
    --     }
    -- },
    -- {
    --     id = 4,
    --     spawnPed = vector4(-514.38, 70.27, 52.59, 177.02),
    --     spawns = {
    --         vector4(-535.4, 54.81, 52.4, 85.78),
    --         vector4(-535.4, 47.66, 52.4, 84.59),
    --         vector4(-523.62, 46.21, 52.4, 83.23),
    --         vector4(-521.84, 52.78, 52.4, 82.76),
    --     }
    -- },
    -- {
    --     id = 5,
    --     spawnPed = vector4(315.49, -1088.15, 29.4, 89.43),
    --     spawns = {
    --         vector4(307.06, -1093.99, 29.18, 123.26),
    --         vector4(306.28, -1103.07, 29.21, 121.33),
    --         vector4(306.29, -1085.94, 29.21, 120.82),
    --         vector4(306.47, -1080.89, 29.2, 119.83),
    --     }
    -- },
    -- {
    --     id = 6,
    --     spawnPed = vector4(260.55, -638.64, 40.57, 75.18),
    --     spawns = {
    --         vector4(247.77, -648.96, 38.93, 340.02),
    --         vector4(255.13, -631.16, 40.43, 335.25),
    --         vector4(259.95, -621.65, 41.33, 332.5),
    --         vector4(226.25, -633.01, 39.5, 157.6),
    --     }
    -- }
}
Config.translations = {
    en = {
        rent = 'Rent a vehicle',
        back = 'Return the vehicle (Recover 50% of the rental price)',
        success_back = 'You returned the vehicle, and you got back $',
        info_back = 'Remember to return this vehicle to recover 50% of the price of the vehicle.',
        error_no_license = 'You do not have the necessary license to be able to rent this vehicle',
        error_no_money = 'You do not have enough money.',
        error_no_papers = 'I can\'t take a vehicle without its papers.',
        error_not_a_rent = 'This is not a rented vehicle.',
        error_to_far = 'I don\'t see any rented vehicles, please make sure they are nearby',
        error_all_emplacement_used = 'All spawn locations are in use',
    },
    fr = {
        rent = 'Louer un véhicule',
        back = 'Rendre le véhicule (Récupérer 50% du prix de la location)',
        success_back = 'Vous avez rendu le véhicule, et vous avez récupéré $',
        info_back = 'Pensez à rendre ce véhicule pour récupérer 50% du prix du véhicule.',
        error_no_license = 'Vous n\'avez pas la license nécéssaire pour pouvoir louer ce véhicule',
        error_no_money = 'Vous n\'avez pas assez d\'argent.',
        error_no_papers = 'Je ne peux pas prendre un véhicule sans ses papiers.',
        error_not_a_rent = 'Ce n\'est pas un véhicule loué.',
        error_to_far = 'Je ne vois aucun véhicule loué, assurez-vous qu\'il se trouve à proximité',
        error_all_emplacement_used = 'Tous les emplacements de spawn sont en cours d\'utilisation',
    }

    -- add more languages
}


