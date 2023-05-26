local RSGCore = exports['legends-core']:GetCoreObject()

-----------------------------------------------------------------------------------

-- use cleankit
RSGCore.Functions.CreateUseableItem("cleankit", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('legends-weaponsmith:client:serviceweapon', src, 'cleankit', 1)
end)

-----------------------------------------------------------------------------------

-- check player has items
RSGCore.Functions.CreateCallback('legends-weaponsmith:server:checkitems', function(source, cb, craftitems)
    local src = source
    local hasItems = false
    local icheck = 0
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(craftitems) do
        if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount then
            icheck = icheck + 1
            if icheck == #craftitems then
                cb(true)
            end
        else
            TriggerClientEvent("legends_notify.LegendsNotification", 'Você não tem os Itens', '1', 'menu_textures', 'cross', 3000)
            cb(false)
            return
        end
    end
end)

-----------------------------------------------------------------------------------

-- finish crafting
RegisterServerEvent('legends-weaponsmith:server:finishcrafting')
AddEventHandler('legends-weaponsmith:server:finishcrafting', function(craftitems, receive)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- remove craftitems
    for k, v in pairs(craftitems) do
        if Config.Debug == true then
            print(v.item)
            print(v.amount)
        end
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
    end
    -- add items
    Player.Functions.AddItem(receive, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")
    TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.crafting_finished'), 'success')
end)

-----------------------------------------------------------------------------------
