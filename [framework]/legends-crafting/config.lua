Config = {}
Config.Debug = false

Config.CraftingLocations = {
    {
        name = 'Crafting Valentine', -- Nama lokasi crafting
        coords = vector3(-369.4787, 796.1747, 116.3813), -- Koordinat lokasi crafting dalam format vector3
        showblip = true -- Apakah ingin menampilkan blip pada lokasi crafting (true/false)
    },
    {
        name = 'Crafting Blackwater', -- Nama lokasi crafting
        coords = vector3(-878.3790, -1362.1334, 43.5280), -- Koordinat lokasi crafting dalam format vector3
        showblip = true -- Apakah ingin menampilkan blip pada lokasi crafting (true/false)
    }
}

Config.CraftingIngrident = {
    ["Shovel"] = {
        name =  'shovel',
        craftingtime = 5000,
        ingredients = {
            [1] = { item = "iron", amount = 1 },
            [2] = { item = "wood", amount = 1 }
        },
        receive = "shovel"
    },
    ["Axe"] = {
        name = 'axe',
        craftingtime = 5000,
        ingredients = {
            [1] = { item = "steel", amount = 1 },
            [2] = { item = "wood", amount = 1 }
        },
        receive = "axe"
    }
}

-- Config.CraftingIngrident['weapon'] = {
--     ["Revolver lemat"] = {
--         name =  'weapon_revolver_cattleman',
--         craftingtime = 5000,
--         ingredients = {
--             [1] = { item = "steel", amount = 1 },
--             [2] = { item = "copper", amount = 2 },
--             [3] = { item = "aluminum", amount = 1 }
--         },
--         receive = "weapon_revolver_cattleman"
--     },
--     ["Pistol Volcanic"] = {
--         name = 'weapon_pistol_volcanic',
--         craftingtime = 5000,
--         ingredients = {
--             [1] = { item = "steel", amount = 1 },
--             [2] = { item = "copper", amount = 2 },
--             [3] = { item = "aluminum", amount = 1 }
--         },
--         receive = "weapon_pistol_volcanic"
--     }
-- }