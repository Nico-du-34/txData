--
--
--                                                    /$$$$$ /$$$$$$ /$$$$$$$   /$$$$$$  /$$     /$$ /$$$$$$                                                                           
--                                                   |__  $$|_  $$_/| $$__  $$ /$$__  $$|  $$   /$$//$$__  $$                                                                          
--                                                      | $$  | $$  | $$  \ $$| $$  \ $$ \  $$ /$$/| $$  \ $$                                                                          
--                                                      | $$  | $$  | $$$$$$$/| $$$$$$$$  \  $$$$/ | $$$$$$$$                                                                          
--                                                 /$$  | $$  | $$  | $$__  $$| $$__  $$   \  $$/  | $$__  $$                                                                          
--                                                | $$  | $$  | $$  | $$  \ $$| $$  | $$    | $$   | $$  | $$                                                                          
--                                                |  $$$$$$/ /$$$$$$| $$  | $$| $$  | $$    | $$   | $$  | $$                                                                          
--                                                 \______/ |______/|__/  |__/|__/  |__/    |__/   |__/  |__/                                                                          
--                                                                                                                               
--                                                                                                                               
--                                                                                                                               
--                       /$$$$$$   /$$$$$$       /$$ /$$       /$$   /$$  /$$$$$$  /$$   /$$ /$$     /$$ /$$      /$$  /$$$$$$  /$$$$$$$   /$$$$$$ 
--                      /$$__  $$ /$$__  $$     /$$/| $$      | $$  | $$ /$$__  $$| $$  /$$/|  $$   /$$/| $$$    /$$$ /$$__  $$| $$__  $$ /$$__  $$
--                     | $$  \__/| $$  \__/    /$$/ | $$      | $$  | $$| $$  \__/| $$ /$$/  \  $$ /$$/ | $$$$  /$$$$| $$  \ $$| $$  \ $$| $$  \__/
--                     | $$ /$$$$| $$ /$$$$   /$$/  | $$      | $$  | $$| $$      | $$$$$/    \  $$$$/  | $$ $$/$$ $$| $$  | $$| $$  | $$|  $$$$$$ 
--                     | $$|_  $$| $$|_  $$  /$$/   | $$      | $$  | $$| $$      | $$  $$     \  $$/   | $$  $$$| $$| $$  | $$| $$  | $$ \____  $$
--                     | $$  \ $$| $$  \ $$ /$$/    | $$      | $$  | $$| $$    $$| $$\  $$     | $$    | $$\  $ | $$| $$  | $$| $$  | $$ /$$  \ $$
--                  /$$|  $$$$$$/|  $$$$$$//$$/     | $$$$$$$$|  $$$$$$/|  $$$$$$/| $$ \  $$    | $$    | $$ \/  | $$|  $$$$$$/| $$$$$$$/|  $$$$$$/
--                 |__/ \______/  \______/|__/      |________/ \______/  \______/ |__/  \__/    |__/    |__/     |__/ \______/ |_______/  \______/ 
--                                                                                                                                                                                                                                                                                                  
if not exports.ox_target then
    print("Erreur : ox_target n'est pas chargé correctement.");
else
    print("ox_target est chargé correctement.");
