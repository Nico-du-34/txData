function SetData()
    players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert( players, player )
end

    
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', "~b~Los Santos Horizon • ~p~ https://discord.gg/Q8xs5tpCJH  •  ~b~ID: ~p~"..id) -- Mettre le nom de votre serveur et votre invite Discord
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        SetData()
    end
end)

Citizen.CreateThread(function()
    while true do
        AddTextEntry('PM_SCR_MAP', '~b~Carte')
        AddTextEntry('PM_SCR_GAM', '~r~Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', '~g~Logs')
        AddTextEntry('PM_SCR_SET', '~p~Configuration')
        AddTextEntry('PM_SCR_STA', '~b~Statistiques')
        AddTextEntry('PM_SCR_GAL', '~y~Galerie')
        AddTextEntry('PM_SCR_RPL', '~y~Éditeur ∑')
        AddTextEntry('PM_PANE_CFX', '~y~Los Santos Horizon') -- MEttre le nom de votre serveur
        AddTextEntry('PM_PANE_LEAVE', '~p~Se déconnecter de Los Santos Horizon'); -- Mettre le nom de votre serveur
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
        Citizen.Wait(5000)
    end
end)