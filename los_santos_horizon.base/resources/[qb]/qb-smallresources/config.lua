Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)
Config.PauseMapText = ''                                     -- Text shown above the map when ESC is pressed. If left empty 'FiveM' will appear
Config.HarnessUses = 20
Config.DamageNeeded = 100.0                                  -- amount of damage till you can push your vehicle. 0-1000

Config.AFK = {
    ignoredGroups = {
        ['mod'] = true,
        ['admin'] = true,
        ['god'] = true
    },
    secondsUntilKick = 1000000, -- AFK Kick Time Limit (in seconds)
    kickInCharMenu = true      -- Set to true if you want to kick players for being AFK even when they are in the character menu.
}

Config.HandsUp = {
    command = 'hu',
    keybind = 'Y',
    controls = { 24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264 }
}

Config.Binoculars = {
    zoomSpeed = 10.0,        -- camera zoom speed
    storeBinocularsKey = 177 -- backspace by default
}

Config.AIResponse = {
    wantedLevels = false, -- if true, you will recieve wanted levels
    dispatchServices = {  -- AI dispatch services
        [1] = false,      -- Police Vehicles
        [2] = false,      -- Police Helicopters
        [3] = false,      -- Fire Department Vehicles
        [4] = false,      -- Swat Vehicles
        [5] = false,      -- Ambulance Vehicles
        [6] = false,      -- Police Motorcycles
        [7] = false,      -- Police Backup
        [8] = false,      -- Police Roadblocks
        [9] = false,      -- PoliceAutomobileWaitPulledOver
        [10] = false,     -- PoliceAutomobileWaitCruising
        [11] = false,     -- Gang Members
        [12] = false,     -- Swat Helicopters
        [13] = false,     -- Police Boats
        [14] = false,     -- Army Vehicles
        [15] = false      -- Biker Backup
    }
}

-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
Config.Discord = {
    isEnabled = true,                                     -- If set to true, then discord rich presence will be enabled
    applicationId = '1221109227062300692',                   -- The discord application id
    iconLarge = 'logo',                               -- The name of the large icon
    iconLargeHoverText = 'Los Santos Horizon', -- The hover text of the large icon
    iconSmall = 'logo',                         -- The name of the small icon
    iconSmallHoverText = 'Los Santos Horizon', -- The hover text of the small icon
    updateRate = 60000,                                    -- How often the player count should be updated
    showPlayerCount = true,                                -- If set to true the player count will be displayed in the rich presence
    maxPlayers = 64,                                       -- Maximum amount of players
    buttons = {
        {
            text = 'Discord',
            url = 'https://discord.gg/Q8xs5tpCJH'
        }
    }
}

Config.Density = {
    parked = 0.1,
    vehicle = 0.6,
    multiplier = 0.6,
    peds = 0.6,
    scenario = 0.4
}

Config.Disable = {
    hudComponents = { 1, 2, 3, 4, 7, 9, 13, --[[14,]] 19, 20, 21, 22 }, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    controls = { 37 },                                            -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true,                                           -- false disables ammo display
    ambience = true,                                             -- disables distance sirens, distance car alarms, flight music, etc
    idleCamera = true,                                            -- disables the idle cinematic camera
    vestDrawable = false,                                         -- disables the vest equipped when using heavy armor
    pistolWhipping = true,                                        -- disables pistol whipping
    driveby = true,                                              -- disables driveby
}

