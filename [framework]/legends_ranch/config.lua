Config = {}

Config.RicXDog = true

Config.MenuJob = false --for no job: Config.MenuJob = false

Config.AnimalLevel = {
    [1] = {
        ["Scale"] = 0.5,
        ["MoneyOdds"] = 0.1,
    },
    [2] = {
        ["Scale"] = 0.55,
        ["MoneyOdds"] = 0.2,
    },
    [3] = {
        ["Scale"] = 0.6,
        ["MoneyOdds"] = 0.3,
    },
    [4] = {
        ["Scale"] = 0.65,
        ["MoneyOdds"] = 0.4,
    },
    [5] = {
        ["Scale"] = 0.7,
        ["MoneyOdds"] = 0.5,
    },
    [6] = {
        ["Scale"] = 0.75,
        ["MoneyOdds"] = 0.6,
    },
    [7] = {
        ["Scale"] = 0.8,
        ["MoneyOdds"] = 0.7,
    },
    [8] = {
        ["Scale"] = 0.85,
        ["MoneyOdds"] = 0.8,
    },
    [9] = {
        ["Scale"] = 0.9,
        ["MoneyOdds"] = 0.9,
    },
    [10] = {
        ["Scale"] = 0.95,
        ["MoneyOdds"] = 1.1,
    },
    [11] = {
        ["Scale"] = 1.0,
        ["MoneyOdds"] = 1.3,
    },
    [12] = {
        ["Scale"] = 1.05,
        ["MoneyOdds"] = 1.5,
    },
    [13] = {
        ["Scale"] = 1.15,
        ["MoneyOdds"] = 1.7,
    },
    [14] = {
        ["Scale"] = 1.2,
        ["MoneyOdds"] = 2.0,
    },
    [15] = {
        ["Scale"] = 1.25,
        ["MoneyOdds"] = 2.2,
    },
}

