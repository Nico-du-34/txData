Citizen.CreateThread(function()
    local colors = {
        -- {255, 0, 0},  -- Rosso
        -- {0, 255, 0},  -- Verde
        {0, 0, 255},   -- Blu
        {0, 0, 255},
        {0, 0, 255}
    }
    local index = 1
    local nolageffect = 3000
    while true do
        ReplaceHudColourWithRgba(142, colors[index][1], colors[index][2], colors[index][3], 255)
        index = (index % #colors) + 1
        Citizen.Wait(nolageffect)
    end
nolageffect = 0
end)