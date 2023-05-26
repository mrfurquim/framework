local RSGCore = exports['legends-core']:GetCoreObject()

local isBusy = false
local testAnimDict = 'amb_rest_drunk@world_human_drinking@flask@male_a@stand_enter'
local testAnim = 'enter_back_lf'

function loadAnimDict(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function loadModel(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

function doAnim (Amodel, bone, pX, pY, pZ, rX, rY, rZ, anim, Adict, duration)
    local model = loadModel(GetHashKey(Amodel))
    object = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
    AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), bone), pX, pY, pZ, rX, rY, rZ, false, true, true, true, 0, true)
    local dict = loadAnimDict(Adict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 5.0, 5.0, duration, 1, false, false, false)
end

function AnimDetatch (sleep)
    Citizen.Wait(sleep)
    if object ~= nil then
        DetachEntity(object, true, true)
        DeleteObject(object)
    end
end

AddEventHandler('legends-essentials:client:DrinkingAnimation', function()
    local ped = PlayerPedId()

    loadAnimDict(testAnimDict)

    Wait(100)

    TaskPlayAnim(ped, testAnimDict, testAnim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)

RegisterNetEvent("consumables:client:Drink", function(itemName)
    if isBusy then return end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger00")
    local prop = CreateObject(GetHashKey("p_flask01x"), coords, true, true, true)
    isBusy = not isBusy

    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    FreezeEntityPosition(ped, true)
    ClearPedTasksImmediately(ped)

    TriggerEvent('legends-essentials:client:DrinkingAnimation')

    Wait(2700) -- Timing is very important here :D

    AttachEntityToEntity(prop, ped, boneIndex, 0.05, -0.14, -0.02, -75.0, 4.0, -12.0, true, true, true, false, 0, true)

    RSGCore.Functions.Progressbar("drinking-water", "Drinking from the Flask", 4500, false, true,
    {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = true,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)

        isBusy = not isBusy

        SetEntityAsNoLongerNeeded(prop)
        DeleteEntity(prop)
        DeleteObject(prop)

        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesDrink[itemName])

        RSGCore.Functions.Notify("You drank from your Flask!", 'success', 3000)
    end)
end)

RegisterNetEvent("consumables:client:Smoke", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        local sleep = 10000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        local cigar = nil
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local item_model = nil
            local pX, pY, pZ, rX, rY, rZ = nil, nil, nil, nil, nil, nil
            if itemName == "cigar" then
                sleep = 20000
                item_model = "p_cigar01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.0, 0.0, 00.0, 0.0
            else
                item_model = "p_cigarette_cs01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.01, 0.0, 180.0, 90.0
            end
            doAnim(item_model, "SKEL_R_FINGER12", pX, pY, pZ, rX, rY, rZ, 'base', 'amb_wander@code_human_smoking_wander@cigar@male_a@base', sleep)
        end
        Wait(sleep)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent('hud:server:RelieveStress', math.random(20, 40))
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:Eat", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local dict = loadAnimDict('mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese')
            TaskPlayAnim(PlayerPedId(), dict, 'quick_right_hand', 5.0, 5.0, -1, 1, false, false, false)
        end
        Wait(sleep)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
        ClearPedTasks(PlayerPedId())
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:EatStew", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
        TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
        TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
        Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
        isBusy = not isBusy
    end
end)

-- player use bandage
RegisterNetEvent('hospital:client:UseBandage', function(itemName)
    local ped = PlayerPedId()
    local dict = loadAnimDict('script_re@gold_panner@gold_success')
    TaskPlayAnim(PlayerPedId(), dict, 'SEARCH01', 8.0, 8.0, -1, 1, false, false, false)
    ClearPedTasks(PlayerPedId())
    RSGCore.Functions.Progressbar("using bandage", "Using a Bandage..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = BandageDict,
        anim = BandageAnim,
        flags = 1,
    }, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        SetEntityHealth(ped, GetEntityHealth(ped) + 60)
        -- health adjust
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, (GetAttributeCoreValue(ped, 0) + 60))
        -- end health adjust
    end, function() -- Cancel
        StopAnimTask(ped, BandageDict, BandageAnim, 1.0)
        RSGCore.Functions.Notify(Lang:t('error.canceled'), 'error')
    end)
end)

--player use firstaid

RegisterNetEvent('hospital:client:Usefirstaid', function(itemName)
    local ped = PlayerPedId()
    local dict = loadAnimDict('script_re@gold_panner@gold_success')
    TaskPlayAnim(PlayerPedId(), dict, 'SEARCH01', 8.0, 8.0, -1, 1, false, false, false)
    ClearPedTasks(PlayerPedId())
    RSGCore.Functions.Progressbar("using firstaid", "Using a Firstaid..", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = BandageDict,
        anim = BandageAnim,
        flags = 1,
    }, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        SetEntityHealth(ped, GetEntityHealth(ped) + 600)
        -- health adjust
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, (GetAttributeCoreValue(ped, 0) + 600))
        -- end health adjust
    end, function() -- Cancel
        StopAnimTask(ped, BandageDict, BandageAnim, 1.0)
        RSGCore.Functions.Notify(Lang:t('error.canceled'), 'error')
    end)
end)