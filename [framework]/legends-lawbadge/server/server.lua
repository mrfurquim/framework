local RSGCore = exports['legends-core']:GetCoreObject()

RSGCore.Commands.Add("lawbadge", 'put on / take off badge', {}, false, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == Config.LawJob and Player.PlayerData.job.onduty then
        TriggerClientEvent("legends-lawbadge:client:lawbadge", src)
    else
        TriggerClientEvent('Notification:Legends', src, 'Precisa estar em Serviço', '' ,'menu_textures', 'menu_icon_alert', 3000)
    end
end)
--