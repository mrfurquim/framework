
local show = false

RegisterNetEvent("menu:id:start")
AddEventHandler("menu:id:start", function()  --target1
	show = not show
	if show then
       TriggerServerEvent("identity:getInfo")
       Wait(250)
    else
      TriggerEvent("identity:hideInfo")
	  Wait(250)
    end
end)


RegisterNetEvent("menu:id:get")              --target1
AddEventHandler("menu:id:get", function()
	show = not show
	if show then
		local closestPlayer, closestDistance = GetClosestPlayer()
		if (closestPlayer ~= nil and closestPlayer ~= -1) and (closestDistance < 10) then
			local destSource = GetPlayerServerId(closestPlayer)
			TriggerServerEvent("identity:getInfoAnother", destSource)
		end
	else
		TriggerEvent("identity:hideInfo")
		Wait(250)
	end
end)

RegisterNetEvent("identity:showInfo")
AddEventHandler("identity:showInfo", function(completename,birthdate, corsivo, citizenid)
	
	local gender 
	if IsPedMale(PlayerPedId()) then 
		gender = "Homem" 
	else 
		gender = "Mulher" 
	end
	
	SendNUIMessage(
		{
			type = "ui",
			display = true,
			completename = completename,
			birthdate = birthdate,
			corsivo = corsivo,
			gender1 = gender,
			citizenid = citizenid
			
		}
	)
	Citizen.Wait(6000)
	SendNUIMessage({action = "close"})
end)

RegisterNetEvent("identity:hideInfo")
AddEventHandler("identity:hideInfo", function()
    SendNUIMessage({
        type = "ui",
        display = false
    })
end)



function GetClosestPlayer()

	local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
	local playerPed, playerId = PlayerPedId(), PlayerId()
	local coords, usePlayerPed = coords, false
    
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end
    
	for i=1, #players, 1 do

		local target = GetPlayerPed(players[i])

		if IsPlayerTargettingEntity(PlayerId(), target, false) then
			local targetCoords = GetEntityCoords(target)
			local distance = #(coords - targetCoords)
			return players[i], distance
		end

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

			local targetCoords = GetEntityCoords(target)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end

		end

	end
	return closestPlayer, closestDistance
end