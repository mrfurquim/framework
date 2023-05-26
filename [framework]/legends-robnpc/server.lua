local RSGCore = exports['legends-core']:GetCoreObject()



RegisterServerEvent("legends-robnpc:server:givemoney")
    AddEventHandler("legends-robnpc:server:givemoney", function(amount)
    local src = source
    local ply = RSGCore.Functions.GetPlayer(src)
    local amount = (math.random(Config.MinMoney, Config.MaxMoney))
    ply.Functions.AddMoney("cash", (amount))
end)