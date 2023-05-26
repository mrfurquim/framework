local RSGCore = exports['legends-core']:GetCoreObject()
local PlayerData = RSGCore.Functions.GetPlayerData()
local currentname
local currentzone

-----------------------------------------------------------------------------------

-- job prompts and blips
Citizen.CreateThread(function()
    for saloontender, v in pairs(Config.SaloonTenderLocations) do
        exports['legends-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'legends-saloontender:client:mainmenu',
            args = { v.location, v.coords },
        })
        if v.showblip == true then
            local SaloonTenderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(SaloonTenderBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(SaloonTenderBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, SaloonTenderBlip, Config.Blip.blipName)
        end
    end
end)

-----------------------------------------------------------------------------------

-- saloontender menu
RegisterNetEvent('legends-saloontender:client:mainmenu', function(name, zone)
    local job = RSGCore.Functions.GetPlayerData().job.name
    if job == name then
        currentname = name
        currentzone = zone
        exports['legends-menu']:openMenu({
            {
                header = 'Saloon Tender',
                isMenuHeader = true,
            },
            {
                header = "Saloon Storage",
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'legends-saloontender:client:storage',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = "DukeBox",
                txt = "",
                icon = "fas fa-music",
                params = {
                    event = 'legends-saloontender:client:musicmenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = "Job Management",
                txt = "",
                icon = "fas fa-user-circle",
                params = {
                    event = 'legends-bossmenu:client:OpenMenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = ">> Close Menu <<",
                txt = '',
                params = {
                    event = 'legends-menu:closeMenu',
                }
            },
        })
    else
        RSGCore.Functions.Notify('you are not authorised!', 'error')
    end
end)

-----------------------------------------------------------------------------------

-- saloon general storage
RegisterNetEvent('legends-saloontender:client:storage', function()
    local job = RSGCore.Functions.GetPlayerData().job.name
    local stashloc = currentname
    if job == currentname then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashloc, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashloc)
    end
end)

-----------------------------------------------------------------------------------

RegisterNetEvent('legends-saloontender:client:musicmenu', function()
    local name = currentname
    local zone = currentzone
    exports['legends-menu']:openMenu({
        {
            header = "💿 | DukeBox Menu",
            isMenuHeader = true,
        },
        {
            header = "🎶 | Play Music",
            txt = "Enter a youtube URL",
            params = {
                event = "legends-saloontender:client:playMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "⏸️ | Pause Music",
            txt = "Pause currently playing music",
            params = {
                event = "legends-saloontender:client:pauseMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "▶️ | Resume Music",
            txt = "Resume playing paused music",
            params = {
                event = "legends-saloontender:client:resumeMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "🔈 | Change Volume",
            txt = "Adjust the volume of the music",
            params = {
                event = "legends-saloontender:client:changeVolume",
                isServer = false,
                args = {},
            }
        },
        {
            header = "❌ | Turn off music",
            txt = "Stop the music & choose a new song",
            params = {
                event = "legends-saloontender:client:stopMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "<< Back",
            txt = '',
            params = {
                event = 'legends-saloontender:client:mainmenu',
            }
        },
    })
end)

RegisterNetEvent('legends-saloontender:client:playMusic', function()
    local dialog = exports['legends-input']:ShowInput({
        header = 'Song Selection',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        TriggerServerEvent('legends-saloontender:server:playMusic', dialog.song, currentname, currentzone)
    end
end)

-- change volume
RegisterNetEvent('legends-saloontender:client:changeVolume', function()
    local dialog = exports['legends-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('legends-saloontender:server:changeVolume', dialog.volume, currentname, currentzone)
    end
end)

-- pause music
RegisterNetEvent('legends-saloontender:client:pauseMusic', function()
    TriggerServerEvent('legends-saloontender:server:pauseMusic', currentname, currentzone)
end)

-- resume music
RegisterNetEvent('legends-saloontender:client:resumeMusic', function()
    TriggerServerEvent('legends-saloontender:server:resumeMusic', currentname, currentzone)
end)

-- stop music
RegisterNetEvent('legends-saloontender:client:stopMusic', function()
    TriggerServerEvent('legends-saloontender:server:stopMusic', currentname, currentzone)
end)
