local TEXTS = Config.Texts
local TEXTURES = Config.Textures

local WildHorse = nil
local Broken = 2

local pcoords = nil 
local isdead = nil

local naming = false
local blips = nil
local prompts = {}

local PromptKey 
local PromptGroup = GetRandomIntInRange(0, 0xffffff)

local function SetAnimalIsWild(ped, b)
    Citizen.InvokeNative(0xAEB97D84CDF3C00B, ped, b)
end    

local function LoadPrompts()
    local str = TEXTS.Prompt1
    PromptKey = PromptRegisterBegin()
    PromptSetControlAction(PromptKey, Config.Prompts.Prompt1)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(PromptKey, str)
    PromptSetEnabled(PromptKey, 1)
    PromptSetVisible(PromptKey, 1)
	PromptSetStandardMode(PromptKey,1)
	PromptSetGroup(PromptKey, PromptGroup)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,PromptKey,true)
	PromptRegisterEnd(PromptKey)
    prompts[#prompts+1] = PromptKey
end

local function AddName(hmodel, horsetype, price, skill, sex, job)
    naming = true
    AddTextEntry("RICX_REGISTER_WILD_HORSE", TEXTS.AddName)
    DisplayOnscreenKeyboard(1, "RICX_REGISTER_WILD_HORSE", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        Citizen.Wait(1);
    end
    while (UpdateOnscreenKeyboard() == 2) do
        Citizen.Wait(1);
        naming = false
        break
    end
    while (UpdateOnscreenKeyboard() == 1) do
        Citizen.Wait(1)
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result ~= "" then
                TriggerServerEvent("legends_horses:buyhorse", hmodel, horsetype, price, skill, sex, result, job)
                DeleteEntity(WildHorse)
                SetEntityAsNoLongerNeeded(WildHorse)
                WildHorse = nil
                naming = false
                break
            end
        end
    end
end

Citizen.CreateThread(function()
    LoadPrompts()
    while true do 
        Citizen.Wait(500)
        pcoords = GetEntityCoords(PlayerPedId())
        isdead = IsEntityDead(PlayerPedId())
        if WildHorse then 
            if not blips then 
                blips = {}
                for i, v in pairs(Config.RegisterHorseStables) do
                    blips[i] = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
                    SetBlipSprite(blips[i], v.sprite, 1)
                    Citizen.InvokeNative(0x9CB1A1623062F402, blips[i], v.name)
                end  
                TriggerEvent("Notification:left_wild_horse", TEXTS.HorseTaming, TEXTS.Tamed, TEXTURES.horse[1], TEXTURES.horse[2], 3000)
            end
        else
            if blips then 
                for i,v in pairs(blips) do 
                    RemoveBlip(v)
                end
                blips = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local t = 5 
        if pcoords ~= nil and (isdead ~= nil and isdead == false) and (WildHorse and GetMount(PlayerPedId()) == WildHorse) and naming == false then 
            for i,v in pairs(Config.RegisterHorseStables) do 
                local c = vector3(v.x, v.y, v.z)
                local dist = #(pcoords-c)

                if dist < 10.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.x, v.y, v.z-1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 126, 0, 0, 255, 0, 0, 2, 0, 0, 0, 0)
                end

                if dist < 1.8 then 
                    local label  = CreateVarString(10, 'LITERAL_STRING', v.name)
                    PromptSetActiveGroupThisFrame(PromptGroup, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,PromptKey) then
                        TriggerServerEvent("ricx_wild_horse_addon:check_job")
                        --AddName(GetEntityModel(WildHorse), "Wild", 0, 0, 0, false)
                        Citizen.Wait(2000)
                    end
                end
            end
        else
            t = 1500
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1) 
		local size = GetNumberOfEvents(0) 
		if size > 0 then 
			for i = 0, size - 1 do
				local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == GetHashKey("EVENT_HORSE_BROKEN") then 
                    local eventDataSize = 3 
					local eventDataStruct = DataView.ArrayBuffer(24) 
					eventDataStruct:SetInt32(0 ,0)
					eventDataStruct:SetInt32(8 ,0) 	
					eventDataStruct:SetInt32(16 ,0)	
					local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)
					if is_data_exists then
                        if eventDataStruct:GetInt32(16) == Broken then
                            local a = exports.ricx_horses:GetSpawnedHorse()
                            local pid = Citizen.InvokeNative(0xAD03B03737CE6810, eventDataStruct:GetInt32(8))
                            if PlayerPedId() == eventDataStruct:GetInt32(0) and (not a or (a and a ~= eventDataStruct:GetInt32(8))) and pid == 255 then
                                WildHorse = eventDataStruct:GetInt32(8)
                                ClearPedTasksImmediately(WildHorse)
                                ClearPedTasksImmediately(PlayerPedId())
                                SetAnimalIsWild(WildHorse, 0)
                                SetAnimalIsWild(PlayerPedId(), 0)
                            end
                        end
                    end
				end
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    for i,v in pairs(prompts) do 
        PromptDelete(v)
    end
    if blips then
        for i,v in pairs(blips) do 
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent("ricx_wild_horse_addon:can_register")
AddEventHandler("ricx_wild_horse_addon:can_register", function()
    AddName(GetEntityModel(WildHorse), "Wild", 0, 0, 0, false)
end)

--Notification
RegisterNetEvent('Notification:left_wild_horse')
AddEventHandler('Notification:left_wild_horse', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(1)
        end
    end
    if txtr ~= nil then
        exports.ricx_wild_horse_addon.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.ricx_wild_horse_addon.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
    SetStreamedTextureDictAsNoLongerNeeded(dict)
end)
