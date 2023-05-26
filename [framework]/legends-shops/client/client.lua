local RSGCore = exports['legends-core']:GetCoreObject()
local store


Citizen.CreateThread(function()
    local model = GetHashKey(Config.ObjectModel) -- Altera o modelo do NPC para o modelo do objeto
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    -- for store, v in pairs(Config.Locations) do
    --     exports['legends-core']:createPrompt(v.location, v.shopcoords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.open') .. v.name, {
    --         type = 'client',
    --         event = 'legends-shops:openshop',
    --         args = { v.products, v.name },
    --     })

    --     if v.showblip == true then
    --         local StoreBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.shopcoords)
    --         if v.products == "normal" or v.products == "weapons" or v.products == "saloon" then
    --             SetBlipSprite(StoreBlip, v.blipsprite, true)
    --             SetBlipScale(StoreBlip, v.blipscale)
    --         end
    --     end
    -- end

    for _, v in pairs(Config.Locations) do
        local bookspawn = v.bookspawn
        local book = CreateObject(model, bookspawn, true, false, false) -- Cria um objeto no lugar do NPC
        if v.name == 'Rhodes General Store' then
            SetEntityRotation(book, 0, 0, -115.45453643798828)
        elseif v.name == 'Valentine General Store' then
            SetEntityRotation(book, 0, 0, 54.99921035766601)
        elseif v.name == 'Strawberry General Store' then
            SetEntityRotation(book, 0, 0, -125.13414001464844)
        elseif v.name == 'Saint Denis General Store' then
            SetEntityRotation(book, 0, 0, -175.43414306640625)
        elseif v.name == 'Tumbleweed General Store' then
            SetEntityRotation(book, 0, 0, -52.8626823425293)
        elseif v.name == 'Armadillo General Store' then
            SetEntityRotation(book, 0, 0, 89.48053741455078)
        elseif v.name == 'Blackwater General Store' then
            SetEntityRotation(book, 0, 0, 0)
        elseif v.name == 'Van Horn General Store' then
            SetEntityRotation(book, 0, 0, 79.25359344482422)
        end
        if v.showblip == true then
            local StoreBlip = Citizen.InvokeNative(0x554D9D53F696D002, 819673798, v.bookspawn)
            if v.products == "normal" or v.products == "weapons" or v.products == "saloon" then
            SetBlipSprite(StoreBlip, v.blipsprite, true)
            SetBlipScale(StoreBlip, v.blipscale)
            end
        end
        
        exports['legends-target']:AddTargetEntity(book, {
            options = {
                {
                    type = "client",
                    --icon = "far fa-eye",
                    label = "Abrir " ..v.name, --"Abrir Loja",
                    action = function() 
                        TriggerEvent('legends-shops:openshop', v.products, v.name)
                    end,
                }
            },
            distance = 3.0,
        })
    end
end)



RegisterNetEvent('legends-shops:openshop')
AddEventHandler('legends-shops:openshop', function(shopType, shopName)
    local type = shopType
    local shop = shopName
    local ShopItems = {}
    ShopItems.items = {}
    RSGCore.Functions.TriggerCallback('legends-shops:server:getLicenseStatus', function(result)
        ShopItems.label = shop
        if type == "weapon" then
            if result then
                ShopItems.items =  Config.Products[type]
            else
                for i = 1, #Config.Products[type] do
                    if not Config.Products[type][i].requiresLicense then
                        table.insert(ShopItems.items, Config.Products[type][i])
                    end
                end
            end
        else
            ShopItems.items = Config.Products[type]
        end
        ShopItems.slots = 30
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..type, ShopItems)
        
    end)
end)
RegisterNetEvent('legends-shops:client:UpdateShop')
AddEventHandler('legends-shops:client:UpdateShop', function(shopType, itemData, amount)
    TriggerServerEvent('legends-shops:server:UpdateShopItems', shopType, itemData, amount)
end)

RegisterNetEvent('legends-shops:client:SetShopItems')
AddEventHandler('legends-shops:client:SetShopItems', function(shopType, shopProducts)
    Config.Products[shopType] = shopProducts
end)

RegisterNetEvent('legends-shops:client:RestockShopItems')
AddEventHandler('legends-shops:client:RestockShopItems', function(shopType, amount)
    print('RESTOCK FUNCTION')
    print(shopType)
    print(amount)
    if Config.Products[shopType] ~= nil then
        for k, v in pairs(Config.Products[shopType]) do
            Config.Products[shopType][k].amount = Config.Products[shopType][k].amount + amount
        end
    end
end)

AddEventHandler('onResourceStop', function(resName)
    local player = PlayerPedId()
    local ped = GetPlayerPed(player)
    --ClearPedTasks(player)

    if resName ~= GetCurrentResourceName() then
        return
    end
    -- Destruct logic here.
    for _, object in pairs(Config.Locations) do
        local ent = GetClosestObjectOfType(object.bookspawn, 1.0, GetHashKey(Config.ObjectModel), false, false, false)
        if DoesEntityExist(ent) then
            SetEntityAsMissionEntity(ent, true, true)
            DeleteEntity(ent)
            
                exports['legends-target']:RemoveTargetEntity(ent)    
        
        
      
        end
        if object.showblip == true then
            RemoveBlip()
        end
    end
end)