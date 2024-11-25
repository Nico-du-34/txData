CreateThread(function()
    Wait(1500)
    -- Cabinet 1
    local cabinet1Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211277791983702077/1.png?ex=65ed9d5a&is=65db285a&hm=f8842c300d8fded65330a5f8122389e9501bfedf2060c8a06954268581f02028&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_cabinet',
        ['price'] = 220,
        ['label'] = 'GCOM cabinet',
        ['description'] = 'A luxurious and very detailed cabinet, really good!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('hangingcaninets', cabinet1Items)
    exports['qs-housing']:AddFurniture('kitchenetteleft', cabinet1Items)
    exports['qs-housing']:AddFurniture('kitchenetteright', cabinet1Items)
    exports['qs-housing']:AddFurniture('bedsidetable', cabinet1Items)

    -- Cabinet 2
    local cabinet2Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211278640751317042/2.png?ex=65ed9e24&is=65db2924&hm=8a246ec90e5796b4d45cd31f3e4e70c962db5a590307ab5c3a3048d73288244d&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_cabinet_2',
        ['price'] = 150,
        ['label'] = 'GCOM cabinet Small',
        ['description'] = 'A luxurious and very detailed cabinet, really good, but very small!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', cabinet2Items)

    -- Bathcab
    local bathcabItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211278885166129152/3.png?ex=65ed9e5e&is=65db295e&hm=58c798424656cac368bfc92fd0a984559ef31837deec79368f3cfc1180cc5fe4&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_bathcab',
        ['price'] = 150,
        ['label'] = 'GCOM bathcab',
        ['description'] = 'Beautiful floating shelf, very small and delicate, like a flower',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', bathcabItems)

    -- Table 1
    local table1Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211279506002681876/4.png?ex=65ed9ef2&is=65db29f2&hm=f36177aed5fe2ba3fbc7acf6d3938aba62934b9202d206e8ffcae6be2713a67a&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_table_1',
        ['price'] = 150,
        ['label'] = 'GCOM table Single',
        ['description'] = 'Modern table, minimalist style with white and brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('table', table1Items)
    exports['qs-housing']:AddFurniture('pc-table', table1Items)
    exports['qs-housing']:AddFurniture('couchtable', table1Items)

    -- Table 2
    local table2Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211279841861570620/5.png?ex=65ed9f42&is=65db2a42&hm=6a64e6b92f01977557c1e65d7ec49680594fac9293fec1fa1fdd1cc76325c2f7&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_table_2',
        ['price'] = 150,
        ['label'] = 'GCOM crystal table',
        ['description'] = 'Huge glass table, with high quality brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('table', table2Items)
    exports['qs-housing']:AddFurniture('pc-table', table2Items)
    exports['qs-housing']:AddFurniture('couchtable', table2Items)

    -- Wardrobe 1
    local wardrobe1Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211281291056521309/6.png?ex=65eda09c&is=65db2b9c&hm=0e61b604328451f7debf7c14111c610dc9098fb4fc51a2ecb9b3bc98b3a20cc0&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_wall',
        ['price'] = 150,
        ['label'] = 'GCOM wall wardrobe',
        ['description'] = 'Giant shelf where you can store everything except clothes!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', wardrobe1Items)

    -- Wardrobe 2
    local wardrobe2Items = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211281720897441814/7.png?ex=65eda102&is=65db2c02&hm=d1afb127d36bab78bdbe3dca150ee5fa19c0a0b0248d3ed5566394c972b7ef53&=&format=webp&quality=lossless',
        ['object'] = 'gcom_dec_pack_wardrobe_1',
        ['price'] = 450,
        ['label'] = 'GCOM clear wardrobe',
        ['description'] = 'Set of beautiful shelves with glass and rhinestones',
        ['colorlabel'] = 'Big',
        ['colors'] = {
            {
                label = 'Small',
                object = 'gcom_dec_pack_wardrobe_2',
                price = 320,
                type = 'gardrobe',
                offset = { x = 0.0, y = 0.0, z = 0.0 }
            },
        },
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', wardrobe2Items)

    -- Wardrobe mumrm
    local murmCabinetItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211282029618921534/8.png?ex=65eda14c&is=65db2c4c&hm=47f213fa1dc146bc98840fdbff0f6790555a8a4573a8a82d31ce6b5ee060fbab&=&format=webp&quality=lossless',
        ['object'] = 'murm_dec_pack_cabinet',
        ['price'] = 550,
        ['label'] = 'MURM wardrobe',
        ['description'] = 'Outsizedly beautiful wardrobe!',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('wardrobe', murmCabinetItems)

    -- Chair mumrm 1
    local chair1tItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211282538270818394/9.png?ex=65eda1c5&is=65db2cc5&hm=cad8e9d8a2f7ada791ccd104abe50d9901c39a59c3f3ec931ba1e2f8355091cb&=&format=webp&quality=lossless',
        ['object'] = 'murm_dec_pack_chair_1',
        ['price'] = 90,
        ['label'] = 'MURM single chair',
        ['description'] = 'Simple and minimalist chair with beautiful brown details',
        ['colorlabel'] = 'Brown',
        ['colors'] = {},
        type = 'gardrobe',
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    }
    exports['qs-housing']:AddFurniture('chair', chair1tItems)

    -- Dresset mumrm
    local dressertItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211282897982459904/10.png?ex=65eda21b&is=65db2d1b&hm=838b8f1417aaa5a8cd3cbdba396ae107f9c4b3205ba6f1ffa19006c3c3234782&=&format=webp&quality=lossless',
        ['object'] = 'murm_dec_pack_dresser',
        ['price'] = 220,
        ['label'] = 'MURM dresser',
        ['description'] = 'A super antique dresser made of painted and varnished pine wood',
        ['colorlabel'] = 'Black',
        ['colors'] = {},
        type = 'stash',
        offset = { x = 0.0, y = 0.0, z = 0.0 },
        stash = { maxweight = 50000, slots = 3 }
    }
    exports['qs-housing']:AddFurniture('bedsidetable', dressertItems)

    -- Sofa mumrm
    local sofaMItems = {
        ['img'] = 'https://media.discordapp.net/attachments/1166657197263036428/1211283239851925524/11.png?ex=65eda26c&is=65db2d6c&hm=f21e5808f976a06285e5c216e698814b38ab8b6ce1308dae41190ee29e43b5a4&=&format=webp&quality=lossless',
        ['object'] = 'murm_dec_pack_sofa',
        ['price'] = 350,
        ['label'] = 'MURM sofa',
        ['description'] = 'A large beautiful sofa, I dear Murm!',
        ['colorlabel'] = 'Black',
        ['colors'] = {}
    }
    exports['qs-housing']:AddFurniture('sofa', sofaMItems)
    exports['qs-housing']:AddFurniture('couch', sofaMItems)

    print('The dlc [murm_dec_pack] was completely imported, these furniture are a reality thanks to the collaboration with https://es.gta5-mods.com/users/DaMax_xY')
end)
