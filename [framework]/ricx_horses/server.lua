local RSGCore = exports['legends-core']:GetCoreObject()

local maxHorsesPerPlayer = 5
local maxHorsesPerTrainer = 20
local TEXTURES = Config.Textures
local SellPoints = {}
local PlayerHorses = {}
local storages = {}

AddEventHandler('playerDropped', function()
    local _source = source

    if _source and PlayerHorses[_source] then

        TriggerClientEvent("ricx_horses:deletehorse_c", -1, PlayerHorses[_source])
        PlayerHorses[_source] = nil
    end

    for i, v in pairs(SellPoints) do
        if v.owner == _source then
            TriggerClientEvent("ricx_horses:sell:updatepoints", -1, nil, i, tonumber(v.pedid))

            SellPoints[i] = nil
        end
    end
end)
--------------------------------------------------------
--[[
RegisterServerEvent("ricx_horses:")
AddEventHandler("ricx_horses:", function()
    local _source = source

    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
    end)
end)]]
--------------------------------------------------------
RegisterServerEvent("ricx_horses:checktraining")
AddEventHandler("ricx_horses:checktraining", function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    local hasjob = false

    if not Player then return end

    if Config.JobRequired then
        local job = Player.PlayerData.job.name

        for _ ,v in pairs(Config.TrainingJobs) do
            if job == v and not hasjob then
                hasjob = true

                break
            end
        end

        if not hasjob then
            TriggerClientEvent("Notification:lefth", _source, Config.Texts.HorseTraining, Config.Texts.NoJob, TEXTURES.locked[1], TEXTURES.locked[2], 2000)

            return
        end
    end

    TriggerClientEvent("ricx_horses:training:start", _source)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:addtrainerxp")
AddEventHandler("ricx_horses:addtrainerxp",function(xp)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.cid

    MySQL.Async.fetchAll('SELECT * FROM ricxhorsetrainer WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(result)
        if not result[1] then return end

        local newxp = result[1].exp + xp

        if newxp > Config.MaxTrainerXP then
            newxp = Config.MaxTrainerXP
        end

        local Parameters = { ['identifier'] = identifier, ['charid'] = charid}

        MySQL.Async.execute(" UPDATE ricxhorsetrainer SET exp ='"..newxp.."' WHERE identifier = @identifier AND charid = @charid", Parameters)
    end)
end)
--------------------------------------------------------
RegisterServerEvent("RegisterUsableItem:horsebrush")
AddEventHandler("RegisterUsableItem:horsebrush", function(source)
    local _source = source

    TriggerClientEvent("ricx_horses:startbrush", _source)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:checkfeed")
AddEventHandler("ricx_horses:checkfeed", function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local itemData = nil
    local label = nil
    local iname = nil

    for i, v in pairs(Config.FeedItems) do
        local idata = Player.Functions.GetItemByName(v.itemname)

        if idata and idata.amount > 0 then
            itemData = idata
            label = RSGCore.Shared.Items[idata.name].label
            iname = i

            break
        end
    end

    if not itemData then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.HorseFeed, Config.Texts.NoFeedItem, TEXTURES.cross[1], TEXTURES.cross[2], 2000)

        return
    end

    Player.Functions.RemoveItem(itemData.name, 1)

    TriggerClientEvent("Notification:lefth", _source, Config.Texts.HorseFeed, Config.Texts.HorseFed.." "..label, TEXTURES.tick[1], TEXTURES.tick[2], 2000)
    TriggerClientEvent("ricx_horses:startfeed",_source, iname)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:sell:droppedupdate")
AddEventHandler("ricx_horses:sell:droppedupdate", function(id)
    TriggerClientEvent("ricx_horses:sell:updatepoints", -1, nil, tonumber(id), nil)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:sell:getpoints")
AddEventHandler("ricx_horses:sell:getpoints", function()
    TriggerClientEvent("ricx_horses:sell:gotpoints_c", source, SellPoints)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:sell:buyoffer")
AddEventHandler("ricx_horses:sell:buyoffer", function(_owner, _price, _id)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local owner = tonumber(_owner)
    local price = tonumber(_price)
    local horseid = tonumber(_id)

    if not horseid then return end

    local tidenti
    local tcharid
    local oidenti
    local ocharid
    local cango = false
    tidenti = Player.PlayerData.citizenid
    tcharid = Player.PlayerData.cid
    local max = maxHorsesPerPlayer

    for _, v in pairs(Config.TrainingJobs) do
        if Player.PlayerData.job.name == v then
            max = maxHorsesPerTrainer

            break
        end
    end

    local gonow = true

    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = tidenti, charid = tcharid}, function(horse)
        if horse then
            if #horse >= max then
                gonow = false
            end
        end
    end)

    Wait(500)

    if not gonow then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, "No more horse can be purchased", TEXTURES.locked[1], TEXTURES.locked[2], 2000)

        return
    end

    if Player.Functions.GetMoney('cash') < price then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.PlayerBuyHorse, Config.Texts.PlayerBuyNoMoney, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
        TriggerClientEvent("Notification:lefth", owner, Config.Texts.PlayerBuyHorse, Config.Texts.PlayerBuyNoMoneyAtBuyer, TEXTURES.locked[1], TEXTURES.locked[2], 2000)

        cango = false

        return
    else
        cango = true
    end

    if cango then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.PlayerBuyHorse, Config.Texts.PlayerBoughtHorse, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

        Player.Functions.RemoveMoney('cash', price)
    end

    Wait(500)

    if not cango then return end

    oidenti = Player.PlayerData.citizenid
    ocharid = Player.PlayerData.cid

    TriggerClientEvent("Notification:lefth", owner, Config.Texts.PlayerBuyHorse, Config.Texts.PlayerSoldHorse, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

    Player.Functions.AddMoney('cash', price)

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = tidenti, ['@charid'] = tcharid, ['@selected'] = 1 }, function(result)
        Wait(300)

        if result then
            MySQL.Async.execute("UPDATE ricxhorses SET selected=@selected WHERE identifier=@tidenti AND charid=@tcharid AND selected=@selected2", {['tidenti'] = tidenti, ['tcharid'] = tcharid,  ['id'] = horseid, ['selected'] = 0, ['selected2'] = 1})

            Wait(300)
        end
    end)

    Wait(500)

    local params2 = { ['oidenti'] = oidenti, ['ocharid'] = ocharid,  ['id'] = horseid, ['tcharid'] = tcharid, ['selected'] = 1,['tidenti'] = tidenti}

    while not params2.tidenti do
        Wait(1)
    end

    MySQL.Async.execute("UPDATE ricxhorses SET identifier=@tidenti, charid=@tcharid, selected=@selected WHERE identifier=@oidenti AND charid=@ocharid AND id=@id", params2)
    MySQL.Async.execute("UPDATE ricxhorsecomps SET identifier=@tidenti, charid=@tcharid WHERE identifier=@oidenti AND charid=@ocharid AND horseid=@id", params2)

    SellPoints[horseid] = nil

    TriggerClientEvent("ricx_horses:sell:updatepoints1", -1, horseid)
    TriggerClientEvent("ricx_horses:sell:finishsell", owner)
    TriggerClientEvent("ricx_horses:sell:finishsell2", _source)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:sell:stop")
AddEventHandler("ricx_horses:sell:stop", function(id)
    local _id = tonumber(id)

    if not _id then return end

    SellPoints[_id] = nil

    TriggerClientEvent("ricx_horses:sell:updatepoints1", -1, _id)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:sell:create")
AddEventHandler("ricx_horses:sell:create", function(id, price, coords, pid, pedid)
    local _source = source
    local _id = tonumber(id)

    if not _id then return end

    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    SellPoints[_id] = {}

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND id=@id", { ['@identifier'] = identifier, ['@charid'] = charid, ['@id'] = tonumber(id) }, function(result)
        if not result then return end

        SellPoints[_id] = result[1]
        SellPoints[_id].identifier = nil
        SellPoints[_id].charid = nil
        SellPoints[_id].sellprice = tonumber(price)
        SellPoints[_id].owner = _source
        SellPoints[_id].sellcoords = coords
        SellPoints[_id].pedid = tonumber(pedid)

        TriggerClientEvent("ricx_horses:sell:updatepoints", -1, SellPoints[_id], _id, nil)
    end)
end)
--------------------------------------------------------
AddEventHandler("RSGCore:Server:PlayerLoaded", function(source1)
    local _source = source1
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    -- print("Horse Data loaded for "..user.getName())

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid

    if not identifier then return end

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1 }, function(result)
        Wait(100)

        if result[1] then
            result[1].identifier, result[1].charid = nil, nil

            TriggerClientEvent("ricx_horses:foundselected", _source, result[1])
        end
    end)

    Wait(300)

    local currentxp = nil

    MySQL.Async.fetchAll("SELECT * FROM ricxhorsetrainer WHERE identifier=@identifier AND charid=@charid", { ['@identifier'] = identifier, ['@charid'] = charid}, function(result)
        Wait(100)

        if result[1] then
            currentxp = result[1].exp

            TriggerClientEvent("ricx_horses:foundxp", _source, currentxp)
        else
            local params = { ['@identifier'] = identifier, ['@charid'] = charid, ['@exp'] = 0 }
            currentxp = 0

            Wait(300)

            MySQL.Async.execute("INSERT INTO ricxhorsetrainer (identifier, charid, exp) VALUES (@identifier, @charid, @exp)",  params, function()
            end)

            TriggerClientEvent("ricx_horses:foundxp", _source, currentxp)
        end
    end)
