RSGConfig = {}

RSGConfig.MaxPlayers = GetConvarInt('sv_maxclients', 48) -- Gets max players from config file, default 48
RSGConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)
RSGConfig.UpdateInterval = 0.5 -- how often to update player data in minutes
RSGConfig.StatusInterval = 5000 -- how often to check hunger/thirst status in milliseconds

RSGConfig.Money = {}
RSGConfig.Money.MoneyTypes = { cash = 500, bank = 5000, bloodmoney = 0 } -- type = startamount - Add or remove money types for your server (for ex. blackmoney = 0), remember once added it will not be removed from the database!
RSGConfig.Money.DontAllowMinus = { 'cash', 'bloodmoney' } -- Money that is not allowed going in minus
RSGConfig.Money.PayCheckTimeOut = 30 -- The time in minutes that it will give the paycheck
RSGConfig.Money.PayCheckSociety = false -- If true paycheck will come from the society account that the player is employed at, requires qb-management

RSGConfig.Player = {}
RSGConfig.Player.RevealMap = true
RSGConfig.Player.HungerRate = 2.2 -- Rate at which hunger goes down.
RSGConfig.Player.ThirstRate = 1.8 -- Rate at which thirst goes down.
RSGConfig.Player.Bloodtypes = {
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-",
}

RSGConfig.Server = {} -- General server config
RSGConfig.Server.Closed = false -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
RSGConfig.Server.ClosedReason = "Server Closed" -- Reason message to display when people can't join the server
RSGConfig.Server.Uptime = 0 -- Time the server has been up.
RSGConfig.Server.Whitelist = false -- Enable or disable whitelist on the server
RSGConfig.Server.WhitelistPermission = 'admin' -- Permission that's able to enter the server when the whitelist is on
RSGConfig.Server.Discord = "https://discord.com/api/oauth2/authorize?client_id=1097230155866451988&permissions=8&scope=bot" -- Discord invite link
RSGConfig.Server.CheckDuplicateLicense = true -- Check for duplicate rockstar license on join
RSGConfig.Server.Permissions = { 'god', 'admin', 'mod' } -- Add as many groups as you want here after creating them in your server.cfg


RSGConfig.Game = {}
RSGConfig.Game.EnableEagleEye       = false
RSGConfig.Game.EnablePVP            = true
RSGConfig.Game.WeaponRecoilSystem   = true          -- Set to true to enable weapon recoil system.
RSGConfig.Game.WeaponRecoils        = {
    [34411519]                          = 0.7,          -- weapon_pistol_volcanic
    [1252941818]                        = 0.7,          -- weapon_pistol_mauser_drunk
    [1534638301]                        = 0.7,          -- weapon_pistol_m1899
    [1701864918]                        = 0.7,          -- weapon_pistol_semiauto
    [2239809086]                        = 0.7,          -- weapon_pistol_mauser
    [1905553950]                        = 0.7,          -- weapon_repeater_evans
    [2511488402]                        = 0.7,          -- weapon_repeater_henry
    [2823250668]                        = 0.7,          -- weapon_repeater_winchester
    [4111948705]                        = 0.7,          -- weapon_repeater_carbine
    [127400949]                         = 0.7,          -- weapon_revolver_doubleaction
    [379542007]                         = 0.7,          -- weapon_revolver_cattleman
    [383145463]                         = 0.7,          -- weapon_revolver_cattleman_mexican
    [1529685685]                        = 0.7,          -- weapon_revolver_lemat
    [2075992054]                        = 0.7,          -- weapon_revolver_schofield
    [2212320791]                        = 0.7,          -- weapon_revolver_doubleaction_gambler
    [1676963302]                        = 0.7,          -- weapon_rifle_springfield
    [1999408598]                        = 0.7,          -- weapon_rifle_boltaction
    [3724000286]                        = 0.7,          -- weapon_rifle_varmint
    [392538360]                         = 0.7,          -- weapon_shotgun_sawedoff
    [575725904]                         = 0.7,          -- weapon_shotgun_doublebarrel_exotic
    [834124286]                         = 0.7,          -- weapon_shotgun_pump
    [1674213418]                        = 0.7,          -- weapon_shotgun_repeating
    [1838922096]                        = 0.7,          -- weapon_shotgun_semiauto
    [1845102363]                        = 0.7,          -- weapon_shotgun_doublebarrel
    [1402226560]                        = 0.7,          -- weapon_sniperrifle_carcano
    [3788682007]                        = 0.7,
}
    -- These are how you define different notification variants
-- The "color" key is background of the notification
-- The "icon" key is the css-icon code, this project uses `Material Icons` & `Font Awesome`
RSGConfig.Notify = {}

RSGConfig.Notify.NotificationStyling = {
    group = true, -- Allow notifications to stack with a badge instead of repeating
    position = "left", -- top-left | top-right | bottom-left | bottom-right | top | bottom | left | right | center
    progress = true -- Display Progress Bar
}
RSGConfig.Notify.VariantDefinitions = {
    success = {
        classes = 'success',
        icon = 'done'
    },
    primary = {
        classes = 'primary',
        icon = 'info'
    },
    error = {
        classes = 'error',
        icon = 'dangerous'
    },
    police = {
        classes = 'police',
        icon = 'local_police'
    },
    medic = {
        classes = 'medic',
        icon = 'fas fa-ambulance'
    },
    horse = {
        classes = 'horse',
        icon = 'fas fa-horse-head'
    },
    warning = {
        classes = 'warning',
        icon = 'warning'
    }
}

