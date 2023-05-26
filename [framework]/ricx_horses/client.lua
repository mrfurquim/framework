---------------------------REDEMRP_MENU----------------------------
MenuData = {}
TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)
----------------------------END REDEMRP_MENU----------------------------
local TEXTURES = Config.Textures
local MENUTEXTS = Config.Texts.Menus
local pcoords = nil
local playerdead = nil
local menuOpen = false
local tempHorse = nil
local tempHorseData = {}
local SelectedHorse = {}
local PlayerHorseId = nil

local StableBlips = {}
local TrainingBlips = {}

local ownedHorses = {}
local currentHorseComps = nil

local fleeing = false
local fleecd = 0

local ownedstat = false

local calledHorse = false

local cameraindex = 1
local Camera = nil
local CamAttach
local stat = false

local tempStableID = nil

local called = false
local tempDelete = nil

local selling = false
local SellPointsC = {}

local StableOpenPrompt
local StablePrompts = GetRandomIntInRange(0, 0xffffff)

local StartTrainPrompt
local TrainingPrompts = GetRandomIntInRange(0, 0xffffff)

local HorseFeedPrompt
local HorseSellPrompt
local HorseLayPrompt
local HorsePrompts

local StopSellPrompt
local SellPrompts = GetRandomIntInRange(0, 0xffffff)

local BuyHorsePrompt
local BuyHorsePrompts = GetRandomIntInRange(0, 0xffffff)

local HorseDrinkPrompt
local DrinkPrompt = GetRandomIntInRange(0, 0xffffff)

local HorseGrazePrompt
local GrazePrompt = GetRandomIntInRange(0, 0xffffff)

local StableCameraPrompt
local CameraPrompt = GetRandomIntInRange(0, 0xffffff)

local XPboostr = 0

local training = false
local showButton = false
local counter = 0
local trainingCD = Config.TrainingTimer
local gender = Config.Texts.Gender[1]
local RGB = Config.Checkpoints

local TrainingLevel = Config.DefaultTrainingLevel
local HorseTrainerExp = nil

local feeding = false
local brushing = false
local objectInteract = false

local hblip

local canChange = true

function SetupStablePrompt()
        local str1 = Config.Prompts.Open[1]
        StableOpenPrompt = PromptRegisterBegin()
        PromptSetControlAction(StableOpenPrompt, Config.Prompts.Open[2])
        str1 = CreateVarString(10, 'LITERAL_STRING', str1)
        PromptSetText(StableOpenPrompt, str1)
        PromptSetEnabled(StableOpenPrompt, 1)
        PromptSetVisible(StableOpenPrompt, 1)
        PromptSetStandardMode(StableOpenPrompt,1)
        PromptSetGroup(StableOpenPrompt, StablePrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,StableOpenPrompt,true)
        PromptRegisterEnd(StableOpenPrompt)

        local str2 = Config.Prompts.StartTrain[1]
        StartTrainPrompt = PromptRegisterBegin()
        PromptSetControlAction(StartTrainPrompt, Config.Prompts.StartTrain[2])
        str2 = CreateVarString(10, 'LITERAL_STRING', str2)
        PromptSetText(StartTrainPrompt, str2)
        PromptSetEnabled(StartTrainPrompt, 1)
        PromptSetVisible(StartTrainPrompt, 1)
        PromptSetStandardMode(StartTrainPrompt,1)
        PromptSetGroup(StartTrainPrompt, TrainingPrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,StartTrainPrompt,true)
        PromptRegisterEnd(StartTrainPrompt)

        local str4 = Config.Prompts.HorseDrink[1]
        HorseDrinkPrompt = PromptRegisterBegin()
        PromptSetControlAction(HorseDrinkPrompt,Config.Prompts.HorseDrink[2])
        str4 = CreateVarString(10, 'LITERAL_STRING', str4)
        PromptSetText(HorseDrinkPrompt, str4)
        PromptSetEnabled(HorseDrinkPrompt, 1)
        PromptSetVisible(HorseDrinkPrompt, 1)
        PromptSetStandardMode(HorseDrinkPrompt,1)
        PromptSetGroup(HorseDrinkPrompt, DrinkPrompt)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,HorseDrinkPrompt,true)
        PromptRegisterEnd(HorseDrinkPrompt)

        local str6 = Config.Prompts.HorseGraze[1]
        HorseGrazePrompt = PromptRegisterBegin()
        PromptSetControlAction(HorseGrazePrompt,Config.Prompts.HorseGraze[2])
        str6 = CreateVarString(10, 'LITERAL_STRING', str6)
        PromptSetText(HorseGrazePrompt, str6)
        PromptSetEnabled(HorseGrazePrompt, 1)
        PromptSetVisible(HorseGrazePrompt, 1)
        PromptSetStandardMode(HorseGrazePrompt,1)
        PromptSetGroup(HorseGrazePrompt, GrazePrompt)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,HorseGrazePrompt,true)
        PromptRegisterEnd(HorseGrazePrompt)

        local str5 = Config.Prompts.Camera[1]
        StableCameraPrompt = PromptRegisterBegin()
        PromptSetControlAction(StableCameraPrompt,Config.Prompts.Camera[2])
        str5 = CreateVarString(10, 'LITERAL_STRING', str5)
        PromptSetText(StableCameraPrompt, str5)
        PromptSetEnabled(StableCameraPrompt, 1)
        PromptSetVisible(StableCameraPrompt, 1)
        PromptSetStandardMode(StableCameraPrompt,1)
        PromptSetGroup(StableCameraPrompt, CameraPrompt)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,StableCameraPrompt,true)
        PromptRegisterEnd(StableCameraPrompt)

    if Config.TrainerBlip.enabled == true then
        for i, v in pairs(Config.HorseTraining) do
            TrainingBlips[i] = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
            SetBlipSprite(TrainingBlips[i], Config.TrainerBlip.sprite, 1)
            SetBlipScale(TrainingBlips[i], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, TrainingBlips[i], Config.TrainerBlip.name)
        end  
    end

    for i, v in pairs(Config.Stables) do
        StableBlips[i] = N_0x554d9d53f696d002(1664425300, v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(StableBlips[i], Config.Blips.sprite, 1)
        SetBlipScale(StableBlips[i], 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, StableBlips[i], Config.Blips.name)
    end  
end

function SetupSellPrompt()
        local str1 = Config.Prompts.StopSell[1]
        StopSellPrompt = PromptRegisterBegin()
        PromptSetControlAction(StopSellPrompt, Config.Prompts.StopSell[2])
        str1 = CreateVarString(10, 'LITERAL_STRING', str1)
        PromptSetText(StopSellPrompt, str1)
        PromptSetEnabled(StopSellPrompt, 1)
        PromptSetVisible(StopSellPrompt, 1)
        PromptSetStandardMode(StopSellPrompt,1)
        PromptSetGroup(StopSellPrompt, SellPrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,StopSellPrompt,true)
        PromptRegisterEnd(StopSellPrompt)

        local str3 = Config.Prompts.BuyHorse[1]
        BuyHorsePrompt = PromptRegisterBegin()
        PromptSetControlAction(BuyHorsePrompt, Config.Prompts.BuyHorse[2])
        str3 = CreateVarString(10, 'LITERAL_STRING', str3)
        PromptSetText(BuyHorsePrompt, str3)
        PromptSetEnabled(BuyHorsePrompt, 1)
        PromptSetVisible(BuyHorsePrompt, 1)
        PromptSetStandardMode(BuyHorsePrompt,1)
        PromptSetGroup(BuyHorsePrompt, BuyHorsePrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,BuyHorsePrompt,true)
        PromptRegisterEnd(BuyHorsePrompt)
end

function SetupHorsePrompts()
        local str2 = Config.Prompts.Feed[1]
        HorseFeedPrompt = PromptRegisterBegin()
        PromptSetControlAction(HorseFeedPrompt,Config.Prompts.Feed[2])
        str2 = CreateVarString(10, 'LITERAL_STRING', str2)
        PromptSetText(HorseFeedPrompt, str2)
        PromptSetEnabled(HorseFeedPrompt, 1)
        PromptSetVisible(HorseFeedPrompt, 1)
        PromptSetStandardMode(HorseFeedPrompt,1)
        PromptSetGroup(HorseFeedPrompt, HorsePrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,HorseFeedPrompt,true)
        PromptRegisterEnd(HorseFeedPrompt)

        local str3 = Config.Prompts.Sell[1]
        HorseSellPrompt = PromptRegisterBegin()
        PromptSetControlAction(HorseSellPrompt,Config.Prompts.Sell[2])
        str3 = CreateVarString(10, 'LITERAL_STRING', str3)
        PromptSetText(HorseSellPrompt, str3)
        PromptSetEnabled(HorseSellPrompt, 1)
        PromptSetVisible(HorseSellPrompt, 1)
        PromptSetStandardMode(HorseSellPrompt,1)
        PromptSetGroup(HorseSellPrompt, HorsePrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C,HorseSellPrompt,true)
        PromptRegisterEnd(HorseSellPrompt)

        if SelectedHorse.xp >= Config.LayTrickXP then
            local str4 = Config.Prompts.Lay[1]
            HorseLayPrompt = PromptRegisterBegin()
            PromptSetControlAction(HorseLayPrompt,Config.Prompts.Lay[2])
            str4 = CreateVarString(10, 'LITERAL_STRING', str4)
            PromptSetText(HorseLayPrompt, str4)
            PromptSetEnabled(HorseLayPrompt, 1)
            PromptSetVisible(HorseLayPrompt, 1)
            PromptSetStandardMode(HorseLayPrompt,1)
            PromptSetGroup(HorseLayPrompt, HorsePrompts)
            Citizen.InvokeNative(0xC5F428EE08FA7F2C,HorseLayPrompt,true)
            PromptRegisterEnd(HorseLayPrompt)
        end
end
------------------BASIC THREADS------------------
Citizen.CreateThread(function()
    --TriggerServerEvent("ricx_horses:checkselected")
    --Citizen.Wait(500)
    --TriggerServerEvent("ricx_horses:checktrainerxp")
    --Citizen.Wait(500)
    TriggerServerEvent("ricx_horses:sell:getpoints")
    Citizen.Wait(500)
    SetupStablePrompt()
    SetupSellPrompt()


    while PlayerPedId() < 99 do 
        Citizen.Wait(2000)
    end

    Citizen.Wait(10000)
    if HorseTrainerExp == nil then
        TriggerServerEvent("ricx_horses:load_playerdata")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if PlayerPedId() ~= nil then
            pcoords = GetEntityCoords(PlayerPedId())
            playerdead = IsEntityDead(PlayerPedId())
        end
    end
end)
------------------------------------------------------

------------------CAMERA CHANGE----------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if tempHorse ~= nil then
            if tempStableID ~= nil then
                if Camera ~= nil then
                    local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.Camera)
                    PromptSetActiveGroupThisFrame(CameraPrompt, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,StableCameraPrompt) then
                        cameraindex = cameraindex + 1
                        if cameraindex > #Config.Stables[tempStableID].campos then
                            cameraindex = 1
                        end
                        local tempAttach = Config.Stables[tempStableID].campos[cameraindex]
                        AttachCamToEntity(Camera, tempHorse, tempAttach[1], tempAttach[2], tempAttach[3], true)
                        if tempAttach[4] ~= nil then
                            SetCamRot(Camera, tempAttach[4], tempAttach[5], tempAttach[6])
                        end
                        Citizen.Wait(50)
                    end
                else
                    t = 1000
                end
            else
                t = 2000
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------CALL HORSE THREAD------------------
Citizen.CreateThread(function()
    while true do
        local t = 10
        if playerdead ~= nil and playerdead == false then
            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x24978A28) or Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0xE7EB9185) then
                if calledHorse == false then
                    calledHorse = true
                    CallHorse()
                    if fleeing == true then
                        fleeing = false
                    end
                else
                    t = 1000
                end
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end    
end)
------------------MENU THREADS------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        local dists = {}
        if pcoords ~= nil and menuOpen == false then
            if playerdead == false then
                for i, v in pairs(Config.Stables) do
                    local dist = GetDistanceBetweenCoords(pcoords.x,pcoords.y,pcoords.z,v.pos.x, v.pos.y, v.pos.z, true)
                    dists[i] = dist
                    if dist < 10.0 then
                        Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.pos.x, v.pos.y, v.pos.z-1 , 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.stableshop[1], RGB.stableshop[2], RGB.stableshop[3], 100, 0, 0, 2, 0, 0, 0, 0)
                    end
                    if dist < 1.3 then
                        local label  = CreateVarString(10, 'LITERAL_STRING', ""..v.name.." "..Config.Prompts.Stable)
                        PromptSetActiveGroupThisFrame(StablePrompts, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE,StableOpenPrompt) then
                            if PlayerHorseId == nil then
                                StableOpen(i)
                            else
                                TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.SendHome, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
                            end
                            Citizen.Wait(2000)
                        end
                    end
                end
                local cango = 0 
                for i,v in pairs(dists) do 
                    if v > 15.0 then 
                        cango = cango + 1
                    end
                end
                if cango == #dists then 
                    t = 2500
                end
            else
                t = 2000
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if stat == true then
            while not tempHorseData[1] do
                Citizen.Wait(1)
            end
            if tempHorseData[1] then
                Text3d("       ")
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if ownedstat == true then
            while not tempHorseData[1] do
                Citizen.Wait(100)
            end
            if tempHorseData[1] then
                OwnedStatF("       ")
            elseif tempHorseData[1] == "None" then
                OwnedStatF("       ")
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

