local RSGCore = exports['legends-core']:GetCoreObject()

-- Drink

RSGCore.Functions.CreateUseableItem("water", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("coffee", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

-- EAT

RSGCore.Functions.CreateUseableItem("sandwich", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("bread", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("apple", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("chocolate", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("stew", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:EatStew", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("cooked_meat", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("cooked_fish", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

-- OTHER

RSGCore.Functions.CreateUseableItem("cigarette", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("cigar", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

RSGCore.Functions.CreateUseableItem("dual", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb:Dual", source)
end)

-- player field bandage
RSGCore.Functions.CreateUseableItem("bandage", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("hospital:client:UseBandage", source, item.name)
        TriggerEvent('legends-log:server:CreateLog', 'eat', 'Used a Bandage  ', 'green', firstname..' '..lastname..' Has Used a bandage ')
    end
end)
-- player firstaid
RSGCore.Functions.CreateUseableItem("firstaid", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("hospital:client:Usefirstaid", source, item.name)
        TriggerEvent('legends-log:server:CreateLog', 'eat', 'Used a Firstaid  ', 'green', firstname..' '..lastname..' Has Used a bandage ')
    end
end)
-- remove item
RegisterNetEvent('consumables:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item], "remove")
end)
