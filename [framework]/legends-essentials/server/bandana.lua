local RSGCore = exports['legends-core']:GetCoreObject()

RSGCore.Commands.Add('bandana', 'Bandana on/off', {}, false, function(source)
    local src = source
    TriggerClientEvent('legends-bandana:client:ToggleBandana', src)
end)