------------------------------------------------------
-------------------------------DRINK PROMPT-------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if IsPedLeadingHorse(PlayerPedId()) and objectInteract == false then
            local thorse = GetLedHorseFromPed(PlayerPedId())
            if IsEntityInWater(thorse) then
                if IsPedStill(thorse) and not IsPedSwimming(thorse) then
                    DisableControlAction(0, 0x7914A3DD, true)
                    local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.Horse)
                    PromptSetActiveGroupThisFrame(DrinkPrompt, label) 
                    if Citizen.InvokeNative(0xC92AC953F0A982AE, HorseDrinkPrompt) then
                        objectInteract = true
                        TaskStopLeadingHorse(PlayerPedId())
                        Citizen.Wait(500)
                        local tc = GetEntityCoords(thorse)
                        RequestAnimDict(Config.DrinkAnim[1])
                        while not HasAnimDictLoaded(Config.DrinkAnim[1]) do
                            Citizen.Wait(1)
                        end
                        local timer = Config.DrinkDuration * 1000
                        TaskPlayAnim(thorse, Config.DrinkAnim[1], Config.DrinkAnim[2], 1.0, 1.0, timer, 1, 0, 1, 0, 0, 0, 0)
                        Citizen.Wait(timer)
                        BoostHorse(0, Config.DrinkStaminaBoost, false, 0, 0, false, 0, 0)
                        objectInteract = false
                    end
                else
                    t = 500
                end
            else
                if Config.InteractWithObjects == true then
                    local forward = GetOffsetFromEntityInWorldCoords(thorse, 0.0, 0.8, -0.5)
                    local obj = nil
                    local type = nil
                    for i,v in pairs(Config.InteractObjects) do
                        local objt = GetClosestObjectOfType(forward.x, forward.y, forward.z, 0.9, v[1], 0, 1, 1)
                        if objt ~= 0 and obj == nil then
                            obj = objt
                            type = v[2]
                        end
                    end
                    --Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, forward.x, forward.y, forward.z , 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.training[1], RGB.training[2], RGB.training[3], 100, 0, 0, 2, 0, 0, 0, 0)
                            
                    if obj ~= nil then
                        if type == "drink" then
                            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.Horse)
                            PromptSetActiveGroupThisFrame(DrinkPrompt, label) 
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, HorseDrinkPrompt) then
                                objectInteract = true
                                TaskStopLeadingHorse(PlayerPedId())
                                Citizen.Wait(500)
                                TaskGoStraightToCoord(thorse, forward.x, forward.y, forward.z, 1.0, -1, -1, 0)
                                Citizen.Wait(1000)
                                TaskTurnPedToFaceEntity(thorse, obj, 1000)
                                Citizen.Wait(1000)
                                local tc = GetEntityCoords(thorse)
                                RequestAnimDict(Config.DrinkAnim2[1])
                                while not HasAnimDictLoaded(Config.DrinkAnim2[1]) do
                                    Citizen.Wait(1)
                                end
                                local timer = Config.DrinkDuration * 1000
                                TaskPlayAnim(thorse, Config.DrinkAnim2[1], Config.DrinkAnim2[2], 1.0, 1.0, timer, 1, 0, 1, 0, 0, 0, 0)
                                Citizen.Wait(timer)
                                ClearPedTasks(thorse)
                                BoostHorse(0, Config.DrinkStaminaBoost, false, 0, 0, false, 0, 0)
                                objectInteract = false
                            end
                        elseif type == "feed" then
                            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.Horse)
                            PromptSetActiveGroupThisFrame(GrazePrompt, label) 
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, HorseGrazePrompt) then
                                objectInteract = true
                                TaskStopLeadingHorse(PlayerPedId())
                                Citizen.Wait(500)
                                TaskGoStraightToCoord(thorse, forward.x, forward.y, forward.z, 1.0, -1, -1, 0)
                                Citizen.Wait(1000)
                                TaskTurnPedToFaceEntity(thorse, obj, 1000)
                                Citizen.Wait(1000)
                                local tc = GetEntityCoords(thorse)
                                RequestAnimDict(Config.GrazeAnim[1])
                                while not HasAnimDictLoaded(Config.GrazeAnim[1]) do
                                    Citizen.Wait(1)
                                end
                                local timer = Config.GrazeDuration * 1000
                                TaskPlayAnim(thorse, Config.GrazeAnim[1], Config.GrazeAnim[2], 1.0, 1.0, timer, 1, 0, 1, 0, 0, 0, 0)
                                Citizen.Wait(timer)
                                ClearPedTasks(thorse)
                                BoostHorse(Config.GrazeHealthBoost, 0, false, 0, 0, false, 0, 0)
                                objectInteract = false
                            end
                        end
                    end
                else
                    t = 2000
                end
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
-------------------------------TRAINING THREADS-------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        local dists = {}
        if Config.TrainingEnabled == true then
            if pcoords ~= nil and training == false then
                if playerdead == false then
                    for i, v in pairs(Config.HorseTraining) do
                        local dist = GetDistanceBetweenCoords(pcoords.x,pcoords.y,pcoords.z,v.x, v.y, v.z, true)
                        dists[i] = dist
                        if dist < 10.0 then
                            Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.x, v.y, v.z-0.9 , 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.training[1], RGB.training[2], RGB.training[3], 100, 0, 0, 2, 0, 0, 0, 0)
                        end
                        if dist < 1.3 then
                            --local label  = CreateVarString(10, 'LITERAL_STRING', Config.Prompts.HorseTraining.." (Trainer XP: "..HorseTrainerExp..")")
                            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Prompts.HorseTraining) --Above the one is optimal to show Player Trainer XP, comment this line and uncomment that one to use
                            PromptSetActiveGroupThisFrame(TrainingPrompts, label)
                            if Citizen.InvokeNative(0xC92AC953F0A982AE,StartTrainPrompt) then
                                TriggerServerEvent("ricx_horses:checktraining")
                                Citizen.Wait(2000)
                            end
                        end
                    end
                    local cango = 0
                    for i,v in pairs(dists) do 
                        if v > 15.0 then 
                            cango = cango + 1
                        end
                    end
                    if cango == TableNum(dists) then 
                        t = 2000
                    end
                else
                    t = 2000
                end
            else
                t = 2000
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
--------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if training == true and showButton == false then
            local nr1 = math.random(Config.TrainingLevels[TrainingLevel].Params[1],Config.TrainingLevels[TrainingLevel].Params[2])
            Citizen.Wait(nr1)
            showButton = true
            local nr = math.random(Config.TrainingLevels[TrainingLevel].Params[3],Config.TrainingLevels[TrainingLevel].Params[4])
            Citizen.Wait(nr)
            showButton = false
        else
            Citizen.Wait(2000)
        end
    end
end)
--------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if showButton == true then
            SetTextScale(0.35, 0.35)
            SetTextFontForCurrentCommand(1)
            SetTextColor(255, 255, 255, 215)
            local str = CreateVarString(10, "LITERAL_STRING", Config.TrainingButton.text, Citizen.ResultAsLong())
            SetTextCentre(1)
            DisplayText(str, Config.TrainingButton.pos[1], Config.TrainingButton.pos[2])
            DrawSprite("generic_textures","hud_menu_4a", Config.TrainingButton.pos[1], Config.TrainingButton.pos[2]+0.012, (Config.TrainingButton.basesize)*2.5, Config.TrainingButton.basesize, 0.0, Config.TrainingButton.bg[1], Config.TrainingButton.bg[2], Config.TrainingButton.bg[3], Config.TrainingButton.bg[4], 0)
        else
            t = 200
        end
        Citizen.Wait(t)
    end
end)

function ShowTrainingProgress()
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", Config.Texts.TrainProgress..counter.."/"..Config.TrainingLevels[TrainingLevel].MaxProgress.."\n"..trainingCD.." "..Config.Texts.TrainSecondsLeft, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str, Config.TrainingProgress.pos[1], Config.TrainingProgress.pos[2])
    DrawSprite("generic_textures","hud_menu_4a", Config.TrainingProgress.pos[1], Config.TrainingProgress.pos[2]+0.012, Config.TrainingProgress.basesize[1], Config.TrainingProgress.basesize[2], 0.0, Config.TrainingProgress.bg[1], Config.TrainingProgress.bg[2], Config.TrainingProgress.bg[3], Config.TrainingProgress.bg[4], 0)
end
--------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 1

        if training then
            ShowTrainingProgress()

            if IsControlJustPressed(0, Config.TrainingButton.ProgressKey) or IsDisabledControlJustPressed(0, Config.TrainingButton.ProgressKey) then
                if showButton then
                    showButton = false
                    counter = counter + 1

                    if counter == Config.TrainingLevels[TrainingLevel].MaxProgress then
                        EndHorseTraining(false)
                    end
                else
                    counter = counter - 1
                    if counter < 0 then
                        counter = 0
                    end
                end
            end
        else
            t = 2000
        end

        Wait(t)
    end
