local RSGCore = exports['legends-core']:GetCoreObject()

local TEXTS = Config.Texts
local TEXTURES = Config.Textures

RegisterServerEvent("ricx_wild_horse_addon:check_job")
AddEventHandler("ricx_wild_horse_addon:check_job", function()
    local _source = source 
    local player = RSGCore.Functions.GetPlayerData(source)
    local job = player.PlayerData.job.name
    if Config.RegisterJob ~= false then 
        cango = false
        if job == nil then
            print("[ricx_wild_horse_addon] Error: Unable to get player job.")
            return
        end
        for i,v in pairs(Config.RegisterJob) do 
            if v == job then 
                TriggerClientEvent("ricx_wild_horse_addon:can_register", _source)
                cango = true
                break
            end
        end
        if not cango then 
            TriggerClientEvent("Notification:left_wild_horse", _source, TEXTS.HorseTaming, TEXTS.NoJob, TEXTURES.horse[1], TEXTURES.horse[2], 3000)
        end
    else
        TriggerClientEvent("ricx_wild_horse_addon:can_register", _source)
    end
end)