end
local v0, v1, v2, v3, v4 = false, 0 - 0, false, false, false;
RegisterNetEvent("vehicle:lockUnlockDoors", function(v5)
    -- local v6 = GetVehicleDoorLockStatus(v5) >= 2;
    -- SetVehicleDoorsLocked(v5, (v6 and 1) or (2 + 0));
    -- if not v6 then
    --     local v45 = 0;
    --     while true do
    --         if (v45 == (998 - (915 + 82))) then
    --             lib.notify({
    --                 title = "Portes",
    --                 description = "Véhicule verrouillé.",
    --                 type = "info"
    --             });
    --             break
    --         end
    --         if (v45 == 0) then
    --             for v58 = -(2 - 1), GetVehicleNumberOfPassengers(v5) - (1 + 0) do
    --                 local v59 = 0 - 0;
    --                 local v60;
    --                 while true do
    --                     if (v59 == (1187 - (1069 + 118))) then
    --                         v60 = GetPedInVehicleSeat(v5, v58);
    --                         if DoesEntityExist(v60) then
    --                             SetVehicleDoorsLockedForPlayer(v5, v60, true);
    --                         end
    --                         break
    --                     end
    --                 end
    --             end
    --             SetVehicleDoorsLockedForAllPlayers(v5, true);
    --             v45 = 1;
    --         end
    --     end
    -- else
    --     for v46 = -(2 - 1), GetVehicleNumberOfPassengers(v5) - (1 - 0) do
    --         local v47 = GetPedInVehicleSeat(v5, v46);
    --         if DoesEntityExist(v47) then
    --             SetVehicleDoorsLockedForPlayer(v5, v47, false);
    --         end
    --     end
    --     SetVehicleDoorsLockedForAllPlayers(v5, false);
    --     lib.notify({
    --         title = "Portes",
    --         description = "Véhicule déverrouillé.",
    --         type = "info"
    --     });
    -- end
    print("Debug porte vérouillé")
end);
Citizen.CreateThread(function()
    while true do
        local v42 = 0 + 0;
        local v43;
        local v44;
        while true do
            if (v42 == (1 - 0)) then
                v44 = GetVehiclePedIsIn(v43, false);
                if (v44 and (GetPedInVehicleSeat(v44, -(1 + 0)) == v43)) then
                    local v61 = 0;
                    local v62;
                    while true do
                        if (v61 == (791 - (368 + 423))) then
                            v62 = GetVehicleDoorLockStatus(v44) >= (6 - 4);
                            if v62 then
                                DisableControlAction(18 - (10 + 8), 75, true);
                                DisableControlAction(103 - 76, 517 - (416 + 26),
                                                     true);
                                if (IsControlJustPressed(0 - 0, 33 + 42) or
                                    IsDisabledControlJustPressed(0 - 0, 513 -
                                                                     (145 + 293))) then
                                    lib.notify({
                                        title = "Véhicule",
                                        description = "VÉHICULE VERROUILLÉ !",
                                        type = "error"
                                    });
                                end
                            end
                            break
                        end
                    end
                end
                break
            end
            if (v42 == (430 - (44 + 386))) then
                Citizen.Wait(0);
                v43 = PlayerPedId();
                v42 = 1487 - (998 + 488);
            end
        end
    end
end);
RegisterNetEvent("vehicle:manageDoors", function(v7)
    local v8 = {
        {
            title = "Verrouiller/Déverrouiller toutes les portes",
            event = "vehicle:lockUnlockDoors",
            args = v7
        }, {
            title = "Porte Avant Gauche",
            description = ((GetVehicleDoorAngleRatio(v7, 0 + 0) >
                (772 - (201 + 571))) and "Fermer") or "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 1138 - (116 + 1022)}
        }, {
            title = "Porte Avant Droite",
            description = ((GetVehicleDoorAngleRatio(v7, 1) > (0 + 0)) and
                "Fermer") or "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 1}
        }, {
            title = "Porte Arrière Gauche",
            description = ((GetVehicleDoorAngleRatio(v7, 2) > 0) and "Fermer") or
                "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 7 - 5}
        }, {
            title = "Porte Arrière Droite",
            description = ((GetVehicleDoorAngleRatio(v7, 862 - (814 + 45)) > 0) and
                "Fermer") or "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 3}
        }, {
            title = "Coffre",
            description = ((GetVehicleDoorAngleRatio(v7, 1 + 4) > 0) and
                "Fermer") or "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 5}
        }, {
            title = "Capot",
            description = ((GetVehicleDoorAngleRatio(v7, 4) > 0) and "Fermer") or
                "Ouvrir",
            event = "vehicle:toggleDoor",
            args = {vehicle = v7, door = 4}
        }
    };
    lib.registerContext({
        id = "vehicle_doors",
        title = "Gestion des Portes",
        options = v8
    });
    lib.showContext("vehicle_doors");
end);
RegisterNetEvent("vehicle:toggleDoor", function(v9)
    local v10 = 0;
    while true do
        if (v10 == (0 + 0)) then
            if v3 then return; end
            v3 = true;
            v10 = 886 - (261 + 624);
        end
        if (v10 == (1 - 0)) then
            if (GetVehicleDoorAngleRatio(v9.vehicle, v9.door) >
                (1080 - (1020 + 60))) then
                SetVehicleDoorShut(v9.vehicle, v9.door, false);
            else
                SetVehicleDoorOpen(v9.vehicle, v9.door, false, false);
            end
            Wait(1923 - (630 + 793));
            v10 = 2;
        end
        if (v10 == (6 - 4)) then
            TriggerEvent("vehicle:manageDoors", v9.vehicle);
            v3 = false;
            break
        end
    end
end);
function openVehicleMenu()
    local v11 = 0;
    local v12;
    while true do
        if (v11 == 0) then
            v12 = GetVehiclePedIsIn(PlayerPedId(), false);
            if not DoesEntityExist(v12) then
                local v55 = 0 - 0;
                while true do
                    if (v55 == (0 + 0)) then
                        TriggerEvent("chat:addMessage", {
                            args = {"Vous n'êtes pas dans un véhicule."}
                        });
                        return;
                    end
                end
            end
            v11 = 1;
        end
        if (v11 == (1748 - (760 + 987))) then
            lib.registerContext({
                id = "vehicle_menu",
                title = "Gestion du Véhicule",
                options = {
                    {
                        title = "Extras",
                        description = "Gérer les extras",
                        event = "vehicle:manageExtras",
                        args = v12
                    }, {
                        title = "Moteur",
                        description = "Allumer/Éteindre moteur",
                        event = "vehicle:toggleEngine",
                        args = v12
                    }, {
                        title = "Portes",
                        description = "Ouvrir/Fermer portes",
                        event = "vehicle:manageDoors",
                        args = v12
                    }, {
                        title = "Fenêtres",
                        description = "Ouvrir/Fermer fenêtres",
                        event = "vehicle:manageWindows",
                        args = v12
                    }, {
                        title = "Régulateur de vitesse",
                        description = "Gérer le régulateur",
                        event = "vehicle:toggleSpeedLimiter",
                        args = v12
                    }
                }
            });
            lib.showContext("vehicle_menu");
            break
        end
    end
