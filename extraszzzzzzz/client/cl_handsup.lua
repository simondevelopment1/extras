RegisterCommand('handsup', function()
	if not handsup then
		handsup = true
		ESX.Streaming.RequestAnimDict("missminuteman_1ig_2", function()
			TaskPlayAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
		end) 
		TriggerServerEvent('esx_thief:update', handsup)
	else 
		ClearPedTasks(PlayerPedId())
		handsup = false
		TriggerServerEvent('esx_thief:update', handsup)
	end
end, true)
RegisterKeyMapping('handsup', 'Hands Up/Down', 'keyboard', 'X')