Config.Options = {
    ["ControlKey"] = 0xCEFD9220, -- [E] for shop
    ["MaxAnimals"] = 10,
    ["AnimalControls"] = {
        ["Graze"] = {'Pastar',0x05CA7C52},
        ["Follow"] = {'Seguir',0xA65EBAB4},
        ["Home"] =  {'Mandar Embora',0x6319DB71},
        ["Herd"] = {'Rebanho',0xDEB34313},
    },
    ["BlipEnable"] = true,
    ["ShopBlipName"] = "Animal Shop",
    ["ShopBlipSprite"] =  -1733535731,
    ["ButcherySprite"] = -1852063472,
    ["GrazeTime"] = 20, --seconds for grazing function. Animal gets xp after finishing grazeing
    ["GrazeXP"] = 5,
    ["GrazeXPs"] = {
        ["Bull"] = 1,
        ["Ox"] = 1,
        ["Chicken"] = 20,
        ["Cow"] = 1,
        ["Goat"] = 10,
        ["Sheep"] = 10,
        ["Pig"] = 10,
        ["Rooster"] = 20,
        ["Turkey"] = 10,
        ["Rabbit"] = 15,
    },
    ["Messages"] = {
        ["AnimalSpawned"] = "Your animal has already spawned!",
        ["AnimalHere"] = "Your animal spawned. ",
        ["AnimalGrazing"] = "Your animal is grazing already!",
        ["AnimalBusy"] = "Your animal is busy!",
        ["GrazeError"] = "Animals cant graze in towns and cities!",
        ["AnimalHome"] = "You sent your animal back to home!",
        ["AnimalSold"] = "You sold an animal!",
        ["NoAnimal"] = "There is no animal near the Butchery!",
        ["BoughtAnimal"] = "You bought an animal!",
        ["NoMoney"] = "You dont have money!",
        ["AnimalShop"] = "Animal Shop",
        ["NoJob"] = "You dont have the reqiured job!",
        ["RicXDogs"] = {
            ["GuardSuccess"] = "Your animal finished grazing and started again, because of your skilled dog!",
            ["FinishedGraze"] = "Your animal finished grazing, and started wandering!",
            ["GuardFail"] = "Your animal finished grazing.~n~You dog is not skilled to guard it, animal is wandering.",
        },
        
    },
    ["MenuTexts"] = {
        ["Butchery"] = "Butchery",
        ["SellSubText"] = "Sell Animals",
        ["SellBtn"] = "Sell",
        ["Title"] = "Farm Animals",
        ["SubText"] = "Options",
        ["OwnedAnimals"] = "Owned Animals",
        ["OwnedDesc"] = "Your Animals",
        ["Chickens"] = "Chickens",
        ["Roosters"] = "Roosters",
        ["Turkeys"] = "Turkeys",
        ["Rabbits"] = "Rabbits",
        ["Goats"] = "Goats",
        ["Pigs"] = "Pigs",
        ["Sheeps"] = "Sheeps",
        ["Cows"] = "Cows",
        ["Bulls"] = "Bulls",
        ["DelAnimal"] = "Animal Deletado"
    },
    ["MenuOptions"] = {
        ["ChooseAnimal"] = "Choose",
        ["ChooseAnimalSub"] = "Choose your animal",
        ["DeleteAnimal"] = "Delete",
        ["DeleteAnimalSub"] = "Delete your animal",
        ["Chickens"] = {
            [1] = "Leghorn Chicken",
            [2] = "Dominique Chicken",
            [3] = "Java Chicken",
        },
        ["Roosters"] = {
            [1] = "Dominique Rooster",
            [2] = "Java Rooster",
        },
        ["Turkeys"] = {
            [1] = "Turkey",
        },
        ["Rabbits"] = {
            [1] = "Grey Rabbit",
            [2] = "Rabbit",
            [3] = "White Rabbit",
        },
        ["Goats"] = {
            [1] = "White Alpine Goat",
            [2] = "Black Alpine Goat",
        },
        ["Pigs"] = {
            [1] = "China Pig",
            [2] = "Berkshire Pig",
            [3] = "Old Spot Pig",
        },
        ["Sheeps"] = {
            [1] = "Grey Sheep",
            [2] = "White Sheep",
            [3] = "Black Sheep",
        },
        ["Cows"] = {
            [1] = "Cow (Brown-White)",
            [2] = "Cow (Dark Brown)",
            [3] = "Cow (Brown White)",
            [4] = "Cow (Light)",
            [5] = "Cow (Black White)",
            [6] = "Cow (White Brown)",
            [7] = "Cow (Black White)",
            [8] = "Cow (Light)",
            [9] = "Cow (White Black)",
            [10] = "Cow (Black White)",
            [11] = "Cow (Albino)",
            [12] = "Cow (Dark Brown)",
            [13] = "Cow (Black)", 
        },
        ["Bulls"] = {
            [1] = "Devon Ox",
            [2] = "Angus Ox",
            [3] = "Hereford Bull",
            [4] = "Devon Bull",
            [5] = "Angus Bull",
        },
    },
}

Config.AnimalPrices = {
    [1] = 30,
    [2] = 30, 
    [3] = 30,
    [4] = 30,
    [5] = 30,
    [6] = 30,
    [7] = 30,
    [8] = 30,
    [9] = 35,
    [10] = 60,
    [11] = 60,
    [12] = 60,
    [13] = 60,
    [14] = 60,
    [15] = 60,
    [16] = 60,
    [17] = 60,
    [18] = 90,
    [19] = 90,
    [20] = 90,
    [21] = 90,
    [22] = 90,
    [23] = 90,
    [24] = 90,
    [25] = 90,
    [26] = 90,
    [27] = 90,
    [28] = 90,
    [29] = 90,
    [30] = 90,
    [31] = 100,
    [32] = 100,
    [33] = 100,
    [34] = 100,
    [35] = 100,
}