ESX = exports["es_extended"]:getSharedObject()

-- Barbie was here --
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}

local isCarry 				  = false
local hasRope 				  = true
local hasUsedRope 			= true


function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

RegisterNetEvent('esx_barbie_lyftupp:upplyft')
AddEventHandler('esx_barbie_lyftupp:upplyft', function(target)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local lPed = PlayerPedId()
	local dict = "amb@code_human_in_car_idles@low@ps@"
	
	if isCarry == false then
		LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
		TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
		
		AttachEntityToEntity(PlayerPedId(), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
		
		isCarry = true
	else
		DetachEntity(PlayerPedId(), true, false)
		ClearPedTasksImmediately(targetPed)
		ClearPedTasksImmediately(PlayerPedId())
		
		isCarry = false
	end
end)

RegisterNetEvent('esx_barbie_lyftupp')
AddEventHandler('esx_barbie_lyftupp', function()
  OpenActionMenuInteraction()
end)


RegisterCommand("carry", function (target, showError)

	TriggerServerEvent('esx_barbie_lyftupp:lyfteruppn', GetPlayerServerId(player))
	Citizen.Wait(1)
	if hasRope == true then
		local dict = "anim@heists@box_carry@"
				
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end
				
		local player, distance = ESX.Game.GetClosestPlayer()
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
				
		if distance ~= -1 and distance <= 3.0 then
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()
			TriggerServerEvent('esx_barbie_lyftupp:lyfter', GetPlayerServerId(closestPlayer))		
					
			TaskPlayAnim(PlayerPedId(), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
			isCarry = true
		else
			ESX.ShowNotification("No one is nearby...")
		end
	end
end)