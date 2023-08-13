function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', '~p~CSX Development ~p~| ~r~ID: ' .. GetPlayerServerId(PlayerId()).. ' ~y~| https://discord.gg/gcFm6Z8ns9')
end)