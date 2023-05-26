local RSGCore = exports['legends-core']:GetCoreObject()
local petout = false
local pets

Citizen.CreateThread(function()
    for pets, v in pairs(Config.PetShopLocations) do
        exports['legends-core']:createPrompt(v.shopname, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'legends-pets:client:OpenPetShop',
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, Config.Blip.blipSprite, 1)
            SetBlipScale(StoreBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, Config.Blip.blipName)
        end
    end
end)

RegisterNetEvent('legends-pets:client:OpenPetShop')
AddEventHandler('legends-pets:client:OpenPetShop', function()
    local ShopItems = {}
    ShopItems.label = "Pet Shop"
    ShopItems.items = Config.PetShop
    ShopItems.slots = #Config.PetShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "PetShop_"..math.random(1, 99), ShopItems)
end)

-- call foxhound
RegisterNetEvent("legends-pets:client:callfoxhound")
AddEventHandler("legends-pets:client:callfoxhound", function()
    local hasItem = RSGCore.Functions.HasItem('foxhound', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogAmericanFoxhound_01"
            local name = "foxhound"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call sheperd
RegisterNetEvent("legends-pets:client:callsheperd")
AddEventHandler("legends-pets:client:callsheperd", function()
    local hasItem = RSGCore.Functions.HasItem('sheperd', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogAustralianSheperd_01"
            local name = "sheperd"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call coonhound
RegisterNetEvent("legends-pets:client:callcoonhound")
AddEventHandler("legends-pets:client:callcoonhound", function()
    local hasItem = RSGCore.Functions.HasItem('coonhound', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogBluetickCoonhound_01"
            local name = "coonhound"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call catahoulacur
RegisterNetEvent("legends-pets:client:callcatahoulacur")
AddEventHandler("legends-pets:client:callcatahoulacur", function()
    local hasItem = RSGCore.Functions.HasItem('catahoulacur', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogCatahoulaCur_01"
            local name = "catahoulacur"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call bayretriever
RegisterNetEvent("legends-pets:client:callbayretriever")
AddEventHandler("legends-pets:client:callbayretriever", function()
    local hasItem = RSGCore.Functions.HasItem('bayretriever', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogChesBayRetriever_01"
            local name = "bayretriever"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call collie
RegisterNetEvent("legends-pets:client:callcollie")
AddEventHandler("legends-pets:client:callcollie", function()
    local hasItem = RSGCore.Functions.HasItem('collie', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogCollie_01"
            local name = "collie"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call hound
RegisterNetEvent("legends-pets:client:callhound")
AddEventHandler("legends-pets:client:callhound", function()
    local hasItem = RSGCore.Functions.HasItem('hound', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogHound_01"
            local name = "hound"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call husky
RegisterNetEvent("legends-pets:client:callhusky")
AddEventHandler("legends-pets:client:callhusky", function()
    local hasItem = RSGCore.Functions.HasItem('husky', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogHusky_01"
            local name = "husky"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call lab
RegisterNetEvent("legends-pets:client:calllab")
AddEventHandler("legends-pets:client:calllab", function()
    local hasItem = RSGCore.Functions.HasItem('lab', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogLab_01"
            local name = "lab"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call poodle
RegisterNetEvent("legends-pets:client:callpoodle")
AddEventHandler("legends-pets:client:callpoodle", function()
    local hasItem = RSGCore.Functions.HasItem('poodle', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogPoodle_01"
            local name = "poodle"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)

-- call street
RegisterNetEvent("legends-pets:client:callstreet")
AddEventHandler("legends-pets:client:callstreet", function()
    local hasItem = RSGCore.Functions.HasItem('street', 1)
    if hasItem then
        if petout == false then
            local model = "A_C_DogStreet_01"
            local name = "street"
            doggo = newDoggo(model, name)
            petout = true
            doggo.whistle()
            Wait(Config.whistle_wait)
        else
            doggo.delete()
            petout = false
            RSGCore.Functions.Notify('sent your dog to the kennel', 'success')
        end
    else
        RSGCore.Functions.Notify('you don\'t have this pet!', 'error')
    end
end)