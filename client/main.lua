-- You can change keys
  local leftkey = 174 -- Default: Left Arrow
  local rightkey = 175 -- Default: Right Arrrow
  local hazards = 173 -- Default: Down Arrow

-- Do not touch anything below this text!

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if IsControlJustPressed(1, leftkey) then 
			if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				TriggerEvent('IND', 'left')
			end
		end

		if IsControlJustPressed(1, rightkey) then 
			if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				TriggerEvent('IND', 'right')
			end
		end
		
		if IsControlJustPressed(1, hazards) then
			if IsPedInAnyVehicle(GetPlayerPed(-1),true) then
				TriggerEvent('IND', 'left')
				TriggerEvent('IND', 'right')
			end
		end
		
    end
end)

local INDL = false
local INDR = false

AddEventHandler('IND', function(dir)
	Citizen.CreateThread(function()
		local Ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(Ped, true) then
			local Veh = GetVehiclePedIsIn(Ped, false)
			if GetPedInVehicleSeat(Veh, -1) == Ped then
				if dir == 'left' then
					INDL = not INDL
					TriggerServerEvent('INDL', INDL)
				elseif dir == 'right' then
					INDR = not INDR
					TriggerServerEvent('INDR', INDR)
				end
			end
		end
	end)
end)

RegisterNetEvent('updateIndicators')
AddEventHandler('updateIndicators', function(PID, dir, Toggle)
		local VehChecker = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(PID)), false)
		if dir == 'left' then
			SetVehicleIndicatorLights(VehChecker, 1, Toggle)
		elseif dir == 'right' then
			SetVehicleIndicatorLights(VehChecker, 0, Toggle)
	end
end)