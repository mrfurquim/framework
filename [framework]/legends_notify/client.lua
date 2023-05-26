RegisterNetEvent('Notification:LegendsLeft')
AddEventHandler('Notification:LegendsLeft', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.legends_notify.LegendsNotificationLeft(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.legends_notify.LegendsNotificationLeft(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)

RegisterNetEvent('Notification:LegendsRight')
AddEventHandler('Notification:LegendsRight', function(text, dict, icon, text_color, duration)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if icon ~= nil then
        exports.legends_notify.LegendsNotificationRight(0, text, dict, icon, text_color, duration)
    else
        local icon = "tick"
        exports.legends_notify.LegendsNotificationRight(0, text, dict, icon, text_color, duration)
    end
end)