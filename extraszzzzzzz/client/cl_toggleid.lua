ESX = exports["es_extended"]:getSharedObject()

local forceDraw = false
local shouldDraw = false
local whitelistOnly = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if whitelistOnly then
            if ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.group ~= 'user' then
                shouldDraw = IsControlPressed(0, 121)
            end
        else
            shouldDraw = IsControlPressed(0, 121)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if shouldDraw or forceDraw then
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local x, y, z = table.unpack(v.coords)
                if whitelistOnly then
                    if ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.group ~= 'user' then
                        Draw3DText(x, y, z + 1.1, v.playerId)
                    end
                else
                    Draw3DText(x, y, z + 1.1, v.playerId)
                end
            end
        end
    end
end)

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, _ = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10)
    
    local players_clean = {}
    local found_players = false
    
    for i = 1, #players, 1 do
        found_players = true
        table.insert(players_clean, {playerName = GetPlayerName(players[i]), playerId = GetPlayerServerId(players[i]), coords = GetEntityCoords(GetPlayerPed(players[i]))})
    end
    return players_clean
end
