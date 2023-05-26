local RSGCore = exports['legends-core']:GetCoreObject()

RegisterServerEvent('legends-appearance:SaveSkin')
AddEventHandler('legends-appearance:SaveSkin', function(skin)
    local _skin = skin
    local _source = source
    local encode = json.encode(_skin)
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(source, 'license')
    TriggerEvent("legends-appearance:retrieveSkin", citizenid, license, function(call)
        if call then
            MySQL.Async.execute("UPDATE playerskins SET `skin` = ? WHERE `citizenid`= ? AND `license`= ?", {encode, citizenid, license})
        else
            MySQL.Async.insert('INSERT INTO playerskins (citizenid, license, skin) VALUES (?, ?, ?);', {citizenid, license, encode})
        end
    end)
    TriggerClientEvent('legends-spawn:client:setupSpawnUI', source, encode, true)
end)

RegisterServerEvent('legends-appearance:SetPlayerBucket')
AddEventHandler('legends-appearance:SetPlayerBucket', function(b)
   SetPlayerRoutingBucket(source, b)
end)

RegisterServerEvent('legends-appearance:LoadSkin')
AddEventHandler('legends-appearance:LoadSkin', function()
    local _source = source
    local User = RSGCore.Functions.GetPlayer(source)
    local citizenid = User.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(source, 'license')
    local skins = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND license = ?', {citizenid, license})
    if skins[1] then
        local skin = skins[1].skin
        local decoded = json.decode(skin)
        TriggerClientEvent("legends-appearance:ApplySkin", _source, decoded)
    else
        TriggerClientEvent("legends-appearance:OpenCreator", _source)
    end
end)

AddEventHandler('legends-appearance:retrieveSkin', function(citizenid, license, callback)
    local Callback = callback
    local skins = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND license = ?', {citizenid, license})
    if skins[1] then
        Callback(skins[1])
    else
        Callback(false)
    end
end)

RegisterServerEvent("legends-appearance:deleteSkin")
AddEventHandler("legends-appearance:deleteSkin", function(license, Callback)
    local _source = source
    local id
    for k, v in ipairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end
    local Callback = callback
    MySQL.Async.fetchAll('DELETE FROM playerskins WHERE `citizenid`= ? AND`license`= ?;', {id, license})
end)

