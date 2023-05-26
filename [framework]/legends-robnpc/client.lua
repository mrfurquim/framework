local RSGCore = exports['legends-core']:GetCoreObject()

local robbedRecently = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if aiming or IsControlPressed(0, 25) then
            local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))

            if aiming then
                local playerPed = GetPlayerPed(-1)
                local pCoords = GetEntityCoords(playerPed, true)
                local tCoords = GetEntityCoords(targetPed, true)

                if DoesEntityExist(targetPed) and IsPedHuman(targetPed) then
                    if robbedRecently then
                        RSGCore.Functions.Notify("Slow your roll you Thug!!")
                    elseif IsPedDeadOrDying(targetPed, true) then
                        RSGCore.Functions.Notify("Dude is DEAD MAN!!")
                    elseif GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true) >= Config.RobDistance then
                        RSGCore.Functions.Notify("He's just too far away")
                    else
                        robNpc(targetPed)
                    end
                end
            end
        end
    end
end)

function robNpc(targetPed)
    robbedRecently = true
    Citizen.CreateThread(function()
        local dict = 'random@mugging3'
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end
        TaskStandStill(targetPed, Config.RobAnimationSeconds * 1000)
        FreezeEntityPosition(targetPed, true)
        TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 8.0, -8, .01, 49, 0, 0, 0, 0)
        RSGCore.Functions.Notify('robbery_started')
        RSGCore.Functions.Progressbar("ROBBING_NPC", "Reach for the sky Pilgram!!", (Config.RobAnimationSeconds * 1000), false, true)
        Citizen.Wait(Config.RobAnimationSeconds * 1000)
        TriggerServerEvent('rsg-robnpc:server:givemoney', amount)
        FreezeEntityPosition(targetPed, false)
        RSGCore.Functions.Notify('robbery_completed', (amount))
    end)
    if Config.ShouldWaitBetweenRobbing then
        Citizen.Wait(math.random(Config.MinWaitSeconds, Config.MaxWaitSeconds) * 1000)
        RSGCore.Functions.Notify("Coast is clear you can rob again!")
    end
    robbedRecently = false
end
