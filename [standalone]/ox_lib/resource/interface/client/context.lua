local contextMenus = {}
local openContextMenu = nil

---@class ContextMenuItem
---@field title? string
---@field menu? string
---@field icon? string | {[1]: IconProp, [2]: string};
---@field iconColor? string
---@field onSelect? fun(args: any)
---@field arrow? boolean
---@field description? string
---@field metadata? string | { [string]: any } | string[]
---@field disabled? boolean
---@field event? string
---@field serverEvent? string
---@field args? any

---@class ContextMenuArrayItem : ContextMenuItem
---@field title string

---@class ContextMenuProps
---@field id string
---@field title string
---@field menu? string
---@field onExit? fun()
---@field onBack? fun()
---@field canClose? boolean
---@field options { [string]: ContextMenuItem } | ContextMenuArrayItem[]

local function closeContext(_, cb, onExit)
    if cb then cb(1) end

    lib.resetNuiFocus()

    if (cb or onExit) and contextMenus[openContextMenu].onExit then contextMenus[openContextMenu].onExit() end

    if not cb then SendNUIMessage({ action = 'hideContext' }) end

    openContextMenu = nil

    for i=1, 10 do Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0 - (i / 10)); Wait(15) end	-- SET_TIMECYCLE_MODIFIER_STRENGTHs
    Citizen.InvokeNative(0x0E3F4AF2D63491FB)
    DisplayRadar(true)
    DisplayHud(true)
end

---@param id string
function lib.showContext(id)
    if not contextMenus[id] then error('No context menu of such id found.') end

    local data = contextMenus[id]
    openContextMenu = id

    lib.setNuiFocus(false)
    DisplayRadar(false)
    DisplayHud(false)
    Citizen.InvokeNative(0xFA08722A5EA82DA7, 'RespawnLight')   	-- SET_TIMECYCLE_MODIFIER
    for i=0, 10 do Citizen.InvokeNative(0xFDB74C9CC54C3F37, 0.1 + (i / 10)); Wait(15) end	-- SET_TIMECYCLE_MODIFIER_STRENGTHs

    SendNuiMessage(json.encode({
        action = 'showContext',
        data = {
            title = data.title,
            canClose = data.canClose,
            menu = data.menu,
            options = data.options
        }
    }, { sort_keys = true }))
end

---@param context ContextMenuProps | ContextMenuProps[]
function lib.registerContext(context)
    for k, v in pairs(context) do
        if type(k) == 'number' then
            contextMenus[v.id] = v
        else
            contextMenus[context.id] = context
            break
        end
    end
end

---@return string?
function lib.getOpenContextMenu() return openContextMenu end

---@param onExit boolean?
function lib.hideContext(onExit) closeContext(nil, nil, onExit) end

RegisterNUICallback('openContext', function(data, cb)
    if data.back and contextMenus[openContextMenu].onBack then contextMenus[openContextMenu].onBack() end
    cb(1)
    lib.showContext(data.id)
end)

RegisterNUICallback('clickContext', function(id, cb)
    cb(1)

    if math.type(tonumber(id)) == 'float' then
        id = math.tointeger(id)
    elseif tonumber(id) then
        id += 1
    end

    local data = contextMenus[openContextMenu].options[id]

    if not data.event and not data.serverEvent and not data.onSelect then return end

    openContextMenu = nil

    for i=1, 10 do Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0 - (i / 10)); Wait(15) end	-- SET_TIMECYCLE_MODIFIER_STRENGTHs
    Citizen.InvokeNative(0x0E3F4AF2D63491FB)
    DisplayRadar(true)
    DisplayHud(true)

    lib.resetNuiFocus()

    if data.onSelect then data.onSelect(data.args) end
    if data.event then TriggerEvent(data.event, data.args) end
    if data.serverEvent then TriggerServerEvent(data.serverEvent, data.args) end

    SendNUIMessage({
        action = 'hideContext'
    })
end)

RegisterNUICallback('closeContext', closeContext)



