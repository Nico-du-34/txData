CreateThread(function()
    Wait(1500)
    -- Chair
    local chairItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1154188702210342985/1212222214821257266/2.png?ex=65f10cea&is=65de97ea&hm=862ed734894feab8180319273260d1993632d65e1c72128aca1fe3c5b88c944d&=&format=webp&quality=lossless',
        ['object'] = 'kawaiispace_gamingchair',
        ['price'] = 1290,
        ['label'] = 'Kawaii Gaming Chair',
        ['description'] = 'Gaming chair for Kawaii games station',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Black',
                object = 'kawaiispace_chairbw',
                price = 1290,
            },
            {
                label = 'Gray',
                object = 'kawaiispace_chairgre',
                price = 1290,
            },
            {
                label = 'Orange',
                object = 'kawaiispace_chairorange',
                price = 1290,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_chairpink',
                price = 1290,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_chairpurp',
                price = 1290,
            },
            {
                label = 'Blue',
                object = 'kawaiispace_chairblue',
                price = 1290,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', chairItems)

    -- Station
    local stationItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1154188702210342985/1212222214506549329/1.png?ex=65f10ce9&is=65de97e9&hm=a3938c84449d6cabfff3a7b9ab61ff653ab5ca46dbd8748e000e0081b13c2c52&=&format=webp&quality=lossless',
        ['object'] = 'kawaiispace_gamingstation',
        ['price'] = 2550,
        ['label'] = 'Kawaii Gaming Station',
        ['description'] = 'Games station for the Kawaii gaming chair',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Green',
                object = 'kawaiispace_stationgreen',
                price = 2550,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_stationpink',
                price = 2550,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_stationpurple',
                price = 2550,
            },
            {
                label = 'White',
                object = 'kawaiispace_stationwhite',
                price = 2550,
            },
        },
    }
    exports['qs-housing']:AddFurniture('chair', stationItems)

    -- Keyboard
    local keyboardItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1154188702210342985/1212222214292901998/3.png?ex=65f10ce9&is=65de97e9&hm=6890d4531b3956f0b12e3a192e27b378c0ce6c0115e4453991e1c7a23bafbad5&=&format=webp&quality=lossless',
        ['object'] = 'kawaiispace_keyboard',
        ['price'] = 300,
        ['label'] = 'Kawaii Gaming Keyboard',
        ['description'] = 'A complete keyboard and mouse for the Kawaii setup!',
        ['colorlabel'] = 'Pink',
        ['colors'] = {
            {
                label = 'Gray',
                object = 'kawaiispace_keyboardgre',
                price = 300,
            },
            {
                label = 'Orange',
                object = 'kawaiispace_keyboardorg',
                price = 300,
            },
            {
                label = 'Pink',
                object = 'kawaiispace_keyboardpink',
                price = 300,
            },
            {
                label = 'Purple',
                object = 'kawaiispace_keyboardpurp',
                price = 300,
            },
        },
    }
    exports['qs-housing']:AddFurniture('laptop', keyboardItems)

    print('The dlc [KillstorexQuasar_props] was completely imported, these furniture are a reality thanks to the collaboration with https://killstore.net')
end)
