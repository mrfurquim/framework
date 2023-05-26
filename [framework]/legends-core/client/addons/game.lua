-- RECOIL SYSTEM
if RSGConfig.Game.WeaponRecoilSystem then
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if IsPedShooting(ped) then
                local _,wep = GetCurrentPedWeapon(ped)
                if RSGConfig.Game.WeaponRecoils[wep] and RSGConfig.Game.WeaponRecoils[wep] ~= 0 then
                    TimeValue = 0
                    repeat
                        Wait(0)
                        GameplayCamPitch = GetGameplayCamRelativePitch()
                        if RSGConfig.Game.WeaponRecoils[wep] > 0.1 then
                            SetGameplayCamRelativePitch(GameplayCamPitch+0.6, 1.2)
                            TimeValue = TimeValue+0.6
                        else
                            SetGameplayCamRelativePitch(GameplayCamPitch+0.016, 0.333)
                            TimeValue = TimeValue+0.1
                        end
                    until TimeValue >= RSGConfig.Game.WeaponRecoils[wep]
                end
            end
            Wait(0)
        end
    end)
end



--DISABLE EAGLEEYE
CreateThread(function()
    while true do
        Wait(500)
        if LocalPlayer.state.isLoggedIn then
            Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerPedId(), RSGConfig.Game.EnableEagleEye) -- _ENABLE_EAGLE_EYE
            return
        end
    end
end)


--ENABLE PVP
CreateThread(function()
    while true do
        Wait(500)
        if LocalPlayer.state.isLoggedIn then
            Citizen.InvokeNative(0xF808475FA571D823, RSGCore.Config.Game.EnablePVP) --enable friendly fire
            NetworkSetFriendlyFireOption(true)
            SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
            print("PVP Enabled")
            return
        end
    end
end)