local hurt = false
local player = PlayerPedId()
local injuredcounter = 0
Citizen.CreateThread(function()
while true do
if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
setHurt()
StillInjured = true
elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
setNotHurt()
end
Citizen.Wait(500)
end
end)

function setHurt()
hurt = true
RequestAnimSet("move_m@injured")
SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

Citizen.CreateThread(function()
	while true do
		if injuredcounter == 20000 then
		ApplyDamageToPed(GetPlayerPed(-1),  23, false)
		elseif injuredcounter == 36000 then
		local ped = GetPlayerPed(-1)
 		local currentHealth = GetEntityHealth(ped)
		GetEntityHealth(ped, currentHealth - 5)
        Citizen.Wait(5000)
		elseif injuredcounter == 54000 then -- 54000
			ApplyDamageToPed(player, 800, false)
		end
		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if StillInjured then
		injuredcounter = injuredcounter + 1
		else
			Citizen.Wait(1000)
		end
	end
end)

function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function setNotHurt()
hurt = false
StillInjured = false
injuredcounter = 0
ResetPedMovementClipset(GetPlayerPed(-1))
ResetPedWeaponMovementClipset(GetPlayerPed(-1))
ResetPedStrafeClipset(GetPlayerPed(-1))
SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end