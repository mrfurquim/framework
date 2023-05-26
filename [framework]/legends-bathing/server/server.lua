local RSGCore = exports['legends-core']:GetCoreObject()

BathingSessions = {}

RegisterServerEvent("legends-bathing:server:canEnterBath")
AddEventHandler("legends-bathing:server:canEnterBath", function(town)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local currentMoney = Player.PlayerData.money["cash"]

    if not BathingSessions[town] then
        if currentMoney >= Config.NormalBathPrice then
            Player.Functions.RemoveMoney("cash", Config.NormalBathPrice)
            BathingSessions[town] = src
            TriggerClientEvent("legends-bathing:client:StartBath", src, town)
        else
            print("NOTIFICATION HERE")
        end
    else
        print("NOTIFICATION HERE")
    end
end)


RegisterServerEvent("legends-bathing:server:canEnterDeluxeBath")
AddEventHandler("legends-bathing:server:canEnterDeluxeBath", function(p1 , p2 , p3)
    local src = source
    if BathingSessions[p2] == src then

        local Player = RSGCore.Functions.GetPlayer(src)
        local currentMoney = Player.PlayerData.money["cash"]
            
        if currentMoney >= Config.DeluxeBathPrice then
            Player.Functions.RemoveMoney("cash", Config.DeluxeBathPrice)
            TriggerClientEvent("legends-bathing:client:StartDeluxeBath", src , p1 , p2 , p3)
        else
            print("NOTIFICATION HERE")
            TriggerClientEvent("legends-bathing:client:HideDeluxePrompt", src)
        end
    end
end)

RegisterServerEvent("legends-bathing:server:setBathAsFree")
AddEventHandler("legends-bathing:server:setBathAsFree", function(town)
    if BathingSessions[town] == source then
        BathingSessions[town] = nil
    end
end)

AddEventHandler('playerDropped', function()
    for town,player in pairs(BathingSessions) do
        if player == source then
            BathingSessions[town] = nil
        end
    end
end)
