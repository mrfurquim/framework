

RSGCore  = exports['legends-core']:GetCoreObject()

RegisterServerEvent("identity:getInfo")
AddEventHandler("identity:getInfo", function()
    local _source = source
    local Player = RSGCore .Functions.GetPlayer(source)
    local PlayerData = Player.PlayerData
	local job = Player.PlayerData.job.name
	local firstname = Player.PlayerData.charinfo.firstname
	local lastname = Player.PlayerData.charinfo.lastname
    local birthdate = Player.PlayerData.charinfo.birthdate
    local citizenid = Player.PlayerData.citizenid
    local completename = firstname .. ' '.. lastname
		
	TriggerClientEvent("identity:showInfo", _source, completename, birthdate, job, citizenid )
	
end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

RegisterServerEvent("identity:getInfoAnother")
AddEventHandler("identity:getInfoAnother", function(player)

    local _source = source
    local Player = RSGCore .Functions.GetPlayer(source)
    local PlayerData = Player.PlayerData
	local job = Player.PlayerData.job.name
	local firstname = Player.PlayerData.charinfo.firstname
	local lastname = Player.PlayerData.charinfo.lastname
    local birthdate = Player.PlayerData.charinfo.birthdate
	TriggerClientEvent("identity:showInfo", player, firstname, lastname, birthdate, job)
	
end)