end)

RegisterServerEvent("ricx_horses:load_playerdata")
AddEventHandler("ricx_horses:load_playerdata", function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    -- print("Horse Data loaded for "..user.getName())

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid

    if not charid then return end

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1 }, function(result)
        Wait(100)

        if result[1] then
            result[1].identifier, result[1].charid = nil, nil

            TriggerClientEvent("ricx_horses:foundselected", _source, result[1])
        end
    end)

    Wait(300)

    local currentxp = nil

    MySQL.Async.fetchAll("SELECT * FROM ricxhorsetrainer WHERE identifier=@identifier AND charid=@charid", { ['@identifier'] = identifier, ['@charid'] = charid}, function(result)
        Wait(100)

        if result[1] then
            currentxp = result[1].exp

            TriggerClientEvent("ricx_horses:foundxp", _source, currentxp)
        else
            local params = { ['@identifier'] = identifier, ['@charid'] = charid, ['@exp'] = 0 }
            currentxp = 0

            Wait(300)

            MySQL.Async.execute("INSERT INTO ricxhorsetrainer (identifier, charid, exp) VALUES (@identifier, @charid, @exp)",  params, function()
            end)

            TriggerClientEvent("ricx_horses:foundxp", _source, currentxp)
        end
    end)
end)

RegisterServerEvent("ricx_horses:checkselected")
AddEventHandler("ricx_horses:checkselected", function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid

    if not identifier then return end

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1 }, function(result)
        if result[1] then
            result[1].identifier, result[1].charid = nil, nil

            TriggerClientEvent("ricx_horses:foundselected", _source, result[1])
        end
    end)
