local RSGCore = exports['legends-core']:GetCoreObject()

RSGCore.Commands.Add("dualwield", 'dual wield weapons', {}, false, function(source, args)
    local src = source
    TriggerClientEvent('legends-dualwield:client:dualwield', src)
end)
