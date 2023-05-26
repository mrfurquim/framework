Config = {}
---------------------------------------------------------------------------------------------------------
Config.DrinkAnim = {"amb_creature_mammal@world_horse_drink_ground@base", "base"}
Config.DrinkAnim2 = {"amb_creature_mammal@prop_horse_drink_trough@idle0", "idle_a"}
Config.GrazeAnim = {"amb_creature_mammal@world_horse_grazing@idle", "idle_a"}
---------------------------------------------------------------------------------------------------------
Config.DrinkStaminaBoost = 5
Config.GrazeHealthBoost = 7.5
---------------------------------------------------------------------------------------------------------
Config.DrinkDuration = 5--seconds
Config.GrazeDuration = 7.5--seconds
---------------------------------------------------------------------------------------------------------
Config.InteractWithObjects = true --if false, horses cant interact with feed/drink objects while led by owner player
---------------------------------------------------------------------------------------------------------
Config.InteractObjects = {--2 option: drink or feed
    [1] = {`p_watertrough02x`, "drink"}, 
    [2] = {`p_watertrough01x`, "drink"}, 
    [3] = {`p_haypile01x`, "feed"},
}
---------------------------------------------------------------------------------------------------------
Config.TrainerBlip = {
    enabled = true,
    sprite = -1327110633,
    name = "Horse Training",
}
---------------------------------------------------------------------------------------------------------
Config.TrainingEnabled = true
Config.JobRequired = false
---------------------------------------------------------------------------------------------------------
Config.TrainingJobs = {--if Config.JobRequired is true
    "horsetrainer",
    "horsetrainer2",
}
---------------------------------------------------------------------------------------------------------
Config.TrainingAnim = {"script_story@wnt2@ig@cme_rideout","trot_player"}--Anim during Training -- OR: {"veh_lo_res_idle", "horse_rider_idle"}
Config.TrainingTimer = 30 --seconds
---------------------------------------------------------------------------------------------------------
Config.MaxTrainerXP = 1000
---------------------------------------------------------------------------------------------------------
Config.TrainingLevels = {
    [1] = {
        name = "Very Easy",
        xpreq = {800,1000},--mininum XP, maximum XP for level
        Params = {350, 1600, 700, 1200},
        MaxProgress = 8 -- players progress points needed to finish train
    },
    [2] = {
        name = "Easy",
        xpreq = {200,799},
        Params = {350, 1550, 500, 950},
        MaxProgress = 10
    },
    [3] = {
        name = "Medium",
        xpreq = {70,199},
        Params = {300, 1450, 400, 850},
        MaxProgress = 12
    },
    [4] = {
        name = "Difficult",
        xpreq = {30,69},
        Params = {300, 1350, 300, 800},
        MaxProgress = 15
    },
    [5] = {
        name = "Hard",
        xpreq = {10,29},
        Params = {250, 1200, 250, 800},
        MaxProgress = 18
    },
    [6] = {
        name = "Ultra Hard",
        xpreq = {0, 9},
        Params = {200, 1000, 200, 800},
        MaxProgress = 20
    },
}
---------------------------------------------------------------------------------------------------------
Config.DefaultTrainingLevel = 3 -- Medium -- if 3, players will have this level of difficulty or easier (depends on the trainer xp of player)
---------------------------------------------------------------------------------------------------------
Config.ExtraTricksXP = 5000 --dance with SPACE while standing, CTRL+SPACE rear up etc
Config.LayTrickXP = 3000 -- XP needs for playerhorse to lay down
---------------------------------------------------------------------------------------------------------
Config.AgressionDeleteLevel = 5 --Courage level requirement for agression delete - MAX LEVEL 9
---------------------------------------------------------------------------------------------------------
Config.TrainingButton = {
    pos = {0.9, 0.6},
    basesize = 0.03,
    bg = {0,0,0,255},
    text = "PRESS [SPACE] NOW",
    ProgressKey = `INPUT_JUMP`, -- Spacebar
}
---------------------------------------------------------------------------------------------------------
Config.TrainingProgress = {
    pos = {0.9, 0.65},
    basesize = {0.15, 0.03},
    bg = {0,0,0,255},
}
---------------------------------------------------------------------------------------------------------
Config.Checkpoints = {
    training = {128, 200, 0},
    stableshop = {128, 0, 0},
    sell = {255, 192, 0}
}
---------------------------------------------------------------------------------------------------------
Config.HorseTraining = {
    [1] = {x = -391.262, y = 778.792, z = 115.683},
    [2] = {x = 1204.054, y = -213.659, z = 100.315},
    [3] = {x = 981.297, y = -1832.338, z = 46.719},
    [4] = {x = 2976.694, y = 780.267, z = 50.973},
    [5] = {x = -1795.996, y = -573.618, z = 155.957},
    [6] = {x = -5541.011, y = -3037.537, z = -1.282},
}
---------------------------------------------------------------------------------------------------------
Config.HealPrice = 100
---------------------------------------------------------------------------------------------------------
Config.Prompts = {
    Stable = "Stable",
    HorseTraining = "Horse Training",
    StartTrain = {"Start", 0xCEFD9220}, -- E key
    Open = {"Open Shop", 0xCEFD9220}, -- E key
    Feed = {"Feed", 0xD8CF0C95},--C
    Sell = {"Sell", 0x43DBF61F},--ENTER
    Lay = {"Lay", 0xD8F73058},--U
    StopSell = {"Stop", 0xD8F73058},--U
    BuyHorse = {"Buy", 0x43DBF61F},--ENTER
    HorseDrink = {"Drink", 0xD8CF0C95},--C
    HorseGraze = {"Graze", 0xD8CF0C95},--C
    Camera = {"Change Camera", 0xD8CF0C95},--C
}
---------------------------------------------------------------------------------------------------------
Config.Blips = {
    name = "Stable",
    sprite = -643888085,
}
---------------------------------------------------------------------------------------------------------
Config.StatMenu = {
    startpos = {0.7,0.54},
    basesize = 0.03,
    bg = {0,0,0,255},
    optionpos = {0.1, 0.13, 0.16,  0.19,  0.22,  0.25, 0.28, 0.31, 0.34, 0.37, 0.40, 0.43, 0.46}
}
---------------------------------------------------------------------------------------------------------
Config.FeedItems = {
    Hay = {
        name = "Hay",
        itemname = "haycube",
        healthboost = 50,
        staminaboost = 50,
        goldboost = {enabled = false, hp = 0.0, stamina = 0.0},
        gold2boost = {enabled = false, hp = 0.0, stamina = 0.0},
    },
    Carrot = {
        name = "Carrot",
        itemname = "carrot",
        healthboost = 50,
        staminaboost = 50,
        goldboost = {enabled = true, hp = 100.0, stamina = 200.0},
        gold2boost = {enabled = true, hp = 100.0, stamina = 100.0},
    },
}
---------------------------------------------------------------------------------------------------------
Config.SpawnedHorseFlags = {
    --More Flags here https://github.com/femga/rdr3_discoveries/tree/master/AI/CPED_CONFIG_FLAGS
    {324, true},--
    {211, true},--PCF_GiveAmbientDefaultTaskIfMissionPed 
    {208, true},--
    {209, true},--
    {400, true},--
    {522, true},--PCF_DontFleeFromDroppedAnimals
    {297, true},--PCF_ForceInteractionLockonOnTargetPed
    {136, false},--(for horse) disable mount
    {312, true},--PCF_DisableHorseGunshotFleeResponse
    {113, false},--PCF_DisableShockingEvents
    {301, false},--PCF_DisableInteractionLockonOnTargetPed
    {277, true},--
    {319, true},--PCF_EnableAsVehicleTransitionDestination
    {6, true},--PCF_DontInfluenceWantedLevel
    {297, true},-- Enable_Horse_Leadin  
}
---------------------------------------------------------------------------------------------------------
Config.Texts = {
    Horse = "Horse",
    Camera = "Camera",
    HorseName = "Add name",
    ShopTitle = "Horse Shop",
    HorseManage = "Horse Manage",
    BuyHorseDollar = "Buy Horse $",
    ShopNoMoney = "You dont have enough money!",
    HorseBought = "You bought a horse!",
    RemoveComp = "You removed an equipment from your horse",
    CompBought = "Equipment Bought!",
    SoldHorse = "You sold a horse for $",
    SellAddPrice = "Add Price",
    HorseHealed = "Your horse is healed! -$",
    HealNoMoney = "You have no money for heal! $",
    MainHorse = "Main horse selected: ",
    HorseXP = "Horse XP +",
    SendHome = "Flee your horse first!",
    CallFarAway = "Your horse is far away",
    CallComing = "Your horse will be available in a moment!",
    CallInjured = "Your horse is injured!",
    CallNoSelected = "You dont have any horse selected!",
    CallNoRoads = "No road closeby! Try while around roads!",
    CantFlee = "You must stop leading the horse before doing that!",
    CompUpdated = "Equipment updated on horse!",
    CompNoMoney = "You have no money for the equipment!",
    TrainNotOwned = "You need to mount your own horse!",
    TrainNeedOwned = "You have to call your own horse first!",
    TrainFinished = "You finished the horse training!",
    TrainFailed = "You failed at the horse training",
    TrainProgress = "Training Progress: ",
    PlayerBuyHorse = "Buying Horse",
    PlayerBuyNoMoney = "You dont have enough money to buy this horse!",
    PlayerBoughtHorse = "You bought a horse!",
    PlayerBuyNoMoneyAtBuyer = "Buyer does not have enough money!",
    PlayerSoldHorse = "You sold a horse!",
    HorseFeed = "Horse Feed",
    NoFeedItem = "You dont have any food for horse!",
    HorseFed = "You fed your horse with",
    WaitFeed = "Wait before feeding!",
    HorseBrush = "Horse Brush",
    WaitBrush = "Wait before brush!",
    HorseFarAway = "Horse is far away!",
    HorseTraining = "Horse Training",
    TrainSecondsLeft = "seconds left",
    NoJob = "You dont have the required job!",
    WaitLoad = "Please wait, the menu is loading!",
    NoBags = "Horse does not have saddlebags equipped!",
    Gender = {
        "Male",
        "Female",
    },
    Menus = {
        AddName = "You must give some name!",
        GenderSelect = " | Gender ",
        StallionMare = "1 - Male | 2 - Female",
        Buy_ = "Buy ",
        ChooseGender = "Choose gender for horse!",
        GenderNumbers = "None, choose 1 or 2",
        OwnedHorses = "Owned Horses",
        OwnedHorsesDesc = "Select your Horse",
        BuyHorses = "Buy Horses",
        BuyHorsesDesc = "Buy New Horse",
        Options = "Options",
        SelectedHorseT = " | SELECTED",
        SelectedHorseDesc = "Select to manage",
        ManageSelect = "Select Horse",
        ManageSelectDesc = "Select for ride",
        ManageBuyComp = "Buy/Equip Equipment",
        ManageBuyCompDesc = "Saddles, Stirrups etc",
        ManageRemoveComp = "Remove Equipment",
        ManageRemoveCompDesc = "Remove components",
        ManageHeal = "Heal Horse $100",
        ManageHealDesc = "Take care of injuries",
        ManageSell = "Sell Horse ",
        ManageSellDesc = "Delete and get back money",
        RemoveComp = "Remove Component",
        CategorySelect = "Select Category",
        HorseEquipments = "Horse Equipments",
        Select_ = "Select ",
        SpaceDollar = " $",
        BuyEquipment = "Buy Equipment",
        OwnedComponent = " - OWNED",
        HorseCategorySelect = "Select Horse Category",
        HorseCategories = "Horse Categories",
        Yes = "Yes",
        None = "None",
        Health = "Health: ",
        Stamina = "Stamina: ",
        Courage = "Courage: ",
        Agility = "Agility: ",
        Speed = "Speed: ",
        Acceleration = "Acceleration: ",
        Bonding = "Bonding: ",
        Gender = "Gender: ",
        Experience = "Experience: ",
        Price = "Price: ",
        Name = "Name: ",
        Healthy = "Healthy",
        Injured = "Injured",
        Type = "Type: ",
    },
    Categories = {
        Saddle = "Saddle",
        Stirrup = "Stirrup",
        Bedrolls = "Bedrolls",
        Blankets = "Blankets",
        Horns = "Horns",
        Manes = "Manes",
        Saddlebags = "Saddlebags",
        Tails = "Tails",
        Shoes = "Shoes",
        Lantern = "Lantern",
        Holster = "Holster",
        Bridles = "Bridles",
        Masks = "Masks",
        Mustaches = "Mustaches",
        Specials = "Specials",
    },
    NoJob2 = "You dont have the required job!",
}
---------------------------------------------------------------------------------------------------------
Config.Images = {
    Manes = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_mane.png",
    Saddle = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_saddle.png",
    Stirrup = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_stirrup.png",
    Bedrolls = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_bedroll.png",
    Blankets = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_blanket.png",
    Horns = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_horn.png",
    Saddlebags = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_saddlebag.png",
    Tails = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/generic_horse_equip_tail.png",
    Shoes = "http://femga.com/images/samples/ui_textures_no_bg/ui_textures_mp/inventory_items_mp/generic_horse_mod.png",
    Lantern = "http://femga.com/images/samples/ui_textures_no_bg/ui_textures_mp/inventory_items_mp/generic_horse_equip_lantern.png",
    Holster = "http://femga.com/images/samples/ui_textures_no_bg/inventory_items/upgrade_offhand_holster.png",
    Bridles = "http://femga.com/images/samples/ui_textures_no_bg/ui_hud/hud_toasts/toast_horse_bond.png",
    Masks = "http://femga.com/images/samples/ui_textures_no_bg/ui_textures_mp/inventory_items_mp/generic_horse_equip_mask.png",
    Mustaches = "http://femga.com/images/samples/ui_textures_no_bg/shaving_menu/scissors.png",
}
---------------------------------------------------------------------------------------------------------
Config.Stables = {
    [1] = {
        name = "Valentine",
        pos = {x=-367.73, y=787.72, z=116.26},
        horsepos = {x=-372.43, y=791.79, z=116.13, h=182.3},
        campos = {
            [1] = {1.0, 2.0, 1.5, -20.0, 0.0, -40.0},
            [2] = {0.0, -2.0, 1.0, -20.0, 0.0, 180.0},
            [3] = {-2.0, 0.0, 1.3, -20.0, 0.0, 100.0},
            [4] = {0.0, 2.5, 0.5, 0.0, 0.0, 0.0},
        },
    },
    [2] = {
        name = "Blackwater",
        pos = {x=-873.167, y=-1366.040, z=43.531},
        horsepos = {x=-864.373, y=-1361.485, z=43.702, h=181.91},
        campos = {
            [1] = {-2.0, 0.0, 2.0, -30.0, 0.0, 90.0},
            [2] = {0.0, 2.7, 0.5, 0.0, 0.0, 0.0},
            [3] = {1.2, 0.4, 1.5, -40.0, 0.0, -120.0},
            [4] = {0.0, -1.7, 0.0, 0.0, 0.0, -180.0},
        },
    },
    [3] = {
        name = "Saint Denis",
        pos = {x=2503.153, y=-1442.725, z=46.312},
        horsepos = {x=2508.822, y=-1449.949, z=46.402, h=93.13},
        campos = {
            [1] = {-2.0, 0.5, 1.5, -40.0, 0.0, -20.0},
            [2] = {2.0, 0.0, 2.0, -40.0, 0.0, 180.0},
            [3] = {0.0, 2.5, 0.7, 0.0, 0.0, -90.0},
            [4] = {0.0, -1.7, 0.8, -30.0, 0.0, 90.0},
        },
    },
    [4] = {
        name = "Rhodes",
        pos = {x=1209.58, y=-191.01, z=101.39},
        horsepos = {x=1203.76, y=-193.06, z=101.49, h=288.82},
        campos = {
            [1] = {1.3, 0.0, 1.5, -40.0, 0.0, 0.0},
            [2] = {0.3, 2.5, 0.6, 0.0, 0.0, 90.0},
            [3] = {0.3, -2.0, 0.6, -30.0, 0.0, -70.0},
            [4] = {-1.0, 0.0, 1.2, -30.0, 0.0, 240.0},
        },
    },
    [5] = {
        name = "Annesburg",
        pos = {x=2967.24, y=797.27, z=51.4},
        horsepos = {x=2967.06, y=802.23, z=51.53, h=174.31},
        campos = {
            [1] = {2.0, 1.5, 1.5, -20.0, 0.0, -70.0},
            [2] = {-0.2, 2.7, 0.6, 0.0, 0.0, 0.0},
            [3] = {0.0, -2.0, 0.7, -30.0, 0.0, 180.0},
            [4] = {-2.0, 1.0, 1.5, -30.0, 0.0, 60.0},
        },
    },
    [6] = {
        name = "Colter",
        pos = {x=-1336.29, y=2398.25, z=307.06},
        horsepos = {x=-1340.93, y=2400.1, z=306.98, h=244.1},
        campos = {
            [1] = {0.0, 3.0, 0.5, 0.0, 0.0, 50.0},
            [2] = {2.0, 2.0, 0.8, 0.0, 0.0, 0.0},
            [3] = {0.0, -2.5, 0.6, -10.0, 0.0, -120.0},
            [4] = {-2.0, 1.5, 0.8, 0.0, 0.0, 500.0},
        },
    },
    [7] = {
        name = "Little Creek Farm",
        pos = {x=-2218.27, y=733.91, z=123.19},
        horsepos = {x=-2225.42, y=729.01, z=123.06, h=304.96},
        campos = {
            [1] = {2.0, -1.0, 1.0, 0.0, 0.0, 0.0},
            [2] = {0.0, 2.8, 0.7, -10.0, 0.0, 120.0},
            [3] = {0.0, -2.2, 0.8, -20.0, 0.0, -50.0},
            [4] = {-2.0, 0.0, 1.0, 0.0, 0.0, -120.0},
        },
    },
    [8] = { 
        name = "Tumbleweed",
        pos = {x=-5519.95, y=-3044.34, z=-2.29},
        horsepos = {x=-5519.26, y=-3051.24, z=-2.39, h=1.06}, 
        campos = {
            [1] = {-1.5, 0.0, 1.4, -30.0, 0.0, -80.0},
            [2] = {0.0, 2.7, 0.7, 0.0, 0.0, 180.0},
            [3] = {0.0, -2.5, 0.8, -20.0, 0.0, 0.0},
            [4] = {1.5, 0.5, 1.4, -30.0, 0.0, 100.0},
        },
    },
    [9] = { 
        name = "Strawberry",
        pos = {x=-1821.375, y=-561.061, z=156.06},
        horsepos = {x=-1819.905, y=-555.839, z=156.06, h=167.72}, 
        campos = {
            [1] = {1.5, 2.5, 1.5, -20.0, 0.0, -40.0},
            [2] = {-0.3, 2.5, 0.6, 0.0, 0.0, 0.0},
            [3] = {0.3, -2.0, 0.9, -30.0, 0.0, 180.0},
            [4] = {-1.0, 0.5, 1.5, -40.0, 0.0, 110.0},
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Horses = {
    [1] = {
        category = "American Paint",
        Variants = {
            -- hashid, label, price, skill level, job
            [1] = {`a_c_horse_americanpaint_greyovero`, "Grey Overo", 45, 0, "horsetrainer"},
            [2] = {`a_c_horse_americanpaint_overo`, "Overo", 45, 0},
            [3] = {`a_c_horse_americanpaint_splashedwhite`, "Splashed White", 45, 0},
            [4] = {`a_c_horse_americanpaint_tobiano`, "Splashed White", 45, 0},
        }
    },
    [2] = {
        category = "American Standardberd",
        Variants = {
            [1] = {`a_c_horse_americanstandardbred_silvertailbuckskin`, "Silvertail", 30, 0},
            [2] = {`a_c_horse_americanstandardbred_palominodapple`, "Palomino", 30, 0},
            [3] = {`a_c_horse_americanstandardbred_lightbuckskin`, "Light Buck", 30, 0},
            [4] = {`a_c_horse_americanstandardbred_buckskin`, "Buck", 30, 0},
            [5] = {`a_c_horse_americanstandardbred_black`, "Black", 30, 0},
        }
    },
    [3] = {
        category = "Andalusian",
        Variants = {
            [1] = {`a_c_horse_andalusian_rosegray`, "Rosegray", 60, 0},
            [2] = {`a_c_horse_andalusian_perlino`, "Perlino", 60, 0},
            [3] = {`a_c_horse_andalusian_darkbay`, "Darkbay", 60, 0},
        }
    },
    [4] = {
        category = "Appaloosa",
        Variants = {
            [1] = {`a_c_horse_appaloosa_blacksnowflake`, "Black", 47, 0},
            [2] = {`a_c_horse_appaloosa_blanket`, "Appaloosa", 47, 0},
            [3] = {`a_c_horse_appaloosa_brownleopard`, "Brown", 47, 0},
            [4] = {`a_c_horse_appaloosa_fewspotted_pc`, "Spotted", 80, 0},
            [5] = {`a_c_horse_appaloosa_leopard`, "Leopard", 80, 0},
            [6] = {`a_c_horse_appaloosa_leopardblanket`, "Leopard 2", 80, 0},
        }
    },
    [5] = {
        category = "Arabian",
        Variants = {
            [1] = {`a_c_horse_arabian_white`, "White", 80, 0},
            [2] = {`a_c_horse_arabian_warpedbrindle_pc`, "Brindle", 120, 0},
            [3] = {`a_c_horse_arabian_rosegreybay`, "Rosegray", 120, 0},
            [4] = {`a_c_horse_arabian_redchestnut_pc`, "Red Chestnut", 80, 0},
            [5] = {`a_c_horse_arabian_redchestnut`, "Red", 80, 0},
            [6] = {`a_c_horse_arabian_grey`, "Grey", 120, 0},
            [7] = {`a_c_horse_arabian_black`, "Black", 80, 0},
        }
    },
    [6] = {
        category = "Ardennes",
        Variants = {
            [1] = {`a_c_horse_ardennes_strawberryroan`, "Strawberry Roan", 50, 0},
            [2] = {`a_c_horse_ardennes_irongreyroan`, "Irongray", 50, 0},
            [3] = {`a_c_horse_ardennes_bayroan`, "Bay Roan", 50, 0},
        }
    },
    [7] = {
        category = "Belgian",
        Variants = {
            [1] = {`a_c_horse_belgian_mealychestnut`, "Mealy", 50, 0},
            [2] = {`a_c_horse_belgian_blondchestnut`, "Blonde", 50, 0},
        }
    },
    [8] = {
        category = "Breton",
        Variants = {
            [1] = {`a_c_horse_breton_steelgrey`, "Steelgray", 100, 0},
            [2] = {`a_c_horse_breton_sorrel`, "Sorrel", 70, 0},
            [3] = {`a_c_horse_breton_sealbrown`, "Sealbrown", 85, 0},
            [4] = {`a_c_horse_breton_redroan`, "Redroan", 70, 0},
            [5] = {`a_c_horse_breton_mealydapplebay`, "Dapplebay", 85, 0},
            [6] = {`a_c_horse_breton_grullodun`, "Grullodun", 70, 0},
        }
    },
    [9] = {
        category = "Criollo",
        Variants = {
            [1] = {`a_c_horse_criollo_sorrelovero`, "Sorrel", 180, 0},
            [2] = {`a_c_horse_criollo_marblesabino`, "Marble", 180, 0},
            [3] = {`a_c_horse_criollo_dun`, "Dun", 180, 0},
            [4] = {`a_c_horse_criollo_blueroanovero`, "Blue", 180, 0},
            [5] = {`a_c_horse_criollo_bayframeovero`, "Bay", 180, 0},
            [6] = {`a_c_horse_criollo_baybrindle`, "Bay Brindle", 180, 0},
        }
    },
    [10] = {
        category = "Dutch Warmblood",
        Variants = {
            [1] = {`a_c_horse_dutchwarmblood_chocolateroan`, "Chocolate", 60, 0},
            [2] = {`a_c_horse_dutchwarmblood_sealbrown`, "Seal brown", 60, 0},
            [3] = {`a_c_horse_dutchwarmblood_sootybuckskin`, "Sooty Buck", 60, 0},
        }
    },
    [11] = {
        category = "Gypsy Cob",
        Variants = {
            [1] = {`a_c_horse_gypsycob_palominoblagdon`, "Palomino", 150, 0},
            [2] = {`a_c_horse_gypsycob_piebald`, "Piebald", 150, 0},
            [3] = {`a_c_horse_gypsycob_skewbald`, "Skewbald", 150, 0},
            [4] = {`a_c_horse_gypsycob_splashedbay`, "Splashed Bay", 150, 0},
            [5] = {`a_c_horse_gypsycob_splashedpiebald`, "Splashed Pie", 150, 0},
            [6] = {`a_c_horse_gypsycob_whiteblagdon`, "White", 150, 0},
        }
    },
    [12] = {
        category = "Hungarian Halfbred",
        Variants = {
            [1] = {`a_c_horse_hungarianhalfbred_piebaldtobiano`, "Piebald", 200, 0},    
            [2] = {`a_c_horse_hungarianhalfbred_liverchestnut`, "Brown", 200, 0}, 
            [3] = {`a_c_horse_hungarianhalfbred_flaxenchestnut`, "Flaxen", 200, 0}, 
            [4] = {`a_c_horse_hungarianhalfbred_darkdapplegrey`, "Dark grey", 200, 0},
        }
    },
    [13] = {
        category = "Kentucky Saddle",
        Variants = {
            [1] = {`a_c_Horse_KentuckySaddle_Grey`, "Grey", 20, 0},
            [2] = {`a_c_Horse_KentuckySaddle_Black`, "Black", 20, 0},
            [3] = {`a_c_Horse_KentuckySaddle_Buttermilkbuckskin_pc`, "Buttermilk", 20, 0},
            [4] = {`a_c_Horse_KentuckySaddle_Chestnutpinto`, "Chestnut", 20, 0},
            [5] = {`a_c_Horse_KentuckySaddle_Silverbay`, "Silverbay", 20, 0},
        }
    },
    [14] = {
        category = "Kladruber",
        Variants = {
            [1] = {`a_c_horse_kladruber_white`, "White", 120, 0},
            [2] = {`a_c_horse_kladruber_silver`, "Silver", 180, 0},
            [3] = {`a_c_horse_kladruber_grey`, "Grey", 120, 0},
            [4] = {`a_c_horse_kladruber_dapplerosegrey`, "Dark", 180, 0},
            [5] = {`a_c_horse_kladruber_cremello`, "Cremello", 120, 0},
            [6] = {`a_c_horse_kladruber_black`, "Black", 180, 0},
        }
    },
    [15] = {
        category = "Missouri Fox Trotter",
        Variants = {
            [1] = {`a_c_horse_missourifoxtrotter_silverdapplepinto`, "Silver", 140, 0},
            [2] = {`a_c_horse_missourifoxtrotter_sablechampagne`, "Sable", 140, 0},
            [3] = {`a_c_horse_missourifoxtrotter_amberchampagne`, "Amber", 140, 0},
            [4] = {`a_c_horse_missourifoxtrotter_dapplegrey`, "Dapple Gray", 200, 0},
            [5] = {`a_c_horse_missourifoxtrotter_blacktovero`, "Black Tovero", 200, 0},
            [6] = {`a_c_horse_missourifoxtrotter_blueroan`, "Blue Roan", 200, 0},
            [7] = {`a_c_horse_missourifoxtrotter_buckskinbrindle`, "Buck skin", 200, 0},
        }
    },
    [16] = {
        category = "Morgan",
        Variants = {
            [1] = {`a_c_Horse_Morgan_Palomino`, "Palomino", 21, 0},
            [2] = {`a_c_Horse_Morgan_Bay`, "Bay", 21, 0},
            [3] = {`a_c_Horse_Morgan_Bayroan`, "Bayroan", 21, 0},
            [4] = {`a_c_Horse_Morgan_flaxenchestnut`, "Brown", 21, 0},
            [5] = {`a_c_Horse_Morgan_liverchestnut_pc`, "Dark", 21, 0},
        }
    },
    [17] = {
        category = "Mustang",
        Variants = {
            [1] = {`a_c_horse_mustang_wildbay`, "Wildbay", 100, 0},
            [2] = {`a_c_horse_mustang_tigerstripedbay`, "Tiger striped", 160, 0},
            [3] = {`a_c_horse_mustang_grullodun`, "Grullodun", 160, 0},
            [4] = {`a_c_horse_mustang_goldendun`, "Gold", 160, 0},
            [5] = {`a_c_horse_mustang_buckskin`, "Buckskin", 200, 0},
            [6] = {`a_c_horse_mustang_chestnuttovero`, "Chestnut", 200, 0},
            [7] = {`a_c_horse_mustang_reddunovero`, "Red Dun", 200, 0},
            [8] = {`a_c_horse_mustang_blackovero`, "Black Overo", 200, 0},
        }
    },
    [18] = {
        category = "Nokota",
        Variants = {
            [1] = {`a_c_horse_nokota_whiteroan`, "White", 280, 0},
            [2] = {`a_c_horse_nokota_reversedappleroan`, "Colored", 240, 0},
            [3] = {`a_c_horse_nokota_blueroan`, "Blueroan", 180, 0}, 
        }
    },
    [19] = {
        category = "Norfolk Roadster",
        Variants = {
            [1] = {`a_c_horse_norfolkroadster_black`, "Black", 140, 0},
            [2] = {`a_c_horse_norfolkroadster_dappledbuckskin`, "Buck", 140, 0},
            [3] = {`a_c_horse_norfolkroadster_piebaldroan`, "Piebald", 200, 0},
            [4] = {`a_c_horse_norfolkroadster_rosegrey`, "Rosegrey", 200, 0},
            [5] = {`a_c_horse_norfolkroadster_speckledgrey`, "Speckled Grey", 200, 0},
            [6] = {`a_c_horse_norfolkroadster_spottedtricolor`, "Spotted", 200, 0},
        }
    },
    [20] = {
        category = "Other Horses",
        Variants = {
            [1] = {`a_c_HORSEMULE_01`, "Mule", 5, 0},
            [2] = {`a_c_horse_murfreebrood_mange_01`, "Murfree breed 1", 75, 0},
            [3] = {`a_c_horse_murfreebrood_mange_02`, "Murfree breed 2", 75, 0},
            [4] = {`a_c_horse_murfreebrood_mange_03`, "Murfree breed 3", 75, 0},
            [5] = {`a_c_Horse_MP_Mangy_Backup`, "Mangy Backup", 10, 0},
        }
    },
    [21] = {
        category = "Shire",
        Variants = {
            [1] = {`a_c_horse_shire_ravenblack`, "Raven black", 50, 0},
            [2] = {`a_c_horse_shire_lightgrey`, "Light gray", 50, 0},
            [3] = {`a_c_horse_shire_darkbay`, "Dark bay", 50, 0},
        }
    },
    [22] = {
        category = "Special Horses",
        Variants = {
            [1] = {`a_c_horse_eagleflies`, "Eagle Flies' horse", 1000, 0},
            [2] = {`a_c_horse_gang_bill`, "Bill's horse", 1000, 0},
            [3] = {`a_c_horse_gang_charles`, "Charles' horse", 1000, 0},
            [4] = {`a_c_horse_gang_dutch`, "Dutch's horse", 1000, 0},
            [5] = {`a_c_horse_gang_javier`, "Hosea's horse", 1000, 0},
            [6] = {`a_c_horse_gang_john`, "John's horse", 1000, 0},
            [7] = {`a_c_horse_gang_karen`, "Karen's horse", 1000, 0},
            [8] = {`a_c_horse_gang_kieran`, "Kieran's horse", 1000, 0},
            [9] = {`a_c_horse_gang_lenny`, "Lenny's horse", 1000, 0},
            [10] = {`a_c_horse_gang_micah`, "Micah's horse", 1000, 0},
            [11] = {`a_c_horse_gang_sadie`, "Sadie's horse", 1000, 0},
            [12] = {`a_c_horse_gang_sadie_endlesssummer`, "Sadie's horse 2", 1000, 0},
            [13] = {`a_c_horse_gang_sean`, "Sean's horse", 1000, 0},
            [14] = {`a_c_horse_gang_trelawney`, "Trelawney's horse", 1000, 0},
            [15] = {`a_c_horse_gang_uncle`, "Uncle's horse", 1000, 0},
            [16] = {`a_c_horse_gang_uncle_endlesssummer`, "Uncle's horse 2", 1000, 0},
            [17] = {`a_c_horse_buell_warvets`, "Buell", 1000, 0},
            [18] = {`a_c_donkey_01`, "Donkey", 1000, 0},
            [19] = {`a_c_horsemulepainted_01`, "Tiger striped Mule", 1000, 0},
            [20] = {`MP_HORSE_OWLHOOTVICTIM_01`, "Other Horse 1", 1000, 0},
            [21] = {`MP_A_C_HORSECORPSE_01`, "Other Horse 2", 1000, 0},
            [22] = {`a_c_horse_winter02_01`, "Other Horse", 1000, 0},
            [23] = {`a_c_horse_gang_charles_endlesssummer`, "Charles Horse 2", 1000, 0},
            [24] = {`a_c_horse_john_endlesssummer`, "John Horse 2", 1000, 0},
            [25] = {`a_c_horse_gang_javier`, "Javier's Horse", 1000, 0},    
            [26] = {`mp_horse_owlhootvictim_01`, "Owlhoot Horse", 1000, 0},    
        }
    },
    [23] = {
        category = "Suffolk Punch",
        Variants = {
            [1] = {`a_c_horse_suffolkpunch_sorrel`, "Sorrel", 50, 0},
		    [2] = {`a_c_horse_suffolkpunch_redchestnut`, "Red Chestnut", 50, 0},
        }
    },
    [24] = {
        category = "Tenessee Walker",
        Variants = {
            [1] = {`a_c_horse_tennesseewalker_redroan`, "Redroan", 70, 0},
            [2] = {`a_c_horse_tennesseewalker_mahoganybay`, "Mahoganbay", 85, 0},
            [3] = {`a_c_horse_tennesseewalker_goldpalomino_pc`, "Gold", 70, 0},
            [4] = {`a_c_horse_tennesseewalker_flaxenroan`, "Flaxen", 85, 0},
            [5] = {`a_c_horse_tennesseewalker_dapplebay`, "Dapplebay", 85, 0},
            [6] = {`a_c_horse_tennesseewalker_chestnut`, "Chestnut", 50, 0},
            [7] = {`a_c_horse_tennesseewalker_blackrabicano`, "Black", 50, 0},
        }
    },
    [25] = {
        category = "Thoroughbred",
        Variants = {
            [1] = {`a_c_Horse_Thoroughbred_DappleGrey`, "Dapple Gray", 70, 0},
            [2] = {`a_c_Horse_Thoroughbred_blackchestnut`, "Black", 70, 0},
            [3] = {`a_c_Horse_Thoroughbred_bloodbay`, "Bloodbay", 70, 0},
            [4] = {`a_c_Horse_Thoroughbred_brindle`, "Brindle", 100, 0},
            [5] = {`a_c_Horse_Thoroughbred_reversedappleblack`, "Dark", 100, 0},
        }
    },
    [26] = {
        category = "Turkoman",
        Variants = {
            [1] = {`a_c_Horse_Turkoman_Gold`, "Gold", 280, 0},
            [2] = {`a_c_Horse_Turkoman_Silver`, "Silver", 280, 0},
            [3] = {`a_c_Horse_Turkoman_Darkbay`, "Darkbay", 280, 0},
            [4] = {`a_c_horse_turkoman_black`, "Black", 280, 0},
            [5] = {`a_c_horse_turkoman_chestnut`, "Brown", 280, 0},
            [6] = {`a_c_horse_turkoman_grey`, "Grey", 280, 0},
            [7] = {`a_c_horse_turkoman_perlino`, "Perlino", 280, 0},
        }
    },
}
---------------------------------------------------------------------------------------------------------
Config.Saddle = {
    [1] = {
        name = "Special Saddles",
        Variants = {
            {"Special 1", 100, 0x003897CA },
            {"Special 2", 100, 0x0205E696 },
            {"Special 3", 100, 0x19FFCB58 },
            {"Special 4", 100, 0x219DE87C },
            {"Special 5", 100, 0x34CC8CDF },
            {"Special 6", 100, 0x3A758C4B },
            {"Special 7", 100, 0x43FC9BB6 },
            {"Special 8", 100, 0x445FEF15 },
            {"Special 9", 100, 0x454BA1F7 },
            {"Special 10", 100, 0x51314715 },
            {"Special 11", 100, 0x53739DBF },
            {"Special 12", 100, 0x56DA4514 },
            {"Special 13", 100, 0x5EC8FD2D },
            {"Special 14", 100, 0x622583DE },
            {"Special 15", 100, 0x6380DE5D },
            {"Special 16", 100, 0x6E3AF3D1 },
            {"Special 17", 100, 0x73957E8A },
            {"Special 18", 100, 0x77A4AEDC },
            {"Special 19", 100, 0x791482E6 },
            {"Special 20", 100, 0x7ECB7A3F },
            {"Special 21", 100, 0x7FF31745 },
            {"Special 22", 100, 0x80BB92BC },
            {"Special 23", 100, 0x846B4869 },
            {"Special 24", 100, 0x8EF048CA },
            {"Special 25", 100, 0x9054977C },
            {"Special 26", 100, 0x95E9C95B },
            {"Special 27", 100, 0x98C71B0F },
            {"Special 28", 100, 0x9C2977E5 },
            {"Special 29", 100, 0x9E163303 },
            {"Special 30", 100, 0xA4D2725F },
            {"Special 31", 100, 0xA78E9B7F },
            {"Special 32", 100, 0xAB909F14 },
            {"Special 33", 100, 0xAD4A6355 },
            {"Special 34", 100, 0xAF96C329 },
            {"Special 35", 100, 0xB03CD750 },
            {"Special 36", 100, 0xC1A0FA18 },
            {"Special 37", 100, 0xC4E32120 },
            {"Special 38", 100, 0xCA9F6038 },
            {"Special 39", 100, 0xCD4CFC95 },
            {"Special 40", 100, 0xE1430217 },
            {"Special 41", 100, 0xEF0CDA78 },
            {"Special 42", 100, 0xFDB0F237 },
            {"Big Valley Doublefork", 100, 0x8FFCF06B },
            {"Random ", 100, 0xAD4A6355 },
            {"High Plains Cutting", 100, 0xBFD09512, },
        },
    },
    [2] = {
        name = "Charro Saddles",
        Variants = {
            { "Improved", 100, 0x5546EB7A, },
            { "Improved 1", 100, 0x8E64DDB5, },
            { "Improved 2", 100, 0x7092A211, },
            { "Improved 3", 100, 0xC0C04297, },
            { "Improved 4", 100, 0xBE703DF7, },
            { "Improved 5", 100, 0xE5510BB8, },
            { "Special", 200, 0x7D795D72, },
            { "New Stock 0", 60, 0x0522CCED, },
            { "New Stock 1", 60, 0x5B45F932, },
            { "New Stock 2", 60, 0x219D85E2, },
            { "New Stock 3", 60, 0x7DBB3E1C, },
            { "New Stock 4", 60, 0x4C1A5ADB, },
            { "New Stock 5", 60, 0xF1BAA60D, },
            { "Used Stock 0", 20, 0xE6488B58, },
            { "Used Stock 1", 20, 0xD2FA64BC, },
            { "Used Stock 2", 20, 0x189F7005, },
            { "Used Stock 3", 20, 0xF7682D97, },
            { "Used Stock 4", 20, 0x1D0BF8F2, },
            { "Used Stock 5", 20, 0x0A39D34E, },
        },
    },
    [3] = {
        name = "McClellan",
        Variants = {
            { "Improved 0", 100, 0x17153A45, },
            { "Improved 1", 100, 0x05D717C9, },
            { "Improved 2", 100, 0x4B372288, },
            { "Improved 3", 100, 0x78F07DFA, },
            { "Improved 4", 100, 0x2E4668A3, },
            { "Improved 5", 100, 0x1C14443F, },
            { "Special", 100, 0x353FC03C, },
            { "New Stock 0", 100, 0xD97573C1, },
            { "New Stock 1", 100, 0xF3BEA853, },
            { "New Stock 2", 100, 0x01F7C4C5, },
            { "New Stock 3", 100, 0x106961A8, },
            { "New Stock 4", 100, 0x2ECD9E70, },
            { "New Stock 5", 100, 0x3D0C3AED, },
            { "Used Stock 0", 100, 0xF94D5623, },
            { "Used Stock 1", 100, 0x3F9F62CE, },
            { "Used Stock 2", 100, 0x150D0DAA, },
            { "Used Stock 3", 100, 0xEB1139AB, },
            { "Used Stock 4", 100, 0xC04FE429, },
            { "Used Stock 5", 100, 0x0DE47F51, },
        },
    },
    [4] = {
        name = "Mother Hubbard",
        Variants = {
            { "Improved 0", 100, 0x5BBC54C3, },
            { "Improved 1", 100, 0x8D163776, },
            { "Improved 2", 100, 0x3E949A74, },
            { "Improved 3", 100, 0x70BB7EC1, },
            { "Improved 4", 100, 0xD11CBF82, },
            { "Improved 5", 100, 0xBA6A921E, },
            { "Special", 100, 0xD225CCA0, },
            { "New Stock 0", 100, 0x6D403492, },
            { "New Stock 1", 100, 0xBB335077, },
            { "New Stock 2", 100, 0x8D9D754C, },
            { "New Stock 3", 100, 0x5B6390D9, },
            { "New Stock 4", 100, 0x14168240, },
            { "New Stock 5", 100, 0x7FD859C2, },
            { "Used Stock 0", 100, 0x87F421F7, },
            { "Used Stock 1", 100, 0xC1AF1568, },
            { "Used Stock 2", 100, 0xF36A78DE, },
            { "Used Stock 3", 100, 0x9CD94BC1, },
            { "Used Stock 4", 100, 0xCE8C2F22, },
            { "Used Stock 5", 100, 0x2844E292, },
        },
    },
    [5] = {
        name = "Western 1",
        Variants = {
            { "Improved 0", 100, 0xC10B5450,},
            { "Improved 1", 100, 0xD2C8F7CB,},
            { "Improved 2", 100, 0xE5B31D9F,},
            { "Improved 3", 100, 0xF373B920,},
            { "Improved 4", 100, 0x7A23C686, },
            { "Improved 5", 100, 0x88C363C5,},
            { "Special", 100, 0xB5802A5F,},
            { "New Stock 0", 100, 0x7C2C580C,  },
            { "New Stock 1", 100, 0x6FEABF89,  },
            { "New Stock 2", 100, 0xA21923E5,},
            { "New Stock 3", 100, 0x93DA8768,},
            { "New Stock 4", 100, 0xA8DB3175,},
            { "New Stock 5", 100, 0x9B1C95F8,},
            { "Used Stock 0", 100, 0x7C19770A,  },
            { "Used Stock 1", 100, 0xA1154105,},
            { "Used Stock 2", 100, 0xB357E58A,},
            { "Used Stock 3", 100, 0x8DD09A7C,},
            { "Used Stock 4", 100, 0x9FF23EBF,},
            { "Used Stock 5", 100, 0xFC6AF7AF,},
        },
    },
    [6] = {
        name = "Western 2",
        Variants = {
            { "Improved 0", 100, 0xB9BE555D,},
            { "Improved 1", 100, 0x01EC65C0,  },
            { "Improved 2", 100, 0x0F2F0045,  },
            { "Improved 3", 100, 0xE52BAC3F,},
            { "Improved 4", 100, 0xF4B14B4A,},
            { "Improved 5", 100, 0x3827D232,  },
            { "Special", 100, 0xDE5A2905,},
            { "New Stock 0", 100, 0xEC882931,},
            { "New Stock 1", 100, 0xDA36048D,},
            { "New Stock 2", 100, 0xC7FC601A,},
            { "New Stock 3", 100, 0xB7B33F88,},
            { "New Stock 4", 100, 0xA7AC9F7B,},
            { "New Stock 5", 100, 0x9533FA8E,},
            { "Used Stock 0", 100, 0xE039FC0F,},
            { "Used Stock 1", 100, 0xF687A8AA,},
            { "Used Stock 2", 100, 0x47D2CB3F,  },
            { "Used Stock 3", 100, 0x15FB6791,  },
            { "Used Stock 4", 100, 0xE36C8274,},
            { "Used Stock 5", 100, 0x40C53D24,  },
        },
    },
    [7] = {
        name = "Western 3",
        Variants = {
            { "Improved 0", 100, 0x64CEC6DF,  },
            { "Improved 1", 100, 0x9E0C3959,},
            { "Improved 2", 100, 0x90489DD2,},
            { "Improved 3", 100, 0xBC52F5E6,},
            { "Improved 4", 100, 0xD61B2996,},
            { "Improved 5", 100, 0xC7D58D0B,},
            { "Special", 100, 0x2BEA8ED4,  },
            { "New Stock 0", 100, 0x8DABACD7,},
            { "New Stock 1", 100, 0x6384D886,  },
            { "New Stock 2", 100, 0x694DE418,  },
            { "New Stock 3", 100, 0x60DE5335,  },
            { "New Stock 4", 100, 0x76887E89,  },
            { "New Stock 5", 100, 0x2E216DBC,  },
            { "Used Stock 0", 100, 0x5A9E4F6C,  },
            { "Used Stock 1", 100, 0x2F8C7941,  },
            { "Used Stock 2", 100, 0xFD4E14C5,},
            { "Used Stock 3", 100, 0xB61F0668,},
            { "Used Stock 4", 100, 0x21E8DDFA,  },
            { "Used Stock 5", 100, 0xDA84CF33,},
        },
    },
    [8] = {
        name = "Western 4",
        Variants = {
            { "Improved 0", 100, 0xC454830C,},
            { "Improved 1", 100, 0xD6BF27E1,},
            { "Improved 2", 100, 0x24F24446,  },
            { "Improved 3", 100, 0x0F4118E4,  },
            { "Improved 4", 100, 0x0306806F,  },
            { "Improved 5", 100, 0x70C65BED,  },
            { "Special", 100, 0xC76C46D9,},
            { "New Stock 0", 100, 0x2E3F3A62,  },
            { "New Stock 1", 100, 0x660B29F9,  },
            { "New Stock 2", 100, 0x335DC49F,  },
            { "New Stock 3", 100, 0xFCE1D7A4,},
            { "New Stock 4", 100, 0x093B7057,  },
            { "New Stock 5", 100, 0x20359E53,  },
            { "Used Stock 0", 100, 0x534A7D59,  },
            { "Used Stock 1", 100, 0xD7FC86BF,},
            { "Used Stock 2", 100, 0xE9B7AA35,},
            { "Used Stock 3", 100, 0x6C622F8C,  },
            { "Used Stock 4", 100, 0x8E22730C,},
            { "Used Stock 5", 100, 0x1EE21489,  },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Stirrup = {
    [1] = {
        name = "Stirrup Variant A",
        Variants = {
            {"Stirrup A 1", 50, 0x00B565B8,},
            {"Stirrup A 2", 50, 0x29E063EB,},
            {"Stirrup A 3", 50, 0x3C4AFBDD,},
            {"Stirrup A 4", 50, 0x40E71A1B,},
            {"Stirrup A 5", 50, 0x43DFDE38,},
            {"Stirrup A 6", 50, 0x4F031B50,},
            {"Stirrup A 7", 50, 0x54461E47,},
            {"Stirrup A 8", 50, 0x54A5B6E9,},
            {"Stirrup A 9", 50, 0x633EC1F4,},
            {"Stirrup A 10", 50, 0x81CEFBFC,},
            {"Stirrup A 11", 50, 0x86568D25,},
            {"Stirrup A 12", 50, 0xD22757E2,},
            {"Stirrup A 13", 50, 0xE73FF221,},
        },
    },
    [2] = {
        name = "Stirrup Variant B",
        Variants = {
            {"Stirrup B 1", 50, 0x317A705D,},
            {"Stirrup B 2", 50, 0x3685C57A,},
            {"Stirrup B 3", 50, 0x371CBE0B,},
            {"Stirrup B 4", 50, 0x5EBFDFAB,},
            {"Stirrup B 5", 50, 0x78CD59E6,},
            {"Stirrup B 6", 50, 0xBDC364E1,},
            {"Stirrup B 7", 50, 0xC481A076,},
            {"Stirrup B 8", 50, 0xCC1096B0,},
            {"Stirrup B 9", 50, 0xDB236FBB,},
            {"Stirrup B 10", 50, 0xE600E0BE,},
            {"Stirrup B 11", 50, 0xEDF82EF6,},
            {"Stirrup B 12", 50, 0xFD31EA31,},
            {"Stirrup B 13", 50, 0x8246282F,},
        },
    },
    [3] = {
        name = "Stirrup Variant C",
        Variants = {
            {"Stirrup C 1", 50, 0x0BD4C573,},
            {"Stirrup C 2", 50, 0x48D64E92,},
            {"Stirrup C 3", 50, 0x843A3A5B,},
            {"Stirrup C 4", 50, 0x8A641D93,},
            {"Stirrup C 5", 50, 0x99EE35DA,},
            {"Stirrup C 6", 50, 0x9B4862F5,},
            {"Stirrup C 7", 50, 0x9C73677E,},
            {"Stirrup C 8", 50, 0x9E7F8E3B,},
            {"Stirrup C 9", 50, 0x9F98E768,},
            {"Stirrup C 10", 50, 0xA023523A,},
            {"Stirrup C 11", 50, 0xA0DD0F3E,},
            {"Stirrup C 12", 50, 0xBDDDEAF4,},
            {"Stirrup C 13", 50, 0xE1CDA19B,},
            {"Stirrup C 14", 50, 0x75178DD2,},
        },
    },
    [4] = {
        name = "Stirrup Variant D",
        Variants = {
            {"Stirrup D 1", 50, 0x260E6A14,},
            {"Stirrup D 2", 50, 0x3B472220,},
            {"Stirrup D 3", 50, 0x979F2EC0,},
            {"Stirrup D 4", 50, 0xBC3DF1CE,},
            {"Stirrup D 5", 50, 0xD7ABBCB5,},
            {"Stirrup D 6", 50, 0xE1392DA2,},
            {"Stirrup D 7", 50, 0xCB9A3AD6,},
        },
    },
    [5] = {
        name = "Stirrup Specials",
        Variants = {
            {"Specials 1", 50, 0x587DD49F,},
            {"Specials 2", 50, 0x67AF7302,}, 
            {"Specials 3", 50, 0x9EE8E174,},
            {"Specials 4", 50, 0xBDF19F85,},
            {"Specials 5", 50, 0x03B3AB08,},
            {"Specials 6", 50, 0xD8AE54FE,},
            {"Specials 7", 50, 0x8D0BC7DA,},
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Bedrolls = {
    [1] = {
        name = "Simple New",
        Variants =  {
            {"Black", 50, 0x9FD99D7D, },
            {"Gray", 50, 0x8C9F7709, },
            {"Light Brown", 50, 0x7B55D476, },
            {"Dark", 50, 0xD8258E14, },
            {"Brown", 50, 0x0AC1F34C, },
        },
    },
    [2] = {
        name = "Simple Used",
        Variants =  {
            {"Black", 20, 0x18BB6B30, },
            {"Gray", 20, 0x12F0DF9F, },
            {"Dark Brown", 20, 0x1B43F045, },
            {"Brown", 20, 0x55A0E4FE, },
            {"Light Brown", 20, 0xFFB0391E, },
        },
    },
    [3] = {
        name = "Adventurer New",
        Variants =  {
            {"Brown", 70, 0x084E5AFA, },
            {"Gray", 70, 0x9D868568, },
            {"Blue", 70, 0x72FCB059, },
            {"Gray 2", 70, 0x69B29DC5, },
            {"Dark Brown", 70, 0xD258EF10, },
        },
    },
    [4] = {
        name = "Adventurer Used",
        Variants =  {
 
            {"Brown", 20, 0x98214B1C, },
            {"Gray", 20, 0x45FEA6D8, },
            {"Brown 2", 20, 0xA643680C, },
            {"Dark", 20, 0x7C8A149A, },
            {"Colored", 20, 0x8DD7B735, },
        },
    },
    [5] = {
        name = "Horse Trainer New",
        Variants =  {
            {"Light", 100, 0xA1FD8B43, },
            {"Brown", 100, 0xB4532FEE, },
            {"Dark", 100, 0xBC664014, },
            {"Dark 2", 100, 0xD020E789, },
            {"Light 2", 100, 0x69B21ADD, },
        },
    },
    [6] = {
        name = "Horse Trainer Used",
        Variants =  {
            {"Light", 70, 0x4B7E0712, },
            {"Brown", 70, 0x36BEDD90, },
            {"Dark Brown", 70, 0x27543EBB, },
            {"Dark", 70, 0x841C784A, },
            {"Yellow", 70, 0x73D157B4, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Blankets = {
     [1] = {
         name = "Blanket 1",
         Variants = {
            {"Variant A", 50, 0x508B80B9, },
            {"Variant B", 50, 0x67CAAF37, },
            {"Variant C", 50, 0xEBB4B70D, },
            {"Variant D", 50, 0xFA1153C6, },
            {"Variant E", 50, 0x0F537E4A, },
         },
     },
     [2] = {
        name = "Blanket 2",
        Variants = {
            {"Variant A", 60, 0x97EBE669, },
            {"Variant B", 60, 0x269583CA, },
            {"Variant C", 60, 0x3973A986, },
            {"Variant D", 60, 0x4A294AF1, },
            {"Variant E", 60, 0xED0190A3, },
        },
    },
    [3] = {
        name = "Blanket 3",
        Variants = {
            {"Variant A", 65, 0xBBF05395, },
            {"Variant B", 65, 0x823A602A, },
            {"Variant C", 65, 0x533A022A,  },
            {"Variant D", 65, 0xB0F7BDA4, },
            {"Variant E", 65, 0xFDC3D6D3, },
        },
    },
    [4] = {
        name = "Blanket 4",
        Variants = {
            {"Variant A", 50, 0x6B2084E5, },
            {"Variant B", 50, 0x78FB209A, },
            {"Variant C", 50, 0x8FAD4DFE, },
            {"Variant D", 50, 0x9DE0EA65, },
            {"Variant E", 50, 0x342916F3, },
        },
    },
    [5] = {
        name = "Blanket 5",
        Variants = {
            {"Variant A", 50, 0xAD283105, },
            {"Variant B", 50, 0xC2EF5C93, },
            {"Variant C", 50, 0xC8A467FD, },
            {"Variant D", 50, 0x4655E362, },
            {"Variant E", 50, 0xDBEF0E96, },
            {"Variant F", 50, 0x7FC85282, },
        },
    },
    [6] = {
        name = "Blanket 6",
        Variants = {
            {"Variant A", 50, 0x7951D487, },
            {"Variant B", 50, 0xC073E2CA, },
            {"Variant C", 50, 0xEDCB3D78, },
            {"Variant D", 50, 0xA3D5298D, },
            {"Variant E", 50, 0xB19B4519, },
        },
    },
    [7] = {
        name = "Blanket 7",
        Variants = {
            {"Variant A", 50, 0xCDD2FB96, },
            {"Variant B", 50, 0xC097E12C, },
            {"Variant C", 50, 0xD333865B, },
            {"Variant D", 50, 0xE409A807, },
            {"Variant E", 50, 0xF6484C84, },
        },
    },
    [8] = {
        name = "Blanket 8",
        Variants = {
            {"Variant A", 50, 0xEC040C89, },
            {"Variant B", 50, 0x19C5E80C, },
            {"Variant C", 50, 0x64BE7DF8, },
            {"Variant D", 50, 0x3278996D, },
            {"Variant E", 50, 0x003D34F3, },
        },
    },
    [9] = {
        name = "Blanket 9",
        Variants = {
            {"Variant A", 50, 0x3BA0D76D, },
            {"Variant B", 50, 0x4BF1F80F, },
            {"Variant C", 50, 0x5F0F9E4A, },
            {"Variant D", 50, 0x71DFC3EA, },
            {"Variant E", 50, 0xF506CA32, },
        },
    },
    [10] = {
        name = "Blanket 10",
        Variants = {
            {"Variant A", 50, 0x2A6D33E8, },
            {"Variant B", 50, 0xFFB1DE72, },
            {"Variant C", 50, 0x0DC87A9F, },
            {"Variant D", 50, 0x20D4A0BF, },
            {"Variant E", 50, 0x127E0412, },
        },
    },
    [11] = {
        name = "Blanket 11",
        Variants = {
            {"Variant A", 50, 0xE32A1050, },
            {"Variant B", 50, 0x5894FB24, },
            {"Variant C", 50, 0xD9E17DBB, },
            {"Variant D", 50, 0xAB302059, },
            {"Variant E", 50, 0x9E468686, },
        },
    },
    [12] = {
        name = "Blanket 12",
        Variants = {
            {"Variant A", 50, 0x90A31F96, },
            {"Variant B", 50, 0x9AD633FC, },
            {"Variant C", 50, 0x53B325B7, },
            {"Variant D", 50, 0x7D637917, },
            {"Variant E", 50, 0xC7688D20, },
        },
    },
    [13] = {
        name = "Special Blankets",
        Variants = {
            {"Alligator", 350, 0x0FAE487F, },
            {"Bison", 350, 0x2286EE30, },
            {"Cougar", 350, 0x41D52CD8, },
            {"Wolf", 350, 0xC4C732B2, },
            {"Bear", 350, 0xFDF4250B, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Horns = {
    [1] = {
        name = "Horn A",
        Variants = {
            {"Horn A 1", 50, 0xB9DC787B,},
            {"Horn A 2", 50, 0xC6C381F5, },
            {"Horn A 3", 50, 0x0385E306, },
            {"Horn A 4", 50, 0x3B04C75F, },
            {"Horn A 5", 50, 0x3D2B5410, },
            {"Horn A 6", 50, 0x529D5458, },
            {"Horn A 7", 50, 0x5365D651, },
            {"Horn A 8", 50, 0x5840D0DA, },
            {"Horn A 9", 50, 0x5AC7E5A0, },
            {"Horn A 10", 50, 0x5EB8810E, },
            {"Horn A 11", 50, 0x634BE419, },
            {"Horn A 12", 50, 0x66B2E37B, },
            {"Horn A 13", 50, 0x7DC54289, },
            {"Horn A 14", 50, 0x8F6714AA, },
            {"Horn A 15", 50, 0x9E930716, },
            {"Horn A 16", 50, 0xA4D3D842, },
            {"Horn A 17", 50, 0xC6C18A58, },
            {"Horn A 18", 50, 0xCEF38CBC, },
            {"Horn A 19", 50, 0xF2CA0CC6, },
        },
    },
    [2] = {
        name = "Horn B",
        Variants = {
            {"Horn B 1", 50, 0x2A28C8BE, },
            {"Horn B 2", 50, 0x0D8DEEA1, },
            {"Horn B 3", 50, 0x1FFA4C3F, },
            {"Horn B 4", 50, 0x20200C8E, },
            {"Horn B 5", 50, 0x2A5AD412, },
            {"Horn B 6", 50, 0x7A255377, },
            {"Horn B 7", 50, 0x7CE8DAD6, },
            {"Horn B 8", 50, 0x835DAEC2, },
            {"Horn B 9", 50, 0xA56B702D, },
            {"Horn B 10", 50, 0xBD255BDC, },
            {"Horn B 11", 50, 0xC8182ACF, },
            {"Horn B 12", 50, 0xE9D46CB4, },
            {"Horn B 13", 50, 0xEB8AB425, },
        },
    },
    [3] = {
        name = "Horn C",
        Variants = {
            {"Horn C 1", 50, 0xF8CAE723, },
            {"Horn C 2", 50, 0xE1B1B8F1, },
            {"Horn C 4", 50, 0xFAA46AFE, },
            {"Horn C 5", 50, 0xC9D2895B, },
            {"Horn C 6", 50, 0xDC172DE4, },
            {"Horn C 7", 50, 0x577C24AC, },
            {"Horn C 8", 50, 0xC1BAF928, },
            {"Horn C 9", 50, 0x94CD1F4D, },
            {"Horn C 10", 50, 0x8806025B, },
            {"Horn C 11", 50, 0xBE896F61, },
            {"Horn C 12", 50, 0xACCECBEC, },
            {"Horn C 13", 50, 0x30C3D3D4, },
        },
    },
    [4] = {
        name = "Horn D",
        Variants = {
            {"Horn D 1", 50, 0x0791AC50, },
            {"Horn D 2", 50, 0x0B7E1689, },
            {"Horn D 3", 50, 0x110144FD, },
            {"Horn D 4", 50, 0x168845BB, },
            {"Horn D 5", 50, 0x204C1921, },
            {"Horn D 6", 50, 0x28DB931A, },
            {"Horn D 7", 50, 0x32085E61, },
            {"Horn D 8", 50, 0x746E78FC, },
            {"Horn D 9", 50, 0x97A9A8C3, },
            {"Horn D 10", 50, 0xAA5ABB5F, },
            {"Horn D 11", 50, 0xC883BF6A, },
            {"Horn D 12", 50, 0xFB906D30, },
            {"Horn D 13", 50, 0xF09C56EE, },
        },
    },
    [5] = {
        name = "Specials",
        Variants = {
            {"Horn Horse", 200, 0x34135CC3, },
            {"Horn Snake", 200, 0x3E40711D, },
            {"Horn Snake 2", 200, 0x107D9598, },
            {"Horn Special 1", 200, 0x9AD2AA40, },
            {"Horn Special 2", 200, 0xED0BCEB5, },
            {"Horn Special 3", 50, 0x333CDC06, },
            {"Horn Special 4", 50, 0xDBE6AC3B, },
            {"Horn Special 5", 50, 0xE1DC3856, },
            {"Horn Special 6", 50, 0xF826E4EB, },
            {"Horn Special 7", 50, 0x7F282C4E, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Manes = {
    [1] = {
        name = "Manes Short",
        Variants = {
            {"Variant 1", 50, 0x0086BEA7, },
            {"Variant 2", 50, 0x0354F6B7, },
            {"Variant 3", 50, 0x18199F48, },
            {"Variant 4", 50, 0x3F1FEE4C, },
            {"Variant 5", 50, 0x4F148D45, },
            {"Variant 6", 50, 0x52DC15C8, },
            {"Variant 7", 50, 0x5DE62AE8, },
            {"Variant 8", 50, 0x648A3924, },
            {"Variant 9", 50, 0x68601E7D, },
            {"Variant 10", 50, 0x7098D141, },
            {"Variant 11", 50, 0x86457C9A, },
            {"Variant 12", 50, 0x960C1B33, },
            {"Variant 13", 50, 0x9782A63C, },
            {"Variant 14", 50, 0x99884CB3, },
            {"Variant 15", 50, 0x99F5A3FA, },
            {"Variant 16", 50, 0xA4E1B8DE, },
            {"Variant 17", 50, 0xABA8475F, },
            {"Variant 18", 50, 0xB288D42C, },
            {"Variant 19", 50, 0xBD7B6B05, },
            {"Variant 20", 50, 0xC15371C1, },
            {"Variant 21", 50, 0xC207B6C9, },
            {"Variant 22", 50, 0xE428F17A, },
            {"Variant 23", 50, 0xF2E555D8, },
            {"Variant 24", 50, 0xFF77B75B, },
        },
    },
    [2] = {
        name = "Manes Medium",
        Variants = {
            {"Variant 1", 50, 0x0A8458A2, },
            {"Variant 2", 50, 0x01068859, },
            {"Variant 3", 50, 0x0A1C6131, },
            {"Variant 4", 50, 0x130E341A, },
            {"Variant 5", 50, 0x16923E26, },
            {"Variant 6", 50, 0x1A5A45B6, },
            {"Variant 7", 50, 0x1BDFED93, },
            {"Variant 8", 50, 0x2035B791, },
            {"Variant 9", 50, 0x2FCAF0CB, },
            {"Variant 10", 50, 0x32244D2B, },
            {"Variant 11", 50, 0x419D9470, },
            {"Variant 12", 50, 0x41EA9196, },
            {"Variant 13", 50, 0x457BD7C4, },
            {"Variant 14", 50, 0x5445B9C0, },
            {"Variant 15", 50, 0x5ED14B9F, },
            {"Variant 16", 50, 0x5F61FDE6, },
            {"Variant 17", 50, 0x62BD2154, },
            {"Variant 18", 50, 0x127BA33B, },
            {"Variant 19", 50, 0x65767C4E, },
            {"Variant 20", 50, 0x66215D77, },
            {"Variant 21", 50, 0x6B3A6471, },
            {"Variant 22", 50, 0x6C3B2C50, },
            {"Variant 23", 50, 0x6F28EE6E, },
            {"Variant 24", 50, 0x724B740B, },
            {"Variant 25", 50, 0x75C33C19, },
            {"Variant 26", 50, 0x7C93AB45, },
            {"Variant 27", 50, 0x7D461CC8, },
            {"Variant 28", 50, 0x817B10F6, },
            {"Variant 29", 50, 0x8C45F563, },
            {"Variant 30", 50, 0x8DC6717E, },
            {"Variant 31", 50, 0x90C786CE, },
            {"Variant 32", 50, 0x9432AE01, },
            {"Variant 33", 50, 0x982FCDEC, },
            {"Variant 34", 50, 0xA005148D, },
            {"Variant 35", 50, 0xA7A4DD49, },
            {"Variant 36", 50, 0xB5F379E6, },
            {"Variant 37", 50, 0xC09EBC9D, },
            {"Variant 38", 50, 0xC63030FC, },
            {"Variant 39", 50, 0xCA39613B, },
            {"Variant 40", 50, 0xCFEDE17C, },
            {"Variant 41", 50, 0xD4680433, },
            {"Variant 42", 50, 0xD894BF28, },
            {"Variant 43", 50, 0xD9B8A432, },
            {"Variant 44", 50, 0xDCCE509C, },
            {"Variant 45", 50, 0xE1435081, },
            {"Variant 46", 50, 0xE93C80A2, },
            {"Variant 47", 50, 0xEA46E28C, },
            {"Variant 48", 50, 0xF1A20AED, },
            {"Variant 49", 50, 0xF571F429, },
            {"Variant 50", 50, 0xFBF310F4, },
            {"Variant 51", 50, 0xFF020F3A, },
        },
    },
    [3] = {
        name = "Manes Medium 2",
        Variants = {
            {"Variant 1", 50, 0x42B73FAC, },
            {"Variant 2", 50, 0x0A7115F0, },
            {"Variant 3", 50, 0x0E60BA50, },
            {"Variant 4", 50, 0x1509BA80, },
            {"Variant 5", 50, 0x18D41981, },
            {"Variant 6", 50, 0x1B9F384C, },
            {"Variant 7", 50, 0x247F0B87, },
            {"Variant 8", 50, 0x25E6FAA8, },
            {"Variant 9", 50, 0x265E2510, },
            {"Variant 10", 50, 0x2A371CD6, },
            {"Variant 11", 50, 0x2C1E693E, },
            {"Variant 12", 50, 0x3556E4A2, },
            {"Variant 13", 50, 0x36A5FD2D, },
            {"Variant 14", 50, 0x397F831C, },
            {"Variant 15", 50, 0x3DAC0C59, },
            {"Variant 16", 50, 0x427C8606, },
            {"Variant 17", 50, 0x464F05C5, },
            {"Variant 18", 50, 0x4BCA27B1, },
            {"Variant 19", 50, 0x4E59C375, },
            {"Variant 20", 50, 0x51EB3AC6, },
            {"Variant 21", 50, 0x5F712DB6, },
            {"Variant 22", 50, 0x8A47959B, },
            {"Variant 23", 50, 0x8DEFC981, },
            {"Variant 24", 50, 0x9209FC2C, },
            {"Variant 25", 50, 0x92A3B567, },
            {"Variant 26", 50, 0x92A63558, },            
            {"Variant 27", 50, 0x7838F17E, },
            {"Variant 28", 50, 0x6F5954BA, },
            {"Variant 29", 50, 0x7161F3C4, },
            {"Variant 30", 50, 0x8035108A, },
            {"Variant 31", 50, 0x835B98AD, },
            {"Variant 32", 50, 0x95F82796, },
            {"Variant 33", 50, 0x972AD502, },
            {"Variant 34", 50, 0x9C803ADB, },
            {"Variant 35", 50, 0xA44ED8BD, },
            {"Variant 36", 50, 0xB6007C20, },
            {"Variant 37", 50, 0xB9AF9821, },
            {"Variant 38", 50, 0xBD16FB35, },
            {"Variant 39", 50, 0xCF4C9FA0, },
            {"Variant 40", 50, 0xD114A330, },
            {"Variant 41", 50, 0xE2CF46A5, },
            {"Variant 42", 50, 0xFED279F2, },
            {"Variant 43", 50, 0xFEDA1FF1, },
            
        },
    },
    [4] = {
        name = "Manes Medium 3",
        Variants = {  
            {"Variant 1", 50, 0x54F6AAFA, },
            {"Variant 2", 50, 0x5924F189, },
            {"Variant 3", 50, 0x5CD349C3, },
            {"Variant 4", 50, 0xFC57549F, },
            {"Variant 5", 50, 0x1ED05FAE, },
        },
    },
    [5] = {
        name = "Manes Medium 4",
        Variants = {
            {"Variant 1", 50, 0x21AD55A4, },
            {"Variant 2", 50, 0x2B676918, },
            {"Variant 3", 50, 0x25F94F4C, },
            {"Variant 4", 50, 0x073CA0C3, },
            {"Variant 5", 50, 0x075510E0, },
            {"Variant 6", 50, 0x3918F467, },
            {"Variant 7", 50, 0x11C0A6DF, },
            {"Variant 8", 50, 0x54402BD9, },
            {"Variant 9", 50, 0x67ECBA72, },
            {"Variant 10", 50, 0x6B67026D, },
            {"Variant 11", 50, 0x6CB65CC5, },
            {"Variant 12", 50, 0x6DE910A2, },
            {"Variant 13", 50, 0x76787049, },
            {"Variant 14", 50, 0x793984BF, },
            {"Variant 15", 50, 0x83760A4C, },
            {"Variant 16", 50, 0x83DF6AC7, },
            {"Variant 17", 50, 0x946DDCC6, },
            {"Variant 18", 50, 0x95B8AED1, },
            {"Variant 19", 50, 0x9F60D111, },
            {"Variant 20", 50, 0xA6F8603C, },
            {"Variant 21", 50, 0xB00AC1F7, },
            {"Variant 22", 50, 0xC3C189AA, },
            {"Variant 23", 50, 0xC5F59E3A, },
            {"Variant 24", 50, 0xCCA21CA3, },
            {"Variant 25", 50, 0xD01DB28A, },
            {"Variant 26", 50, 0xEC1D5B99, },
            {"Variant 27", 50, 0xF4B77BBD, },
            {"Variant 28", 50, 0xFA6BF836, },
            {"Variant 29", 50, 0xFE878F59, },
        },
    },
    [6] = {
        name = "Manes Long",
        Variants = {
            {"Variant 1", 50, 0x0235DBF1, },
            {"Variant 2", 50, 0x0632F2B7, },
            {"Variant 3", 50, 0x0AFB7C24, },
            {"Variant 4", 50, 0x446A6F01, },
            {"Variant 5", 50, 0x47F57737, },
            {"Variant 6", 50, 0x5F0395A3, },
            {"Variant 7", 50, 0x5FE29755, },
            {"Variant 8", 50, 0x61EAC83A, },
            {"Variant 9", 50, 0x3AC55CD7, },
            {"Variant 10", 50, 0x6CB9310E, },
            {"Variant 11", 50, 0x7CB2E0D9, },
            {"Variant 12", 50, 0x838E5EB8, },
            {"Variant 13", 50, 0x94F58186, },
            {"Variant 14", 50, 0x97D095F4, },
            {"Variant 15", 50, 0xA193A97A, },
            {"Variant 16", 50, 0xAA3FAC1A, },
            {"Variant 17", 50, 0xB1AF4C55, },
            {"Variant 18", 50, 0xB881489D, },
            {"Variant 19", 50, 0xC8646863, },
            {"Variant 20", 50, 0xC9D16B31, },
            {"Variant 21", 50, 0xE0BC27A6, },
            {"Variant 22", 50, 0xE49B16DC, },
            {"Variant 23", 50, 0xE8FCC18A, },
            {"Variant 24", 50, 0xF3724E32, },
            {"Variant 25", 50, 0xFC74DF3B, },
        },
    },
    [7] = {
        name = "Manes Long 2",
        Variants = {
            {"Variant 1", 50, 0x2338A1A1, },
            {"Variant 2", 50, 0x35744ED1, },
            {"Variant 3", 50, 0x38BC5565, },
            {"Variant 4", 50, 0x102E87AA, },
            {"Variant 5", 50, 0x1C289C3E, },
            {"Variant 6", 50, 0x63222A34, },
            {"Variant 7", 50, 0x74FE4E10, },
            {"Variant 8", 50, 0xE166AA1B, },
        },
    },
    [8] = {
        name = "Manes Corn",
        Variants = {
            {"Variant 1", 50, 0x054A3CB0, },
            {"Variant 2", 50, 0x25627B98, },
            {"Variant 3", 50, 0x2E378E8A, },
            {"Variant 4", 50, 0x3BFE2A17, },
            {"Variant 5", 50, 0x4FCC51B3, },
            {"Variant 6", 50, 0x5D596CCD, },
            {"Variant 7", 50, 0x6F4510C4, },
            {"Variant 8", 50, 0x7D902D5A, },
            {"Variant 9", 50, 0x92B2579E, },
            {"Variant 10", 50, 0x97105EF6, },
            {"Variant 11", 50, 0xA0F4F423, },
            {"Variant 12", 50, 0xA64BFD6D, },
            {"Variant 13", 50, 0xB13D134B, },
            {"Variant 14", 50, 0xCF434F57, },
            {"Variant 15", 50, 0xD4E65BE5, },
            {"Variant 16", 50, 0xDC62E996, },
            {"Variant 17", 50, 0xE9FE04D0, },
        },
    },
    [9] = {
        name = "Manes Rasta",
        Variants = {
            {"Variant 1", 50, 0x0512377B, },
            {"Variant 2", 50, 0x09A640A3, },
            {"Variant 3", 50, 0x0DCF5321, },
            {"Variant 4", 50, 0x1FDC6D0F, },
            {"Variant 5", 50, 0x241D7FBD, },
            {"Variant 6", 50, 0x3A7C2C86, },
            {"Variant 7", 50, 0x483AC803, },
            {"Variant 8", 50, 0x6038F7FF, },
            {"Variant 9", 50, 0x6D9412B5, },
            {"Variant 10", 50, 0x83563E39, },
            {"Variant 11", 50, 0x96FE6589, },
            {"Variant 12", 50, 0xB2FB934B, },
            {"Variant 13", 50, 0xC929BFA7, },
            {"Variant 14", 50, 0xCDC9C8E7, },
            {"Variant 15", 50, 0xE02377D6, },
            {"Variant 16", 50, 0xFF17AB82, },
            {"Variant 17", 50, 0xFFF3B76A, },
        },
    },
    [10] = {
        name = "Manes Revolution",
        Variants = {
            {"Variant 1", 50, 0x09836E71, },
            {"Variant 2", 50, 0x0B52F0BC, },
            {"Variant 3", 50, 0x14098229, },
            {"Variant 4", 50, 0x1DF21752, },
            {"Variant 5", 50, 0x2D47B5FD, },
            {"Variant 6", 50, 0x388E4B32, },
            {"Variant 7", 50, 0x50AC7CC6, },
            {"Variant 8", 50, 0x8679685F, },
            {"Variant 9", 50, 0x9DF8175C, },
            {"Variant 10", 50, 0xACA2B4B1, },
            {"Variant 11", 50, 0xC0085B74, },
            {"Variant 12", 50, 0xD152FE09, },
            {"Variant 13", 50, 0xD43503D5, },
            {"Variant 14", 50, 0xD9CE8DB4, },
            {"Variant 15", 50, 0xE12C9C64, },
            {"Variant 16", 50, 0xEAB72F85, },
            {"Variant 17", 50, 0xF304C014, },
        },
    },
    [11] = {
        name = "Manes Unique",
        Variants = {
            {"Variant 1", 50, 0x031FED8D, },
            {"Variant 2", 50, 0x09B5FADD, },
            {"Variant 3", 50, 0x23063239, },
            {"Variant 4", 50, 0x27D5B5D8, },
            {"Variant 5", 50, 0x2881B850, },
            {"Variant 6", 50, 0x3590514D, },
            {"Variant 7", 50, 0xD21B0A64, },
            {"Variant 8", 50, 0xDCB71C0A, },
            {"Variant 9", 50, 0xEF69C645, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Saddlebags = {
    [1] = {
        name = "Bear Bags",
        Variants = {
            {"Light", 50, 0x744A78D3,},
            {"Dark Brown", 50, 0xABAA6716,},
            {"Black", 50, 0xBDF78BB0,},
            {"Brown", 50, 0xD03EB03E,},
            {"Gray", 50, 0xE27A54B5,},
        },
    },
    [10] = {
        name = "Town Bags",
        Variants = {
            {"Black 1", 50, 0x0C283176,},
            {"Black 2", 50, 0x0F2DB7B5,},
            {"Gray", 50, 0x1CE65326,},
            {"White", 50, 0x36C306DF,},
            {"Red - Black", 50, 0x4401A15C,},
            {"Dark Gray", 50, 0x5811C97C,},
            {"Brown", 50, 0x69D2ECCA,},
            {"Black - Light", 50, 0xA2C55EEA,},
            {"Dark Brown", 50, 0xB05AFA15,},
            {"Brown ", 50, 0xFDC114DC,},
        },
    },
    [11] = {
        name = "Wapiti Bags",
        Variants = {
            {"Brown", 50, 0x0817C4AB,},
            {"White", 50, 0x15DB6032,},
            {"Dark Brown", 50, 0x18A6655C,},
            {"Light Brown", 50, 0x34859D86,},
            {"Leather", 50, 0x513156DD,},
            {"Leather 2", 50, 0x5EB0F1DC,},
            {"Red - Black", 50, 0xB251191B,},
            {"Reddish", 50, 0xE77A8371,},
            {"Blue - Brown", 50, 0xEB4D0AAA,},
            {"Blue", 50, 0xFB66AB49,},
        },
    },
    [12] = {
        name = "Cowboy Bags",
        Variants = {
            {"Brown", 50, 0x0BFF9C93,},
            {"Brown 2", 50, 0x191DB6CF,},
            {"Black", 50, 0x3A9E79D0,},
            {"Gray", 50, 0x6862D558,},
            {"Dark", 50, 0xBB3BFB09,},
            {"Black 2", 50, 0xEF396307,},
            {"Old", 50, 0x1B0CE7F4,},
        },
    },
    [2] = {
        name = "Upgraded Used",
        Variants = {
            {"Dark", 50, 0xEEC77E72,},
            {"Light Brown", 50, 0x2AEFF6CA,},
            {"Brown", 50, 0x1D4EDB88,},
            {"Brown 2", 50, 0x0E893DFD,},
            {"Dark Brown", 50, 0xF0C30271,},
        },
    },
    [3] = {
        name = "Upgraded New",
        Variants = {
            {"Light", 50, 0x5277E9BA,},
            {"Light Brown", 50, 0x20AA8620,},
            {"Brown", 50, 0x577EF434,},
            {"Dark Brown", 50, 0x293E17B3,},
            {"Dark", 50, 0xE4108D59,},
        },
    },
    [4] = {
        name = "Upgraded Used 2",
        Variants = {
            {"Dark", 50, 0xC05AA4AA,},
            {"Light", 50, 0xAE110017,},
            {"Brown", 50, 0xB4F40DD9,},
            {"Brown 2", 50, 0xE2ADE94C,},
            {"Dark Brown", 50, 0xD048C482,},
        },
    },
    [5] = {
        name = "Bag 1",
        Variants = {
            {"Light", 50, 0xC019F804,},
            {"Light Brown", 50, 0x8BE10F93,},
            {"Brown", 50, 0x9D593283,},
            {"Dark Brown", 50, 0xE57042B4,},
            {"Dark", 50, 0xF8FB69CA,},
        },
    },
    [6] = {
        name = "Raccoon Bags",
        Variants = {
            {"Black - Gray", 50, 0x3CD9F305,},
            {"Black - Light Brown", 50, 0x2F2C57AA,},
            {"Brown", 50, 0xE08DBA6E,},
            {"Dark Brown", 50, 0xD2B91EC5,},
            {"Brown - Light Brown", 50, 0xB433E1C3,},
            {"Silver", 50, 0x0D88946F,},
            {"Brown 2", 50, 0x31FB5D54,},
            {"Gray", 50, 0x5785A868,},
            {"Dark", 50, 0x67C848ED,},
            {"Black", 50, 0xA5A844AC,},
        },
    },
    [7] = {
        name = "Bear Bag",
        Variants = {
            {"Dark Brown", 50, 0xCEFD2E33,},
            {"Light Brown", 50, 0xBB4F86D8,},
            {"Brown", 50, 0xAB49E6CD,},
            {"Red", 50, 0x98BC41B2,},
            {"White", 50, 0x867B1D30,},	
        },
    },
    [8] = {
        name = "Adventurer Bag",
        Variants = {
            {"Dark", 50, 0x27E754ED,},
            {"Light Spotted", 50, 0x3D327F83,},
            {"Light Leather", 50, 0xFDAB0075,},
            {"Gray", 50, 0x10DBA6D6,},
            {"White - Orange", 50, 0x61C248A2,},
            {"Brown", 50, 0x745FEDDD,},
            {"Light Brown - Red", 50, 0x149EAC60,},
            {"White - Red Spotted", 50, 0xE2DFC8E3,},
            {"Brown Leather", 50, 0xF105E52F,},
            {"Gray Spotted", 50, 0xBF3A0198,},
        },
    },
    [9] = {
        name = "Mexican Bag",
        Variants = {
            {"Red - Black", 50, 0x162D31BD},
            {"Black", 50, 0xD4B6AED1,},
            {"Brown", 50, 0x2280CA64},
            {"Dark Brown", 50, 0xFCC2FEE9,},
            {"Brown 2", 50, 0xCA541A0C,},
            {"Red", 50, 0x98ECB73E,},
            {"Blue - Brown", 50, 0xEBBB5CDA,},
            {"Ocean", 50, 0xA15F4823,},
            {"White - Black", 50, 0x88161591,},
            {"Brown - Gray", 50, 0x3DF3014C,},
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Tails = {
    [1] = {
        name = "Variant A",
        Variants = {
            {"Variant 1", 100, 0x04951F22, },
            {"Variant 2", 100, 0x12DBBBAF, },
            {"Variant 3", 100, 0x3B8A8D0C, },
            {"Variant 4", 100, 0x49CD2991, },
            {"Variant 5", 100, 0x607956E9, },
            {"Variant 6", 100, 0x6DB6F164, },
            {"Variant 7", 100, 0x7522834F, },
            {"Variant 8", 100, 0x84269E43, },
            {"Variant 9", 100, 0x876B27E0, },
            {"Variant 10", 100, 0x88A2AA53, },
            {"Variant 11", 100, 0x96EDC3D1, },
            {"Variant 12", 100, 0x972AC447, },
            {"Variant 13", 100, 0xA8A4673A, },
            {"Variant 14", 100, 0xBCD412B1, },
            {"Variant 15", 100, 0xCE62B5CE, },
            {"Variant 16", 100, 0xDD9F5447, },
            {"Variant 17", 100, 0xEFA67855, },
        },
    },
    [2] = {
        name = "Variant B",
        Variants = {
            {"Variant 1", 50, 0x0607E6DD, },
            {"Variant 2", 50, 0x066C266F, },
            {"Variant 3", 50, 0x073073A2, },
            {"Variant 4", 50, 0x084D6B90, },
            {"Variant 5", 50, 0x162191A0, },
            {"Variant 6", 50, 0x1F7A99EA, },
            {"Variant 7", 50, 0x30603BB5, },
            {"Variant 8", 50, 0x383E86F3, },
            {"Variant 9", 50, 0x3AE050B5, },
            {"Variant 10", 50, 0x3D1F13D4, },
            {"Variant 11", 50, 0x4B51B039, },
            {"Variant 12", 50, 0x574BC82D, },
            {"Variant 13", 50, 0x5D7FA043, },
            {"Variant 14", 50, 0x69756C80, },
            {"Variant 15", 50, 0x740701A3, },
            {"Variant 16", 50, 0x810A5CE0, },
            {"Variant 17", 50, 0x894C290D, },
            {"Variant 18", 50, 0x9CB1CFD8, },
            {"Variant 19", 50, 0xA0775A83, },
            {"Variant 20", 50, 0xB244FE1E, },
            {"Variant 21", 50, 0xB4374DB1, },
            {"Variant 22", 50, 0xD7D68A7B, },
            {"Variant 23", 50, 0xD9288D47, },
            {"Variant 24", 50, 0xD9EA1916, },
            {"Variant 24", 50, 0xED787168, },
            {"Variant 25", 50, 0xF4294320, },
            {"Variant 26", 50, 0xF4A3443C, },
            {"Variant 27", 50, 0xA4F0E056, },
            {"Variant 28", 50, 0xE38F5D96, },
            {"Variant 29", 50, 0xEAA5EEE7, },
            {"Variant 30", 50, 0xEABBBAB9, },
            {"Variant 31", 50, 0xF867D611, },
        },
    },
    [3] = {
        name = "Variant C",
        Variants = {
            {"Variant 1", 150, 0x0AFB492C, },
            {"Variant 2", 150, 0x1BB5EAA1, },
            {"Variant 3", 150, 0x1E9A18C2, },
            {"Variant 4", 150, 0x2E753874, },
            {"Variant 5", 150, 0x3B27D1DD, },
            {"Variant 6", 150, 0x3D212D77, },
            {"Variant 7", 150, 0x5062FC53, },
            {"Variant 8", 150, 0x508AD44A, },
            {"Variant 9", 150, 0x543203ED, },
            {"Variant 10", 150, 0x5F4871C5, },
            {"Variant 11", 150, 0x695B2E3F, },
            {"Variant 12", 150, 0x75C4C716, },
            {"Variant 13", 150, 0x7A248ABE, },
            {"Variant 14", 150, 0x82DB38EE, },
            {"Variant 15", 150, 0x84ADE4E4, },
            {"Variant 16", 150, 0xC0AF3489, },
            {"Variant 17", 150, 0xDCE41557, },
            {"Variant 18", 150, 0xEAEAB164, },
        },
    },
    [4] = {
        name = "Variant D",
        Variants = {
            {"Variant 1", 200, 0x17EB79D3, },
            {"Variant 2", 200, 0x1A3B721B, },
            {"Variant 3", 200, 0x25B51566, },
            {"Variant 4", 200, 0x33E7B1CB, },
            {"Variant 5", 200, 0x4124CC49, },
            {"Variant 6", 200, 0x4F5268A4, },
            {"Variant 7", 200, 0xA3DA055A, },
            {"Variant 8", 200, 0xA62C9657, },
            {"Variant 9", 200, 0xA7438C29, },
            {"Variant 10", 200, 0xB4AB3354, },
            {"Variant 11", 200, 0xC2FA4FF2, },
            {"Variant 12", 200, 0xC74FCC45, },
            {"Variant 13", 200, 0xD143E02D, },
            {"Variant 14", 200, 0xDDB48566, },
            {"Variant 15", 200, 0xEBC7218B, },
            {"Variant 16", 200, 0xF6B0AB06, },
        },
    },
    [5] = {
        name = "Variant E",
        Variants = {
            {"Variant 1", 250, 0x1FE89D6A, },
            {"Variant 2", 250, 0x475D7417, },
            {"Variant 3", 250, 0x4F087BA9, },
            {"Variant 4", 250, 0x6465A66B, },
            {"Variant 5", 250, 0xC304EB4C, },
            {"Variant 6", 250, 0xCDFF359A, },
            {"Variant 7", 250, 0xE283AA65, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Shoes = {
    [1] = {
        name = "Horse Shoes",
        Variants = {
            {"Lucky Horse Shoes", 200, 0x0865A270},
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Holster = {
    [1] =  {
        name = "Holsters",
        Variants = {
            {"Holster", 50, 0xF772CED6},
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Lantern = {
    [1] = {
        name = "Lanterns",
        Variants = {
            {"Basic Lantern", 50, 0x635E387C},
	
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Bridles = {
    [1] = {
        name = "All Bridles",
        Variants = {
            { "Variant 1", 50, 0x0C48F261, },
            { "Variant 2", 50, 0x0CBA8E54, },
            { "Variant 3", 50, 0x1A7E09B0, },
            { "Variant 4", 50, 0x2F62D3A4, },
            { "Variant 5", 50, 0x433DE046, },
            { "Variant 6", 50, 0x5BC3AC4D, },
            { "Variant 7", 50, 0x63899BC6, },
            { "Variant 8", 50, 0x754C3F4B, },
            { "Variant 9", 50, 0x7956475F, },
            { "Variant 10", 50, 0x7E89F1D9,},
            { "Variant 11", 50, 0x874F0363, },
            { "Variant 12", 50, 0x880FE4D2, },
            { "Variant 13", 50, 0x95ADA020, },
            { "Variant 14", 50, 0xAAA9CA18, },
            { "Variant 15", 50, 0xB8F0E6A6, },
            { "Variant 16", 50, 0xCFFBF4B5, },
            { "Variant 17", 50, 0xD1D7988F, },
            { "Variant 18", 50, 0xE006B4ED, },
            { "Variant 19", 50, 0xE3139FF7, },
            { "Variant 20", 50, 0xF0D53B7A, },
            { "Variant 21", 50, 0xF18C3CE4, },
            { "Variant 22", 50, 0xFB2178EC, },
            { "Variant 23", 50, 0xFE8E56EC, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Masks = {
    [1] = {
        name = "Buck Masks",
        Variants = {
            {"Buck Brown", 50, 0xD70C73EA,},
            {"Buck Black", 50, 0xF17728C7,},
            {"Buck White", 50, 0x13AC6E51,},
            {"Buck White", 50, 0x406FC6C7,},
            {"Buck Leather", 50, 0x4E22622C,},
            {"Buck Sacred", 50, 0x53EEEBD4, },
            {"Buck Blue", 50, 0x68FB97DE,},
            {"Buck Black", 50, 0x69CD996E,},
            {"Buck Dark Blue", 50, 0x7A773AC1,},
            {"Buck Red", 50, 0x9946F874, },
            {"Buck Dark Brown", 50, 0xE3278C28, },
        },
    },
    [2] = {
        name = "Bison Masks",
        Variants = {
            {"Bison Brown", 50, 0x68DB4FAD,},
            {"Bison Red", 50, 0x08A78F53,},
            {"Bison Gray", 50, 0x872A0C5A, },
            {"Bison Blue", 50, 0x8C471684, },
            {"Bison Brown 2", 50, 0x9A11B219, },
            {"Bison Ocean", 50, 0xB0395F88, },
            {"Bison White", 50, 0xBD887906, },
            {"Bison Reddish", 50, 0xC4886BDC, },
            {"Bison Leather", 50, 0xDDCDB9A0, },
            {"Bison Pink ", 50, 0xEC10D626, },
            {"Bison Dark Gray ", 50, 0xFA5B72BB, },
        },
    },
    [3] = {
        name = "Ram Masks",
        Variants = {
            {"Brown", 50, 0x62C5B02A, },
            {"Gray", 50, 0x30044BAC, },
            {"Pink", 50, 0x4C8C83A4, },
            {"Red", 50, 0x61BEAE08, },
            {"Gray", 50, 0x702A4AF3,},
            {"White", 50, 0x8DB38601, },
            {"Brown", 50, 0x9DB125FC, },
            {"Gray ", 50, 0xB395D1C5, },
            {"Dark Brown ", 50, 0xC907FCA9, },
            {"Mexican ", 50, 0xD6E279B1, },
        },
    },
    [4] = {
        name = "Unicorn Masks",
        Variants = {
            {"Black", 50, 0x2E776EE6,},
            {"Dark", 50, 0x75637CBD,},
            {"Brown", 50, 0x4A992729,},
            {"Black 2", 50, 0x4E312E61,},
        },
    },
    [5] = {
        name = "Sabertooth Masks",
        Variants = {
            {"Brown", 50, 0x48099436,},
            {"Dark", 50, 0x77987353,},
            {"Gray", 50, 0xAD6DDEFD,},
            {"White", 50, 0x5B22BA68,},
        },
    },
    [6] = {
        name = "Snake Masks",
        Variants = {
            {"Black", 50, 0xF0ED62FF, },
            {"Brown", 50, 0x6B355791, },
            {"Leather", 50, 0x7BFA791B, },
            {"Blue", 50, 0x8DCC1CBE, },
            {"Blue 2 ", 50, 0x90A62272, },
            {"Dark", 50, 0xA45049C6, },
            {"Brown 3", 50, 0xC70D8F40, },
            {"White", 50, 0xEEF65F11, },
            {"Blue-Brown ", 50, 0xF606EC4A, },
        },
    },
}
---------------------------------------------------------------------------------------------------------
Config.Mustaches = {
    [1] = {
        name = "All Mustaches",
        Variants = {
            {"Mustache 1 White", 50, 0x004BBEED, },
            {"Mustache 2 Brown", 50, 0x0960D117, },
            {"Mustache 3 Brown", 50, 0x281A6D81, },
            {"Mustache 4 Brown", 50, 0x334F83D3, },
            {"Mustache 5 Brown", 50, 0x5497E784, },
            {"Mustache 6 Brown", 50, 0x67590D8F, },
            {"Mustache 7 Dark", 50, 0x91887491, },
            {"Mustache 8 White", 50, 0x9ADAF492, },
            {"Mustache 9 Brown", 50, 0xAC459767, },
            {"Mustache 10 White", 50, 0xAF2A2FD8,},
            {"Mustache 11 Gray", 50, 0xB755402E,},
            {"Mustache 12 Red", 50, 0xCFBA5E50,},
            {"Mustache 13 White", 50, 0xDC895660,},
            {"Mustache 14 Gray", 50, 0xEAEEF32B,},
            {"Mustache 15 Gray", 50, 0xED8D1970,},
            {"Mustache 16 Red", 50, 0xF7203FC3,},
        },
    },
}
---------------------------------------------------------------------------------------------------------
--DO NOT CHANGE THE NAME OF THE COMPONENTS HERE, COMPONENT'S LABEL CAN BE CHANGED AT Config.Texts - Categories
Config.Components = {
      "Saddle",
      "Stirrup",
      "Bedrolls",
      "Blankets",
      "Horns",
      "Manes",
      "Saddlebags",
      "Tails",
      "Shoes",
      "Lantern",
      "Holster",
      "Bridles",
      "Masks",
      "Mustaches",
}
--DO NOT CHANGE THE NAME OF THE COMPONENTS HERE, COMPONENT'S LABEL CAN BE CHANGED AT Config.Texts - Categories
---------------------------------------------------------------------------------------------------------
Config.Textures = {
    cross = {"scoretimer_textures", "scoretimer_generic_cross"},
    locked = {"menu_textures","stamp_locked_rank"},
    tick = {"scoretimer_textures","scoretimer_generic_tick"},
    money = {"inventory_items", "money_moneystack"},
    alert = {"menu_textures", "menu_icon_alert"},
}
---------------------------------------------------------------------------------------------------------
--[[
    INVENTORY 2.0 CONFIGS 
    ["horsebrush"] =
    {
        label = "Horse Brush",
        description = "Best for horses",
        weight = 0.5,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 1,
        imgsrc = "items/brush.png",
        type = "item_standard",
    },
    ["hay"] =
    {
        label = "Hay",
        description = "Feeditem",
        weight = 0.01,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 100,
        imgsrc = "items/hay.png",
        type = "item_standard",
    },
    ["carrot"] =
    {
        label = "Carrot",
        description = "Provision",
        weight = 0.01,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 100,
        imgsrc = "items/carrot.png",
        type = "item_standard",
    },
]]--
---------------------------------------------------------------------------------------------------------