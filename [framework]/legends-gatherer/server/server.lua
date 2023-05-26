local RSGCore = exports['legends-core']:GetCoreObject()

-- give wood reward
RegisterServerEvent('legends-gatherer:server:giveWoodReward')
AddEventHandler('legends-gatherer:server:giveWoodReward', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local randomNumber = math.random(1,100)
    if randomNumber > 80 then
        Player.Functions.RemoveItem('axe', 1)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items["axe"], "remove")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.your_axe_is_broken'), 'error')
    else
        local givewood = math.random(1,3)
        Player.Functions.AddItem('wood', givewood)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['wood'], "add")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_chopped_wood',{givewood = givewood}), 'success')
    end
end)