Config.Consumables = {
    eat = { -- default food items
        ['sandwich'] = math.random(35, 54),
        ['tosti'] = math.random(40, 50),
        ['twerks_candy'] = math.random(35, 54),
        ['snikkel_candy'] = math.random(40, 50),
        ['burger_fries'] = math.random(30, 60),  
        ['burger_moneyshot'] = math.random(30,60),
        ['sushi11'] = math.random(10,30),
        ['laysblack'] = math.random(5,15),
        ['laysgreen'] = math.random(5,15),
        ['laysyellow'] = math.random(5,15),
        ['bacon_cheese_fries'] = math.random(30,60),
        ['apple_green'] = math.random(5,15),
        ['apple_red'] = math.random(5,15),
        ['chicken_strips'] = math.random(30,60),
        ['cupcake2'] = math.random(5,15),
        ['muffin'] = math.random(5,15),
        ['cupcake'] = math.random(5,15)
    },
    drink = { -- default drink items
        ['water_bottle'] = math.random(35, 54),
        ['kurkakola'] = math.random(35, 54),
        ['coffee'] = math.random(40, 50),
        ['drpepper_cherry'] = math.random(5,15),
        ['fanta_orange'] = math.random(5,15)
    },
    alcohol = { -- default alcohol items
        ['whiskey'] = math.random(20, 30),
        ['beer'] = math.random(30, 40),
        ['vodka'] = math.random(20, 40),
        ['congnac_bourgeoix'] = math.random(30, 60),  
        ['bleuterd_champagne'] = math.random(30, 60),  
        ['gin'] = math.random(20, 40),
        ['tequila'] = math.random(20, 40),
        ['shooter_tequila'] = math.random(5, 20),  
        ['gin_and_tonic'] = math.random(5, 20),
        ['whiskey_cola'] = math.random(20, 40),
        ['whiskey'] = math.random(20, 40),

    },
    custom = { -- put any custom items here
        -- ['newitem'] = {
        --     progress = {
        --         label = 'Using Item...',
        --         time = 5000
        --     },
        --     animation = {
        --         animDict = 'amb@prop_human_bbq@male@base',
        --         anim = 'base',
        --         flags = 8,
        --     },
        --     prop = {
        --         model = false,
        --         bone = false,
        --         coords = false, -- vector 3 format
        --         rotation = false, -- vector 3 format
        --     },
        --     replenish = {'''
        --         type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
        --         replenish = math.random(20, 40),
        --         isAlcohol = false, -- if you want it to add alcohol count
        --         event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
        --         server = false -- if the event above is a server event
        --     }
        -- }
        ['redbull'] = {
            progress = {
                label = 'Boit un Redbull...',
                time = 5000
            },
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49,
            },
            prop = {
                model = 'sf_p_sf_grass_gls_s_01a', -- Props a changé
                bone = 60309,
                coords = vec3(0.0, 0.0, -0.14),
                rotation = vec3(0.0, 0.0, 9),
            },
            replenish = {
                type = 'thirst',
                replenish = math.random(20, 40),
                isAlcohol = false,
                event = false,
                server = false
            }
        }
    }
}

Config.Fireworks = {
    delay = 5, -- time in s till it goes off
    items = {  -- firework items
        'firework1',
        'firework2',
        'firework3',
        'firework4'
    }
}

Config.BlacklistedScenarios = {
    types = {
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE_BIKE'
    },
    groups = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`
    }
}

Config.BlacklistedVehs = {
    [`shamal`] = true,
    [`luxor`] = true,
    [`luxor2`] = true,
    [`jet`] = true,
    [`lazer`] = true,
    [`buzzard`] = true,
    [`buzzard2`] = true,
    [`annihilator`] = true,
    [`savage`] = true,
    [`titan`] = true,
    [`rhino`] = true,
    [`maverick`] = true,
    [`blimp`] = true,
    [`airtug`] = true,
    [`camper`] = true,
    [`hydra`] = true,
    [`oppressor`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`cargoplane2`] = true,
    [`voltic2`] = true
}

Config.BlacklistedWeapons = {
    [`WEAPON_RAILGUN`] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true
}

Config.WeapDraw = {
    variants = { 130, 122, 3, 6, 8 },
    weapons = {
        --'WEAPON_STUNGUN',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL_MK2',
        'WEAPON_COMBATPISTOL',
        'WEAPON_APPISTOL',
        'WEAPON_PISTOL50',
        'WEAPON_REVOLVER',
        'WEAPON_SNSPISTOL',
        'WEAPON_HEAVYPISTOL',
        'WEAPON_VINTAGEPISTOL'
    }
}

Config.Objects = { -- for object removal
    { coords = vector3(266.09, -349.35, 44.74), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02b' },
    { coords = vector3(285.28, -355.78, 45.13), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02a' },
}

-- You may add more than 2 selections and it will bring up a menu for the player to select which floor be sure to label each section though
Config.Teleports = {
    --[[[1] = {                   -- Elevator @ labs
        [1] = {               -- up
            poly = { coords = vector3(3540.74, 3675.59, 20.99), heading = 167.5, length = 2, width = 2 },
            allowVeh = false, -- whether or not to allow use in vehicle
            label = false     -- set this to a string for a custom label or leave it false to keep the default. if more than 2 options, label all options

        },
        [2] = { -- down
            poly = { coords = vector3(3540.74, 3675.59, 28.11), heading = 172.5, length = 2, width = 2 },
            allowVeh = false,
            label = false
        }
    },
    [2] = { --Coke Processing Enter/Exit
        [1] = {
            poly = { coords = vector3(909.49, -1589.22, 30.51), heading = 92.24, length = 2, width = 2 },
            allowVeh = false,
            label = '[E] Enter Coke Processing'
        },
        [2] = {
            poly = { coords = vector3(1088.81, -3187.57, -38.99), heading = 181.7, length = 2, width = 2 },
            allowVeh = false,
            label = '[E] Leave'
        }
    }]]
}

Config.CarWash = {
    dirtLevel = 0.1,                                                                                   -- threshold for the dirt level to be counted as dirty
    defaultPrice = 20,                                                                                 -- default price for the carwash
    locations = {
        [1] = { coords = vector3(174.81, -1736.77, 28.87), length = 7.0, width = 8.8, heading = 359 }, -- South Los Santos Carson Avenue
        [2] = { coords = vector3(25.2, -1391.98, 28.91), length = 6.6, width = 8.2, heading = 0 },     -- South Los Santos Innocence Boulevard
        [3] = { coords = vector3(-74.27, 6427.72, 31.02), length = 9.4, width = 8, heading = 315 },    -- Paleto Bay Boulevard
        [4] = { coords = vector3(1362.69, 3591.81, 34.5), length = 6.4, width = 8, heading = 21 },     -- Sandy Shores
        [5] = { coords = vector3(-699.84, -932.68, 18.59), length = 11.8, width = 5.2, heading = 0 }   -- Little Seoul Gas Station
    }
}

-- Vehicles Push
Config.target = true -- Use target system for vehicle push (disables TextUI)
Config.targetSystem = 'qb-target' -- Target System to use. ox_target, qtarget, qb-target
Config.Usebones = true -- Use bones for vehicle push
Config.PushKey = 'E' -- Key to push vehicle
Config.TurnRightKey = 'Q' -- Keys to turn the vehicle while pushing it.
Config.TurnLeftKey = 'A' -- Keys to turn the vehicle while pushing it.
Config.TextUI = false -- Use Text UI for vehicle push
Config.useOTSkills = false -- Use OT Skills for XP gain from pushing vehicles. Found here: https://otstudios.tebex.io
Config.maxReward = 20 -- Max amount of xp that can be gained from pushing a vehicle per push, make sure this is the same or less than what is set for strength in your OT_skills config.
Config.healthMin = 2000.0 -- Minimum health of vehicle to be able to push it.

Config.blacklist = { -- blacklist vehicle models from being pushed.
    [`phantom`] = true
}

-- Vending Machine
Config.InvPath = "<img src=nui://qb-inventory/html/images/"

Config.Shop = {
    ['water_bottle'] = {
        drinkLabel = 'Eau',
        drinkPrice = 1,
        drinkName = 'water_bottle' --item name not label
    },

    ['kurkakola'] = {
        drinkLabel = 'CocaCola',
        drinkPrice = 2,
        drinkName = 'kurkakola'
    },

    ['coffee'] = {
        drinkLabel = 'Caffé',
        drinkPrice = 4,
        drinkName = 'coffee'
    }


}

Config.Machines = {
    "prop_vend_soda_01",
    "prop_vend_soda_02",
    "prop_vend_snak_01",
    "prop_vend_fridge01",
    "prop_watercooler",
    "prop_vend_snak_01_tu",
    "prop_vend_coffe_01",
    "prop_vend_water_01",
    'molo_h_distri',
}

-- Ped shops
-- Pour la Police --
Config.K9Message = 'Le chien policier a détecté quelque chose !' -- Si le chien policier trouve quelque chose
-- Fin Police -- 

Config.SearchableItems = {

['IllegalItems'] = {

    ['weed'] = 10,
    ['coke'] = 1,
    ['bread'] = 1, -- pain
    ['water'] = 1, -- eau
},
}

Config.IllnessChance = 5 -- Chance de tomber malade (Pour les animaux) - Si Police, a deux chances de tomber malade

Config.HealPrice = 500 -- Prix de soin

Config.FoodPrice = 250 -- Prix de la nourriture
Config.FoodItem = 'petfood' -- Nom de l'item dans la base de données

Config.TennisBallPrice = 100 -- Prix de la balle de tennis

Config.Pet1 = 'a_c_cat_01'
Config.Pet1Price = 500
Config.Pet1Label = 'Chat'

Config.Pet2 = 'a_c_rabbit_01'
Config.Pet2Price = 500
Config.Pet2Label = 'Lapin'

Config.Pet3 = 'a_c_poodle'
Config.Pet3Price = 500
Config.Pet3Label = 'Caniche'

Config.Pet4 = 'a_c_pug'
Config.Pet4Price = 500
Config.Pet4Label = 'Carlin'

Config.Pet5 = 'a_c_husky'
Config.Pet5Price = 2000
Config.Pet5Label = 'Husky'

Config.Pet6 = 'a_c_rottweiler'
Config.Pet6Price = 2000
Config.Pet6Label = 'Rottweiler'

Config.Pet7 = 'a_c_hen'
Config.Pet7Price = 4000
Config.Pet7Label = 'Énorme Coq'

Config.Pet8 = 'a_c_retriever'
Config.Pet8Price = 2000
Config.Pet8Label = 'Retriever'

Config.Pet9 = 'a_c_westy'
Config.Pet9Price = 500
Config.Pet9Label = 'Terrier Highland'

Config.Pet10 = 'a_c_shepherd'
Config.Pet10Price = 500
Config.Pet10Label = 'Berger'

Config.Pet11 = 'a_c_pig'
Config.Pet11Price = 1000
Config.Pet11Label = 'Cochon'


-- qb-dumpsters

-- Récompense monétaire de base
Config.MoneyReward = math.random(18, 26)

-- Types de récompenses possibles
Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
    },
    [3] = {
        type = "nothing",
    }
}

-- Système de rareté avec multiplicateurs et chances
Config.Rarities = {
    COMMON = {
        name = "Commun",
        mult = 1,     -- Multiplicateur de base
        chance = 60,  -- 60% de chance
        color = "primary"
    },
    UNCOMMON = {
        name = "Peu commun",
        mult = 1.5,   -- 50% de bonus
        chance = 25,  -- 25% de chance
        color = "info"
    },
    RARE = {
        name = "Rare",
        mult = 1.5,     -- Double quantité
        chance = 5,  -- 10% de chance
        color = "success"
    },
    EPIC = {
        name = "Épique",
        mult = 1.5,     -- Triple quantité
        chance = 2,   -- 4% de chance
        color = "warning"
    },
    LEGENDARY = {
        name = "Légendaire",
        mult = 1.5,     -- Quintuple quantité
        chance = 1,   -- 1% de chance
        color = "error"
    }
}

-- Configuration des récompenses par type d'objet
Config.Rewardes = {
    ['dumpstares'] = {
        -- Items communs (45-20% de chance)
        {item = "sandwich", minAmount = 1, maxAmount = 3, chance = 45, rarity = "COMMON"},
        {item = "plastic", minAmount = 1, maxAmount = 1, chance = 20, rarity = "COMMON"},
        {item = "empty_weed_bag", minAmount = 1, maxAmount = 3, chance = 30, rarity = "COMMON"},
        {item = "weed_nutrition", minAmount = 1, maxAmount = 1, chance = 12, rarity = "COMMON"},
        
        -- Items peu communs (10-20% de chance)
        {item = "lockpick", minAmount = 1, maxAmount = 1, chance = 2, rarity = "UNCOMMON"},

        -- Figurines Pop Horror (Rares - 5% de chance chacune)
        {item = "annabelle_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "beetlejuice_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "boogeyman_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "carrie_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "chucky_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "freddy_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "jasonvoorhees_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "leatherface_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "michaelmyers_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "pennywise_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "pennywiseballoon_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "pinhead_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "thecreeper_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},

        -- Figurines Pop Disney (Rares - 5% de chance chacune)
        {item = "ariel", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "belle", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "cinderella", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "jasmine", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "jessrabbit", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "rapunzel", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "tiana", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "tinkerbell", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},

        -- Figurines Pop WWE (Rares - 5% de chance chacune)
        {item = "undertakerspecial_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "undertaker_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "tripleh_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "therock_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "theheartbreakkid_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "teddibiase_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "sting_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "reymysterio_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "randyorton_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "natureboy_ricflair_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "mrt_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "mickfoley_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "machoman_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "kurtangle_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "kane_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "johncena_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "hulkhogan_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "hardyboys_2packpop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "andrethegiant_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},
        {item = "ajstyles_pop", minAmount = 1, maxAmount = 1, chance = 5, rarity = "RARE"},

        -- Figurines Pop Harry Potter (Épiques - 3% de chance chacune)
        {item = "draco", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "dumbledore", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "hagrid", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "harrypotter", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "hedwig", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "hermione", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "moaningmertle", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "ron", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "snape", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},
        {item = "voldemort", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},

        -- Tableaux (Épiques)
        {item = "np_american-gothic", minAmount = 1, maxAmount = 1, chance = 8, rarity = "EPIC"},
        {item = "np_dora-maar-auchat", minAmount = 1, maxAmount = 1, chance = 1, rarity = "EPIC"},

        -- Bijoux (Légendaires - 3% de chance chacun)
        {item = "gold_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "silver_ring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_ring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_ring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_ring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_ring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "goldchain", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_necklace", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_necklace", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_necklace", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_necklace", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "silverchain", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_necklace_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_necklace_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_necklace_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_necklace_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "goldearring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_earring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_earring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_earring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_earring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "silverearring", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "diamond_earring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "ruby_earring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "sapphire_earring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"},
        {item = "emerald_earring_silver", minAmount = 1, maxAmount = 1, chance = 1, rarity = "LEGENDARY"}
    }
}

-- Configuration des objets fouillables
Config.ObjectsDump = {
    [`prop_dumpster_01a`] = 'dumpstares',
    [`prop_dumpster_02a`] = 'dumpstares',
    [`prop_dumpster_02b`] = 'dumpstares',
    [`prop_dumpster_3a`] = 'dumpstares',
    [`prop_dumpster_4a`] = 'dumpstares',
    [`prop_dumpster_4b`] = 'dumpstares',
    [`prop_bin_01a`] = 'dumpstares',
    [`prop_bin_14b`] = 'dumpstares',
    [`prop_bin_14a`] = 'dumpstares',
    [`prop_bin_08a`] = 'dumpstares',
    [`prop_bin_05a`] = 'dumpstares',
    [`prop_bin_07c`] = 'dumpstares',
    [`prop_rub_binbag_03`] = 'dumpstares',
    [`prop_rub_binbag_01b`] = 'dumpstares',
    [`prop_rub_binbag_06`] = 'dumpstares',
    [`prop_aircon_m_04`] = 'dumpstares',
    [`prop_aircon_m_06`] = 'dumpstares',
    [`prop_aircon_m_07`] = 'dumpstares',
    [`prop_aircon_m_02`] = 'dumpstares',
}

-- qb-rental

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
