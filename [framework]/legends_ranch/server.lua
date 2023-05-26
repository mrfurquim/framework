local RSGCore = exports['legends-core']:GetCoreObject()

RegisterServerEvent("ricx_farmanimals:deleteped_s")
AddEventHandler("ricx_farmanimals:deleteped_s", function(ent)
    TriggerClientEvent("ricx_farmanimals:deleteped_c", -1, ent)
end)

RegisterServerEvent("ricx_buy_farmanimal:check")
AddEventHandler("ricx_buy_farmanimal:check", function()
    local _source = source
    local go = true
    if Config.MenuJob ~= false then
        go = false
        TriggerEvent(RSGCore.Functions.GetPlayer(), function(player)
            local job = player.PlayerData.job
            for i, v in pairs(Config.MenuJob) do
                if v == job then
                    go = true
                    break
                end
            end
        end)
    end
    if go then
        TriggerClientEvent("ricx_buy_farmanimal", _source)
    else
        TriggerClientEvent("Notification:left_farmanimals", _source, Config.Options.Messages.AnimalShop,
            Config.Options.Messages.NoJob, 'menu_textures', 'stamp_locked_rank', 3000)
    end
end)

RegisterServerEvent('ricx_farmanimal:buyanimal')
AddEventHandler('ricx_farmanimal:buyanimal', function(name, model, preset, price)
    local _source = source
    local _price = tonumber(price)
    local _model = tonumber(model)
    local _preset = tonumber(preset)
    local _name = tostring(name)
    local Player = RSGCore.Functions.GetPlayer(source)
    local cid = Player.PlayerData.cid
    local citizenid = Player.PlayerData.citizenid
    local currentMoney = Player.Functions.GetMoney('cash')
    if currentMoney < _price then
        TriggerClientEvent("Notification:left_farmanimals", _source, Config.Options.MenuTexts.Title,
            Config.Options.Messages.NoMoney, 'menu_textures', 'stamp_locked_rank', 3000)
        return
    else
        local animalid = math.random(1, 999999)
        local Parameters = {
            ['cid'] = cid,
            ['citizenid'] = citizenid,
            ['animalid'] = animalid,
            ['model'] = _model,
            ['preset'] = _preset,
            ['name'] = _name,
            ['xp'] = 0,
            ['price'] = _price
        }
        MySQL.Async.execute(
            "INSERT INTO farmanimals (`cid`, `citizenid`, `animalid`, `model`, `preset`, `name`, `xp`, `price`) VALUES (@cid, @citizenid, @animalid, @model, @preset, @name, @xp, @price)",
            Parameters)
        TriggerClientEvent("Notification:left_farmanimals", _source, Config.Options.MenuTexts.Title,
            Config.Options.Messages.BoughtAnimal, 'menu_textures', 'stamp_locked_rank', 3000)
        Player.Functions.RemoveMoney("cash", _price)
    end
end)

RegisterServerEvent('ricx_farmanimal:getFarmAnimals')
AddEventHandler('ricx_farmanimal:getFarmAnimals', function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local cid = Player.PlayerData.cid
    TriggerEvent('ricx_farmanimal:getFarmAnimals_db', citizenid, cid, function(call)
        if call then
            TriggerClientEvent('ricx_farmanimal:putInTable', _source, call)
        end
    end)
end)

RegisterServerEvent('ricx_farmanimal:getFarmAnimals_db')
AddEventHandler('ricx_farmanimal:getFarmAnimals_db', function(citizenid, cid, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM farmanimals WHERE `citizenid`=@citizenid AND `cid`=@cid;', {
        citizenid = citizenid,
        cid = cid
    }, function(animals)
        if animals[1] then
            Callback(animals)
        else
            Callback(false)
        end
    end)
end)

RegisterServerEvent('ricx_farmanimal:SetAnimal')
AddEventHandler('ricx_farmanimal:SetAnimal', function(model, name, preset, xp, price, animalid)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local cid = Player.PlayerData.cid
    MySQL.Async.fetchAll(
        'SELECT * FROM farmanimals WHERE `citizenid`=@citizenid AND `cid`=@cid AND `animalid`=@animalid AND `model`=@model AND `name`=@name;',
        {
            citizenid = citizenid,
            cid = cid,
            animalid = animalid,
            model = model,
            name = name
        }, function(animals)
            if animals[1] then
                TriggerClientEvent('ricx_farmanimal:spawnanimal', _source, model, name, preset, xp, price, animalid)
            end
        end)
end)

RegisterServerEvent('ricx_farmanimal:DeleteAnimal')
AddEventHandler('ricx_farmanimal:DeleteAnimal', function(model, name, preset, xp, price, animalid, killerid)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local cid = Player.PlayerData.cid
    MySQL.Async.fetchAll(
        'DELETE FROM farmanimals  WHERE `citizenid`=@citizenid AND `cid`=@cid AND`animalid`=@animalid AND `model`=@model AND `name`=@name;',
        {
            citizenid = citizenid,
            cid = cid,
            animalid = animalid,
            model = model,
            name = name
        }, function(result)
            TriggerClientEvent("Notification:left_farmanimals", _source, Config.Options.MenuTexts.DelAnimal, name,
                'menu_textures', 'cross', 3000)
        end)
end)

RegisterServerEvent('ricx_farmanimal:SellAnimal')
AddEventHandler('ricx_farmanimal:SellAnimal', function(id, model, name, preset, xp, price, animalid, odds)
    local _source = source
    local _price = tonumber(price)
    local odds1 = tonumber(odds)
    local _sum = _price * odds1
    local _animalid = tonumber(animalid)
    local _model = tonumber(model)
    local _name = tostring(name)
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local cid = Player.PlayerData.cid
    Player.Functions.AddMoney("cash", _sum)

    MySQL.Async.fetchAll(
        'DELETE FROM farmanimals  WHERE `citizenid`=@citizenid AND `cid`=@cid AND`animalid`=@animalid AND `model`=@model AND `name`=@name;',
        {
            citizenid = citizenid,
            cid = cid,
            animalid = _animalid,
            model = _model,
            name = _name
        }, function(result)
        end)
    TriggerClientEvent("ricx_farmanimal:soldanimal", _source, id)
end)

RegisterServerEvent("ricx_farmanimal:finishedeating")
AddEventHandler("ricx_farmanimal:finishedeating", function(data)
    local _src = source
    local Player = RSGCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local cid = Player.PlayerData.cid
    local newxp = data.xp
    if newxp < 800 then
        local Parameters = {
            ['citizenid'] = citizenid,
            ['cid'] = cid,
            ['model'] = data.model,
            ['animalid'] = data.animalid
        }
        MySQL.Async.execute(" UPDATE farmanimals SET xp ='" .. newxp ..
                                "' WHERE citizenid = @citizenid AND cid = @cid AND model = @model AND animalid = @animalid",
            Parameters)
    end
end)
