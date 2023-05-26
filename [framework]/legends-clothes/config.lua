Config = {}
Config.Shoptext = 'Pressione ~INPUT_JUMP~ para abrir loja de roupas' -- Text to open the clothing shop
Config.Cloakroomtext = 'Pressione ~INPUT_JUMP~ para abrir Armário' -- Text to open the clothing shop
Config.BlipName = 'Loja de Roupas' -- Blip Name Showed on map
Config.BlipNameCloakRoom = 'Wardrobe' -- Blip Name Showed on map
Config.BlipSprite = 1195729388	 -- Clothing shop sprite
Config.BlipSpriteCloakRoom = 1496995379	 -- Clothing shop sprite
Config.BlipScale = 0.2 -- Blip scale
Config.OpenKey = 0xD9D0E1C0 -- Opening key hash
Config.Zones = {
    vector3(-325.5,774.57,117.45), -- VALENTINE
    vector3(1326.42, -1289.56, 77.02), -- RHODES
    vector3(2550.81,-1166.28,53.68), -- SAINT DENIS
    vector3(-767.94,-1294.95,43.84), -- BLACK WATER
    vector3(-1794.89,-385.22,160.33), -- STRAWBERRY
    vector3(-3689.37,-2628.01,-13.41), -- ARMADILO
    vector3(-5490.97,-2938.28,-0.4) -- TUMBLEWEED
}

Config.Cloakroom = {
    vector3(-325.29,766.24,117.48), -- VALENTINE
    vector3(-1817.11,-368.77,166.54), 
    vector3(-825.40,-1323.76,47.91), 
    vector3(1331.86,-1377.35,80.55), 
    vector3(2556.49,-1160.14,53.74) 
}

Config.Label = {
    ["boot_accessories"] = "Acessórios de Botas",
    ["pants"] = "Calças",
    ["cloaks"] = "Capas",
    ["hats"] = "Chapéus",
    ["vests"] = "Colete",
    ["chaps"] = "Chaps",
    ["shirts_full"] = "Camisas Completas",
    ["badges"] = "Emblemas",
    ["masks"] = "Máscaras",
    ["spats"] = "Sapatilhas",
    ["neckwear"] = "Lenços",
    ["boots"] = "Botas",
    ["accessories"] = "Acessórios",
    ["jewelry_rings_right"] = "Joias Anéis Direita",
    ["jewelry_rings_left"] = "Joias Anéis Esquerda",
    ["jewelry_bracelets"] = "Joias Pulseiras",
    ["gauntlets"] = "Luvas de Punho",
    ["neckties"] = "Gravatas",
    ["holsters_knife"] = "Coldres Facas",
    ["talisman_holster"] = "Coldre Talismã",
    ["loadouts"] = "Equipamentos",
    ["suspenders"] = "Suspensórios",
    ["talisman_satchel"] = "Bolsa Talismã",
    ["satchels"] = "Bolsas",
    ["gunbelts"] = "Cintos de Arma",
    ["belts"] = "Cintos",
    ["belt_buckles"] = "Fivelas de Cinto",
    ["holsters_left"] = "Coldres Esquerda",
    ["holsters_right"] = "Coldres Direita",
    ["talisman_wrist"] = "Pulseira Talismã",
    ["coats"] = "Casacos",
    ["coats_closed"] = "Casacos Fechados",
    ["ponchos"] = "Ponchos",
    ["eyewear"] = "Óculos",
    ["gloves"] = "Luvas",
    ["holsters_crossdraw"] = "Coldres Crossdraw",
    ["aprons"] = "Aventais",
    ["skirts"] = "Saias",
    ["hair_accessories"] = "Acessórios de Cabelo",
    ["armor"] = "Armaduras",
    ["dresses"] = "Vestidos",
}

Config.Price = {
    ["boot_accessories"] = 4,
    ["pants"] = 2,
    ["cloaks"] = 4,
    ["hats"] = 2,
    ["vests"] = 2,
    ["chaps"] = 2,
    ["shirts_full"] = 2,
    ["badges"] = 10,
    ["masks"] = 5,
    ["spats"] = 3,
    ["neckwear"] = 2,
    ["boots"] = 2,
    ["accessories"] = 5,
    ["jewelry_rings_right"] = 10,
    ["jewelry_rings_left"] = 10,
    ["jewelry_bracelets"] = 6,
    ["gauntlets"] = 3,
    ["neckties"] = 3,
    ["holsters_knife"] = 3,
    ["talisman_holster"] = 3,
    ["loadouts"] = 5,
    ["suspenders"] = 3,
    ["talisman_satchel"] = 3,
    ["satchels"] = 3,
    ["gunbelts"] = 3,
    ["belts"] = 2,
    ["belt_buckles"] = 6,
    ["holsters_left"] = 5,
    ["holsters_right"] = 5,
    ["talisman_wrist"] = 5,
    ["coats"] = 5,
    ["coats_closed"] = 5,
    ["ponchos"] = 3,
    ["eyewear"] = 5,
    ["gloves"] = 3,
    ["holsters_crossdraw"] = 4,
    ["aprons"] = 4,
    ["skirts"] = 2,
    ["hair_accessories"] = 2,
    ["dresses"] = 1,  
    ["armor"] = 20,        
}

Config.MenuElements = {
    ["head"] = {
    label = "Cabeça",
    category = {
    "hats",
    "eyewear",
    "masks",
    "neckwear",
    "neckties",
    }
    },

    ["torso"] = {
        label = "Tronco",
        category = {
            "cloaks",
            "vests",
            "shirts_full",
            "holsters_knife",
            "loadouts",
            "suspenders",
            "gunbelts",
            "belts",
            "holsters_left",
            "holsters_right",
            "coats",
            "coats_closed",
            "ponchos",
            "dresses",
        }
    },
    
    ["legs"] = {
        label = "Pernas",
        category = {
            "pants",
            "chaps",
            "skirts",
        }
    },
    ["foot"] = {
        label = "Pés",
        category = {
            "boots",
            "spats",
            "boot_accessories",
        }
    },
    
    ["hands"] = {
        label = "Mãos",
        category = {
            "jewelry_rings_right",
            "jewelry_rings_left",
            "jewelry_bracelets",
            "gauntlets",
            "gloves",
        }
    },
    
    ["accessories"] = {
        label = "Acessórios",
        category = {
            "accessories",
            "talisman_wrist",
            "talisman_holster",
            "belt_buckles",
            "satchels",
            "holsters_crossdraw",
            "aprons",
            "bows",
            "armor",
            "badges",
            "hair_accessories",
        }
    },
    }