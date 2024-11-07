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
    -- LS customs
end)