end
RegisterCommand("openvehmenu", openVehicleMenu, false);
RegisterKeyMapping("openvehmenu", "Gestion du véhicule", "keyboard", "=");
exports.ox_target:addEntity({
    name = "vehmenu",
    label = "Gestion du véhicule",
    icon = "fas fa-car",
    bones = {"boot", "bonnet", "engine", "door_dside_f"},
    entities = {GetVehiclePedIsIn(PlayerPedId(), false)},
    action = openVehicleMenu
});
RegisterNetEvent("vehicle:toggleSpeedLimiter", function(v13)
    local v14 = 0;
    local v15;
    while true do
        if (v14 == (1055 - (87 + 968))) then
            v15 = {
                {
                    title = "30 km/h",
                    event = "vehicle:setSpeedLimiter",
                    args = {vehicle = v13, speed = 30}
                }, {
                    title = "50 km/h",
                    event = "vehicle:setSpeedLimiter",
                    args = {vehicle = v13, speed = 50}
                }, {
                    title = "80 km/h",
                    event = "vehicle:setSpeedLimiter",
                    args = {vehicle = v13, speed = 352 - 272}
                }, {
                    title = "100 km/h",
                    event = "vehicle:setSpeedLimiter",
                    args = {vehicle = v13, speed = 226 - 126}
                }, {
                    title = "Personnalisé",
                    description = "Définir une vitesse personnalisée",
                    event = "vehicle:setCustomSpeedLimiter",
                    args = v13
                }, {
                    title = "Désactiver le régulateur",
                    description = "Désactiver la limitation de vitesse",
                    event = "vehicle:disableSpeedLimiter",
                    args = v13
                }
            };
            lib.registerContext({
                id = "speed_limiter_menu",
                title = "Régulateur de Vitesse",
                options = v15
            });
            v14 = 2 - 1;
        end
        if (v14 == (1818 - (1703 + 114))) then
            lib.showContext("speed_limiter_menu");
            break
        end
    end
end);
RegisterNetEvent("vehicle:setSpeedLimiter", function(v16)
    local v17 = 701 - (376 + 325);
    local v18;
    local v19;
    while true do
        if ((1 - 0) == v17) then
            SetVehicleMaxSpeed(v18, v19 / (8.6 - 5));
            lib.notify({
                title = "Régulateur de vitesse",
                description = "Régulateur activé à " .. v19 .. " km/h.",
                type = "success"
            });
            break
        end
        if (v17 == (0 + 0)) then
            v18 = v16.vehicle;
            v19 = v16.speed;
            v17 = 2 - 1;
        end
    end
end);
RegisterNetEvent("vehicle:setCustomSpeedLimiter", function(v20)
    local v21 = 0;
    local v22;
    while true do
        if (v21 == (14 - (9 + 5))) then
            v22 = lib.inputDialog("Vitesse personnalisée",
                                  {"Entrez la vitesse en km/h"});
            if (v22 and tonumber(v22[1266 - (243 + 1022)])) then
                local v56 = tonumber(v22[3 - 2]);
                SetVehicleMaxSpeed(v20, v56 / (3.6 + 0));
                lib.notify({
                    title = "Régulateur de vitesse",
                    description = "Régulateur activé à " .. v56 .. " km/h.",
                    type = "success"
                });
            else
                lib.notify({
                    title = "Erreur",
                    description = "Entrée invalide. Veuillez entrer une vitesse valide.",
                    type = "error"
                });
            end
            break
        end
    end
end);
RegisterNetEvent("vehicle:disableSpeedLimiter", function(v23)
    local v24 = 1180 - (1123 + 57);
    while true do
        if (v24 == 0) then
            SetVehicleMaxSpeed(v23, 0 + 0);
            lib.notify({
                title = "Régulateur de vitesse",
                description = "Régulateur désactivé.",
                type = "info"
            });
            break
        end
    end
end);
RegisterNetEvent("vehicle:toggleEngine", function(v25)
    local v26 = GetIsVehicleEngineRunning(v25);
    SetVehicleEngineOn(v25, not v26, false, true);
    lib.notify({
        title = "Moteur",
        description = (v26 and "Moteur éteint.") or "Moteur allumé.",
        type = "info"
    });
end);
RegisterNetEvent("vehicle:manageExtras", function(v27)
    local v28 = 0;
    local v29;
    while true do
        if (v28 == (254 - (163 + 91))) then
            v29 = {};
            for v54 = 1, 1942 - (1869 + 61) do
                if DoesExtraExist(v27, v54) then
                    local v63 = 0 + 0;
                    local v64;
                    while true do
                        if (v63 == 0) then
                            v64 = IsVehicleExtraTurnedOn(v27, v54);
                            table.insert(v29, {
                                title = "Extra " .. v54,
                                description = (v64 and "Désactiver") or
                                    "Activer",
                                event = "vehicle:toggleExtra",
                                args = {vehicle = v27, extra = v54}
                            });
                            break
                        end
                    end
                end
            end
            v28 = 3 - 2;
        end
        if (v28 == 1) then
            if (#v29 > (0 - 0)) then
                local v57 = 0;
                while true do
                    if (v57 == (0 + 0)) then
                        lib.registerContext({
                            id = "vehicle_extras",
                            title = "Gestion des Extras",
                            options = v29
                        });
                        lib.showContext("vehicle_extras");
                        break
                    end
                end
            else
                lib.notify({
                    title = "Extras",
                    description = "Aucun extra disponible.",
                    type = "info"
                });
            end
            break
        end
    end
end);
RegisterNetEvent("vehicle:toggleExtra", function(v30)
    local v31 = 0 - 0;
    local v32;
    local v33;
    local v34;
    while true do
        if (v31 == (0 + 0)) then
            v32 = v30.vehicle;
            v33 = v30.extra;
            v31 = 1475 - (1329 + 145);
        end
        if (v31 == (972 - (140 + 831))) then
            v34 = IsVehicleExtraTurnedOn(v32, v33);
            SetVehicleExtra(v32, v33, (v34 and (1851 - (1409 + 441))) or
                                (718 - (15 + 703)));
            break
        end
    end
end);
RegisterNetEvent("vehicle:manageWindows", function(v35)
    local v36 = 0;
    local v37;
    while true do
        if (v36 == (0 + 0)) then
            v37 = {
                {
                    title = "Fenêtre Avant Gauche",
                    description = (IsVehicleWindowIntact(v35, 0) and "Ouvrir") or
                        "Fermer",
                    event = "vehicle:toggleWindow",
                    args = {vehicle = v35, window = 1721 - (345 + 1376)}
                }, {
                    title = "Fenêtre Avant Droite",
                    description = (IsVehicleWindowIntact(v35, 4 - 3) and
                        "Ouvrir") or "Fermer",
                    event = "vehicle:toggleWindow",
                    args = {vehicle = v35, window = 2 - 1}
                }, {
                    title = "Fenêtre Arrière Gauche",
                    description = (IsVehicleWindowIntact(v35, 1208 - (696 + 510)) and
                        "Ouvrir") or "Fermer",
                    event = "vehicle:toggleWindow",
                    args = {vehicle = v35, window = 3 - 1}
                }, {
                    title = "Fenêtre Arrière Droite",
                    description = (IsVehicleWindowIntact(v35, 3) and "Ouvrir") or
                        "Fermer",
                    event = "vehicle:toggleWindow",
                    args = {vehicle = v35, window = 1 + 2}
                }
            };
            lib.registerContext({
                id = "vehicle_windows",
                title = "Gestion des Fenêtres",
                options = v37
            });
            v36 = 3 - 2;
        end
        if (v36 == (3 - 2)) then
            lib.showContext("vehicle_windows");
            break
        end
    end
end);
RegisterNetEvent("vehicle:toggleWindow", function(v38)
    local v39 = 0;
    local v40;
    local v41;
    while true do
        if (v39 == (375 - (123 + 251))) then
            if IsVehicleWindowIntact(v40, v41) then
                RollDownWindow(v40, v41);
            else
                RollUpWindow(v40, v41);
            end
            break
        end
        if ((0 - 0) == v39) then
            v40 = v38.vehicle;
            v41 = v38.window;
            v39 = 699 - (208 + 490);
        end
    end
end);
