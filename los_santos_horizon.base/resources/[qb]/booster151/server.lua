local QBCore = exports['qb-core']:GetCoreObject()

-- Listes des cartes (en fonction de leur rareté)
local basicCards = {
    'bulbizarre_1','herbizarre_2','salameche_4', 'reptincel_5', 
    'carapuce_7', 'carabaffe_8','chenipan_10', 'chrysacier_11', 'papilusion_12', 
    'aspicot_13', 'coconfort_14', 'dardagnan_15', 'roucool_16', 'roucoups_17','roucarnage_18', 'rattata_19',
    'rattatac_20','piafabec_21','rapasdepic_22','abo_23','pikachu_25',            
    'raichu_26','sabelette_27','sablaireau_28','nidoran_f_29',          
    'nidorina_30','nidoqueen_31','nidoran_m_32','nidorino_33',           
    'nidoking_34','melofee_35','melodelfe_36','goupix_37',             
    'rondoudou_39','nosferapti_41',         
    'nosferalto_42','mystherbe_43','ortide_44','rafflesia_45',          
    'paras_46','parasect_47','mimitoss_48','aeromite_49',           
    'taupiqueur_50','triopikeur_51','miaouss_52','persian_53',            
    'psykokwak_54','akwakwak_55','ferosinge_56','colossinge_57',         
    'caninos_58','arcanin_59','ptitard_60','tetarte_61',            
    'tartard_62','abra_63','kadabra_64',        
    'machoc_66','machopeur_67','mackogneur_68','chetiflor_69',          
    'boustiflor_70','empiflor_71','tentacool_72','tentacruel_73',         
    'racaillou_74','gravalanch_75','ponyta_77',             
    'galopa_78','ramoloss_79','flagadoss_80','magneti_81',            
    'magneton_82','canarticho_83','doduo_84','dodrio_85',             
    'otaria_86','lamantine_87','tadmorv_88','grotadmorv_89',         
    'kokiyas_90','crustabri_91','fantominus_92','spectrum_93',           
    'ectoplasma_94','onix_95','soporifik_96','hypnomade_97',          
    'krabby_98','krabboss_99','voltorbe_100','electrode_101',         
    'noeunoeuf_102','noadkoko_103','osselait_104','ossatueur_105',         
    'kicklee_106','tygnon_107','excelangue_108','smogo_109',             
    'smogogo_110','rhinocorne_111','rhinoferos_112','leveinard_113',         
    'saquedeneu_114','hypotrempe_116','hypocean_117',          
    'poisirene_118','poissoroy_119','stari_120','staross_121',           
    'mmime_122','insecateur_123','elektek_125',           
    'magmar_126','scarabrute_127','tauros_128','magicarpe_129',         
    'leviator_130','lokhlass_131','metamorph_132','evoli_133',             
    'aquali_134','voltali_135','pyroli_136','porygon_137',           
    'amonita_138','amonistar_139','kabuto_140','kabutops_141',          
    'ptera_142','ronflex_143','artikodin_144',       
    'sulfura_146','minidraco_147','draco_148','dracolosse_149',        
    'mewtwo_150','fossiledome_152','fossilenautile_153',    
    'vieilambre_154','grosballon_155','transfertdeleo_156','pistecyclabe_157',      
    'aidedenina_158','stickersenergie_159','invitationderika_160','charismedegiovanni_161',
    'pinceattrapeuse_162','restes_163','lunettesdeprotection_164','bandeaurigide_165',     
    'bulbizarre_166','herbizarre_167','salameche_168','reptincel_169',         
    'carapuce_170','carabaffe_171','chenipan_172','pikachu_173',           
    'nidoking_174','psykokwak_175','tetarte_176','machopeur_177',         
    'saquedeneu_178','mmime_179','amonita_180','draco_181'
}

local rareCards = {
    'nosferapti_41'
}

local ultraCards = {
    'nosferapti_41'
}

