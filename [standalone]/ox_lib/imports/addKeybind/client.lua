---@diagnostic disable: param-type-mismatch
---@class KeybindProps
---@field name string
---@field description string
---@field defaultKey? string
---@field disabled? boolean
---@field disable? fun(self: CKeybind, toggle: boolean)
---@field onPressed? fun(self: CKeybind)
---@field onReleased? fun(self: CKeybind)
---@field [string] any

---@class CKeybind : KeybindProps
---@field currentKey string
---@field disabled boolean
---@field hash number
---@field getCurrentKey fun(): string

local keybinds = {}

local function disableKeybind(self, toggle)
    keybinds[self.name].disabled = toggle
end

local IsPauseMenuActive = IsPauseMenuActive

local keybind_mt = {
    disabled = false,
}

function keybind_mt:__index(index)
    local value = keybind_mt[index]

    if value then
        return value
    end

    if index == 'currentKey' then
        return self:getCurrentKey()
    end
end

if cache.game == 'redm' then
    ---@param data KeybindProps
    ---@return CKeybind
    function lib.addKeybind(data)
        if not data.hash then return error("No keybind key defined") --[[@as CKeybind]] end
   
        data.disabled = data.disabled
        data.disable = disableKeybind
        keybinds[data.name] = setmetatable(data, keybind_mt)

        return data --[[@as CKeybind]]
    end
    CreateThread(function()
        while true do
            Wait(0)
            for k, v in pairs(keybinds) do
                if IsControlJustReleased(0, v.hash) then
                    if not v.onReleased or v.disabled or IsPauseMenuActive() then goto continue end
                    v:onReleased()
                end

                if IsControlJustPressed(0, v.hash) then
                    if not v.onPressed or v.disabled or IsPauseMenuActive() then goto continue end
                    v:onPressed()
                end

                ::continue::
            end
        end
    end)    
else
    ---@param data KeybindProps
    ---@return CKeybind
    function lib.addKeybind(data)
        if not data.defaultKey then data.defaultKey = '' end

        RegisterCommand('+' .. data.name, function()
            if not data.onPressed or data.disabled or IsPauseMenuActive() then return end
            data:onPressed()
        end)

        RegisterCommand('-' .. data.name, function()
            if not data.onReleased or data.disabled or IsPauseMenuActive() then return end
            data:onReleased()
        end)

        RegisterKeyMapping('+' .. data.name, data.description, 'keyboard', data.defaultKey)

        SetTimeout(500, function()
            TriggerEvent('chat:removeSuggestion', ('/+%s'):format(data.name))
            TriggerEvent('chat:removeSuggestion', ('/-%s'):format(data.name))
        end)

        data.hash = joaat('+' .. data.name) | 0x80000000
        data.disabled = data.disabled
        data.disable = disableKeybind
        keybinds[data.name] = setmetatable(data, keybind_mt)

        return data --[[@as CKeybind]]
    end
end

return lib.addKeybind