end)
--------------------------------------------------------
RegisterServerEvent("ricx_horses:buyhorse")
AddEventHandler("ricx_horses:buyhorse", function(model, type1, price, skill, gender, name, reqjob)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local _model = tonumber(model)
    local _type = tostring(type1)
    local _price = tonumber(price)
    local _skill = tonumber(skill)
    local _gender = tonumber(gender)
    local _xp = _skill * 1000
    local _name = tostring(name)
    local user_identifier = Player.PlayerData.citizenid
    local user_charid = Player.PlayerData.cid
    local user_money = Player.Functions.GetMoney('cash')
    local job = Player.PlayerData.job.name

    Wait(200)

    local gonow = true
    local max = maxHorsesPerPlayer

    for _, v in pairs(Config.TrainingJobs) do
        if job == v then
            max = maxHorsesPerTrainer

            break
        end
    end

    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = user_identifier, charid = user_charid}, function(horse)
        if horse then
            if #horse >= max then
                gonow = false
            end
        end
    end)

    Wait(500)

    if not gonow then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, "No more horse can be purchased", TEXTURES.locked[1], TEXTURES.locked[2], 2000)

        return
    end

    if reqjob ~= false then
        if reqjob ~= job then
            TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.NoJob2, TEXTURES.locked[1], TEXTURES.locked[2], 2000)

            return
        end
    end

    if user_money < _price then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.ShopNoMoney, TEXTURES.locked[1], TEXTURES.locked[2], 2000)

        return
    end

    local components =
    {
        ['Blankets'] = 0,
        ['Horns'] = 0,
        ['Saddlebags'] = 0,
        ['Tails'] = 0,
        ['Manes'] = 0,
        ['Saddle'] = 0,
        ['Stirrup'] = 0,
        ['Bedrolls'] = 0,
        ['Lantern'] = 0,
        ['Bridles'] = 0,
        ['Masks'] = 0,
        ['Mustaches'] = 0,
        ['Shoes'] = 0,
        ['Holster'] = 0,
    }

    local _components = json.encode(components)

    local Parameters =
    {
        ['identifier'] = user_identifier,
        ['charid'] = user_charid,
        ['selected'] = 0,
        ['model'] = _model,
        ['name'] = _name,
        ['components'] = _components,
        ['sex'] = _gender,
        ['xp'] = _xp,
        ['injured'] = 0,
        ['price'] = _price,
    }

    MySQL.Async.execute("INSERT INTO ricxhorses ( `identifier`, `charid`, `selected`, `model`, `name`, `components`, `sex`, `xp`, `injured`, `price`) VALUES ( @identifier, @charid, @selected, @model, @name, @components, @sex, @xp, @injured, @price)", Parameters, function(done)
        while done ~= 1 do
            Wait(1)
        end
    end)

    Wait(300)

    local id = nil

    MySQL.Async.fetchAll('SELECT id FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = user_identifier, charid = user_charid}, function(horse)
        id = horse[#horse].id
    end)

    Wait(100)
    while not id do
        Wait(1)
    end

    local a = {}
    local emptydb = json.encode(a)

    local Parameters2 =
    {
        ['identifier'] = user_identifier,
        ['charid'] = user_charid,
        ['horseid'] = id,
        ['Blankets'] = emptydb,
        ['Horns'] = emptydb,
        ['Saddlebags'] = emptydb,
        ['Tails'] = emptydb,
        ['Manes'] = emptydb,
        ['Saddle'] = emptydb,
        ['Stirrup'] = emptydb,
        ['Bedrolls'] = emptydb,
        ['Lantern'] = emptydb,
        ['Bridles'] = emptydb,
        ['Masks'] = emptydb,
        ['Mustaches'] = emptydb,
        ['Shoes'] = emptydb,
        ['Holster'] = emptydb,
    }

    Wait(300)

    MySQL.Async.execute("INSERT INTO ricxhorsecomps ( `identifier`, `charid`, `horseid`, `Blankets`, `Horns`, `Saddlebags`, `Tails`, `Manes`, `Saddle`, `Stirrup`, `Bedrolls`, `Lantern`, `Bridles`, `Masks`, `Mustaches`, `Shoes`, `Holster`) VALUES ( @identifier, @charid, @horseid, @Blankets, @Horns, @Saddlebags, @Tails, @Manes, @Saddle, @Stirrup, @Bedrolls, @Lantern, @Bridles, @Masks, @Mustaches, @Shoes, @Holster)", Parameters2)

    TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.HorseBought, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

    Player.Functions.RemoveMoney('cash', _price)
end)
--------------------------------------------------------
RegisterServerEvent('ricx_horses:getOwnedHorses')
AddEventHandler('ricx_horses:getOwnedHorses', function(stableid)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid

    TriggerEvent('ricx_horses:getOwnedDB',identifier, charid, function(call)
        if call then
            TriggerClientEvent('ricx_horses:ownedhorses', _source, call, stableid)
        end
    end)
end)
--------------------------------------------------------
RegisterServerEvent('ricx_horses:getOwnedDB')
AddEventHandler('ricx_horses:getOwnedDB', function(identifier, charid, callback)
    local Callback = callback

    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid;', {identifier = identifier, charid = charid}, function(horses)
        Wait(500)

        if horses[1] then
            Callback(horses)
        else
            Callback(false)
        end
    end)