local vmaxCards = {
    'arbok_ex_24','feunard_ex_38','grodoudou_ex_40','alakazam_ex_65','grolem_ex_76',
    'kangourex_ex_115','lippoutou_ex_124','electhor_ex_145','mew_ex_151',
    'florizarre_ex_182','dracaufeu_ex_183','tortank_ex_184','arbok_ex_185','feunard_ex_186',
    'grodoudou_ex_187','alakazam_ex_188','grolem_ex_189','kangourex_ex_190','lippoutou_ex_191',
    'electhor_ex_192','mew_ex_193','transfertdeleo_194','aidedenina_195','invitationderika_196',
    'charismedegiovanni_197','florizarre_ex_198','dracaufeu_ex_199','tortank_ex_200',
    'alakazam_ex_201','electhor_ex_202','invitationderika_203','charismedegiovanni_204'
}

local rainbowCards = {
    'mew_ex_gold_205','echange_gold_206','energiedebase_gold_207'
}

-- Item utilisable
QBCore.Functions.CreateUseableItem("booster151", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    
    -- Vérifier si le joueur a le booster
    if not Player.Functions.GetItemByName("booster151") then
        TriggerClientEvent('QBCore:Notify', source, 'Tu n\'as pas de booster151!', 'error')
        return
    end

    -- Retirer l'item
    Player.Functions.RemoveItem('booster151', 1)

    -- Déclencher l'animation côté client
    TriggerClientEvent('Cards:Client:OpenPack', source)
end)

RegisterServerEvent('Cards:Server:CompleteCardOpen')
AddEventHandler('Cards:Server:CompleteCardOpen', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Générer les cartes
    local cardsReceived = {}
    
    -- Générer 4 cartes aléatoires
    for i = 1, 4 do
        local randomChance = math.random(1, 1000)
        local card = ''

        if randomChance <= 1 then -- 0.01% de chance pour Rainbow (ultra méga rare)
            card = rainbowCards[math.random(1, #rainbowCards)]
        elseif randomChance >= 2 and randomChance <= 3 then -- 0.02% de chance pour VMAX
            card = vmaxCards[math.random(1, #vmaxCards)]
        elseif randomChance >= 4 and randomChance <= 8 then -- 0.05% de chance pour Ultra
            card = ultraCards[math.random(1, #ultraCards)]
        elseif randomChance >= 9 and randomChance <= 29 then -- 0.2% de chance pour Rare
            card = rareCards[math.random(1, #rareCards)]
        else -- 99.72% de chance pour Basic
            card = basicCards[math.random(1, #basicCards)]
        end

        table.insert(cardsReceived, card)
        Player.Functions.AddItem(card, 1)
    end

    -- Envoyer les cartes au client
    TriggerClientEvent('Cards:Client:ShowCards', src, cardsReceived)
end)

-- [Votre code pokemonbox reste inchangé]
RegisterCommand('givepokemonbox', function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local citizenId = Player.PlayerData.citizenid

    local itemName = "pokemonbox"
    local metadata = {
        inventory_id = "Pokemonbox_" .. math.random(10000, 99999),
        label = "Boîte Pokémon de " .. citizenId
    }
    Player.Functions.AddItem(itemName, 1, false, metadata)
    TriggerClientEvent('QBCore:Notify', src, "Vous avez reçu une boîte Pokémon.", "success")
    Player.Functions.RemoveItem('cash', 50, false)
    exports['mh-cashasitem']:UpdateCash(src, 'cash', 50, "remove")
end, false)

QBCore.Functions.CreateUseableItem('pokemonbox', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end

    local inventoryID = item.info and item.info.inventory_id

    if not inventoryID then
        TriggerClientEvent('QBCore:Notify', src, "Erreur: Aucun ID d'inventaire trouvé.", "error")
        return
    end

    local inventoryName = 'pokemonbox_' .. inventoryID

    local inventoryData = {
        label = "Boîte Pokémon",
        maxweight = 40,
        slots = 207,
        inventory_id = inventoryID 
    }

    exports['qb-inventory']:OpenInventory(src, inventoryName, inventoryData, function(openSuccess)
    end)
end)