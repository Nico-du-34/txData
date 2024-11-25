local cached_players = {}

AddEventHandler('playerDropped', function (reason)
    local pCoords = GetEntityCoords(GetPlayerPed(source))
    cached_players[source] = {res = reason, name = GetPlayerName(source), coords = pCoords}
    TriggerClientEvent("utils:playerDisconnect", -1, source, {res = reason, name = GetPlayerName(source), pos = pCoords})
end)