end)
--------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 2
        if training then
            UipromptDisablePromptsThisFrame()
            DisableControlAction(0, 0x4CC0E2FE, true) --B
            DisableControlAction(0, 0xCBDB82A8, true) --E
            DisableControlAction(0, 0x1A3EABBB, true) --F
            
            DisableControlAction(0, 0x171910DC, true) -- TAB 1
            DisableControlAction(0, 0x85D24405, true) -- TAB 
            DisableControlAction(0, 0xE6360A8E, true) -- TAB 
            DisableControlAction(0, 0xB238FE0B, true) -- TAB 
            DisableControlAction(0, 0xAC4BD4F1, true) -- TAB 
            DisableControlAction(0, 0x938D4071, true) -- TAB 
            DisableControlAction(0, 0x1C826362, true) -- TAB 
            DisableControlAction(0, 0x4FD1C57B, true) -- TAB 
            DisableControlAction(0, 0xE2B557A3, true) -- TAB 

           ---RIGHT MOUSE CLICK
           DisableControlAction(0, 0x53296B75, true) --
           DisableControlAction(0, 0x6328239B, true) --	
           DisableControlAction(0, 0xBE1F469, true) --
           DisableControlAction(0, 0xC13A6564, true) --	
           DisableControlAction(0, 0xF84FA74F, true) --	
           DisableControlAction(0, 0xF8982F00, true) --
           DisableControlAction(0, 0x04FB8191, true) --	
           DisableControlAction(0, 0x1E7D7275, true) --	
           DisableControlAction(0, 0x27568539, true) --	
           DisableControlAction(0, 0x61470051, true) --	
           DisableControlAction(0, 0x6777B840, true) --	
           DisableControlAction(0, 0x92F5F01E, true) --	
           DisableControlAction(0, 0xBDD5830D, true) --	
           DisableControlAction(0, 0xD7CAFCEF, true) --	
           DisableControlAction(0, 0xEE2804D0, true) --	
           DisableControlAction(0, 0xD45EC04F, true) --
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
--------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 2
        if training == true then
            DisableAllControlActions(0)
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if training == true then
            trainingCD = trainingCD - 1
            if GetMount(PlayerPedId()) ~= PlayerHorseId then
                EndHorseTraining(true)
            end
            if trainingCD == 0 then
                EndHorseTraining(true)
            end
            Citizen.Wait(1000)
        end
    end
end)
-------------------------------END TRAINING THREADS-------------------------------
local Broken = 2
----------------------------STORAGE AND WILD HORSE THREAD--------------------------
Citizen.CreateThread(function()
	while true do
		local t = 1
        if playerdead ~= nil then
            if playerdead == false and PlayerHorseId ~= nil then
                local size = GetNumberOfEvents(0) 
                if size > 0 then 
                    for i = 0, size - 1 do
                        local eventAtIndex = GetEventAtIndex(0, i)
                        if eventAtIndex == `EVENT_PLAYER_PROMPT_TRIGGERED` then
                            local eventDataSize = 10
                            local eventDataStruct = DataView.ArrayBuffer(80)
                            eventDataStruct:SetInt32(0 ,0)
                            eventDataStruct:SetInt32(8 ,0)	
                            eventDataStruct:SetInt32(16 ,0)
                            eventDataStruct:SetInt32(24 ,0)	
                            eventDataStruct:SetInt32(32 ,0)	
                            eventDataStruct:SetInt32(40 ,0)	
                            eventDataStruct:SetInt32(48 ,0)	
                            eventDataStruct:SetInt32(56 ,0)	
                            eventDataStruct:SetInt32(64 ,0)	
                            eventDataStruct:SetInt32(72 ,0)	
                            local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)
                            if is_data_exists then
                                if eventDataStruct:GetInt32(0) == 35 then
                                    if PlayerHorseId == eventDataStruct:GetInt32(16) then
                                        if selling == false then
                                            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerHorseId), GetEntityCoords(PlayerPedId()),true)
                                            if dist < 1.5 then
                                                local compdata = json.decode(SelectedHorse.components)
                                                Wait(80)
                                                if compdata.Saddlebags ~= 0 then
                                                    -- TriggerServerEvent("ricx_horses:update_storage", SelectedHorse.id)
                                                    Wait(2000)
                                                else
                                                    TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.NoBags, TEXTURES.locked[1], TEXTURES.locked[2], 4000)
                                                end
                                            end
                                        end
                                    end
                                end
                                if eventDataStruct:GetInt32(0) == 33 then
                                    if PlayerHorseId == eventDataStruct:GetInt32(16) then
                                        StartFlee()
                                    end
                                end
                            end
                        end
                    end
                end
            else
                t = 2000
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------------------HORSE EXPERIENCE ADD THREAD------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20000)
        if PlayerHorseId ~= nil then
            if GetMount(PlayerPedId()) == PlayerHorseId then
                XPboostr = XPboostr + 1
                if XPboostr == 12 then
                    XPboostr = 0
                    AddHorseExperience(2)
                end
            end
        end
    end
end)
----------------------------HORSE DEATH THREAD--------------------------
Citizen.CreateThread(function()
    while true do
        local t = 500
        if PlayerHorseId ~= nil then
            local hc = GetEntityCoords(PlayerHorseId)
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),hc, true)
            if dist < 100.0 then
                if IsEntityDead(PlayerHorseId) then
                    TriggerServerEvent("ricx_horses:horsedied")
                    SelectedHorse.injured = 1
                    tempDelete = PlayerHorseId
                    RemoveBlip(hblip)
                    PlayerHorseId = nil
                    Citizen.Wait(15000)
                    --TriggerServerEvent("ricx_horses:deletehorse_server", PedToNet(tempDelete))
                    DeleteEntity(tempDelete)
                    SetEntityAsNoLongerNeeded(tempDelete)
                    tempDelete = nil
                end
            else
                local temp = PlayerHorseId
                RemoveBlip(hblip)
                DeleteEntity(temp)
                SetEntityAsNoLongerNeeded(temp)
                PlayerHorseId = nil
                --TriggerServerEvent("ricx_horses:deletehorse_server", PedToNet(temp))
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------SELL AND PROMPT THREADS------------------
Citizen.CreateThread(function()
    while true do
        local t = 2
        if PlayerHorseId ~= nil then
            DisableControlAction(0, 0x63A38F2C, true)
            DisableControlAction(0, 0x0D55A0F0, true)
            if Citizen.InvokeNative(0xC92AC953F0A982AE,HorseFeedPrompt) then
                if selling == false then
                    local dist = GetDistanceBetweenCoords(pcoords,GetEntityCoords(PlayerHorseId),true)
                    if dist < 1.5 then
                        if selling == false and feeding == false and brushing == false and not IsEntityPlayingAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@base", "base", 3) then
                            TriggerServerEvent("ricx_horses:checkfeed")
                        else
                            TriggerEvent("Notification:lefth", Config.Texts.HorseFeed, Config.Texts.WaitFeed, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
                        end
                    end
                    Citizen.Wait(2000)
                end
            end
            if Citizen.InvokeNative(0xC92AC953F0A982AE,HorseLayPrompt) then
                if SelectedHorse.xp >= Config.LayTrickXP then
                    if not IsEntityPlayingAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@base", "base", 3) then
                        if not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@base") then
                            RequestAnimDict("amb_creature_mammal@world_horse_resting@base")
                            while not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@base") do
                                Citizen.Wait(1)
                            end
                        end
                        if not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@stand_enter") then
                            RequestAnimDict("amb_creature_mammal@world_horse_resting@stand_enter")
                            while not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@stand_enter") do
                                Citizen.Wait(1)
                            end
                        end
                        TaskPlayAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@stand_enter", "enter", 1.0, 1.0, -1, 2, 0.0, false, false, false, '', false)
                        Citizen.Wait(3000)
                        TaskPlayAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@base", "base", 1.0, 1.0, -1, 2, 0.0, false, false, false, '', false)
                    else
                        if not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@quick_exit") then
                            RequestAnimDict("amb_creature_mammal@world_horse_resting@quick_exit")
                            while not HasAnimDictLoaded("amb_creature_mammal@world_horse_resting@quick_exit") do
                                Citizen.Wait(1)
                            end
                        end
                        TaskPlayAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@quick_exit", "quick_exit", 1.0, 1.0, -1, 2, 0.0, false, false, false, '', false)
                        Citizen.Wait(3000)
                        ClearPedTasks(PlayerHorseId)
                    end
                end
            end
            if Citizen.InvokeNative(0xC92AC953F0A982AE,HorseSellPrompt) then
                if selling == false and feeding == false and brushing == false and not IsEntityPlayingAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@base", "base", 3) then
                    local dist = GetDistanceBetweenCoords(pcoords,GetEntityCoords(PlayerHorseId),true)
                    if dist < 1.5 then
                        StartSellHorse()
                    end
                end
                Citizen.Wait(2000)
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------------------------------------------
function TableNum(tbl) 
    local c = 0
    for i,v in pairs(tbl) do 
        c = c + 1
    end
    return c
end
Citizen.CreateThread(function()
    while true do
        local t = 3
        if (SellPointsC ~= nil and TableNum(SellPointsC) > 0) and pcoords ~= nil then
            for i, v in pairs(SellPointsC) do
                if tonumber(v.owner) ~= GetPlayerServerId(PlayerId()) then
                    local dist = GetDistanceBetweenCoords(pcoords, v.sellcoords, true)
                    if dist < 10.0 then
                        Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.sellcoords.x, v.sellcoords.y, v.sellcoords.z-0.9, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.sell[1], RGB.sell[2], RGB.sell[3], 100, 0, 0, 2, 0, 0, 0, 0)
                    end
                    if dist < 2.0 then
                        local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.BuyHorseDollar..""..v.sellprice)
                        PromptSetActiveGroupThisFrame(BuyHorsePrompts, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE,BuyHorsePrompt) then
                            TriggerServerEvent("ricx_horses:sell:buyoffer", v.owner, v.sellprice, v.id)
                            Citizen.Wait(2000)
                        end
                        --Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.sellcoords.x, v.sellcoords.y, v.sellcoords.z-0.9 , 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.sell[1], RGB.sell[2], RGB.sell[3], 100, 0, 0, 2, 0, 0, 0, 0)
                    end
                end
                if tonumber(v.owner) == GetPlayerServerId(PlayerId()) then
                    local dist = GetDistanceBetweenCoords(pcoords, v.sellcoords, true)
                    if dist < 2.0 then
                        Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.sellcoords.x, v.sellcoords.y, v.sellcoords.z-0.9, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.3, RGB.training[1], RGB.training[2], RGB.training[3], 100, 0, 0, 2, 0, 0, 0, 0)
                    end
                end
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local t = 3
        if selling == true then
            DisableControlAction(0, 0xF8982F00, true)
            while SellPointsC[SelectedHorse.id] == nil do
                Citizen.Wait(1)
            end
            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Texts.Menus.ManageSell.."$"..SellPointsC[SelectedHorse.id].sellprice)
            PromptSetActiveGroupThisFrame(SellPrompts, label)
            if Citizen.InvokeNative(0xC92AC953F0A982AE,StopSellPrompt) then
                StopSellHorse()
                Citizen.Wait(2000)
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
---------------------------FLEE THREAD---------------------------
Citizen.CreateThread(function()
    while true do
        local t = 100
        if PlayerHorseId ~= nil then
            if fleeing == true then
                while fleecd < 5 do
                    Citizen.Wait(1000)
                    fleecd = fleecd+ 1
                end
                fleecd = 0
                if fleeing == true then
                    fleeing = false
                    RemoveBlip(hblip)
                    local tempd = PlayerHorseId
                    PlayerHorseId = nil
                    DeleteEntity(tempd)
                    SetEntityAsNoLongerNeeded(tempd)
                    --TriggerServerEvent("ricx_horses:deletehorse_server", PedToNet(PlayerHorseId))
                end
            else
                t = 2000
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)
--------------------------------------THREADS END----------------------------------------------------
--==================================================================================================--
--==================================================================================================--
--------------------------------------FUNCTIONS----------------------------------------------------
--------------------------------------NATIVES--------------------------------------
function GetRiderOfMount(ped, bool)
    return Citizen.InvokeNative(0xB676EFDA03DADA52, ped, bool)
