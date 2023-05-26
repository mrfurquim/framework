local RSGCore = exports['legends-core']:GetCoreObject()

------------------------------------------------------------------------------------------------------------------------

-- death actions remove inventory / cash
RegisterNetEvent('legends-medic:server:deathactions', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Config.WipeInventoryOnRespawn == true then
        Player.Functions.ClearInventory()
        MySQL.Async.execute('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
        TriggerClientEvent('RSGCore:Notify', src, 'you lost all your possessions!', 'primary')
    end
    if Config.WipeCashOnRespawn == true then
        Player.Functions.SetMoney('cash', 0)
        TriggerClientEvent('RSGCore:Notify', src, 'you lost all your cash!', 'primary')
    end
end)

------------------------------------------------------------------------------------------------------------------------

RSGCore.Commands.Add("revive", Lang:t('info.revive_player_a'), {{name = "id", help = Lang:t('info.player_id')}}, false, function(source, args)
    local src = source
    if args[1] then
        local Player = RSGCore.Functions.GetPlayer(tonumber(args[1]))
        if Player then
            TriggerClientEvent('legends-medic:clent:adminRevive', Player.PlayerData.source)
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.not_online'), 'error')
        end
    else
        TriggerClientEvent('legends-medic:clent:playerRevive', src)
    end
end, "admin")

------------------------------------------------------------------------------------------------------------------------
RSGCore.Commands.Add("kill", Lang:t('info.kill_player'), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local target = tonumber(args[1])

    local Player = RSGCore.Functions.GetPlayer(target)

    if not Player then
        RSGCore.Functions.Notify(src, Lang:t('error.not_online'), 'error')

        return
    end

    TriggerClientEvent('legends-medic:client:KillPlayer', Player.PlayerData.source)
end, "admin")

-- set player health
RegisterNetEvent('legends-medic:server:SetHealth', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player then
        amount = tonumber(amount)
        if amount < 1 then
            amount = 1
        elseif amount > Config.MaxHealth then
            amount = Config.MaxHealth
        end
        Player.Functions.SetMetaData("health", amount)
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- medic revive player
RegisterNetEvent('legends-medic:server:RevivePlayer', function(playerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local Patient = RSGCore.Functions.GetPlayer(playerId)
    if Patient then
        if Player.PlayerData.job.name == Config.JobRequired then
            Player.Functions.RemoveItem('firstaid', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['firstaid'], "remove")
            TriggerClientEvent('legends-medic:clent:playerRevive', Patient.PlayerData.source)
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.not_medic'), 'error')
        end
    end
end)

-- medic treat wounds
RegisterNetEvent('legends-medic:server:TreatWounds', function(playerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local Patient = RSGCore.Functions.GetPlayer(playerId)
    if Patient then
        if Player.PlayerData.job.name == Config.JobRequired then
            Player.Functions.RemoveItem('bandage', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['bandage'], "remove")
            TriggerClientEvent('legends-medic:client:HealInjuries', Patient.PlayerData.source, "full")
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.not_medic'), 'error')
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- medics on duty callback
RSGCore.Functions.CreateCallback('legends-medic:server:getmedics', function(source, cb)
    local amount = 0
    local players = RSGCore.Functions.GetRSGPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == Config.JobRequired and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('legends-medic:server:medicAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = RSGCore.Functions.GetRSGPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'medic' and v.PlayerData.job.onduty then
            local alertData = {title = Lang:t('info.new_call'), coords = {coords.x, coords.y, coords.z}, description = text}
            TriggerClientEvent('legends-medic:client:medicAlert', v.PlayerData.source, coords, text)
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------
