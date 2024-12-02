local QBCore = exports['qb-core']:GetCoreObject()

local searched = {}
local canSearch = true

-- Définition des couleurs de notification par rareté
local RarityColors = {
    COMMON = "primary",    -- Bleu clair
    UNCOMMON = "info",     -- Bleu
    RARE = "success",      -- Vert
    EPIC = "warning",      -- Orange
    LEGENDARY = "error"    -- Rouge
}

-- Fonction pour obtenir la rareté
local function getRarity()
    local roll = math.random(1, 100)
    local cumulative = 0
    
    for rarity, data in pairs(Config.Rarities) do
        cumulative = cumulative + data.chance
        if roll <= cumulative then
            return rarity
        end
    end
    
    return "COMMON"
end

-- Fonction modifiée pour prendre en compte la rareté
local function GetItemWithProbability(objectType)
    local rewards = Config.Rewardes[objectType]
    if not rewards then
        print("No rewards configured for this object type: " .. tostring(objectType))
        return nil
    end

    -- Déterminer d'abord la rareté
    local rarity = getRarity()
    local rarityMult = Config.Rarities[rarity].mult
    
    -- Filtrer les items de cette rareté et ajuster leurs chances
    local possibleRewards = {}
    for _, reward in ipairs(rewards) do
        if reward.rarity == rarity then
            local adjustedReward = {
                item = reward.item,
                minAmount = math.ceil(reward.minAmount * rarityMult),
                maxAmount = math.ceil(reward.maxAmount * rarityMult),
                chance = reward.chance * rarityMult
            }
            table.insert(possibleRewards, adjustedReward)
        end
    end
    
    -- Sélectionner un item parmi ceux possibles
    for _, reward in ipairs(possibleRewards) do
        local randomChance = math.random(1, 100)
        if randomChance <= reward.chance then
            local amount = math.random(reward.minAmount, reward.maxAmount)
            return {
                item = reward.item,
                amount = amount,
                rarity = rarity
            }
        end
    end

    return nil
end

RegisterNetEvent('qb-elecsearch:client:searchelec', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for k, v in pairs(Config.ObjectsDump) do
            local elec = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, k, false, false, false)
            local elecPos = GetEntityCoords(elec)
            local dist = #(pos - elecPos)
            
            if dist < 1.8 then
                if searched[elec] then
                    QBCore.Functions.Notify("Déjà fouillé", "error")
                    return
                end
                searched[elec] = true
                TriggerEvent('qb-elecsearch:client:progressbar', Config.ObjectsDump[k])
                break
            end
        end
    end
end)

RegisterNetEvent('qb-elecsearch:client:progressbar', function(objectType)
    local reward = GetItemWithProbability(objectType)
    
    QBCore.Functions.Progressbar("elec_find", "Fouille ...", math.random(1000, 3000), false, true, {
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
        if reward and reward.item and reward.amount then
            -- Envoi unique au serveur
            TriggerServerEvent('qb-elecsearch:server:recieveItem', reward.item, reward.amount, reward.rarity)
        else
            -- Aucune récompense trouvée
            QBCore.Functions.Notify("Rien trouvé", "error")
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        QBCore.Functions.Notify("Fouille arrêtée", "error")
    end)
end)

CreateThread(function()
    for k, v in pairs(Config.ObjectsDump) do
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