local RSGCore = exports['legends-core']:GetCoreObject()

RegisterNetEvent('KickForAFK', function()
    DropPlayer(source, 'You Have Been Kicked For Being AFK')
end)

RSGCore.Functions.CreateCallback('legends-afkkick:server:GetPermissions', function(source, cb)
    cb(RSGCore.Functions.GetPermission(source))
end)
