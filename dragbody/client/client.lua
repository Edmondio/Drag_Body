ESX = exports["es_extended"]:getSharedObject()

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
	--
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if 10.0 > distance and IsPedDeadOrDying(target, 0) then
                closestPlayer = value
				break
            end
        end
    end
	--
    return closestPlayer
end

function GetPlayers()
    local players = {}
	--
    for i = 0, 1024 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
	--
    return players
end

local drag = false
local draggingPed = nil
local animFinished = false
local draggingPlayer = nil
local Player = nil


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        local p1 = PlayerPedId()
		
		if not IsPedDeadOrDying(p1) and not drag then
			local p1pos	= GetEntityCoords(p1)
			local p2 = GetPlayerPed(Player)
			local p2pos = GetEntityCoords(p2)

			if GetDistanceBetweenCoords(p2pos, p1pos, true) <= 10.0 then
				if IsPedDeadOrDying(p2, 0) then
					if GetEntityHealth(p2) <= 6 then
						SetEntityInvincible(p2, true)
						if GetDistanceBetweenCoords(p2pos, p1pos, true) <= 3.0 then
							DrawTextt3DBody(p2pos.x, p2pos.y, p2pos.z, '~w~[~b~E~w~] Tirer')
							if IsControlJustPressed(0, 206) then
								drag = true
								draggingPed = p2
								draggingPlayer = Player
								while not HasAnimDictLoaded('combat@drag_ped@') do
									RequestAnimDict('combat@drag_ped@')
									Wait(0)
								end
								local duration = 5700
								DrawTextt3DBody(p2pos.x, p2pos.y, p2pos.z, '~w~[~b~G~w~] Lacher')
								TaskPlayAnim(p1, 'combat@drag_ped@', 'injured_pickup_back_plyr', 2.0, 2.0, duration, 1, 0, false, false, false)
								TriggerServerEvent('bodydrag-server:attach', GetPlayerServerId(Player))
								Citizen.Wait(duration)
								animFinished = true
								TaskPlayAnim(p1, 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, -1, 1, 0, false, false, false)
							end
						end
					end
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	local sleep = 500
	while true do
		if Player == nil then
			sleep = 500
			Player = GetClosestPlayer()
		else
			Player = GetClosestPlayer()
			sleep = 1000
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	local sleep = 5000
	while true do
		if drag and animFinished then
			local playerPed = PlayerPedId()
			sleep = 7
			if IsControlPressed(0, 30) then
				SetEntityHeading(playerPed, GetEntityHeading(playerPed)+0.5)
			elseif IsControlPressed(0, 34) then
				SetEntityHeading(playerPed, GetEntityHeading(playerPed)-0.5)
			end
			if IsControlJustPressed(0, 47) then
				drag = false
				animFinished = false
				draggingPed = nil
				RequestAnimDict('combat@drag_ped@')
				TaskPlayAnim(playerPed, 'combat@drag_ped@', 'injured_putdown_plyr', 2.0, 2.0, 5500, 1, 0, false, false, false)
				TriggerServerEvent('bodydrag-server:deattach', GetPlayerServerId(draggingPlayer))
				draggingPlayer = nil
			end
		else
			sleep = 1000
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('bodydrag:attach')
AddEventHandler('bodydrag:attach', function(who)
	local p1 = PlayerPedId()
	local p2 = GetPlayerPed(GetPlayerFromServerId(who))
	print(p2)
	local coords = GetEntityCoords(p1)
	local coords2 = GetEntityCoords(p2)
	SetEntityCoordsNoOffset(p1, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(p2), true, false)
	SetEntityHeading(p1, GetEntityHeading(p2))
	SetEntityHealth(p1, GetPedMaxHealth(p1))
	
	AttachEntityToEntity(p1, p2, 11816, 0.0, 0.5, 0.0, GetEntityRotation(coords2), false, false, true, false, 2, false)
	
	while not HasAnimDictLoaded('combat@drag_ped@') do
		RequestAnimDict('combat@drag_ped@')
		Wait(0)
	end
	TaskPlayAnim(p1, 'combat@drag_ped@', 'injured_pickup_back_ped', 2.0, 2.0, -1, 1, 0, false, false, false)
	Citizen.Wait(5700)
	TaskPlayAnim(p1, 'combat@drag_ped@', 'injured_drag_ped', 2.0, 2.0, -1, 1, 0, false, false, false)
	--TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
end)

RegisterNetEvent('bodydrag:deattach')
AddEventHandler('bodydrag:deattach', function(who)
	local p1 = PlayerPedId()
	local p2 = GetPlayerPed(GetPlayerFromServerId(who))
	RequestAnimDict('combat@drag_ped@')
	TaskPlayAnim(p1, 'combat@drag_ped@', 'injured_putdown_ped', 2.0, 2.0, 5700, 1, 0, false, false, false)
	Citizen.Wait(5700)
	DetachEntity(p1, true, true)
	SetEntityHealth(p1, 0)
	--TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
end)

function DrawTextt3DBody(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(8)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 255, 51, 51, 80)
    ClearDrawOrigin()
end

