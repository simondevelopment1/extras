ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('id', function(source, args, rawCommand)
	local src = source	
	TriggerClientEvent('csx_functionsnotify:Alert', src, "SYSTEM", "Your ID is "..src, 10000, 'info')
end)

RegisterCommand('jobs', function(source, args, rawCommand)
	local src = source	
	local xPlayer = ESX.GetPlayerFromId(src)
	TriggerClientEvent('csx_functionsnotify:Alert', src, "SYSTEM", "Your job is "..xPlayer.job.name, 10000, 'info')
end)