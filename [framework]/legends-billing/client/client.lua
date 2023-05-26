local RSGCore = exports['legends-core']:GetCoreObject()
local jobcheck = false

-- billing menu
RegisterNetEvent('legends-billing:client:billingMenu', function()
    local PlayerId = GetPlayerServerId(PlayerId())
    local BillsOptions = {
        {
            header = 'Billing Menu',
            isMenuHeader = true,
            icon = 'fas fa-file-invoice-dollar',
        },
        {
            header = 'Send Bill',
            icon = 'fas fa-dollar-sign',
            txt    = '',
            params = { event = 'legends-billing:client:billplayer' }
        },
        {
            header = 'View Your Bills',
            icon = 'fas fa-dollar-sign',
            txt    = '',
            params = { event = 'legends-billing:client:checkbills' }
        },
        {
            header = 'Cancel Sent Bill',
            icon = 'fas fa-dollar-sign',
            txt    = '',
            params = { event = 'legends-billing:client:deletebills' }
        },
        {
            header = 'close',
            icon   = 'fa-solid fa-circle-xmark',
            txt    = '',
            params = { event = 'legends-menu:closeMenu', }
        },
    }
    exports['legends-menu']:openMenu(BillsOptions)
end)

-- send bill to player (client:billplayer)
RegisterNetEvent('legends-billing:client:billplayer', function()
    local dialog = exports['legends-input']:ShowInput({
    header = "Create Bill",
    submitText = "Send Bill",
        inputs = {
            {
                text = "PlayerID",
                name = "playerid",
                type = "number",
                isRequired = false,
            },
            {
                text = "Bill Price ($)",
                name = "billprice",
                type = "number",
                isRequired = false,
            },
            {
                text = "Bill Type",
                name = "billtype",
                type = "radio",
                options = {
                    { value = "player", text = "Bill as Player" },
                    { value = "society", text = "Bill as Society" },
                },
            },
        }
    })
    if dialog == nil then return end
    if dialog == "" then 
        return 
        --RSGCore.Functions.Notify("you didn't write anything", 'error') end
         TriggerEvent('Notification:Legends','Ops..' , 'Você não escreveu nada' , 'menu_textures', 'cross', 3000)
     end
    if dialog.playerid == "" then 
        return -- RSGCore.Functions.Notify("you didn't write the player id", 'error')
        TriggerClientEvent('Notification:Legends','Ops..' , 'Você não escreveu o PlayerID' , 'menu_textures', 'cross', 3000)
     end
    if dialog.billprice == "" then 
        return --RSGCore.Functions.Notify("you didn't write the bill price", 'error')
        TriggerClientEvent('Notification:Legends','Ops..' , 'Você não colocou o valor da cobrança' , 'menu_textures', 'cross', 3000)
     end
    if dialog.billtype == 'society' then
        local playerjob = RSGCore.Functions.GetPlayerData().job.name
        jobcheck = false
        for _, name in pairs(Config.VerifySociety) do
            if name == playerjob then
                jobcheck = true
            end
        end
        if jobcheck == true then
            TriggerServerEvent('legends-billing:server:sendSocietyBill', dialog.playerid, dialog.billprice, playerjob)    
        else
            RSGCore.Functions.Notify('you are not part of a society!', 'error')
        end
    end
    if dialog.billtype == 'player' then
        TriggerServerEvent('legends-billing:server:sendPlayerBill', dialog.playerid, dialog.billprice)
    end
end, false)

-- check bills with callback (client:checkbills)
RegisterNetEvent('legends-billing:client:checkbills', function()
    local PlayerId = GetPlayerServerId(PlayerId())
    RSGCore.Functions.TriggerCallback('legends-billing:server:checkbills', function(bills, cid)
        local BillsShow = {
            {
                header = 'Unpaid Bills | ID: ' .. PlayerId,
                isMenuHeader = true,
                icon = 'fas fa-file-invoice-dollar',
            },
            {
                header = 'Citizen ID: ' .. cid,
                isMenuHeader = true,
                icon = 'fas fa-id-card-clip',
            },
        }
        
        for _, v in ipairs(bills) do
            BillsShow[#BillsShow + 1] = {
                header = 'Amount: ' .. v.amount .. '$',
                icon = 'fas fa-dollar-sign',
                txt = 'ID : ' ..v.id ..' | From : ' .. v.sender .. ' | ' .. v.society,
                params = { event = 'legends-billing:server:paybills', 
                    isServer = true,
                    args = {
                        sender = v.sender, 
                        amount = v.amount, 
                        billid = v.id, 
                        society = v.society,
                        citizenid = v.citizenid,
                        sendercitizenid = v.sendercitizenid
                    } 
                }
            }
        end

        BillsShow[#BillsShow + 1] = {
            header = 'Close',
            icon   = 'fa-solid fa-circle-xmark',
            txt    = '',
            params = { event = 'legends-menu:closeMenu', }
        }

        exports['legends-menu']:openMenu(BillsShow)
    end, PlayerId)
end)

-- cancel bills with callback -> cancel bill confirm
RegisterNetEvent('legends-billing:client:deletebills', function()

    RSGCore.Functions.TriggerCallback('legends-billing:server:checkSentBills', function(sentbills, citizenid)

        local SentBillsShow = {
            {
                header = 'Sent Bills',
                isMenuHeader = true,
                icon = 'fas fa-file-invoice-dollar',
            },
            {
                header = 'Citizen ID: ' .. citizenid,
                isMenuHeader = true,
                icon = 'fas fa-id-card-clip',
            },
        }
        
        for _, v in ipairs(sentbills) do
            SentBillsShow[#SentBillsShow + 1] = {
                header = 'Amount: ' .. v.amount .. '$',
                icon = 'fas fa-dollar-sign',
                txt = 'ID : ' .. v.id .. ' | To : ' .. v.citizenid,
                params = { event = 'legends-billing:client:cancelbill', 
                    isServer = false,
                    args = {
                        billid = v.id,
                    } 
                }
            }
        end

        SentBillsShow[#SentBillsShow + 1] = {
            header = 'Close',
            icon   = 'fa-solid fa-circle-xmark',
            txt    = '',
            params = { event = 'legends-menu:closeMenu', }
        }

        exports['legends-menu']:openMenu(SentBillsShow)
    end)
	
end)

-- cancel bill confirm
RegisterNetEvent('legends-billing:client:cancelbill', function(data)
    local dialog = exports['legends-input']:ShowInput({
        header = "Cancel Bill",
        submitText = "Submit",
        inputs = {
            {
                text = "Bill ID : "..data.billid,
                name = "cancelbill",
                type = "radio",
                options = {
                    { value = "yes", text = "Yes" },
                    { value = "no", text = "No" },
                },
            },
        },
    })

    if dialog ~= nil then
        if Config.Debug == true then
            print(dialog.cancelbill)
            print(data.billid)
        end
        if dialog.cancelbill == 'yes' then
            TriggerServerEvent('legends-billing:server:cancelbill', tonumber(data.billid))
            RSGCore.Functions.Notify('Bill Canceled!', 'primary')
        else
            RSGCore.Functions.Notify('Bill not canceled!', 'primary')
            return
        end
    end
end, false)
