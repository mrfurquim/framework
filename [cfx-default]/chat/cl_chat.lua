local chatInputActive = false
local chatInputActivating = false
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:addMode')
RegisterNetEvent('chat:removeMode')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg },
      mode = '_global'
    }
  })
end)

-- addMessage
local addMessage = function(message)
  if type(message) == 'string' then
    message = {
      args = { message }
    }
  end

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end

exports('addMessage', addMessage)
AddEventHandler('chat:addMessage', addMessage)

-- addSuggestion
local addSuggestion = function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end

exports('addSuggestion', addSuggestion)
AddEventHandler('chat:addSuggestion', addSuggestion)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addMode', function(mode)
  SendNUIMessage({
    type = 'ON_MODE_ADD',
    mode = mode
  })
end)

AddEventHandler('chat:removeMode', function(name)
  SendNUIMessage({
    type = 'ON_MODE_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  for i=1, 10 do Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0 - (i / 10)); Wait(10) end	-- SET_TIMECYCLE_MODIFIER_STRENGTHs
  Citizen.InvokeNative(0x0E3F4AF2D63491FB)
  DisplayRadar(true)
  DisplayHud(true)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message, data.mode)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) and command.name ~= 'toggleChat' then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init')

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

local CHAT_HIDE_STATES = {
  SHOW_WHEN_ACTIVE = 0,
  ALWAYS_SHOW = 1,
  ALWAYS_HIDE = 2
}

local kvpEntry = GetResourceKvpString('hideState')
local chatHideState = kvpEntry and tonumber(kvpEntry) or CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
local isFirstHide = true

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  local lastChatHideState = -1
  local origChatHideState = -1

  while true do
    Wait(0)

    if not chatInputActive then
      if IsControlPressed(0, `INPUT_MP_TEXT_CHAT_ALL`) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, `INPUT_MP_TEXT_CHAT_ALL`) then
        SetNuiFocus(true)

        DisplayRadar(false)
        DisplayHud(false)
        Citizen.InvokeNative(0xFA08722A5EA82DA7, 'RespawnLight')   	-- SET_TIMECYCLE_MODIFIER
        for i=0, 10 do Citizen.InvokeNative(0xFDB74C9CC54C3F37, 0.1 + (i / 10)); Wait(10) end	-- SET_TIMECYCLE_MODIFIER_STRENGTHs

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local forceHide = IsScreenFadedOut() or IsPauseMenuActive()
      local wasForceHide = false

      if chatHideState ~= CHAT_HIDE_STATES.ALWAYS_HIDE then
        if forceHide then
          origChatHideState = chatHideState
          chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
        end
      elseif not forceHide and origChatHideState ~= -1 then
        chatHideState = origChatHideState
        origChatHideState = -1
        wasForceHide = true
      end

      if chatHideState ~= lastChatHideState then
        lastChatHideState = chatHideState

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          hideState = chatHideState,
          fromUserInteraction = not forceHide and not isFirstHide and not wasForceHide
        })

        isFirstHide = false
      end
    end
  end
end)
