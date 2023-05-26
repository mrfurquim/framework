local RSGCore = exports['legends-core']:GetCoreObject()
local blips = {}

-- create blips and targets
Citizen.CreateThread(function()
    for banks, v in pairs(Config.BankLocations) do
        if Config.UseTarget == false then
            exports['legends-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['RIGHT'], 'Open ' .. v.name, {
                type = 'client',
                event = 'legends-banking:openBankScreen',
                args = {},
            })
        else
            exports['legends-target']:AddCircleZone(v.name, v.coords, 1, {
                name = v.name,
                debugPoly = false,
              }, {
                options = {
                  {
                    type = "client",
                    event = 'legends-banking:openBankScreen',
                    icon = "fas fa-dollar-sign",
                    label = "Abrir Banco",
                  },
                },
                distance = 2.0,
              })
        end
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, -2128054417, 52)
            SetBlipScale(StoreBlip, 0.2)
        end
    end
end)

-- open all doors
Citizen.CreateThread(function()
    for k,v in pairs(Config.BankDoors) do
        Citizen.InvokeNative(0xD99229FE93B46286,v,1,1,0,0,0,0)
        Citizen.InvokeNative(0x6BAB9442830C7F53,v,0)
    end
end)

-- Functions

local function openAccountScreen()
    RSGCore.Functions.TriggerCallback('legends-banking:getBankingInformation', function(banking)
        if banking ~= nil then
            SetNuiFocus(true, true)
            SendNUIMessage({
                status = "openbank",
                information = banking
            })
        end
    end)
end

-- Events

RegisterNetEvent('legends-banking:transferError', function(msg)
    SendNUIMessage({
        status = "transferError",
        error = msg
    })
end)

RegisterNetEvent('legends-banking:successAlert', function(msg)
    SendNUIMessage({
        status = "successMessage",
        message = msg
    })
end)

RegisterNetEvent('legends-banking:openBankScreen', function()
    openAccountScreen()
end)

-- NUI

RegisterNetEvent("hidemenu", function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        status = "closebank"
    })
end)

RegisterNetEvent('legends-banking:client:newCardSuccess', function(cardno, ctype)
    SendNUIMessage({
        status = "updateCard",
        number = cardno,
        cardtype = ctype
    })
end)

-- NUI Callbacks

RegisterNUICallback("NUIFocusOff", function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        status = "closebank"
    })
    cb("ok")
end)

RegisterNUICallback("createSavingsAccount", function(_, cb)
    TriggerServerEvent('legends-banking:createSavingsAccount')
    cb("ok")
end)

RegisterNUICallback("doDeposit", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent('legends-banking:doQuickDeposit', data.amount)
        openAccountScreen()
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("doWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent('legends-banking:doQuickWithdraw', data.amount, true)
        openAccountScreen()
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("doATMWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent('legends-banking:doQuickWithdraw', data.amount, false)
        openAccountScreen()
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("savingsDeposit", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent('legends-banking:savingsDeposit', data.amount)
        openAccountScreen()
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("savingsWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent('legends-banking:savingsWithdraw', data.amount)
        openAccountScreen()
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("doTransfer", function(data, cb)
    if data ~= nil then
        TriggerServerEvent('legends-banking:initiateTransfer', data)
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("createDebitCard", function(data, cb)
    if data.pin ~= nil then
        TriggerServerEvent('legends-banking:createBankCard', data.pin)
        cb("ok")
    end
    cb(nil)
end)

RegisterNUICallback("lockCard", function(_, cb)
    TriggerServerEvent('legends-banking:toggleCard', true)
    cb("ok")
end)

RegisterNUICallback("unLockCard", function(_, cb)
    TriggerServerEvent('legends-banking:toggleCard', false)
    cb("ok")
end)

RegisterNUICallback("updatePin", function(data, cb)
    if data.pin and data.currentBankCard then
        TriggerServerEvent('legends-banking:updatePin', data.currentBankCard, data.pin)
        cb("ok")
    end
    cb(nil)
end)
