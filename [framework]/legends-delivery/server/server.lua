local RSGCore = exports['legends-core']:GetCoreObject()

RegisterNetEvent('legends-delivery:server:givereward', function(cashreward)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash',cashreward)
end)