end

function RemovePedFromMount(ped, p1, p2)
    return Citizen.InvokeNative(0x5337B721C51883A9, ped, p1, p2)
end

function GetAnimalWild(ped)
    return Citizen.InvokeNative(0x3B005FF0538ED2A9,ped)
end

function SetAnimalWild(ped,bool)
    return Citizen.InvokeNative(0xAEB97D84CDF3C00B, ped, bool)
end

function UipromptDisablePromptsThisFrame()
    return Citizen.InvokeNative(0xF1622CE88A1946FB)
end

function NativeSetPedComponentEnabled(ped, component)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, component, true, true, true)
end

function IsPedLeadingHorse(ped)
    return Citizen.InvokeNative(0xEFC4303DDC6E60D3, ped)
end

function GetLedHorseFromPed(ped)
    return Citizen.InvokeNative(0xED1F514AF4732258, ped)
end

function TaskStopLeadingHorse(ped)
    return Citizen.InvokeNative(0xED27560703F37258, ped)
end
----------------------------------------------------------------------------
--------------------------------------TRAINING--------------------------------------
function StartHorseTraining()
    if PlayerHorseId ~= nil then
        if GetMount(PlayerPedId()) == PlayerHorseId and Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId()) == PlayerHorseId then

            counter = 0
            trainingCD = Config.TrainingTimer
            training = true
            RequestAnimDict(Config.TrainingAnim[1])
            while not HasAnimDictLoaded(Config.TrainingAnim[1]) do
                Citizen.Wait(1)
            end
            TaskPlayAnim(PlayerPedId(), Config.TrainingAnim[1], Config.TrainingAnim[2], 8.0, 8.0, -1, 31, 0, false, false, false)
            Citizen.Wait(500)
            SetAnimalWild(PlayerHorseId,1)

        else
            TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.TrainNotOwned, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
        end
    else
        TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.TrainNeedOwned, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
    end
end
----------------------------------------------------------------------------
function EndHorseTraining(failed)
    training = false
    showButton = false
    counter = 0
    trainingCD = Config.TrainingTimer
    SetAnimalWild(PlayerHorseId,false) 

    if failed == true then
        Citizen.InvokeNative(0x48E92D3DDE23C23A,PlayerPedId(),1,0,0,0,0)
    end

    Citizen.InvokeNative(0x00EDE88D4D13CF59, HorseFeedPrompt)
    Citizen.InvokeNative(0x00EDE88D4D13CF59, HorseLayPrompt)
    Citizen.InvokeNative(0x00EDE88D4D13CF59, HorseSellPrompt)
    HorseSellPrompt = nil
    HorseFeedPrompt = nil
    HorseLayPrompt = nil
    Citizen.Wait(100)
    local promptTarget = Citizen.InvokeNative(0xB796970BD125FCE8, PlayerHorseId)
    Citizen.InvokeNative(0x4E52C800A28F7BE8, HorsePrompts,promptTarget)
    HorsePrompts = PromptGetGroupIdForTargetEntity(PlayerHorseId)
    SetupHorsePrompts()
    ClearPedTasksImmediately(PlayerHorseId)
    TaskStandStill(PlayerHorseId, 2000)
    if failed == false then
        Citizen.InvokeNative(0x48E92D3DDE23C23A,PlayerPedId(),1,0,0,0,0)
        AddHorseExperience(20)
        AddPlayerTrainerExp(2)
        TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.TrainFinished, TEXTURES.tick[1], TEXTURES.tick[2], 2000)
    elseif failed == true then
        TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.TrainFailed, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
    end
    Citizen.Wait(2000)
    ClearPedTasks(PlayerPedId())
end
----------------------------------------------------------------------------
function AddPlayerTrainerExp(value)
    HorseTrainerExp = HorseTrainerExp + value
    TriggerServerEvent("ricx_horses:addtrainerxp",value)

    for i,v in pairs(Config.TrainingLevels) do
        if HorseTrainerExp >= v.xpreq[1] and HorseTrainerExp <= v.xpreq[2] then
            if i > Config.DefaultTrainingLevel then 
                TrainingLevel = Config.DefaultTrainingLevel
                break
            else
                TrainingLevel = i
                break
            end
        end
    end
end
----------------------------------------------------------------------------
function AddHorseExperience(value)
    SelectedHorse.xp = SelectedHorse.xp + value
    TriggerServerEvent("ricx_horses:addxp",value, SelectedHorse.xp)
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 0,value)--Health
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 1,value)--Stamina
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 3,value)--Courage
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 4,value)--Agility
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 5,value)--Speed
    Citizen.InvokeNative(0x75415EE0CB583760, PlayerHorseId, 6,value)--Acceleration
    if SelectedHorse.xp >= Config.ExtraTricksXP then
        Citizen.InvokeNative(0x5DA12E025D47D4E5, PlayerHorseId, 7,4)
    end
    TriggerEvent("Notification:righth",Config.Texts.HorseXP..value,TEXTURES.tick[1],TEXTURES.tick[2],"COLOR_GOLD",1000)
    if Citizen.InvokeNative(0xA4C8E23E29040DE0, PlayerHorseId, 3) > 7 then
        Citizen.InvokeNative(0x9F8AA94D6D97DBF4, PlayerHorseId, true)--AGRESSION DELETE
    end
end
----------------------------------------------------------------------------
--------------------------------------INTERACTIONS--------------------------------------
function StartFlee()
    if Citizen.InvokeNative(0xEFC4303DDC6E60D3, PlayerPedId()) then
        if Citizen.InvokeNative(0xED1F514AF4732258, PlayerPedId()) == PlayerHorseId then
            TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CantFlee, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
            return
        end
    end
    TaskAnimalFlee(PlayerHorseId, PlayerPedId(), -1)
    fleeing = true
end
----------------------------------------------------------------------------
function BrushHorse()
    if not IsEntityDead(PlayerHorseId) and not IsEntityDead(PlayerPedId()) then
        local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(PlayerHorseId),1)
        if dist < 1.6 then
            if selling == false and feeding == false and brushing == false and not IsEntityPlayingAnim(PlayerHorseId, "amb_creature_mammal@world_horse_resting@base", "base", 3) then
                brushing = true
                Citizen.InvokeNative(0xCD181A959CFDD7F4, PlayerPedId(), PlayerHorseId, `Interaction_Brush`, `p_brushHorse02x`, 1)
                Citizen.Wait(6000)
                brushing = false
                ClearPedEnvDirt(PlayerHorseId)
                ClearPedDamageDecalByZone(PlayerHorseId ,10 ,"ALL")
                ClearPedBloodDamage(PlayerHorseId)
                PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
                ClearPedSecondaryTask(PlayerHorseId)
                ClearPedSecondaryTask(PlayerPedId())
            else
                TriggerEvent("Notification:lefth", Config.Texts.HorseBrush, Config.Texts.WaitBrush, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
            end
        else
            TriggerEvent("Notification:lefth", Config.Texts.HorseBrush, Config.Texts.HorseFarAway, TEXTURES.locked[1], TEXTURES.locked[2], 2000)
        end
    end
end
----------------------------------------------------------------------------
function FeedHorse(itemname)
    if not IsEntityDead(PlayerHorseId) and not IsEntityDead(PlayerPedId()) then
        local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(PlayerHorseId),1)
        if dist < 1.6 then
            feeding = true
            TaskAnimalInteraction(PlayerPedId(), PlayerHorseId, `INTERACTION_FOOD`,0,0)
            local info = Config.FeedItems[itemname]
            TaskAnimalInteraction(ped, PlayerHorseId,-224471938, 0, 0) --feed
            Citizen.Wait(5000)
            BoostHorse(info.healthboost, info.staminaboost, info.goldboost.enabled, info.goldboost.hp, info.goldboost.stamina,info.gold2boost.enabled, info.gold2boost.hp, info.gold2boost.stamina)
            feeding = false
        end
    end
end
----------------------------------------------------------------------------
function CallHorse()
    if PlayerHorseId ~= nil then
        if not IsEntityDead(PlayerHorseId) then
            if GetScriptTaskStatus(PlayerHorseId, 0x4924437D, 0) ~= 0 then
                local pcoords1 = GetEntityCoords(PlayerPedId())
                local hcoords = GetEntityCoords(PlayerHorseId)
                local caldist = Vdist(pcoords1.x, pcoords1.y, pcoords1.z, hcoords.x, hcoords.y, hcoords.z)
                if caldist >= 30.0 then
                    TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallFarAway, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
                else
                    TaskGoToEntity(PlayerHorseId, PlayerPedId(), -1, 5.0, 2.0, 0, 0)
                end
            end   
        end
    else
        if SelectedHorse.model then
            if SelectedHorse.injured == 0 then
                if menuOpen == false then
                    TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallComing, TEXTURES.tick[1], TEXTURES.tick[2], 5000)
                    SpawnHorse()
                end
            else
                TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallInjured, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
            end
        else
            TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallNoSelected, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
        end
    end
    calledHorse = false
end
----------------------------------------------------------------------------
function BoostHorse(hp, stmn, goldbool, goldhp, goldstmn, gold2bool, gold2hp, gold2stmn)
    local stamina = GetAttributeCoreValue(PlayerHorseId, 1)
    local newStamina = stamina + stmn --stamina value to add
    local Health = GetAttributeCoreValue(PlayerHorseId, 0)
    local newHealth = Health + hp --health value to add

    if newStamina >= 100 then
        newStamina = 100
    end

    if newHealth >= 100 then
        newHealth = 100
    end
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerHorseId, 1, newStamina) 
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerHorseId, 0, newHealth) 
    if goldbool == true then
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerHorseId, 1, goldstmn, false )
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerHorseId, 0, goldhp, true )
    end
    if gold2bool == true then
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerHorseId, 0, gold2hp, true)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerHorseId, 1, gold2stmn, false)
    end
    --PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
end
--------------------------------------SELL--------------------------------------
function StartSellHorse()
    local result = nil

    AddTextEntry("FMMC_KEY_TIP8", Config.Texts.SellAddPrice)
    DisplayOnscreenKeyboard(3, "FMMC_KEY_TIP8", "", "", "", "", "", 5)
    while (UpdateOnscreenKeyboard() == 0) do
        Citizen.Wait(1);
    end
        if (GetOnscreenKeyboardResult()) then
            result = GetOnscreenKeyboardResult()
            if result then
                if tonumber(result) == nil then
                    result = 0
                end
                if tonumber(result) < 1 then
                    result = 0
                end
                SellHorsePriceAdded(tonumber(result))
            end
        end
end
----------------------------------------------------------------------------
function SellHorsePriceAdded(result)
    selling = true
    Citizen.InvokeNative(0x1913FE4CBF41C463, PlayerHorseId, 136, true)
    SetEntityInvincible(PlayerPedId(), true)
    SetEntityInvincible(PlayerHorseId, true)
    FreezeEntityPosition(PlayerHorseId, true)
    TaskStandStill(PlayerPedId(), -1)
    local sc = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("ricx_horses:sell:create",SelectedHorse.id, result, sc, GetPlayerServerId(PlayerId()), PedToNet(PlayerHorseId))
