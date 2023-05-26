Config = {}

Config.Debug = false

Config.Blip = {
    blipName = 'Tobacco Factory', -- Config.Blip.blipName
    blipSprite = 'blip_mp_ordered_item', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- prompt locations
Config.TobaccoFactoryLocations = {
    {name = 'Tobacco Factory', prompt = 'tobacco1', coords = vector3(1833.4796, -1274.331, 43.351779), showblip = true, showmarker = true},
}

-- factory items
Config.FactoryOptions = {

    ["Dry Tobacco Leaves"] = {
        name = "Dry Tobacco",
        factorytime = 5000,
        factoryitems = {
            [1] = { item = "tobacco", amount = 1 },
        },
        receive = "drytobacco"
    },
    
    ["Make a Cigar"] = {
        name = "Cigar",
        factorytime = 10000,
        factoryitems = {
            [1] = { item = "drytobacco", amount = 2 },
        },
        receive = "cigar"
    },
    
    ["Craft Box of Cigars"] = {
        name = "Box of Cigars",
        factorytime = 20000,
        factoryitems = {
            [1] = { item = "cigar", amount = 10 },
        },
        receive = "cigarbox"
    },
    
}
