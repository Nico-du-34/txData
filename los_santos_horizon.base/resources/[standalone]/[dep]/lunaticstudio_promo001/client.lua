CreateThread(function()
    Wait(1500)
    -- Bed 1
    local bed1Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210148735732944996/l1.png?ex=65e981d6&is=65d70cd6&hm=358d8a9b7237918c02c72917de9d12d05d3a94d668f8fbcba75d490240a24a49&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_bed1_a',
        ['price'] = 1230,
        ['label'] = 'Lunatic bed',
        ['description'] = 'Luxury beds with fabric backrests, thanks to Lunatic Studios for such a bed!',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'White',
                object = 'ls_quasar_bed1_a',
                price = 1230,
            },
            {
                label = 'Black and gray',
                object = 'ls_quasar_bed1_c',
                price = 1230,
            },
            {
                label = 'Black and white',
                object = 'ls_quasar_bed1_d',
                price = 1230,
            },
            {
                label = 'Green and white',
                object = 'ls_quasar_bed1_e',
                price = 1230,
            },
            {
                label = 'Red and white',
                object = 'ls_quasar_bed1_f',
                price = 1230,
            },
            {
                label = 'Blue and white',
                object = 'ls_quasar_bed1_g',
                price = 1230,
            },
            {
                label = 'Gray and white',
                object = 'ls_quasar_bed1_h',
                price = 1230,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bed', bed1Items)

    -- Bed 2
    local bed2Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210150363160641597/l2.png?ex=65e9835a&is=65d70e5a&hm=b9845d8fdf785eab52a168acc56875c0c40f90248785111ab01ba53a00032645&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_bed2_a',
        ['price'] = 1230,
        ['label'] = 'Lunatic bed Colored',
        ['description'] = 'Luxury beds with fabric backrests, thanks to Lunatic Studios for such a bed and colored!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {
            {
                label = 'Green',
                object = 'ls_quasar_bed2_a',
                price = 1230,
            },
            {
                label = 'Red',
                object = 'ls_quasar_bed2_c',
                price = 1230,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_bed2_d',
                price = 1230,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_bed2_e',
                price = 1230,
            },
            {
                label = 'White',
                object = 'ls_quasar_bed2_f',
                price = 1230,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_bed2_g',
                price = 1230,
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_bed2_h',
                price = 1230,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bed', bed2Items)

    -- Bookshelf
    local bookshelfItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210151503185055764/l3.png?ex=65e98469&is=65d70f69&hm=9ece7fecdffa9bffe869fcad4fe3ca4851608bb6ca3428a7d64bd5327c86f163&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_book1_a',
        ['price'] = 250,
        ['label'] = 'Lunatic Bookshelf',
        ['description'] = 'The best furniture for the bed from Lunatic Studios',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'Blue',
                object = 'ls_quasar_book1_b',
                price = 250,
            },
            {
                label = 'White',
                object = 'ls_quasar_book1_c',
                price = 250,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_book1_d',
                price = 250,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_book1_e',
                price = 250,
            },
            {
                label = 'Brown',
                object = 'ls_quasar_book1_f',
                price = 250,
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_book1_g',
                price = 250,
            },
            {
                label = 'Light green',
                object = 'ls_quasar_book1_h',
                price = 250,
            },
        },
    }
    exports['qs-housing']:AddFurniture('bedsidetable', bookshelfItems)

    -- Caffee table
    local caffeeItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210152943773290586/l4.png?ex=65e985c1&is=65d710c1&hm=1e080571074a5dbebe030597beca91b2f3d31ff95d75d28f2c26540e2834aa07&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_ctal1_a',
        ['price'] = 410,
        ['label'] = 'Lunatic coffee table',
        ['description'] = 'Elegant coffee tables from the Lunatic Studios winter collection',
        ['colorlabel'] = 'Gray',
        ['colors'] = {
            {
                label = 'Dark green',
                object = 'ls_quasar_ctal1_b',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Green',
                object = 'ls_quasar_ctal1_c',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_ctal1_d',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Red',
                object = 'ls_quasar_ctal1_e',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Black',
                object = 'ls_quasar_ctal1_f',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'White',
                object = 'ls_quasar_ctal1_g',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_ctal1_h',
                price = 410,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('table', caffeeItems)
    exports['qs-housing']:AddFurniture('pc-table', caffeeItems)
    exports['qs-housing']:AddFurniture('couchtable', caffeeItems)

    -- End table
    local caffeeItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210153691080953876/l5.png?ex=65e98673&is=65d71173&hm=e99db964220901473dc0b90d4f541e0df02966bf1fdf1fb15d0192bb0c77a361&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_endt1_a',
        ['price'] = 360,
        ['label'] = 'Lunatic end table',
        ['description'] = 'Elegant and small table, ready to use as an end table, thanks to Lunatic Store',
        ['colorlabel'] = 'Dark green',
        ['colors'] = {
            {
                label = 'Gray',
                object = 'ls_quasar_endt1_b',
                price = 360,
            },
            {
                label = 'Green',
                object = 'ls_quasar_endt1_c',
                price = 360,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_endt1_d',
                price = 360,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_endt1_e',
                price = 360,
            },
            {
                label = 'Black',
                object = 'ls_quasar_endt1_f',
                price = 360,
            },
            {
                label = 'Red',
                object = 'ls_quasar_endt1_g',
                price = 360,
            },
            {
                label = 'Brown',
                object = 'ls_quasar_endt1_h',
                price = 360,
            },
        },
    }
    exports['qs-housing']:AddFurniture('table', caffeeItems)
    exports['qs-housing']:AddFurniture('pc-table', caffeeItems)
    exports['qs-housing']:AddFurniture('couchtable', caffeeItems)

    -- Seat left
    local seatLeftItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210154408097357844/l6.png?ex=65e9871e&is=65d7121e&hm=98e2662c58d79fff0cf99f3cdbebaabf6b1fcf1d9d5a05da84288d41c300d450&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_lsea1_a',
        ['price'] = 290,
        ['label'] = 'Lunatic love seat left',
        ['description'] = 'Lunatic Studios brings us here a sofa with left direction and drawers, beautiful design',
        ['colorlabel'] = 'Skin',
        ['colors'] = {
            {
                label = 'Black',
                object = 'ls_quasar_lsea1_b',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Gray',
                object = 'ls_quasar_lsea1_c',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_lsea1_d',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'White',
                object = 'ls_quasar_lsea1_e',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Green',
                object = 'ls_quasar_lsea1_f',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_lsea1_g',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Red',
                object = 'ls_quasar_lsea1_h',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('sofa', seatLeftItems)
    exports['qs-housing']:AddFurniture('couch', seatLeftItems)

    -- Seat right
    local seatRightItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210155433076195338/l7.png?ex=65e98812&is=65d71312&hm=b877ff77e0ef2bf8420709df5dcfa636c599fd16454ee6bde0db411d15287e18&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_lsea2_a',
        ['price'] = 290,
        ['label'] = 'Lunatic love seat right',
        ['description'] = 'Lunatic Studios brings us here a sofa with right direction and drawers, beautiful design',
        ['colorlabel'] = 'White',
        ['colors'] = {
            {
                label = 'Green',
                object = 'ls_quasar_lsea2_b',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Blue',
                object = 'ls_quasar_lsea2_c',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Gray',
                object = 'ls_quasar_lsea2_d',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Brown',
                object = 'ls_quasar_lsea2_e',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Skin',
                object = 'ls_quasar_lsea2_f',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Black',
                object = 'ls_quasar_lsea2_g',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
            {
                label = 'Dark green',
                object = 'ls_quasar_lsea2_h',
                price = 290,
                type = 'stash',
                offset = { x = 0.0, y = 0.0, z = 0.0 },
                stash = { maxweight = 50000, slots = 3 }
            },
        },
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('sofa', seatRightItems)
    exports['qs-housing']:AddFurniture('couch', seatRightItems)

    -- End table
    local stereoItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1210156108585508924/l8.png?ex=65e988b3&is=65d713b3&hm=95279ba3c624608312e627a7074e3bb81b25d8c328cd2e7fad3659949cf78ae9&=&format=webp&quality=lossless',
        ['object'] = 'ls_quasar_ster1_a',
        ['price'] = 360,
        ['label'] = 'Lunatic stereo',
        ['description'] = 'Musical stereos that are included with a phone similar to a Smartphone, but created by Lunatic Studios',
        ['colorlabel'] = 'Black',
        ['colors'] = {
            {
                label = 'Brown',
                object = 'ls_quasar_ster1_b',
                price = 360,
            },
            {
                label = 'White',
                object = 'ls_quasar_ster1_c',
                price = 360,
            },
            {
                label = 'Green',
                object = 'ls_quasar_ster1_d',
                price = 360,
            },
            {
                label = 'Blue',
                object = 'ls_quasar_ster1_e',
                price = 360,
            },
            {
                label = 'Skin',
                object = 'ls_quasar_ster1_f',
                price = 360,
            },
            {
                label = 'Gray',
                object = 'ls_quasar_ster1_g',
                price = 360,
            },
            {
                label = 'Red',
                object = 'ls_quasar_ster1_h',
                price = 360,
            },
        },
    }
    exports['qs-housing']:AddFurniture('laptop', stereoItems)

    print('The dlc [lunaticstudio_promo001] was completely imported, these furniture are a reality thanks to the collaboration with https://lunaticstudio.tebex.io')
end)
