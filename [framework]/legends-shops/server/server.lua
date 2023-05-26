local RSGCore = exports['legends-core']:GetCoreObject()

RegisterServerEvent('legends-shops:server:UpdateShopItems')
AddEventHandler('legends-shops:server:UpdateShopItems', function(shopType, itemData, amount)
    Config.Products[shopType][itemData.slot].amount =  Config.Products[shopType][itemData.slot].amount - amount
    if Config.Products[shopType][itemData.slot].amount <= 0 then
        Config.Products[shopType][itemData.slot].amount = 0
    end
    TriggerClientEvent('legends-shops:client:SetShopItems', -1, shopType, Config.Products[shopType])
end)

RegisterServerEvent('legends-shops:server:RestockShopItems')
AddEventHandler('legends-shops:server:RestockShopItems', function(shopType)
    if Config.Products[shopType] ~= nil then
        local randAmount = math.random(10, 50)
        for k, v in pairs(Config.Products[shopType]) do
            Config.Products[shopType][k].amount = Config.Products[shopType][k].amount + randAmount
        end
        TriggerClientEvent('legends-shops:client:RestockShopItems', -1, shopType, randAmount)
    end
end)

RSGCore.Functions.CreateCallback('legends-shops:server:getLicenseStatus', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local licenseTable = Player.PlayerData.metadata["licences"]

    if licenseTable.weapon then
        cb(true)
    else
        cb(false)
    end
end)
