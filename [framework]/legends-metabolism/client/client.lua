local RSGCore = exports['legends-core']:GetCoreObject()
local isLoggedIn = false
local PlayerData = {}
local temperature = RSGCore.Functions.GetCurrentTemperature()
local incinematic = false
local inBathing = false
local showUI = true


RegisterNetEvent("HideAllUI")
AddEventHandler("HideAllUI", function()
    showUI = not showUI
end)

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = RSGCore.Functions.GetPlayerData()
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
end)


---damage, effects
Citizen.CreateThread(function()
    while true do
        Wait(7000)
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped)
            local coords = GetEntityCoords(ped)
            local thirst = RSGCore.Functions.GetPlayerData().metadata["thirst"]
            local tempCorp = RSGCore.Functions.GetCorpTemperature()
            if tempCorp <= -8 then
                SetEntityHealth(ped, health - 6)
            elseif tempCorp <= -4 then
                SetEntityHealth(ped, health - 4)
            elseif tempCorp <= 0 then
                SetEntityHealth(ped, health - 2)
            end
            if health > 0 and health < 50 and tempCorp > 0 then 
                SetEntityHealth(ped, health - 1)
                PlayPain(ped, 9, 1, true, true)
                Citizen.InvokeNative(0x4102732DF6B4005F, "MP_Downed", 0, true) -- AnimpostfxPlay
            else
                if Citizen.InvokeNative(0x4A123E85D7C4CA0B, "MP_Downed") then -- AnimpostfxIsRunning
                    Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_Downed") -- AnimpostfxStop
                end
            end
        end
    end
end)


function foo(n)
    return string.format("%.1f", n / 10^8)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    if enableShadow then 
        SetTextDropshadow(1, 0, 0, 0, 255) 
    end
    SetTextFontForCurrentCommand(7)
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if isLoggedIn and incinematic == false and inBathing == false and showUI then        
            DrawTxt(
                "Hora : "..string.format("%0.2d", GetClockHours())..":"..string.format("%0.2d", GetClockMinutes()), 0.01, 0.97, 0.4, 0.4, true, 255, 255, 255, 255, true)
        end
    end
end)

-- check cinematic and hide hud
CreateThread(function()
    while true do
        if LocalPlayer.state['isLoggedIn'] then
            local cinematic = Citizen.InvokeNative(0xBF7C780731AADBF8, Citizen.ResultAsInteger())
            local isBathingActive = exports['legends-bathing']:IsBathingActive()

            if cinematic == 1 then
                incinematic = true
            else
                incinematic = false
            end

            if isBathingActive then
                inBathing = true
            else
                inBathing = false
            end
        end

        Wait(500)
    end
end)
