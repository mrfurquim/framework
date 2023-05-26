local RSGCore = exports['legends-core']:GetCoreObject()
local Zones = {}
local zonename = NIL
local inHostileZone = false

CreateThread(function() 
    for k=1, #Config.HostileZones do
        Zones[k] = PolyZone:Create(Config.HostileZones[k].zones, {
            name = Config.HostileZones[k].name,
            minZ =     Config.HostileZones[k].minz,
            maxZ = Config.HostileZones[k].maxz,
            debugPoly = false,
        })
        Zones[k]:onPlayerInOut(function(isPointInside)
            if isPointInside then
                inHostileZone = true
                zonename = Zones[k].name
                RSGCore.Functions.Notify('you have entered a hostle zone!', 'primary')
                TriggerEvent('legends-outlawpost:client:hostilezone', name)
            else
                inHostileZone = false
            end
        end)
    end
end)

--------------------------------------------------------------------------------------------------------------------

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- start mission npcs
RegisterNetEvent('legends-outlawpost:client:hostilezone')
AddEventHandler('legends-outlawpost:client:hostilezone', function(name)
    if name == hostile1 then
        for z, x in pairs(Config.Mission1Npcs) do
        while not HasModelLoaded( GetHashKey(Config.Mission1Npcs[z]["Model"]) ) do
            Wait(500)
            modelrequest( GetHashKey(Config.Mission1Npcs[z]["Model"]) )
        end
        local npc = CreatePed(GetHashKey(Config.Mission1Npcs[z]["Model"]), Config.Mission1Npcs[z]["Pos"].x, Config.Mission1Npcs[z]["Pos"].y, Config.Mission1Npcs[z]["Pos"].z, Config.Mission1Npcs[z]["Heading"], true, false, 0, 0)
        while not DoesEntityExist(npc) do
            Wait(300)
        end
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
        GiveWeaponToPed_2(npc, 0x64356159, 500, true, 1, false, 0.0)
        TaskCombatPed(npc, PlayerPedId())
        end
    end
end)

--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for outlaw, v in pairs(Config.OutlawLocations) do
        exports['legends-core']:createPrompt(v.location, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'legends-outlawpost:cient:openMenu',
            args = {},
        })
        if v.showblip == true then
            local OutlawPostBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(OutlawPostBlip, 3865995214, 1)
            SetBlipScale(OutlawPostBlip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, OutlawPostBlip, v.name)
        end
    end
end)

-- outlaw menu
RegisterNetEvent('legends-outlawpost:cient:openMenu', function(data)
    exports['legends-menu']:openMenu({
        {
            header = "| Outlaw Menu |",
            isMenuHeader = true,
        },
        {
            header = "Blood Money Wash",
            txt = "wash the blood off your money",
            params = {
                event = 'legends-outlawpost:client:sellbloodmoney',
                isServer = false,
                args = {}
            }
        },
        {
            header = "Sell Gold Bars",
            txt = "sell your gold bars here",
            params = {
                event = 'legends-outlawpost:client:sellgoldbars',
                isServer = false,
                args = {}
            }
        },
        {
            header = "Open Outlaw Shop",
            txt = "buy outlawed items",
            params = {
                event = 'legends-outlawpost:client:OpenOutlawShop',
                isServer = false,
                args = {}
            }
        },
        {
            header = "Close Menu",
            txt = '',
            params = {
                event = 'legends-menu:closeMenu',
            }
        },
    })
end)

-- wash blood money
RegisterNetEvent('legends-outlawpost:client:sellbloodmoney')
AddEventHandler('legends-outlawpost:client:sellbloodmoney', function()
    local moneywash = exports['legends-input']:ShowInput({
        --header = "Money Wash",
        header = "<center><p><img src=nui://"..Config.BloodMoneyImage.." width=100px></p>"..Config.BloodMoneyLabel,
        inputs = {
            {
                text = "Amount to Wash ($)",
                input = "amount",
                type = "number",
                isRequired = true
            },
        }
    })
    if moneywash ~= nil then
        for k,v in pairs(moneywash) do
            TriggerServerEvent('legends-outlawpost:server:sellbloodmoney', v)
        end
    end
end)

--------------------------------------------------------------------------------------------------------------------

-- sell gold bars
RegisterNetEvent('legends-outlawpost:client:sellgoldbars')
AddEventHandler('legends-outlawpost:client:sellgoldbars', function()
    local goldbars = exports['legends-input']:ShowInput({
        --header = "Gold Bars",
        header = "<center><p><img src=nui://"..Config.GoldBarImage.." width=100px></p>"..Config.GoldBarLabel,
        inputs = {
            {
                text = "Amount of Bars",
                input = "amount",
                type = "number",
                isRequired = true
            },
        }
    })
    if goldbars ~= nil then
        for k,v in pairs(goldbars) do
            TriggerServerEvent('legends-outlawpost:server:sellgoldbars', v)
        end
    end
end)

--------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('legends-outlawpost:client:OpenOutlawShop')
AddEventHandler('legends-outlawpost:client:OpenOutlawShop', function()
    local ShopItems = {}
    ShopItems.label = "Outlaw Shop"
    ShopItems.items = Config.OutlawShop
    ShopItems.slots = #Config.OutlawShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "OutlawShop_"..math.random(1, 99), ShopItems)
end)