end
----------------------------------------------------------------------------
function StopSellHorse()
    selling = false
    Citizen.InvokeNative(0x1913FE4CBF41C463, PlayerHorseId, 136, false)
    SetEntityInvincible(PlayerPedId(), false)
    SetEntityInvincible(PlayerHorseId, false)
    FreezeEntityPosition(PlayerHorseId, false)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("ricx_horses:sell:stop",SelectedHorse.id)
end
--------------------------------------SPAWN--------------------------------------
function SpawnHorse()
    local playerped = PlayerPedId()
    
    local model = SelectedHorse.model

    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end
    end

    local spawnPosition

    local x, y, z = table.unpack(pcoords)
    local bool, nodePosition = GetClosestVehicleNode(x, y, z, 1, 100.0, 100.0)

    local index = 0
    while index <= 25 do
        local _bool, _nodePosition = GetNthClosestVehicleNode(x, y, z, index, 1, 100.0, 100.0)
        if _bool == true or _bool == 1 then
            bool = _bool
            nodePosition = _nodePosition
            index = index + 3
        else
            break
        end
    end

    spawnPosition = nodePosition
    if spawnPosition.x == 0 and spawnPosition.y == 0 then
        TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallNoRoads, TEXTURES.cross[1], TEXTURES.cross[2], 4000)
        return
    end

    local tempPlayerHorseId = CreatePed(model, spawnPosition, GetEntityHeading(playerped), true, true)

    SetEntityVisible(tempPlayerHorseId,false)
    Citizen.InvokeNative(0x283978A15512B2FE, tempPlayerHorseId, true)
    
    Citizen.InvokeNative(0x704C908E9C405136, tempPlayerHorseId)
    SetEntityAsMissionEntity(tempPlayerHorseId, true, true)
    if(SelectedHorse.sex == 1) then
        Citizen.InvokeNative(0x5653AB26C82938CF, tempPlayerHorseId, 0xA28B, 0.0)
    elseif SelectedHorse.sex == 2 then
        Citizen.InvokeNative(0x5653AB26C82938CF, tempPlayerHorseId, 0xA28B, 1.0)
    end
    Citizen.InvokeNative(0xCC8CA3E88256E58F, tempPlayerHorseId, 0, 1, 1, 1, 0)
    Citizen.InvokeNative(0x9587913B9E772D29, tempPlayerHorseId, 0)
    Citizen.InvokeNative(0x4DB9D03AC4E1FA84, tempPlayerHorseId, -1, -1, 0)


    Citizen.InvokeNative(0xB8B6430EAD2D2437, tempPlayerHorseId, `PLAYER_HORSE`)
    Citizen.InvokeNative(0xFD6943B6DF77E449, tempPlayerHorseId, false)

    for i,v in pairs(Config.SpawnedHorseFlags) do 
        SetPedConfigFlag(tempPlayerHorseId,v[1],v[2])
        Citizen.Wait(1)
    end
   
    TaskAnimalUnalerted(tempPlayerHorseId, -1, 0, 1, 1)

    Citizen.InvokeNative(0x931B241409216C1F, playerped, tempPlayerHorseId, 0)
    Citizen.InvokeNative(0xD2CB0FB0FDCB473D, PlayerId(), tempPlayerHorseId) -- saddlehorse
    Citizen.InvokeNative(0x06D26A96CA1BCA75,tempPlayerHorseId, 3, 100.0, playerped) --setmood
    SetVehicleHasBeenOwnedByPlayer(tempPlayerHorseId, true)

    local horseXP = SelectedHorse.xp
    local bonding = 0
    if SelectedHorse.xp >= Config.ExtraTricksXP then
        Citizen.InvokeNative(0x5DA12E025D47D4E5, tempPlayerHorseId, 7,4)
        Citizen.InvokeNative(0x725D52F21A5E9E50, tempPlayerHorseId, 4)
    end
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 0,horseXP)--Health
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 1,horseXP)--Stamina
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 3,horseXP)--Courage
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 4,horseXP)--Agility
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 5,horseXP)--Speed
    Citizen.InvokeNative(0x75415EE0CB583760, tempPlayerHorseId, 6,horseXP)--Acceleration

    if Citizen.InvokeNative(0xA4C8E23E29040DE0, tempPlayerHorseId, 3) then
        if Citizen.InvokeNative(0xA4C8E23E29040DE0, tempPlayerHorseId, 3) > Config.AgressionDeleteLevel then
            Citizen.InvokeNative(0x9F8AA94D6D97DBF4, tempPlayerHorseId, true)--DELETE AGRESSION
        end
    end
    SetModelAsNoLongerNeeded(model)
    SetPedNameDebug(tempPlayerHorseId, SelectedHorse.name)
    SetPedPromptName(tempPlayerHorseId, SelectedHorse.name)

    HorsePrompts = PromptGetGroupIdForTargetEntity(tempPlayerHorseId)

	SetupHorsePrompts()

    local compdata = json.decode(SelectedHorse.components)
    Citizen.Wait(500)
    for i, v in pairs(compdata) do
        if tonumber(v) ~= 0 then
            Citizen.Wait(100)
            NativeSetPedComponentEnabled(tempPlayerHorseId, tonumber(v))

            Citizen.Wait(100)
            if i == "Saddle" then --DO NOT CHANGE
                if tonumber(compdata.Bridles) ~= 0 then
                    NativeSetPedComponentEnabled(tempPlayerHorseId, tonumber(compdata.Bridles))
                    Citizen.Wait(100)
                end
            end
            Citizen.Wait(50)
        end
    end
    Citizen.Wait(200)

    hblip = Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, tempPlayerHorseId)
    local playerString = CreateVarString(10, "PLAYER_STRING", SelectedHorse.name)
	Citizen.InvokeNative(0x9CB1A1623062F402, hblip, playerString)

    SetEntityVisible(tempPlayerHorseId,true)

    TaskGoToEntity(tempPlayerHorseId, playerped, -1, 7.2, 2.0, 0, 0) 
    -- TriggerServerEvent("ricx_horses:update_storage", SelectedHorse.id)
    TriggerServerEvent("ricx_horses:update_horses", PedToNet(tempPlayerHorseId))
    PlayerHorseId = tempPlayerHorseId
