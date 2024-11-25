CreateThread(function()
    --Bennys
    exports['qb-target']:AddCircleZone('paintboothbennys1', vector3(-220.13, -1337.5, 31.42), 3.0, {
        name = 'paintboothbennys1',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = Lang:t('target.paint'),
            icon = 'fas fa-fill-drip',
            job = "bennys",
            action = function()
                PaintCategories() -- cosmetics.lua
            end
        } },
        distance = 2.0
    })

    exports['qb-target']:AddCircleZone('paintboothbennys2', vector3(-219.95, -1342.88, 31.42), 3.0, {
        name = 'paintboothbennys2',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = Lang:t('target.paint'),
            icon = 'fas fa-fill-drip',
            job = "bennys",
            action = function()
                PaintCategories() -- cosmetics.lua
            end
        } },
        distance = 2.0
    })
    -- Redline Garage
    exports['qb-target']:AddCircleZone('paintboothredlinegarage1', vector3(967.09, -212.93, 72.99), 3.0, {
        name = 'paintboothredlinegarage1',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = Lang:t('target.paint'),
            icon = 'fas fa-fill-drip',
            job = "redlinegarage",
            action = function()
                PaintCategories() -- cosmetics.lua
            end
        } },
        distance = 2.0
    })
    exports['qb-target']:AddCircleZone('paintboothredlinegarage2', vector3(950.13, -186.96, 72.79), 3.0, {
        name = 'paintboothredlinegarage2',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = Lang:t('target.paint'),
            icon = 'fas fa-fill-drip',
            job = "redlinegarage",
            action = function()
                PaintCategories() -- cosmetics.lua
            end
        } },
        distance = 2.0
    })
    -- East Customs
    exports['qb-target']:AddCircleZone('paintboothredlinegarage1', vector3(895.9, -2102.4, 30.47), 3.0, {
        name = 'paintboothredlinegarage1',
        debugPoly = false,
        useZ = true
    }, {
        options = { {
            label = Lang:t('target.paint'),
            icon = 'fas fa-fill-drip',
            job = "eastcustom",
            action = function()
                PaintCategories() -- cosmetics.lua
            end
        } },
        distance = 2.0
    })
    
end)