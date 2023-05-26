local RSGCore = exports['legends-core']:GetCoreObject()

-- Make Bird Post as a Usable Item
RSGCore.Functions.CreateUseableItem("birdpost", function(source)
    TriggerClientEvent("legends-telegram:client:WriteMessage", source)
end)

-- Delivery Success
RegisterNetEvent("legends-telegram:server:DeliverySuccess")
AddEventHandler("legends-telegram:server:DeliverySuccess", function(sID, tPName)
    RSGCore.Functions.Notify(sID, Lang:t("success.letter_delivered", {pName = tPName}), 'success', 5000)
end)

-- Add Message to the Database
RegisterServerEvent('legends-telegram:server:SendMessage')
AddEventHandler('legends-telegram:server:SendMessage', function(senderID, sender, sendername, tgtid, subject, message)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player == nil then return end
    -- local _tgtid = tonumber(tgtid)
    local targetPlayer = RSGCore.Functions.GetPlayerByCitizenId(tgtid)
    if targetPlayer == nil then
        RSGCore.Functions.Notify(src, Lang:t('error.player_unavailable'), 'error', 5000)
        return
    end

    if not Config.AllowSendToSelf and Player.PlayerData.citizenid == tgtid then
        RSGCore.Functions.Notify(src, Lang:t('error.send_to_self'), 'error', 5000)
        return
    end

    local _citizenid = targetPlayer.PlayerData.citizenid
    local targetPlayerName = targetPlayer.PlayerData.charinfo.firstname..' '..targetPlayer.PlayerData.charinfo.lastname
    local cost = Config.CostPerLetter
    local cashBalance = Player.PlayerData.money["cash"]
    local sentDate = os.date("%x")

    if Config.ChargePlayer and cashBalance < cost then
        RSGCore.Functions.Notify(src, Lang:t('error.insufficient_balance'), 'error', 5000)
        return
    end

    exports.oxmysql:execute('INSERT INTO telegrams (`citizenid`, `recipient`, `sender`, `sendername`, `subject`, `sentDate`, `message`) VALUES (?, ?, ?, ?, ?, ?, ?)',{_citizenid, targetPlayerName, sender, sendername, subject, sentDate, message})
    TriggerClientEvent('legends-telegram:client:ReceiveMessage', targetPlayer.PlayerData.cid, senderID, targetPlayerName)

    if Config.ChargePlayer then
        Player.Functions.RemoveMoney('cash', cost, 'send-post')
    end
end)

RegisterServerEvent('legends-telegram:server:SendMessagePostOffice')
AddEventHandler('legends-telegram:server:SendMessagePostOffice', function(sender, sendername, citizenid, subject, message)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local cost = Config.CostPerLetter
    local cashBalance = Player.PlayerData.money["cash"]
    local sentDate = os.date("%x")

    if Config.ChargePlayer and cashBalance < cost then
        RSGCore.Functions.Notify(src, Lang:t('error.insufficient_balance'), 'error', 5000)
        return
    end

    local result = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = @citizenid', {citizenid = citizenid})

    if result[1] == nil then return end

    local tFirstName = json.decode(result[1].charinfo).firstname
    local tLastName = json.decode(result[1].charinfo).lastname
    local tFullName = tFirstName..' '..tLastName

    exports.oxmysql:execute('INSERT INTO telegrams (`citizenid`, `recipient`, `sender`, `sendername`, `subject`, `sentDate`, `message`) VALUES (?, ?, ?, ?, ?, ?, ?);', {citizenid, tFullName, sender, sendername, subject, sentDate, message})

    RSGCore.Functions.Notify(src, Lang:t("success.letter_delivered", {pName = tFullName}), 'success', 5000)

    if Config.ChargePlayer then
        Player.Functions.RemoveMoney('cash', cost, 'send telegram')
    end
end)