end
--------------------------------------STABLE--------------------------------------
function StableOpen(id)
    menuOpen = true
    TaskStandStill(PlayerPedId(), -1)
    MenuData.CloseAll()
    tempStableID = id
    cameraindex = 1
    CamAttach = Config.Stables[id].campos[cameraindex]
    local elements = {
        {label = MENUTEXTS.OwnedHorses, value = "owned", desc = MENUTEXTS.OwnedHorsesDesc},
        {label = MENUTEXTS.BuyHorses, value ="shop", desc = MENUTEXTS.BuyHorsesDesc},
    }
    MenuData.Open('default', GetCurrentResourceName(), 'stablemainmenu',{
        title    = Config.Stables[id].name.." "..Config.Prompts.Stable,
        subtext  = MENUTEXTS.Options,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        if(data.current.value == 'owned') then
            TriggerServerEvent("ricx_horses:getOwnedHorses",id)
        elseif(data.current.value == 'shop') then
            StableBuyHorse(id)
        end
    end,
    function(data, menu)

        for i,v in pairs(Config.Horses) do
            for c,k in pairs(Config.Horses[i].Variants) do
                local m1 = k[1]
                SetModelAsNoLongerNeeded(m1)
            end
        end
        tempStableID = nil
        ClearPedTasks(PlayerPedId())
        menuOpen = false
        menu.close()
    end)
end
----------------------------------------------------------------------------
RegisterNetEvent('ricx_horses:ownedhorses')
AddEventHandler('ricx_horses:ownedhorses', function(horses, stableid)
    ownedHorses = {}
    for i, c in pairs(horses) do
        --selected, model, name, components, sex, xp
        table.insert(ownedHorses, {id = tonumber(c.id), selected = tonumber(c.selected), model = tonumber(c.model), name = c.name, components = json.decode(c.components), sex = tonumber(c.sex), xp = tonumber(c.xp), injured = tonumber(c.injured), price = tonumber(c.price)})
    end
	OwnedHorsesMenu(stableid)
end)

function OwnedHorsesMenu(stableid)
	local elements_h = {}

    if ownedHorses ~= nil then
        for j, z in pairs(ownedHorses) do
            local st = ""
            if z.selected == 1 then
                st = MENUTEXTS.SelectedHorseT
            end
            table.insert (elements_h , {label = ownedHorses[j].name..""..st, value = ownedHorses[j], desc =  MENUTEXTS.SelectedHorseDesc})
        end
	end
	MenuData.CloseAll()
    local model = ownedHorses[1].model
    local pos = Config.Stables[stableid].horsepos
    CreateShowroomHorse(stableid, model, pos)
    SetShowroomRanks(ownedHorses[1].xp, tempHorse)
    for i, v in pairs(ownedHorses[1].components) do
        if v ~= 0 then
            Citizen.Wait(120)
            NativeSetPedComponentEnabled(tempHorse, tonumber(v))
        end
    end
    tempHorseData = GetHorseData(tempHorse, ownedHorses[1])
    ownedstat = true
	MenuData.Open(
			'default', GetCurrentResourceName(), 'owned_horses',
			{
				title    = MENUTEXTS.OwnedHorses,
				subtext    = '',
				align    = 'top-left',
				elements = elements_h,
			},
			function(data, menu)
				HorseManage(data.current.value, stableid)
			end,
			function(data, menu)
                RenderScriptCams(false, true, 500, true, true)
                DestroyCam(Camera)
                Camera = nil
                ownedstat = false
                DeleteEntity(tempHorse)
				StableOpen(stableid)
	        end,
            function(data,menu)
                if(data.current.value) then
                    if canChange == true then
                        canChange = false
                        ownedstat = false
                        if tempHorse ~= nil then
                            SetEntityVisible(tempHorse, false)
                            DeleteEntity(tempHorse)
                            while IsAnEntity(tempHorse) do
                                Citizen.Wait(1)
                            end
                        end
                        model = data.current.value.model
                        if not HasModelLoaded(model) then
                            RequestModel(model)
                            while not HasModelLoaded(model) do
                                Citizen.Wait(1)
                            end
                        end
            
                        tempHorse = CreatePed(model, pos.x, pos.y, pos.z-1, pos.h, false, 0)
                        Citizen.InvokeNative(0xBA8818212633500A,tempHorse, 6, 1)
                        SetEntityVisible(tempHorse,false)
                        Citizen.InvokeNative(0x283978A15512B2FE, tempHorse, true)
                        NetworkSetEntityInvisibleToNetwork(tempHorse, true)
                        SetVehicleHasBeenOwnedByPlayer(tempHorse, true)
                        Citizen.InvokeNative(0x9F8AA94D6D97DBF4, PlayerHorseId, true)
                        FreezeEntityPosition(tempHorse,true)
                        SetEntityInvincible(tempHorse, true)
                        CamAttach = Config.Stables[stableid].campos[cameraindex]
                        AttachCamToEntity(Camera, tempHorse, CamAttach[1], CamAttach[2], CamAttach[3], true)
                        if CamAttach[4] ~= nil then
                            SetCamRot(Camera, CamAttach[4], CamAttach[5], CamAttach[6])
                        end
                        SetShowroomRanks(data.current.value.xp, tempHorse)
                        for i, v in pairs(data.current.value.components) do
                            if v ~= 0 then
                                Citizen.Wait(120)
                                NativeSetPedComponentEnabled(tempHorse, tonumber(v))
                            end
                        end
                        SetEntityVisible(tempHorse,true)
                        tempHorseData = GetHorseData(tempHorse, data.current.value)
                        ownedstat = true
                        canChange = true
                    end
                end
            end
    )
end
----------------------------------------------------------------------------
function HorseManage(hdata, stableid)
    MenuData.CloseAll()
    ownedstat = true
    local price_ = CalculateOwnedPrice(hdata.price,hdata.xp)
    local elements_o_h = {
        {label = MENUTEXTS.ManageSelect, value = "SetHorse" , desc =  MENUTEXTS.ManageSelectDesc },
        {label = MENUTEXTS.ManageBuyComp, value = "BuyComp" , desc =  MENUTEXTS.ManageBuyCompDesc },
        {label = MENUTEXTS.ManageRemoveComp, value = "RemoveComp" , desc =  MENUTEXTS.ManageRemoveCompDesc },
        {label = MENUTEXTS.ManageHeal, value = "HealHorse" , desc =  MENUTEXTS.ManageHealDesc },
        {label = MENUTEXTS.ManageSell..price_, value = "DeleteHorse" , desc =  MENUTEXTS.ManageSellDesc }
    }
    MenuData.Open(
        'default', GetCurrentResourceName(), 'horse_manage',
        {
            title    = MENUTEXTS.Options,
            subtext    = '',
            align    = 'top-left',
            elements =  elements_o_h,
        },
        function(data, menu)
            if hdata.injured == 0 and data.current.value == "SetHorse" then
                ClearPedTasks(PlayerPedId())
                menuOpen = false
                RenderScriptCams(false, true, 500, true, true)
                DestroyCam(Camera)
                Camera = nil
                ownedstat = false
                DeleteEntity(tempHorse)
                menu.close()
                TriggerServerEvent('ricx_horses:'..data.current.value , hdata)
            elseif data.current.value == "HealHorse" then
                if hdata.injured == 1 then
                    ClearPedTasks(PlayerPedId())
                    menuOpen = false
                    ownedstat = false
                    RenderScriptCams(false, true, 500, true, true)
                    DestroyCam(Camera)
                    Camera = nil
                    DeleteEntity(tempHorse)
                    menu.close()
                    TriggerServerEvent('ricx_horses:'..data.current.value , hdata)
                end
            elseif data.current.value == "DeleteHorse" then
                TriggerServerEvent("ricx_horses:"..data.current.value, hdata, price_)
                Citizen.Wait(300)
                ownedstat = false
                DestroyCam(Camera)
                Camera = nil
                DeleteEntity(tempHorse)
                StableOpen(stableid)
            elseif data.current.value == "BuyComp" then
                OpenComponentStore(stableid, hdata)
            elseif data.current.value == "RemoveComp" then
                OpenRemoveComponentStore(stableid, hdata)
            else
                TriggerEvent("Notification:lefth", Config.Texts.Horse, Config.Texts.CallInjured, TEXTURES.cross[1], TEXTURES.cross[2], 4000)
            end
        end,
        function(data, menu)
            TriggerServerEvent("ricx_horses:getOwnedHorses",stableid)
	end)
end
----------------------------------------------------------------------------
function OpenRemoveComponentStore(stableid, hdata)
    MenuData.CloseAll()
    local elements = {}
    for i,v in pairs(Config.Components) do
        elements[i] = {label = Config.Texts.Categories[v], value = v, desc = MENUTEXTS.RemoveComp, components = Config[v]}
    end
    for i, v in pairs(hdata.components) do
        NativeSetPedComponentEnabled(tempHorse,v)
    end
    ownedstat = false
    MenuData.Open('default', GetCurrentResourceName(), 'removecomp',{
        title    = Config.Stables[stableid].name.." "..Config.Prompts.Stable,
        subtext  = MENUTEXTS.RemoveComp,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        if(data.current.value) then
            TriggerServerEvent("ricx_horses:removecomp", hdata.id, data.current.value)
            hdata.components[data.current.value] = 0
            SelectedHorse.components = json.encode(hdata.components)
            UpdateHorseAfterCompRemove(stableid, hdata)
        end
    end,
    function(data, menu)
        HorseManage(hdata, stableid)
    end)
end
----------------------------------------------------------------------------
function UpdateHorseAfterCompRemove(stableid, hdata)
    if tempHorse ~= nil then
        SetEntityVisible(tempHorse, false)
        DeleteEntity(tempHorse)
        while IsAnEntity(tempHorse) do
            Citizen.Wait(1)
        end
    end
    local model = hdata.model
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end
    end
    local pos = Config.Stables[stableid].horsepos
    tempHorse = CreatePed(model, pos.x, pos.y, pos.z-1, pos.h, false, 0)
    Citizen.InvokeNative(0xBA8818212633500A,tempHorse, 6, 1)
    SetEntityVisible(tempHorse,false)
    Citizen.InvokeNative(0x283978A15512B2FE, tempHorse, true)
    NetworkSetEntityInvisibleToNetwork(tempHorse, true)
    SetVehicleHasBeenOwnedByPlayer(tempHorse, true)
    Citizen.InvokeNative(0x9F8AA94D6D97DBF4, PlayerHorseId, true)
    FreezeEntityPosition(tempHorse,true)
    SetEntityInvincible(tempHorse, true)
    CamAttach = Config.Stables[stableid].campos[cameraindex]
    AttachCamToEntity(Camera, tempHorse, CamAttach[1], CamAttach[2], CamAttach[3], true)
    if CamAttach[4] ~= nil then
        SetCamRot(Camera, CamAttach[4], CamAttach[5], CamAttach[6])
    end
    for i, v in pairs(hdata.components) do
        if v ~= 0 then
            Citizen.Wait(120)
            NativeSetPedComponentEnabled(tempHorse, tonumber(v))
            if i == "Saddle" then
                Citizen.Wait(200)
                NativeSetPedComponentEnabled(tempHorse, tonumber(hdata.components.Bridles))
            end
        end
    end
    SetEntityVisible(tempHorse,true)
end
----------------------------------------------------------------------------
function OpenComponentStore(stableid, hdata)
    MenuData.CloseAll()
    local elements = {}
    for i,v in pairs(Config.Components) do
        if Config.Images[v] then
            elements[i] = {label = Config.Texts.Categories[v], value = "comp"..i, desc = "<img src='"..Config.Images[v].."'><br>"..MENUTEXTS.CategorySelect, components = Config[v], label2 = v}
        else
            elements[i] = {label = Config.Texts.Categories[v], value = "comp"..i, desc = MENUTEXTS.CategorySelect, components = Config[v]}
        end
    end
    for i, v in pairs(hdata.components) do
        NativeSetPedComponentEnabled(tempHorse,v)
    end
    ownedstat = false
    MenuData.Open('default', GetCurrentResourceName(), 'compstore',{
        title    = Config.Stables[stableid].name.." "..Config.Prompts.Stable,
        subtext  = MENUTEXTS.HorseEquipments,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        if(data.current.value) then
            
            OpenComponents(stableid, data.current.components, data.current.label2, hdata)
        end
    end,
    function(data, menu)
        HorseManage(hdata, stableid)
    end)
end
----------------------------------------------------------------------------
function OpenComponents(stableid, compdata, catname, hdata)
    local elements = {}
    UpdateHorseAfterCompRemove(stableid, hdata)
    for i,v in pairs(compdata) do
        elements[i] = {label = Config[catname][i].name, value = "compdata"..i, desc = MENUTEXTS.Select_..catname, components = v.Variants, catname = catname}
    end
    MenuData.Open('default', GetCurrentResourceName(), 'comps'..catname,{
        title    = Config.Stables[stableid].name.." "..Config.Prompts.Stable,
        subtext  = catname,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        if(data.current.value) then
            OpenCompVariants(stableid, data.current.components, data.current.label, compdata, data.current.catname, hdata)
        end
    end,
    function(data, menu)
        OpenComponentStore(stableid, hdata)
    end)
end
----------------------------------------------------------------------------
function OpenCompVariants(stableid, compdata, catname, olddata, oldname, hdata)
    MenuData.CloseAll()

    local elements = {}
    local first 
    local old = {[1] = olddata, [2] = oldname}
    currentHorseComps = nil
    TriggerServerEvent("ricx_horses:getcomps:ownedhorse",hdata.id, oldname)
    TriggerEvent("Notification:lefth", Config.Texts.ShopTitle, Config.Texts.WaitLoad, TEXTURES.alert[1], TEXTURES.alert[2], 2000)
    Citizen.Wait(400)
    local editlabel = MENUTEXTS.SpaceDollar
    while currentHorseComps == nil do
        Citizen.Wait(100)

    end
    Citizen.Wait(100)
    for i,v in pairs(compdata) do
        if i == 1 then
            first = v[3]
        end
        editlabel = MENUTEXTS.SpaceDollar..v[2]
        for c,k in pairs(currentHorseComps) do
            if tonumber(k) == tonumber(v[3]) then
                editlabel = MENUTEXTS.OwnedComponent
                break
            end
            editlabel = MENUTEXTS.SpaceDollar..v[2]
        end
        elements[i] = {label = v[1]..""..editlabel, value = "compdat"..i, desc = MENUTEXTS.BuyEquipment, component = v}
        Citizen.Wait(1)
    end

    NativeSetPedComponentEnabled(tempHorse, tonumber(first))
    Citizen.Wait(300)
    MenuData.Open('default', GetCurrentResourceName(), 'comps1'..oldname,{
        title    = Config.Stables[stableid].name.." "..Config.Prompts.Stable,
        subtext  = catname,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        local compCatName = old[2]
        local hash = data.current.component[3]
        if old[2] == "Specials" then
            if hash == 0x0865A270 then
                compCatName = "Shoes"
            elseif hash == 0xF772CED6 then
                compCatName = "Holster"
            elseif hash == 0x635E387C then
                compCatName = "Lantern"
            end
        end
        local opening = {}
        opening[1] = stableid
        opening[2] = old[1]
        opening[3] = old[2]
        opening[4] = hdata
        TriggerServerEvent("ricx_horses:buycomponent", compCatName, hash, data.current.component[2], hdata, opening)
        Citizen.Wait(500)
    end,
    function(data, menu)
        OpenComponents(stableid, old[1], old[2], hdata)
    end,
    function(data, menu)
        Citizen.Wait(100)
        NativeSetPedComponentEnabled(tempHorse, tonumber(data.current.component[3]))
    end)

end
----------------------------------------------------------------------------
function SetShowroomRanks(xp, ped)
    local horseXP = xp
    if horseXP >= Config.ExtraTricksXP then
        Citizen.InvokeNative(0x5DA12E025D47D4E5, ped, 7,4)
    end
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 0,horseXP)--Health
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 1,horseXP)--Stamina
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 3,horseXP)--Courage
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 4,horseXP)--Agility
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 5,horseXP)--Speed
    Citizen.InvokeNative(0x75415EE0CB583760, ped, 6,horseXP)--Acceleration
    
