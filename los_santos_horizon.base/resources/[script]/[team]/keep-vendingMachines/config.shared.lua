Config = Config or {}

Config.target = "qb-target" -- interactionMenu / ox_target / qb-target
Config.framework = 'qb'          -- qb / esx

Config.animations = {
    dispense = {
        "mini@sprunk",
        "plyr_buy_drink_pt1"
    }
}

Config.machines = {
    {
        model = 'prop_vend_soda_01',
        items = {
            {
                name = "ecola",
                label = 'Ecola ($%price%)',
                price = 50
            },
            {
                name = "orange_juice",
                label = 'Jus d\'orange ($%price%)',
                price = 40
            }
        },
        offset = vec3(0, 0, 0)
    },
    {
        model = 'prop_vend_fridge01',
        items = {
            {
                name = "ecola",
                label = 'Ecola ($%price%)',
                price = 50
            },
            {
                name = "orange_juice",
                label = 'Jus d\'orange ($%price%)',
                price = 40
            }
        },
        offset = vec3(0, 0, 0)
    },
    {
        model = 'prop_vend_soda_02',
        items = {
            {
                name = "ecola",
                label = 'Ecola ($%price%)',
                price = 50
            },
            {
                name = "orange_juice",
                label = 'Jus d\'orange ($%price%)',
                price = 40
            }
        },
        offset = vec3(0, 0, 0)
    },
    {
        model = 'prop_vend_water_01',
        items = {
            {
                name = "water_bottle",
                label = 'Eau ($%price%)',
                price = 30
            }
        },
        offset = vec3(0, 0, 0)
    },
    {
        model = 'prop_vend_coffe_01',
        items = {
            {
                name = "coffee",
                label = 'Coffee ($%price%)',
                icon = 'fa fa-mug-hot',
                price = 50
            },
            {
                name = "tea",
                label = 'Tea ($%price%)',
                icon = 'fa fa-mug-hot',
                price = 40
            },
            {
                name = "cappuccino",
                label = 'Cappuccino ($%price%)',
                icon = 'fa fa-mug-saucer',
                price = 60
            },
            {
                name = "latte",
                label = 'Latte ($%price%)',
                icon = 'fa fa-mug-saucer',
                price = 55
            },
            {
                name = "hot_chocolate",
                label = 'Hot Chocolate ($%price%)',
                icon = 'fa fa-mug-hot',
                price = 45
            },
            {
                name = "espresso",
                label = 'Espresso ($%price%)',
                icon = 'fa fa-mug-saucer',
                price = 50
            }
        },
        offset = vec3(0, 0, 1.0)
    },
    {
        model = 'prop_vend_snak_01',
        items = {
            {
                name = "tosti",
                label = 'Sandwich ($%price%)',
                price = 30
            }
        },
        offset = vec3(0, 0, 0)
    },
    {
        model = 'prop_vend_snak_01_tu',
        items = {
            {
                name = "tosti",
                label = 'Sandwich ($%price%)',
                price = 30
            }
        },
        offset = vec3(0, 0, 0)
    },
}
