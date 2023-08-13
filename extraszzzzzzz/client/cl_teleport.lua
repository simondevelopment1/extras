ESX = exports["es_extended"]:getSharedObject()
--ESX                           = nil

local PlayerData              = {}




RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Teleporters = {
	['Mourge'] = {
		['Job'] = 'ambulance',
		['Enter'] = { 
			['m'] = 42,
			['x'] = -794.33, 
			['y'] = -1245.65, 
			['z'] = 7.34,
			
			['Information'] = '[E] To Enter Morgue',
		},
		['Exit'] = {
			['m'] = 42,
			['x'] = 280.15, 
			['y'] = -1348.81, 
			['z'] = 24.54,
			['Information'] = '[E] To Leave Morgue' 
		} 
	}, 

    ['HospitalHeli'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['m'] = 42,
			['x'] = -798.05, 
			['y'] = -1250.12, 
			['z'] = 7.34,
			
			['Information'] = '[E] To Enter Helipad',
		},
		['Exit'] = {
			['m'] = 42,
			['x'] = -773.71, 
			['y'] = -1207.02, 
			['z'] = 51.15,
			['Information'] = '[E] To Leave Helipad' 
		}
	},
}

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------

function LoadMarkers()
    Citizen.CreateThread(function()
    
        while true do
            sleep = 1000    --Citizen.Wait(5)

            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 5.0 then
                    sleep = 0
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM2(Enter['Information'], Exit['m'], Enter['x'], Enter['y'], Enter['z'])

                            if dstCheckEnter <= 1.0 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'enter')
                                end
                            end

                        end
                    else
                        DrawM2(Enter['Information'], Exit['m'], Enter['x'], Enter['y'], Enter['z'])

                        if dstCheckEnter <= 1.0 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end

                        end

                    end
                end

                if dstCheckExit <= 5.0 then
                    sleep = 0
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM2(Exit['Information'], Exit['m'], Exit['x'], Exit['y'], Exit['z'])

                            if dstCheckExit <= 1.0 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                end
                            end

                        end
                    else

                        DrawM2(Exit['Information'], Exit['m'], Exit['x'], Exit['y'], Exit['z'])

                        if dstCheckExit <= 1.0 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end

                        end
                    end
                end

            end
            Citizen.Wait(sleep)

        end

    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(1000)

        Citizen.Wait(1000)
		
        ESX.Game.Teleport(PlayerPedId(), table['Exit'])
		FreezeEntityPosition(PlayerPedId(), true)
        DoScreenFadeIn(3000)
		Citizen.Wait(1000)
		FreezeEntityPosition(PlayerPedId(), false)
    else
		DoScreenFadeOut(1000)

        Citizen.Wait(1000)

        ESX.Game.Teleport(PlayerPedId(), table['Enter'])
		FreezeEntityPosition(PlayerPedId(), true)
		DoScreenFadeIn(3000)
		Citizen.Wait(1000)
		FreezeEntityPosition(PlayerPedId(), false)
    end
end


function DrawM2(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 0, 0, 100, false, true, 2, true, false, false, false)
end