end
----------------------------------------------------------------------------
function CreateShowroomHorse(id, model, pos)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end
    end
        
    if tempHorse ~= nil then
        SetEntityVisible(tempHorse, false)
        DeleteEntity(tempHorse)
        while IsAnEntity(tempHorse) do
            Citizen.Wait(1)
        end
    end
    tempHorse = CreatePed(model, pos.x, pos.y, pos.z-1, pos.h, false, 0)
    Citizen.InvokeNative(0xBA8818212633500A,tempHorse, 6, 1)
    Citizen.InvokeNative(0x283978A15512B2FE, tempHorse, true)
    NetworkSetEntityInvisibleToNetwork(tempHorse, true)
    SetVehicleHasBeenOwnedByPlayer(tempHorse, true)
    FreezeEntityPosition(tempHorse,true)
    Citizen.InvokeNative(0x9F8AA94D6D97DBF4, tempHorse, true)
    SetEntityInvincible(tempHorse, true)
    if Camera == nil then 
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        RenderScriptCams(true, true, 1000, true, true)
    end
    CamAttach = Config.Stables[id].campos[cameraindex]
    AttachCamToEntity(Camera, tempHorse, CamAttach[1], CamAttach[2], CamAttach[3], true)
    
    if CamAttach[4] ~= nil then
        SetCamRot(Camera, CamAttach[4], CamAttach[5], CamAttach[6])
    end
