local RSGCore = exports['legends-core']:GetCoreObject()

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- load animal
Citizen.CreateThread(function()
    for z, x in pairs(Config.SpawnAnimal) do
    while not HasModelLoaded( GetHashKey(Config.SpawnAnimal[z]["Model"]) ) do
        Wait(500)
        modelrequest( GetHashKey(Config.SpawnAnimal[z]["Model"]) )
    end
    local npc = CreatePed(GetHashKey(Config.SpawnAnimal[z]["Model"]), Config.SpawnAnimal[z]["Pos"].x, Config.SpawnAnimal[z]["Pos"].y, Config.SpawnAnimal[z]["Pos"].z, Config.SpawnAnimal[z]["Heading"], true, true, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
	Citizen.InvokeNative(0xDC19C288082E586E, npc, true, false)
	Citizen.InvokeNative(0xBB9CE077274F6A1B, npc, 10.0, 10)
    SetModelAsNoLongerNeeded(GetHashKey(Config.SpawnAnimal[z]["Model"]))
    end
end)