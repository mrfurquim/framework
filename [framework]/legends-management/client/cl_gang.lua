local RSGCore = exports['legends-core']:GetCoreObject()
local PlayerGang = RSGCore.Functions.GetPlayerData().gang
local shownGangMenu = false
local DynamicMenuItems = {}
local gangmenu

Citizen.CreateThread(function()
     for gangmenu, v in pairs(Config.GangLocations) do
         exports['legends-core']:createPrompt(v.gangname, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
             type = 'client',
             event = 'legends-gangmenu:client:OpenMenu',
             args = { },
         })
         if v.showblip == true then
             local GangBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
             SetBlipSprite(GangBlip, GetHashKey("blip_honor_bad"), true)
             SetBlipScale(GangBlip, 0.2)
			 Citizen.InvokeNative(0x9CB1A1623062F402, GangBlip, v.name)
         end
     end
end)

-- UTIL
local function CloseMenuFullGang()
    exports['legends-menu']:closeMenu()
    exports['legends-core']:HideText()
    shownGangMenu = false
end

local function comma_valueGang(amount)
    local formatted = amount
    while true do
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

--//Events
AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerGang = RSGCore.Functions.GetPlayerData().gang
    end
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    PlayerGang = RSGCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('RSGCore:Client:OnGangUpdate', function(InfoGang)
    PlayerGang = InfoGang
end)

RegisterNetEvent('legends-gangmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
        maxweight = 4000000,
        slots = 100,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
end)

RegisterNetEvent('legends-gangmenu:client:Warbobe', function()
    TriggerEvent('legends-clothes:OpenOutfits')
end)

local function AddGangMenuItem(data, id)
    local menuID = id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

exports("AddGangMenuItem", AddGangMenuItem)

local function RemoveGangMenuItem(id)
    DynamicMenuItems[id] = nil
end

exports("RemoveGangMenuItem", RemoveGangMenuItem)

RegisterNetEvent('legends-gangmenu:client:OpenMenu', function()
    shownGangMenu = true
    local gangMenu = {
        {
            header = "Gang Management  - " .. string.upper(PlayerGang.label),
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Manage Gang Members",
            icon = "fa-solid fa-list",
            txt = "Recruit or Fire Gang Members",
            params = {
                event = "legends-gangmenu:client:ManageGang",
            }
        },
        {
            header = "Recruit Members",
            icon = "fa-solid fa-hand-holding",
            txt = "Hire Gang Members",
            params = {
                event = "legends-gangmenu:client:HireMembers",
            }
        },
        {
            header = "Storage Access",
            icon = "fa-solid fa-box-open",
            txt = "Open Gang Stash",
            params = {
                event = "legends-gangmenu:client:Stash",
            }
        },
        {
            header = "Outfits",
            txt = "Change Clothes",
            icon = "fa-solid fa-shirt",
            params = {
                event = "legends-gangmenu:client:Warbobe",
            }
        },
        {
            header = "Money Management",
            icon = "fa-solid fa-sack-dollar",
            txt = "Check your Gang Balance",
            params = {
                event = "legends-gangmenu:client:SocietyMenu",
            }
        },
    }

    for _, v in pairs(DynamicMenuItems) do
        gangMenu[#gangMenu + 1] = v
    end

    gangMenu[#gangMenu + 1] = {
        header = "Exit",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "legends-menu:closeMenu",
        }
    }

    exports['legends-menu']:openMenu(gangMenu)
end)

RegisterNetEvent('legends-gangmenu:client:ManageGang', function()
    local GangMembersMenu = {
        {
            header = "Manage Gang Members - " .. string.upper(PlayerGang.label),
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
    }
    RSGCore.Functions.TriggerCallback('legends-gangmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            GangMembersMenu[#GangMembersMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "legends-gangmenu:lient:ManageMember",
                    args = {
                        player = v,
                        work = PlayerGang
                    }
                }
            }
        end
        GangMembersMenu[#GangMembersMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "legends-gangmenu:client:OpenMenu",
            }
        }
        exports['legends-menu']:openMenu(GangMembersMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('legends-gangmenu:lient:ManageMember', function(data)
    local MemberMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    for k, v in pairs(RSGCore.Shared.Gangs[data.work.name].grades) do
        MemberMenu[#MemberMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "legends-gangmenu:server:GradeUpdate",
                icon = "fa-solid fa-file-pen",
                args = {
                    cid = data.player.empSource,
                    grade = tonumber(k),
                    gradename = v.name
                }
            }
        }
    end
    MemberMenu[#MemberMenu + 1] = {
        header = "Fire",
        icon = "fa-solid fa-user-large-slash",
        params = {
            isServer = true,
            event = "legends-gangmenu:server:FireMember",
            args = data.player.empSource
        }
    }
    MemberMenu[#MemberMenu + 1] = {
        header = "Return",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "legends-gangmenu:client:ManageGang",
        }
    }
    exports['legends-menu']:openMenu(MemberMenu)
end)

RegisterNetEvent('legends-gangmenu:client:HireMembers', function()
    local HireMembersMenu = {
        {
            header = "Hire Gang Members - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    RSGCore.Functions.TriggerCallback('legends-gangmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMembersMenu[#HireMembersMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    icon = "fa-solid fa-user-check",
                    params = {
                        isServer = true,
                        event = "legends-gangmenu:server:HireMember",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMembersMenu[#HireMembersMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "legends-gangmenu:client:OpenMenu",
            }
        }
        exports['legends-menu']:openMenu(HireMembersMenu)
    end)
end)

RegisterNetEvent('legends-gangmenu:client:SocietyMenu', function()
    RSGCore.Functions.TriggerCallback('legends-gangmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_valueGang(cb) .. " - " .. string.upper(PlayerGang.label),
                isMenuHeader = true,
                icon = "fa-solid fa-circle-info",
            },
            {
                header = "Deposit",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Deposit Money",
                params = {
                    event = "legends-gangmenu:client:SocietyDeposit",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "Withdraw",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Withdraw Money",
                params = {
                    event = "legends-gangmenu:client:SocietyWithdraw",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "Return",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "legends-gangmenu:client:OpenMenu",
                }
            },
        }
        exports['legends-menu']:openMenu(SocietyMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('legends-gangmenu:client:SocietyDeposit', function(saldoattuale)
    local deposit = exports['legends-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. saldoattuale,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("legends-gangmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('legends-gangmenu:client:SocietyWithdraw', function(saldoattuale)
    local withdraw = exports['legends-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. saldoattuale,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = '$'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("legends-gangmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)