end
----------------------------------------------------------------------------
function StableBuyHorse(id)
    if called == false then
        if not HasModelLoaded(Config.Horses[1].Variants[1][1]) then
            TriggerEvent("Notification:lefth", Config.Texts.ShopTitle, Config.Texts.WaitLoad, TEXTURES.alert[1], TEXTURES.alert[2], 2000)
        end
        called = true
        MenuData.CloseAll()

        for c,k in pairs(Config.Horses) do
            local m1 = k.Variants[1][1]
            RequestModel(m1)
            while not HasModelLoaded(m1) do
                Citizen.Wait(10)
            end
        end

        local elements = {}
        for i,v in pairs(Config.Horses) do
            elements[i] = {label = v.category, value = "category"..i, desc = MENUTEXTS.HorseCategorySelect, catid = i}
        end
        local model = `a_c_horse_americanpaint_greyovero`
        local pos = Config.Stables[id].horsepos
        CreateShowroomHorse(id, model, pos)

        MenuData.Open('default', GetCurrentResourceName(), 'horsecat',{
            title    = Config.Stables[id].name.." "..Config.Prompts.Stable,
            subtext  = MENUTEXTS.HorseCategories,
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            StableCategory(id, data.current.catid)
        end,
        function(data, menu)
            SetEntityVisible(tempHorse, false)
            DeleteEntity(tempHorse)
            RenderScriptCams(false, true, 500, true, true)
            DestroyCam(Camera)
            while IsAnEntity(tempHorse) do
                Citizen.Wait(50)
            end
            SetEntityAsNoLongerNeeded(tempHorse)
            SetModelAsNoLongerNeeded(model)
            Camera = nil
            called = false

            StableOpen(id)
        end,
        function(data, menu)
            if(data.current.value) then
                if canChange == true then
                    canChange = false
                    if tempHorse ~= nil then
                        SetEntityVisible(tempHorse, false)
                        DeleteEntity(tempHorse)
                        while IsAnEntity(tempHorse) do
                            Citizen.Wait(1)
                        end
                    end
                    model = Config.Horses[data.current.catid].Variants[1][1]
                    tempHorse = CreatePed(model, pos.x, pos.y, pos.z-1, pos.h, false, 0)
                    Citizen.InvokeNative(0xBA8818212633500A,tempHorse, 6, 1)
                    Citizen.InvokeNative(0x283978A15512B2FE, tempHorse, true)
                    NetworkSetEntityInvisibleToNetwork(tempHorse, true)
                    SetVehicleHasBeenOwnedByPlayer(tempHorse, true)
                    FreezeEntityPosition(tempHorse,true)
                    Citizen.InvokeNative(0x9F8AA94D6D97DBF4, tempHorse, true)
                    SetEntityInvincible(tempHorse, true)
                    CamAttach = Config.Stables[id].campos[cameraindex]
                    AttachCamToEntity(Camera, tempHorse, CamAttach[1], CamAttach[2], CamAttach[3], true)
                    if CamAttach[4] ~= nil then
                        SetCamRot(Camera, CamAttach[4], CamAttach[5], CamAttach[6])
                    end
                    canChange = true
                end
            end
        end)
    end
end
----------------------------------------------------------------------------
function StableCategory(id, catid)
    MenuData.CloseAll()

    if not HasModelLoaded(Config.Horses[catid].Variants[1][1]) then
        TriggerEvent("Notification:lefth", Config.Texts.ShopTitle, Config.Texts.WaitLoad, TEXTURES.alert[1], TEXTURES.alert[2], 2000)
    end

    for c,k in pairs(Config.Horses[catid].Variants) do
        local m1 = k[1]
        RequestModel(m1)
        while not HasModelLoaded(m1) do
            Citizen.Wait(10)
        end
    end

    tempHorseData = GetHorseData(tempHorse)
    stat = true
    local elements = {}
    for i,v in pairs(Config.Horses[catid].Variants) do
        elements[i] = {label = v[2]..MENUTEXTS.SpaceDollar..v[3]..MENUTEXTS.GenderSelect, value = 1, value2 = "horse"..i, desc =MENUTEXTS.StallionMare, info = v, type = "slider" , min = 0, max = 2, hop = 1}
    end

    local pos = Config.Stables[id].horsepos
    local model 

    MenuData.Open('default', GetCurrentResourceName(), 'horseshop'..id,{
        title    = Config.Stables[id].name.." "..Config.Prompts.Stable,
        subtext  = MENUTEXTS.Buy_..Config.Horses[catid].category,
        align    = 'top-left',
        elements = elements,
    },
    function(data, menu)
        for i,v in pairs(elements) do
            if(data.current.value ~= 0) then
                if(data.current.value2 == 'horse'..i) then
                    local sex = data.current.value
                    local sex2 = ""
                    if sex == 1 then
                        sex2 = Config.Texts.Gender[1]
                    else
                        sex2 = Config.Texts.Gender[2]
                    end
                    
                    tempHorseData = GetHorseData(tempHorse)
                    
                    local price = data.current.info[3]
                    local hmodel = data.current.info[1]
                    local skill = data.current.info[4]
                    local job = data.current.info[5] or false
                    local horsetype = Config.Horses[catid].category.."("..data.current.info[2]..")"
                    AddName(hmodel, horsetype, price, skill, sex, job)
                    break
                end
            elseif(data.current.value == 0) then
                TriggerEvent("Notification:lefth", Config.Texts.Horse, MENUTEXTS.ChooseGender, TEXTURES.cross[1], TEXTURES.cross[2], 2000)
                break
            end
        end
    end,
    function(data, menu)
        called = false
        stat = false
        ownedstat = false
        StableBuyHorse(id)
    end,
    function(data, menu)
        if canChange == true then
            canChange = false
            stat = false
            if tempHorse ~= nil then
                SetEntityVisible(tempHorse, false)
                DeleteEntity(tempHorse)
                while IsAnEntity(tempHorse) do
                    Citizen.Wait(1)
                end
            end
            local idhash = data.current.info[1]
            model = data.current.info[1]
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                end
            end
            tempHorse = CreatePed(model, pos.x, pos.y, pos.z-1, pos.h, false, 0)
            Citizen.InvokeNative(0xBA8818212633500A,tempHorse, 6, 1)
            SetEntityVisible(tempHorse,false)
            Citizen.InvokeNative(0x283978A15512B2FE, tempHorse, true)
            NetworkSetEntityInvisibleToNetwork(tempHorse, true)
            SetVehicleHasBeenOwnedByPlayer(tempHorse, true)
            Citizen.InvokeNative(0x9F8AA94D6D97DBF4, PlayerHorseId, true)
            FreezeEntityPosition(tempHorse,true)
            SetEntityInvincible(tempHorse, true)
            Citizen.InvokeNative(0x704C908E9C405136, tempHorse)
            if(data.current.value == 1) then
                Citizen.InvokeNative(0x5653AB26C82938CF, tempHorse, 0xA28B, 0.0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, tempHorse, 0, 1, 1, 1, 0)
                gender = Config.Texts.Gender[1]
            elseif data.current.value == 2 then
                Citizen.InvokeNative(0x5653AB26C82938CF, tempHorse, 0xA28B, 1.0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, tempHorse, 0, 1, 1, 1, 0)
                gender = Config.Texts.Gender[2]
            elseif data.current.value == 0 then
                gender = MENUTEXTS.GenderNumbers
            end
            SetEntityVisible(tempHorse,true)
            CamAttach = Config.Stables[id].campos[cameraindex]
            AttachCamToEntity(Camera, tempHorse, CamAttach[1], CamAttach[2], CamAttach[3], true)
            if CamAttach[4] ~= nil then
                SetCamRot(Camera, CamAttach[4], CamAttach[5], CamAttach[6])
            end
            Citizen.Wait(200)
            tempHorseData = GetHorseData(tempHorse)
            stat = true
            canChange = true
        end
    end)
end
----------------------------------------------------------------------------
function AddName(hmodel, horsetype, price, skill, sex, job)
    AddTextEntry("RICX_HORSES_NAME", Config.Texts.HorseName)
    DisplayOnscreenKeyboard(1, "RICX_HORSES_NAME", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        Citizen.Wait(1);
    end
    while (UpdateOnscreenKeyboard() == 2) do
        Citizen.Wait(1);
        break
    end
    while (UpdateOnscreenKeyboard() == 1) do
        Citizen.Wait(1)
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result ~= "" then
                TriggerServerEvent("ricx_horses:buyhorse", hmodel, horsetype, price, skill, sex, result, job)
                break
            end
        end
    end
end
--------------------------------------OWNED STAT DISPLAY--------------------------------------
function OwnedStatF(text)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str, 0.8, 0.6)
    local lengthf = (string.len(text)) / 150
    ShowOwnedOption(lengthf)
end

function ShowOwnedOption(lengthf)
    local bt = ""
    if type(tempHorseData[7]) == "number" then
        if tempHorseData[7] >= 1450 then
            bt = MENUTEXTS.Yes
        else
            bt = MENUTEXTS.None
        end
    else
        bt = MENUTEXTS.None
    end
    local gender1 = ""
    if tempHorseData[13] == 1 then
        gender1 = Config.Texts.Gender[1]
    elseif tempHorseData[13] == 2 then
        gender1 = Config.Texts.Gender[2]
    end
    local h, s, c, a, sp, ac, b, g = MENUTEXTS.Health..tempHorseData[1], MENUTEXTS.Stamina..tempHorseData[2], MENUTEXTS.Courage..tempHorseData[3], MENUTEXTS.Agility..tempHorseData[4], MENUTEXTS.Speed..tempHorseData[5], MENUTEXTS.Acceleration..tempHorseData[6], MENUTEXTS.Bonding..bt, MENUTEXTS.Gender..gender1
    local inj = ""
    local exp = "~COLOR_PLATINUM~"..MENUTEXTS.Experience..tempHorseData[10]
    local price = "~COLOR_GOLD~"..MENUTEXTS.Price..tempHorseData[9]
    local name = "~COLOR_BLUEDARK~"..MENUTEXTS.Name..tempHorseData[11]
    if tempHorseData[8] then
        if tempHorseData[8] == 0 then
            inj = "~COLOR_GREEN~"..MENUTEXTS.Healthy
        elseif tempHorseData[8] == 1 then
            inj = "~COLOR_RED~"..MENUTEXTS.Injured
        end
    end
    local type = "~COLOR_YELLOW~"..MENUTEXTS.Type..tempHorseData[12]
    local texts = {h,s,c,a,sp,ac,b,g, inj, price, exp, name, type}
    local pos = {Config.StatMenu.optionpos[1],Config.StatMenu.optionpos[2],Config.StatMenu.optionpos[3],Config.StatMenu.optionpos[4],Config.StatMenu.optionpos[5],Config.StatMenu.optionpos[6],Config.StatMenu.optionpos[7],Config.StatMenu.optionpos[8],Config.StatMenu.optionpos[9],Config.StatMenu.optionpos[10],Config.StatMenu.optionpos[11],Config.StatMenu.optionpos[12],Config.StatMenu.optionpos[13]}
    for i,v in pairs(texts) do
        SetTextScale(0.35, 0.35)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        local str = CreateVarString(10, "LITERAL_STRING", texts[i], Citizen.ResultAsLong())
        SetTextCentre(1)
        DisplayText(str, Config.StatMenu.startpos[1], pos[i])
    end
    CreateMenu2(lengthf,#texts)
end
----------------------------------------------------------------------------
function CreateMenu2(lengthf, l2)
    for i = 1, l2, 1 do
        DrawSprite("generic_textures","hud_menu_4a", Config.StatMenu.startpos[1], Config.StatMenu.optionpos[i]+0.012, (Config.StatMenu.basesize+lengthf)*2.5, Config.StatMenu.basesize, 0.0, Config.StatMenu.bg[1], Config.StatMenu.bg[2], Config.StatMenu.bg[3], Config.StatMenu.bg[4], 0)
    end
end
----------SHOP STAT DISPLAY-----------
function Text3d(text)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str, 0.8, 0.6)
    local lengthf = (string.len(text)) / 150
    ShowMenuOption(lengthf)
end
----------------------------------------------------------------------------
function ShowMenuOption(lengthf)
    local bt = ""
    if type(tempHorseData[7]) == "number" then
        if tempHorseData[7] >= Config.ExtraTricksXP then
            bt = MENUTEXTS.Yes
        else
            bt = MENUTEXTS.None
        end
    else
        bt = MENUTEXTS.None
    end
    local h, s, c, a, sp, ac, b, g = MENUTEXTS.Health..tempHorseData[1], MENUTEXTS.Stamina..tempHorseData[2], MENUTEXTS.Courage..tempHorseData[3], MENUTEXTS.Agility..tempHorseData[4], MENUTEXTS.Speed..tempHorseData[5], MENUTEXTS.Acceleration..tempHorseData[6], MENUTEXTS.Bonding..bt, MENUTEXTS.Gender..gender
    local texts = {h,s,c,a,sp,ac,b,g}
    local pos = {Config.StatMenu.optionpos[1],Config.StatMenu.optionpos[2],Config.StatMenu.optionpos[3],Config.StatMenu.optionpos[4],Config.StatMenu.optionpos[5],Config.StatMenu.optionpos[6],Config.StatMenu.optionpos[7],Config.StatMenu.optionpos[8]}
    for i,v in pairs(texts) do
        SetTextScale(0.35, 0.35)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        local str = CreateVarString(10, "LITERAL_STRING", texts[i], Citizen.ResultAsLong())
        SetTextCentre(1)
        DisplayText(str, Config.StatMenu.startpos[1], pos[i])
    end
    CreateMenu(lengthf, #texts)
end
 ----------------------------------------------------------------------------
function CreateMenu(lengthf, l2)
    for i = 1, l2, 1 do
        DrawSprite("generic_textures","hud_menu_4a", Config.StatMenu.startpos[1], Config.StatMenu.optionpos[i]+0.012, (Config.StatMenu.basesize+lengthf)*2.5, Config.StatMenu.basesize, 0.0, Config.StatMenu.bg[1], Config.StatMenu.bg[2], Config.StatMenu.bg[3], Config.StatMenu.bg[4], 0)
    end
end
------------------------------------HORSE DATA----------------------------------------
function GetHorseData(horse, gotdata)
    local hdata = {}
    hdata[1] = Citizen.InvokeNative(0xA4C8E23E29040DE0, horse, 0)--health
    hdata[2] = Citizen.InvokeNative(0xA4C8E23E29040DE0, horse, 1)--stamina
    hdata[3] = Citizen.InvokeNative(0xA4C8E23E29040DE0, horse, 3)--courage
    hdata[4] = Citizen.InvokeNative(0xA4C8E23E29040DE0, horse, 4)--agility
    hdata[5] = Citizen.InvokeNative(0xA4C8E23E29040DE0,horse, 5)--speed
    hdata[6] = Citizen.InvokeNative(0xA4C8E23E29040DE0, horse, 6)--acceleration
    hdata[7] = Citizen.InvokeNative(0x219DA04BAA9CB065, horse, 7)--bonding

    if gotdata then
        hdata[8] = gotdata.injured
        hdata[9] = CalculateOwnedPrice(gotdata.price,gotdata.xp)
        hdata[10] = gotdata.xp
        hdata[11] = gotdata.name
        hdata[13] = gotdata.sex
        local found = false
        for i,v in pairs(Config.Horses) do
            for c,k in pairs(v.Variants) do
                if found == false then
                    if gotdata.model == k[1] then
                        hdata[12] = ""..v.category.." ("..k[2]..")"
                        found = true
                    end
                end
            end
        end
    end
    for i,v in pairs(hdata) do
        if v == false then
            hdata[i] = MENUTEXTS.None
        end
    end
    return hdata
end
----------------------------------------------------------------------------
function CalculateOwnedPrice(price,xp)
    return ((price*0.6)+(xp*0.05))
end

function GetSpawnedHorse()
    return PlayerHorseId
end
----------------------------EVENTS----------------------------
RegisterNetEvent('ricx_horses:')
AddEventHandler('ricx_horses:', function()
   
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:startfeed')
AddEventHandler('ricx_horses:startfeed', function(itemname)
    FeedHorse(itemname)
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:startbrush')
AddEventHandler('ricx_horses:startbrush', function()
    BrushHorse()
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:sell:finishsell')
AddEventHandler('ricx_horses:sell:finishsell', function()
    if selling == true then
        selling = false
        DeletePed(PlayerHorseId)
        SetEntityAsNoLongerNeeded(PlayerHorseId)
    end
    PlayerHorseId = 0
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), false)
    PlayerHorseId = nil
    SelectedHorse = {}
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:sell:finishsell2')
AddEventHandler('ricx_horses:sell:finishsell2', function()
    TriggerServerEvent("ricx_horses:checkselected")
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:sell:gotpoints_c')
AddEventHandler('ricx_horses:sell:gotpoints_c', function(selldata)
    SellPointsC = selldata
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:sell:updatepoints')
AddEventHandler('ricx_horses:sell:updatepoints', function(selldata, id, pedid)
    local _id = tonumber(id)
    SellPointsC[_id] = selldata
    if pedid ~= nil then
        local _pedid = NetToPed(pedid)
        if DoesEntityExist(_pedid) then
            DeletePed(_pedid)
            SetEntityAsNoLongerNeeded(_pedid)
        end
    end
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:sell:updatepoints1')
AddEventHandler('ricx_horses:sell:updatepoints1', function(id)
    SellPointsC[tonumber(id)] = nil
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:deletehorse_c')
AddEventHandler('ricx_horses:deletehorse_c', function(pedid)
    local _pedid = NetToPed(pedid)
    if _pedid then 
        if DoesEntityExist(_pedid) then
            DeletePed(_pedid)
            SetEntityAsNoLongerNeeded(_pedid)
        end
    end
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:updatecomponent:opencomps')
AddEventHandler('ricx_horses:updatecomponent:opencomps', function(tableh)
    OpenComponentStore(tableh[1], tableh[4])
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:foundselected')
AddEventHandler('ricx_horses:foundselected', function(hdata)
    SelectedHorse = hdata
    while PlayerHorseId == nil do
        Citizen.Wait(1)
    end
    SelectedHorse.pedid = PlayerHorseId
end)
--------------------------------------------------------
RegisterNetEvent('ricx_horses:foundxp')
AddEventHandler('ricx_horses:foundxp', function(exp)
    HorseTrainerExp = tonumber(exp)
    for i,v in pairs(Config.TrainingLevels) do
        if exp >= v.xpreq[1] and exp <= v.xpreq[2] then
            if i > Config.DefaultTrainingLevel then 
                TrainingLevel = Config.DefaultTrainingLevel
                break
            else
                TrainingLevel = i
                break
            end
        end
    end
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:sendcomps:ownedhorse")
AddEventHandler("ricx_horses:sendcomps:ownedhorse", function(comp)
    currentHorseComps = comp
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:training:start")
AddEventHandler("ricx_horses:training:start", function()
    StartHorseTraining()
end)
--------------------------------------------------------
RegisterNetEvent("ricx_horses:heal:update")
AddEventHandler("ricx_horses:heal:update", function(value)
    SelectedHorse.injured = value
    if tempDelete ~= nil then
        --TriggerServerEvent("ricx_horses:deletehorse_server", PedToNet(tempDelete))
        DeleteEntity(tempDelete)
        SetEntityAsNoLongerNeeded(tempDelete)
        tempDelete = nil
    end
end)

--------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if tempHorse ~= nil then
        SetEntityVisible(tempHorse, false)
        DeletePed(tempHorse)
        SetEntityAsNoLongerNeeded(tempHorse)
        tempHorse = nil
    end
    if Camera ~= nil then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(Camera)
        Camera = nil
    end
    if MenuData then
        ClearPedTasks(PlayerPedId())
        MenuData.CloseAll()
    end
    if PlayerHorseId ~= nil then
        RemoveBlip(hblip)
        --TriggerServerEvent("ricx_horses:deletehorse_server", PedToNet(PlayerHorseId))
        DeleteEntity(PlayerHorseId)
        SetEntityAsNoLongerNeeded(PlayerHorseId)
    end
    if StableBlips then
        for i,v in pairs(StableBlips) do
            RemoveBlip(v)
        end
        StableBlips = {}
    end
    if TrainingBlips then
        for i,v in pairs(TrainingBlips) do
            RemoveBlip(v)
        end
        TrainingBlips = {}
    end
    if tempDelete ~= nil then
        DeletePed(tempDelete)
        tempDelete = nil
    end
    if training == true then
        ClearPedTasksImmediately(PlayerPedId())
    end
    if selling == true then
        ClearPedTasks(PlayerPedId())
    end
end)
----------------------------Basic Notification----------------------------
RegisterNetEvent('Notification:lefth')
AddEventHandler('Notification:lefth', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(5)
        end
    end
    if txtr ~= nil then
        exports.ricx_horses.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.ricx_horses.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)
------------------------------------------------------------------------------------
RegisterNetEvent('Notification:righth')
AddEventHandler('Notification:righth', function(text, dict, icon, text_color, duration)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if icon ~= nil then
        exports.ricx_horses.RightNot(0, text, dict, icon, text_color, duration)
    else
        local icon = "tick"
        exports.ricx_horses.RightNot(0, text, dict, icon, text_color, duration)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------