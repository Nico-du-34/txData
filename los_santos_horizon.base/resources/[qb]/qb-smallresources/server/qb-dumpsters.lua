local QBCore = exports['qb-core']:GetCoreObject()

-- Fonction pour logger les erreurs
local function LogError(message, playerId, item)
    print(string.format("[qb-elecsearch] ERROR: %s (Player: %s, Item: %s)", 
        message, tostring(playerId), tostring(item)))
end

-- Fonction pour vérifier si l'item existe
local function IsValidItem(item)
    return QBCore.Shared.Items[item] ~= nil
end

-- Fonction pour obtenir la récompense en argent basée sur la rareté
local function GetMoneyReward(rarity)
    local baseReward = Config.MoneyReward
    local rarityMult = Config.Rarities[rarity] and Config.Rarities[rarity].mult or 1
    return math.floor(baseReward * rarityMult)
end

-- Variable pour éviter les doublons de récompenses
local recentRewards = {}

RegisterNetEvent('qb-elecsearch:server:recieveItem', function(item, amount, rarity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end

    -- Vérifier si le joueur a récemment reçu une récompense
    local playerTime = recentRewards[src]
    if playerTime and (os.time() - playerTime) < 1 then -- Éviter les doublons dans la même seconde
        return
    end
    recentRewards[src] = os.time()

    -- Vérifier si l'item existe dans QB-Core
    if item and not IsValidItem(item) then
        return
    end

    -- Traitement direct des items (sans RewardTypes pour le moment)
    if item then
        local itemInfo = QBCore.Shared.Items[item]
        if not itemInfo then return end

        -- Debug log avant l'ajout
        print(string.format("[qb-elecsearch] Adding item to player %s: %s x%d", src, item, amount))

        -- Tentative d'ajout de l'item
        if Player.Functions.AddItem(item, amount) then
            -- Envoi d'une seule notification avec toutes les informations
            local rarityText = rarity and string.format(" (%s)", rarity) or ""
            TriggerClientEvent('QBCore:Notify', src, string.format("Trouvé: %dx %s%s", amount, itemInfo.label, rarityText), "success")
            
            -- Mise à jour visuelle de l'inventaire
            TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")

            -- Log de succès
            print(string.format("[qb-elecsearch] SUCCESS: Player %s received %dx %s", src, amount, item))
        else
            TriggerClientEvent('QBCore:Notify', src, "Inventaire plein", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Rien trouvé", "error")
    end
end)

-- Nettoyage périodique de recentRewards
CreateThread(function()
    while true do
        Wait(60000) -- Nettoie toutes les minutes
        local currentTime = os.time()
        for src, time in pairs(recentRewards) do
            if currentTime - time > 60 then -- Supprime les entrées plus vieilles qu'une minute
                recentRewards[src] = nil
            end
        end
    end
end)