end)
--------------------------------------------------------
RegisterServerEvent('ricx_horses:SetHorse')
AddEventHandler('ricx_horses:SetHorse', function(hdata)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local _id = tonumber(hdata.id)
    local params = { ['identifier'] = identifier, ['charid'] = charid,  ['id'] = _id, ['selected'] = 1, ['selected0'] = 0}

    MySQL.Async.execute("UPDATE ricxhorses SET selected=@selected0 WHERE identifier=@identifier AND charid=@charid AND selected=@selected", params)

    Wait(200)

    MySQL.Async.execute("UPDATE ricxhorses SET selected=@selected WHERE  identifier=@identifier AND charid=@charid AND id=@id", params)

    Wait(200)

    MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1 }, function(result)
        if result[1] then
            result[1].identifier, result[1].charid = nil, nil

            TriggerClientEvent("ricx_horses:foundselected", _source, result[1])
            TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.MainHorse..result[1].name, TEXTURES.tick[1], TEXTURES.tick[2], 2000)
        end
    end)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:HealHorse")
AddEventHandler("ricx_horses:HealHorse",function(hdata)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local healprice = Config.HealPrice
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local money = Player.Functions.GetMoney('cash')
    local _id = hdata.id

    if money < healprice then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.HealNoMoney..healprice, TEXTURES.cross[1], TEXTURES.cross[2], 2000)

        return
    end

    local params = { ['identifier'] = identifier, ['charid'] = charid,  ['id'] = _id, ['injured'] = 0}

    MySQL.Async.execute("UPDATE ricxhorses SET injured=@injured WHERE identifier=@identifier AND charid=@charid AND id=@id", params)

    Player.Functions.RemoveMoney('cash', healprice)

    TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.HorseHealed..healprice, TEXTURES.tick[1], TEXTURES.tick[2], 2000)
    TriggerClientEvent("ricx_horses:heal:update",_source,0)