-- Check for Inbox
RegisterServerEvent('legends-telegram:server:CheckInbox')
AddEventHandler('legends-telegram:server:CheckInbox', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player == nil then return end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM telegrams WHERE citizenid = ? AND (birdstatus = 0 OR birdstatus = 1) ORDER BY id DESC',{citizenid}, function(result)
        local res = {}

        res['list'] = result or {}

        TriggerClientEvent('legends-telegram:client:InboxList', src, res)
    end)
end)

-- Get Messages from the Database
RegisterServerEvent('legends-telegram:server:GetMessages')
AddEventHandler('legends-telegram:server:GetMessages', function(tid)
    local src = source
    local telegram = {}

    local result = MySQL.query.await('SELECT * FROM telegrams WHERE id = @id AND (birdstatus = 0 OR birdstatus = 1)',
    {
        ['@id'] = tid
    })

    if result[1] == nil then
        RSGCore.Functions.Notify(src, Lang:t('error.no_message'), 'error', 3000)
        return
    end

    telegram['citizenid'] = result[1]['citizenid']
    telegram['recipient'] = result[1]['recipient']
    telegram['sender'] = result[1]['sender']
    telegram['sendername'] = result[1]['sendername']
    telegram['subject'] = result[1]['subject']
    telegram['sentDate'] = result[1]['sentDate']
    telegram['message'] = result[1]['message']

    MySQL.Async.execute("UPDATE `telegrams` SET `status` = 1, `birdstatus` = 1 WHERE id = @id",
    {
        ['@id'] = tid
    })

    TriggerClientEvent('legends-telegram:client:MessageData', src, telegram)
end)

-- Delete Message
RegisterServerEvent('legends-telegram:server:DeleteMessage')
AddEventHandler('legends-telegram:server:DeleteMessage', function(tid)
    local src = source

    local result = MySQL.query.await("SELECT * FROM telegrams WHERE id = @id",
    {
        ['@id'] = tid
    })

    if result[1] == nil then
        RSGCore.Functions.Notify(src, Lang:t('error.delete_fail'), 'error', 3000)
        return
    end

    MySQL.Async.execute("DELETE FROM telegrams WHERE id = @id",
    {
        ["@id"] = tid
    })

    RSGCore.Functions.Notify(src, Lang:t('success.delete_success') , 'success', 3000)
    TriggerClientEvent('legends-telegram:client:ReadMessages', src)
end)

-- Get Players
RSGCore.Functions.CreateCallback('legends-telegram:server:GetPlayers', function(source, cb)
    local players = {}
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM `address_book` WHERE owner = @owner  ORDER BY name ASC', {
        ["@owner"] = xPlayer.PlayerData.citizenid
    }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RSGCore.Functions.CreateCallback('legends-telegram:server:GetPlayersPostOffice', function(source, cb)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM `address_book` WHERE owner = @owner  ORDER BY name ASC', {
        ["@owner"] = xPlayer.PlayerData.citizenid
    }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)


RegisterServerEvent('legends-telegram:server:SavePerson')
AddEventHandler('legends-telegram:server:SavePerson', function(name,cid)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(0) end
    exports.oxmysql:execute('INSERT INTO address_book (`citizenid`, `name`, `owner`) VALUES (?, ?, ?);', {cid, name, xPlayer.PlayerData.citizenid})
    RSGCore.Functions.Notify(src, "New Person add Successfuly" , 'success', 3000)
end)

RegisterServerEvent('legends-telegram:server:RemovePerson')
AddEventHandler('legends-telegram:server:RemovePerson', function(cid)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(0) end
    MySQL.Async.execute("DELETE FROM address_book WHERE owner like @owner AND citizenid like @citizenid",
    {
        ["@owner"] = xPlayer.PlayerData.citizenid,
        ['citizenid'] = cid
    })

    RSGCore.Functions.Notify(src, Lang:t('success.delete_success') , 'success', 3000)
end)


-- Command
RSGCore.Commands.Add('addressbook', 'Your Personal Addressbook', {}, false, function(source)
    local src = source
    TriggerClientEvent('legends-telegram:client:OpenAddressbook', src)
end)
