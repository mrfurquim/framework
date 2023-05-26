local RSGCore = exports['legends-core']:GetCoreObject()

-- use moonshine kit
RSGCore.Functions.CreateUseableItem("moonshinekit", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('legends-moonshiner:client:moonshinekit', source, item.name)
    end
end)

-- brew moonshine
RegisterServerEvent('legends-moonshiner:server:givemoonshine')
AddEventHandler('legends-moonshiner:server:givemoonshine', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if amount == 1 then
        Player.Functions.RemoveItem('sugar', 1)
        Player.Functions.RemoveItem('corn', 1)
        Player.Functions.RemoveItem('water', 1)
        Player.Functions.AddItem('moonshine', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['moonshine'], "add")
        RSGCore.Functions.Notify(src, Lang:t('success.you_made_some_moonshine'), 'success')
    else
        RSGCore.Functions.Notify(src, Lang:t('error.something_went_wrong'), 'error')
        print('something went wrong with moonshine script could be exploint!')
    end
end)

-- sell moonshine at vendor
RegisterServerEvent('legends-moonshiner:server:sellitem')
AddEventHandler('legends-moonshiner:server:sellitem', function(amount, data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local checkitem = Player.Functions.GetItemByName(data.item)
    if amount >= 0 then
        if checkitem ~= nil then
            local amountitem = Player.Functions.GetItemByName(data.item).amount
            if amountitem >= amount then
                totalcash = (amount * data.price) 
                Player.Functions.RemoveItem(data.item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[data.item], "remove")
                Player.Functions.AddMoney('cash', totalcash)
                TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_sold',{amount = amount,totalcash = totalcash}), 'success')
            else
                TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_that_much_on_you'), 'error')
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_an_item_on_you'), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.must_not_be_a_negative_value'), 'error')
    end
end)

RegisterServerEvent('legends-moonshiner:server:startsmoke')
AddEventHandler('legends-moonshiner:server:startsmoke', function(coords)
    local src = source
    TriggerClientEvent('legends-moonshiner:client:startsmoke', -1, coords)
end)