end)
--------------------------------------------------------
RegisterServerEvent('ricx_horses:DeleteHorse')
AddEventHandler('ricx_horses:DeleteHorse', function(hdata, price)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local params = {identifier = identifier, charid = charid,  id = tonumber(hdata.id)}

    MySQL.Async.fetchAll('DELETE FROM ricxhorses  WHERE `identifier`=@identifier AND `charid`=@charid AND `id`=@id;', params, function()
    end)

    Wait(100)

    MySQL.Async.fetchAll('DELETE FROM ricxhorsecomps  WHERE `identifier`=@identifier AND `charid`=@charid AND `horseid`=@id;', params, function()
    end)

    TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.SoldHorse..price, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

    Player.Functions.AddMoney('cash', price)

    if hdata.selected == 1 then
        TriggerClientEvent("ricx_horses:sell:finishsell", _source)
    end
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:addxp")
AddEventHandler("ricx_horses:addxp",function(xp, horsexp)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local _xp = tonumber(xp)
    local _horsexp = tonumber(horsexp)

    if _horsexp < 10000 then
        local Parameters = { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1, ['@xp1'] = _xp}

        MySQL.Async.execute("UPDATE ricxhorses SET xp=xp + @xp1 WHERE identifier = @identifier AND charid = @charid AND selected = @selected", Parameters, function(done)
        end)
    end

    --[[
    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid AND `selected`=@selected;', {identifier = identifier, charid = charid, selected = 1}, function(horses)
        local newxp = horses[1].xp + xp

        if newxp >= 10000 then
            newxp = 9999
        end

        local Parameters = { ['identifier'] = identifier, ['charid'] = charid, ['id'] = horses[1].id}

        MySQL.Async.execute(" UPDATE ricxhorses SET xp ='"..newxp.."' WHERE identifier = @identifier AND charid = @charid AND id = @id", Parameters)
    end)
    ]]--
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:horsedied")
AddEventHandler("ricx_horses:horsedied",function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local params = { ['identifier'] = identifier, ['charid'] = charid,  ['selected'] = 1, ['injured'] = 1}

    MySQL.Async.execute("UPDATE ricxhorses SET injured=@injured WHERE identifier=@identifier AND charid=@charid AND selected=@selected", params)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:buycomponent")
AddEventHandler("ricx_horses:buycomponent",function(cat, hash, price, hdata, opening)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local onlyupdate = false
    hdata.components[cat] = hash
    local compd2 = {}

    MySQL.Async.fetchAll('SELECT * FROM ricxhorsecomps WHERE `identifier`=@identifier AND `charid`=@charid AND `horseid`=@id;', {identifier = identifier, charid = charid, id = tonumber(hdata.id)}, function(horsecomp)
        compd2 = json.decode(horsecomp[1][cat])
    end)

    Wait(200)

    if #compd2 > 0 then
        for _, v in pairs(compd2) do
            if tonumber(v) == hash then
                TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.CompUpdated, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

                opening[4].components[cat] = hash
                onlyupdate = true

                break
            end
        end
    end

    if not onlyupdate then
        if tonumber(price) > Player.Functions.GetMoney('cash') then
            TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.CompNoMoney, TEXTURES.cross[1], TEXTURES.cross[2], 2000)

            return
        end

        if #compd2 > 0 then
            compd2[#compd2 + 1] = hash
        else
            compd2 = {hash}
        end

        local tempcat = json.encode(compd2)
        local params2 = { ['identifier'] = identifier, ['charid'] = charid,  ['id'] = tonumber(hdata.id), ['cat1'] = tempcat}

        while not params2.cat1 do
            Wait(1)
        end

        MySQL.Async.execute("UPDATE ricxhorsecomps SET "..tostring(cat).."=@cat1 WHERE identifier=@identifier AND charid=@charid AND horseid=@id", params2)

        TriggerClientEvent("ricx_horses:sendcomps:ownedhorse",_source, compd2)
    end

    Wait(300)

    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid AND `id`=@id;', {identifier = identifier, charid = charid, id = tonumber(hdata.id)}, function(horses)
        local compd = json.decode(horses[1].components)
        compd[cat] = hash
        local params = { ['identifier'] = identifier, ['charid'] = charid,  ['id'] = tonumber(hdata.id), ['components'] = json.encode(compd)}

        Wait(300)

        MySQL.Async.execute("UPDATE ricxhorses SET components=@components WHERE identifier=@identifier AND charid=@charid AND id=@id", params)

        Wait(300)

        if horses[1].selected == 1 then
            MySQL.Async.fetchAll("SELECT * FROM ricxhorses WHERE identifier=@identifier AND charid=@charid AND selected=@selected", { ['@identifier'] = identifier, ['@charid'] = charid, ['@selected'] = 1 }, function(result)
                result[1].identifier, result[1].charid = nil, nil

                TriggerClientEvent("ricx_horses:foundselected", _source, result[1])
            end)
        end
    end)

    if not onlyupdate then
        TriggerClientEvent("Notification:lefth", _source, Config.Texts.ShopTitle, Config.Texts.CompBought.." -$"..price, TEXTURES.tick[1], TEXTURES.tick[2], 2000)

        Player.Functions.RemoveMoney('cash', price)
    end

    opening[4].components[cat] = hash

    TriggerClientEvent("ricx_horses:updatecomponent:opencomps",_source,opening, hdata.components)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:removecomp")
AddEventHandler("ricx_horses:removecomp",function(horseid, cat)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local compd = nil

    MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE `identifier`=@identifier AND `charid`=@charid AND `id`=@id;', {identifier = identifier, charid = charid, id = tonumber(horseid)}, function(horses)
        compd = json.decode(horses[1].components)
    end)

    Wait(100)

    while not compd do
        Wait(100)
    end

    compd[cat] = 0
    local params2 = { ['identifier'] = identifier, ['charid'] = charid,  ['id'] = tonumber(horseid), ['cat1'] = json.encode(compd)}

    Wait(100)

    MySQL.Async.execute("UPDATE ricxhorses SET components=@cat1 WHERE identifier=@identifier AND charid=@charid AND id=@id", params2)

    TriggerClientEvent("Notification:lefth", _source, Config.Texts.HorseManage, Config.Texts.RemoveComp, TEXTURES.tick[1], TEXTURES.tick[2], 2000)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:getcomps:ownedhorse")
AddEventHandler("ricx_horses:getcomps:ownedhorse",function(horseid, cat)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)

    if not Player then return end

    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid
    local comps = nil

    MySQL.Async.fetchAll('SELECT * FROM ricxhorsecomps WHERE `identifier`=@identifier AND `charid`=@charid AND `horseid`=@id;', {identifier = identifier, charid = charid, id = tonumber(horseid)}, function(horsecomp)
        comps = json.decode(horsecomp[1][cat])
    end)

    Wait(100)

    while not comps do
        Wait(1)
    end

    TriggerClientEvent("ricx_horses:sendcomps:ownedhorse",_source, comps)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:update_horses")
AddEventHandler("ricx_horses:update_horses",function(id)
    PlayerHorses[source] = tonumber(id)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:update_storage")
AddEventHandler("ricx_horses:update_storage",function(id, hc)
    local _source = source
    local _id = tostring(id)
    local ltxt = "horse".._id
    local pos = vector3(-10000.0, -10000.0, 10000.0)
    if not storages[ltxt] then
        data.createLocker(ltxt, pos.x, pos.y, pos.z, nil)
        data.updateLockers(-1)
        storages[ltxt] = true
    end
    Wait(500)
    TriggerClientEvent('redemrp_inventory:OpenLocker', _source, ltxt)
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:deletehorse_server")
AddEventHandler("ricx_horses:deletehorse_server",function(ped)
    TriggerClientEvent("ricx_horses:deletehorse_c", -1, ped)
end)
--------------------------------------------------------