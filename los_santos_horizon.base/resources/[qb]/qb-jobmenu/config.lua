Config = {
    Jobs = {
        ["police"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertepoliceduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-bell",header = "Menu trafic", txt = "", event = "qb-jobmenu:client:scenemenu", submenu = "", subheader = "", rank = 1},
                
                {icon = "fas fa-bell",header = "menu.h_emergency", txt = "menu.t_emergency", event = "police:client:SendPoliceEmergencyAlert", submenu = "", subheader = "", rank = 1},
                {icon = "fas fa-circle-info",header = "menu.h_checkvehstatus", txt = "menu.t_checkvehstatus", event = "qb-tunerchip:client:TuneStatus", submenu = "", subheader = "", rank = 2},
                {icon = "fas fa-key",header = "menu.h_resethouse", txt = "menu.t_resethouse", event = "qb-houses:client:ResetHouse", submenu = "", subheader = "", rank = 3},
                {icon = "fas fa-id-card",header = "menu.h_takedriverlicense", txt = "menu.t_takedriverlicense", event = "police:client:SeizeDriverLicense", submenu = "", subheader = "", rank = 4},
                -- Police interactions submenu
                {icon = "fas fa-list-check",header = "menu.h_policeinteractions", txt = "menu.t_policeinteractions", event = "qb-jobmenu:client:opensubmenu", submenu = "", subheader = "policeinteractions", rank = 4},
                {icon = "fas fa-heart-pulse",header = "submenu.h_statuscheck", txt = "submenu.t_statuscheck", event = "hospital:client:CheckStatus", submenu = "policeinteractions", subheader = ""},
                {icon = "fas fa-question",header = "submenu.h_checkstatus", txt = "submenu.t_checkstatus", event = "police:client:CheckStatus", submenu = "policeinteractions", subheader = ""},
                {icon = "fas fa-user-group",header = "submenu.h_escort", txt = "submenu.t_escort", event = "police:client:EscortPlayer", submenu = "policeinteractions", subheader = ""},
                {icon = "fas fa-magnifying-glass",header = "submenu.h_searchplayer", txt = "submenu.t_searchplayer", event = "police:client:SearchPlayer", submenu = "policeinteractions", subheader = ""},
                {icon = "fas fa-user-lock",header = "submenu.h_jailplayer", txt = "submenu.t_jailplayer", event = "police:client:JailPlayer", submenu = "policeinteractions", subheader = ""},
                -- Police objects submenu
                {icon = "fas fa-road",header = "menu.h_policeobjects", txt = "menu.t_policeobjects", event = "qb-jobmenu:client:opensubmenu", submenu = "", subheader = "policeobjects", rank = 4},
                {icon = "fas fa-triangle-exclamation",header = "submenu.h_spawnpion", txt = "submenu.t_spawnpion", event = "police:client:spawnCone", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-torii-gate",header = "submenu.h_spawnhek", txt = "submenu.t_spawnhek", event = "police:client:spawnBarrier", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-sign",header = "submenu.h_spawnschotten", txt = "submenu.t_spawnschotten", event = "police:client:spawnRoadSign", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-campground",header = "submenu.h_spawntent", txt = "submenu.t_spawntent", event = "police:client:spawnTent", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-lightbulb",header = "submenu.h_spawnverlichting", txt = "submenu.t_spawnverlichting", event = "police:client:spawnLight", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-caret-up",header = "submenu.h_spikestrip", txt = "submenu.t_spikestrip", event = "police:client:SpawnSpikeStrip", submenu = "policeobjects", subheader = ""},
                {icon = "fas fa-trash",header = "submenu.h_deleteobject", txt = "submenu.t_deleteobject", event = "police:client:deleteObject", submenu = "policeobjects", subheader = ""},
            }
        },
        ["gendarmerie"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertegendarmerieduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["ambulance"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alerteambulanceduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-heart-pulse",header = "menu.h_statuscheck", txt = "menu.t_statuscheck", event = "hospital:client:CheckStatus",submenu = "", subheader = "", rank = 1},
                {icon = "fas fa-user-doctor",header = "menu.h_revivep", txt = "menu.t_revivep", event = "hospital:client:RevivePlayer",submenu = "", subheader = "", rank = 1},
                {icon = "fas fa-bandage",header = "menu.h_treatwounds", txt = "menu.t_treatwounds", event = "hospital:client:TreatWounds",submenu = "", subheader = "", rank = 1},
                {icon = "fas fa-bell",header = "menu.h_emergencybutton2", txt = "menu.t_emergencybutton2", event = "police:client:SendPoliceEmergencyAlert",submenu = "", subheader = "", rank = 1},
                {icon = "fas fa-user-group",header = "submenu.h_escort", txt = "submenu.t_escort", event = "police:client:EscortPlayer",submenu = "", subheader = "", rank = 1},
                -- Ambulance stretcher options
                {icon = "fas fa-bed-pulse",header = "menu.h_stretcheroptions", txt = "menu.t_stretcheroptions", event = "qb-jobmenu:client:opensubmenu",submenu = "", subheader = "stretcheroptions", rank = 2},
                {icon = "fas fa-plus",header = "submenu.h_spawnstretcher", txt = "submenu.t_spawnstretcher", event = "qb-radialmenu:client:TakeStretcher",submenu = "stretcheroptions", subheader = ""},
                {icon = "fas fa-minus",header = "submenu.h_despawnstretcher", txt = "submenu.t_despawnstretcher", event = "qb-radialmenu:client:RemoveStretcher",submenu = "stretcheroptions", subheader = ""},
            }
        },
        ["pompier"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertepompierduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["realestate"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alerterealestateduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["taxi"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertetaxiduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "menu.h_togglemeter", txt = "menu.t_togglemeter", event = "qb-taxi:client:toggleMeter",submenu = "", subheader = "", rank = 0},
                {icon = "fas fa-hourglass-start",header = "menu.h_togglemouse", txt = "menu.t_togglemouse", event = "qb-taxi:client:enableMeter",submenu = "", subheader = "", rank = 0},
                {icon = "fas fa-taxi",header = "menu.h_npc_mission", txt = "menu.t_npc_mission", event = "qb-taxi:client:DoTaxiNpc",submenu = "", subheader = "", rank = 0},
            }
        },
        ["cardealer"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertecardealerduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["dir"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertedirduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["vinci"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertevinciduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["norauto"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertenorautoduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
        ["brinks"] = {
            menuoptions = {
                {icon = "fas fa-mobile",header = "Alerte Télephone", txt = "Activer/Desactiver les appels entreprise", event = "qb-jobmenu:client:alertebrinksduty",submenu = "", subheader = "", rank = 0},
                --
                {icon = "fas fa-eye-slash",header = "Mission", txt = "", event = "qb-brinksjob:client:startBrinkspick",submenu = "", subheader = "", rank = 0},
            }
        },
    },
    PersonalMenu = {
        { header = "Fermer", label = "", event = "qb-jobmenu:client:Menu:Close", icon = "fas fa-circle-xmark" },
        { header = "Menu Job", label = "", event = "qb-jobmenu:client:openJobMenu", icon = "fas fa-clipboard" },
        { header = "Intéractions Joueur", label = "", event = "qb-jobmenu:client:openSubInteractionMenu", icon = "fas fa-person" },
        { header = "Vètements", label = "", event = "qb-jobmenu:client:openSubClothingMenu", icon = "fas fa-shirt" },
        ----------
        { header = "Donner son numéro", label = "", event = "qb-phone:client:GiveContactDetails", icon = "fas fa-address-book" },
        { header = "Rentrer dans le coffre", label = "", event = "qb-trunk:client:GetIn", icon = "fas fa-car" },
        { header = "Vente de drogue", label = "", event = "qb-drugs:client:cornerselling", icon = "fas fa-cannabis" },
    },
    SubInteractionMenu = {
        { header = "Retour", label = "", event = "qb-jobmenu:client:backtomenuperso", icon = "fas fa-caret-left" },
        ----------
        { header = "Menotté", label = "", event = "police:client:CuffPlayerSoft", icon = "fas fa-user-lock" },
        { header = "Mettre dans le véhicule", label = "", event = "police:client:PutPlayerInVehicle", icon = "fas fa-car-side" },
        { header = "Sortir du véhicule", label = "", event = "police:client:SetPlayerOutVehicle", icon = "fas fa-car-side" },
        { header = "Volé", label = "", event = "police:client:RobPlayer", icon = "fas fa-mask" },
        { header = "Kidnapper", label = "", event = "police:client:KidnapPlayer", icon = "fas fa-user-group" },
        { header = "Escorté", label = "", event = "police:client:EscortPlayer", icon = "fas fa-user-group" },
        { header = "Prendre en Otage", label = "", event = "A5:Client:TakeHostage", icon = "fas fa-child" },
    },
    SubClothingMenu = {
        { header = "Retour", label = "", event = "qb-jobmenu:client:backtomenuperso", icon = "fas fa-caret-left" },
        ----------
        { header = "Retirer tenue", label = "", event = "eraoutfits:client:makeoutfit", icon = "fas fa-shopping-bag" },
        { header = "Chapeau", label = "", event = "eraoutfits:client:hat", icon = "fas fa-hat-cowboy-side" },
        { header = "Masque", label = "", event = "eraoutfits:client:mask", icon = "fas fa-theater-masks" },
        { header = "Haut", label = "", event = "eraoutfits:client:shirt", icon = "fas fa-tshirt" },
        { header = "Pantalon", label = "", event = "eraoutfits:client:pant", icon = "fas fa-user" },
        { header = "Chaussures", label = "", event = "eraoutfits:client:shoes", icon = "fas fa-shoe-prints" },
        { header = "Kevlar", label = "", event = "eraoutfits:client:kevlar", icon = "fas fa-vest" },
        { header = "Coiffure", label = "", event = "eraoutfits:client:switchHair", icon = "fas fa-arrows-rotate" },
        ----------
        { header = "Extra", label = "", event = "qb-jobmenu:client:openSubClothingMenu", icon = "fas fa-plus" },
        ----------
        { header = "Lunettes", label = "", event = "eraoutfits:client:glasses", icon = "fas fa-glasses" },
        { header = "Oreille", label = "", event = "eraoutfits:client:ears", icon = "fas fa-headphones" },
        { header = "Chaînes", label = "", event = "eraoutfits:client:chains", icon = "fas fa-user-tie" },
        { header = "Visière", label = "", event = "qb-radialmenu:ToggleProps", icon = "fas fa-hat-cowboy-side" },
        { header = "Sac", label = "", event = "eraoutfits:client:bags", icon = "fas fa-shopping-bag" },
        { header = "Bracelet", label = "", event = "eraoutfits:client:bracelet", icon = "fas fa-user" },
        { header = "Montre", label = "", event = "eraoutfits:client:watch", icon = "fas fa-stopwatch" },
        { header = "Autocolant", label = "", event = "eraoutfits:client:decals", icon = "fas fa-vest-patches" },
        
    }   
}