local RSGCore = exports['legends-core']:GetCoreObject()

-- use canoe
RSGCore.Functions.CreateUseableItem("canoe", function(source, item)
    local src = source
    TriggerClientEvent('legends-canoe:client:lauchcanoe', src, item.name)
end)
