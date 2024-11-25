-- Zones for Menus
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    police = {
        vector3(447.16, -974.31, 30.47),
    },
    ambulance = {
        vector3(311.21, -599.36, 43.29),
    },
    cardealer = {
        vector3(-807.11, -207.95, 37.04),
    },
    mosley = {
        vector3(-2.16, -1658.43, 29.26),
    },
    bennys = {
        vector3(-194.18, -1320.38, 35.57),
    },
    lscustom = {
        vector3(-326.88, -157.92, 38.9),
    },
    redlinegarage = {
        vector3(955.56, -221.14, 76.88),
    },
    taxi = {
        vector3(898.94, -165.41, 74.17),
    },
    realestate = {
        vector3(-716.0, 260.99, 83.47),
    },
    mcdonald = {
        vector3(83.57, 294.87, 109.75),
    },
    lsburgershot = {
        vector3(-818.75, -795.32, 21.02),
    },
    ssburgershot = {
        vector3(1448.32, 3566.32, 36.72),
    },
    unicorn = {
        vector3(111.91, -1321.15, 20.48),
    },
    malibu = {
        vector3(-798.77, -1221.21, 11.26),
    },
    yellowjack = {
        vector3(1995.32, 3048.01, 50.54),
    },
    au_siecle_dor = {
        vector3(-174.47, 300.96, 100.66),
    },
    reporter = {
        vector3(-576.11, -937.62, 28.58),
    },
    eastcustom = {
        vector3(887.86, -2099.69, 34.58),  
    },
    pawnshop = {
        vector3(451.39, -1461.79, 29.1),
    },
}
Config.GangMenus = {
    lostmc = {
        vector3(0, 0, 0),
    },
    ballas = {
        vector3(0, 0, 0),
    },
    vagos = {
        vector3(0, 0, 0),
    },
    cartel = {
        vector3(0, 0, 0),
    },
    families = {
        vector3(0, 0, 0),
    },
}
