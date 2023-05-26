local RSGCore = exports['legends-core']:GetCoreObject()
local xSound = exports.xsound
local isPlaying = false
local volume = Config.DukeBoxDefaultVolume
local radius = Config.DukeBoxRadius

RegisterNetEvent('legends-saloontender:server:playMusic', function(song, name, zone)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local boothCoords = zone
    local dist = #(coords - boothCoords)
    local mysong = song
    if dist > 3 then return end
    xSound:PlayUrlPos(-1, name, mysong, volume, coords)
    xSound:Distance(-1, name, radius)
    isPlaying = true
end)

RegisterNetEvent('legends-saloontender:server:changeVolume', function(volume, currentname, currentzone)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local boothCoords = currentzone
    local dist = #(coords - boothCoords)
    if dist > 3 then return end
    if not tonumber(volume) then return end
    if isPlaying then
        xSound:setVolume(-1, currentname, volume)
    end
end)

RegisterNetEvent('legends-saloontender:server:pauseMusic', function(currentname, currentzone)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local boothCoords = currentzone
    local dist = #(coords - boothCoords)
    if dist > 3 then return end
    if isPlaying then
        isPlaying = false
        xSound:Pause(-1, currentname)
    end
end)

RegisterNetEvent('legends-saloontender:server:resumeMusic', function(currentname, currentzone)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local boothCoords = currentzone
    local dist = #(coords - boothCoords)
    if dist > 3 then return end
    if not isPlaying then
        isPlaying = true
        xSound:Resume(-1, currentname)
    end
end)

RegisterNetEvent('legends-saloontender:server:stopMusic', function(currentname, currentzone)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local boothCoords = currentzone
    local dist = #(coords - boothCoords)
    if dist > 3 then return end
    if isPlaying then
        isPlaying = false
        xSound:Destroy(-1, currentname)
    end
end)
