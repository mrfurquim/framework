RSGCore = {}
RSGCore.Config = RSGConfig
RSGCore.Shared = RSGShared
RSGCore.ClientCallbacks = {}
RSGCore.ServerCallbacks = {}
RSGCore.PlayerCoords = {}

exports('GetCoreObject', function()
    return RSGCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local RSGCore = exports['legends-core']:GetCoreObject()

RegisterServerEvent("legends:server:RegisterCoords", function(coords)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player then
        Player.PlayerData.position[source] = coords -- Register the player's coords.
    end
end)