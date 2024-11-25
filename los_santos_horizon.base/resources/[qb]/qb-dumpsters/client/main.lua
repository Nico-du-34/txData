local QBCore = exports['qb-core']:GetCoreObject()

local searched = {}
local canSearch = true

-- Fonction utilitaire pour choisir un item en fonction de sa probabilité
local function GetItemWithProbability(objectType)
    local rewards = Config.Rewardes[objectType]
    if not rewards then
        print("No rewards configured for this object type: " .. tostring(objectType))
        return nil
    end

    for _, reward in ipairs(rewards) do
        local randomChance = math.random(1, 100) -- Génère un nombre entre 1 et 100
        if randomChance <= reward.chance then
            local amount = math.random(reward.minAmount, reward.maxAmount)
            return {item = reward.item, amount = amount}
        end
    end

    -- Si aucun objet n'est sélectionné, retourner nil
    return nil
end

RegisterNetEvent('qb-elecsearch:client:searchelec', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local elecFound = false

        for k, v in pairs(Config.Objects) do
            local elec = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, k, false, false, false)
            local elecPos = GetEntityCoords(elec)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, elecPos.x, elecPos.y, elecPos.z, true)
            if dist < 1.8 then
                if searched[elec] ~= nil then
                    QBCore.Functions.Notify("Déjà fouillé", "error")
                    return
                end
                searched[elec] = true
                TriggerEvent('qb-elecsearch:client:progressbar', Config.Objects[k])
            end
        end
    end
end)

RegisterNetEvent('qb-elecsearch:client:progressbar', function(objectType)
    local reward = GetItemWithProbability(objectType)
    QBCore.Functions.Progressbar("elec_find", "Fouille ...", math.random(5000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        if reward then
            -- Si un item est trouvé
            QBCore.Functions.Notify("J'ai trouvé " .. reward.amount .. "x " .. reward.item, "success")
            TriggerServerEvent('qb-elecsearch:server:recieveItem', reward.item, reward.amount)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[reward.item], "add")
        else
            -- Si rien n'est trouvé
            QBCore.Functions.Notify("Rien trouvé", "error")
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        QBCore.Functions.Notify("Fouille arrêtée", "error")
    end)
end)

CreateThread(function()
    for k, v in pairs(Config.Objects) do
        exports['qb-target']:AddTargetModel(k, {
            options = {
                {
                    type = "client",
                    event = "qb-elecsearch:client:searchelec",
                    icon = "fas fa-pencil-ruler",
                    label = "Fouille",
                },
            },
            distance = 2.1
        })
    end
end)
