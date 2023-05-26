local RSGCore = exports['legends-core']:GetCoreObject()

RSGCore.Functions.CreateUseableItem("beer", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("legends-drinker:client:DrinkBeer", src, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("whiskey", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("legends-drinker:client:DrinkWhiskey", src, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("moonshine", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("legends-drinker:client:DrinkMoonshine", src, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("coffee", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("legends-drinker:client:DrinkCoffee", src, item.name)
    end
end)
