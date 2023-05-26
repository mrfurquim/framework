RegisterNetEvent('Notification:Legends')
AddEventHandler('Notification:Legends', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.legends_notify.LegendsNotification(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.legends_notify.LegendsNotification(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)
