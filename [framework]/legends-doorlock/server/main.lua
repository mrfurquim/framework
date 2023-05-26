local RSGCore = exports['legends-core']:GetCoreObject()

local DoorInfo	= {}

RegisterServerEvent('legends-doorlock:updatedoorsv')
AddEventHandler('legends-doorlock:updatedoorsv', function(doorID, state, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.nokey"), 'error')
            return
        else
            TriggerClientEvent('legends-doorlock:changedoor', src, doorID, state)
        end
end)

RegisterServerEvent('legends-doorlock:updateState')
AddEventHandler('legends-doorlock:updateState', function(doorID, state, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if type(doorID) ~= 'number' then
            return
        end
        if not IsAuthorized(Player.PlayerData.job.name, Config.DoorList[doorID]) then
            return
        end
        DoorInfo[doorID] = {}
        TriggerClientEvent('legends-doorlock:setState', -1, doorID, state)
end)

function IsAuthorized(jobName, doorID)
    for _,job in pairs(doorID.authorizedJobs) do
        if job == jobName then
            return true
        end
    end
    return false
end
