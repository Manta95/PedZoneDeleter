RegisterServerEvent('clearAreaOfPeds')
AddEventHandler('clearAreaOfPeds', function(areas)
    TriggerClientEvent('clearAreaOfPeds', -1, areas)
end)
