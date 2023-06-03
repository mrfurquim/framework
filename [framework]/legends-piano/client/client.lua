local RSGCore = exports['legends-core']:GetCoreObject()
local pianoPlayed = false

RegisterNetEvent('legends-piano:PianoPlay', function(position, heading, animation)
    local pos = position
    local head = heading
    local anim = nil 
    if IsPedMale(PlayerPedId()) then 
        anim =  animation.Man
    else anim = animation.Woman end

    if not pianoPlayed then 
        pianoPlayed = true
        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey(anim), pos.x - 0.08, pos.y, pos.z + 0.03, head, 0, true, true, 0, true) 
    end      
end)

CreateThread(function()

    local modelhash = GetHashKey("p_piano03x")
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end

    for k, v in pairs(Config.PianoLocation) do  
        exports['legends-target']:AddTargetEntity(modelhash, {
            options = {
                {
                    type = "client",
                    --icon = "far fa-eye",
                    label = "Tocar Piano",
                    action = 'legends-piano:PianoPlay',
                    args = {v.SitPosition,v.SitHeading,v.Animation}
                }
            },
            distance = 3.0,
        })


        exports['legends-core']:createPrompt("legends-piano:Piano"..k, v.SitPosition, RSGCore.Shared.Keybinds['J'], 'Tocar Piano', {
            type = 'client',
            event = 'legends-piano:PianoPlay',
            args = {v.SitPosition,v.SitHeading,v.Animation}
        })
        exports['legends-core']:createPrompt("legends-piano:PianoRemove"..k, v.SitPosition, RSGCore.Shared.Keybinds['ENTER'], 'Levantar', {
            type = 'client',
            event = 'legends-piano:PianoPause',
        })
        end
end)

RegisterNetEvent('legends-piano:PianoPause', function()
    pianoPlayed = false
    ClearPedTasks(PlayerPedId())
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k,v in pairs(Config.PianoLocation) do 
            exports['legends-core']:deletePrompt('legends-piano:Piano'..k)
            exports['legends-core']:deletePrompt('legends-piano:PianoRemove'..k)
        end
    end
end)
