--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    ESX = exports['es_extended']:getSharedObject()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    RefreshableData()
end)

function GetPlayerIdentifier()
    return ESX.GetPlayerData().identifier
end

function GetPlayers()
    return ESX.Game.GetPlayers()
end

function GetJob()
    return {
        name = PlayerData?.job?.name,
        grade = PlayerData?.job?.grade,
        label = PlayerData?.job?.label
    }
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

-- register event to notify player
RegisterNetEvent('qs-billing:client:Notify')
AddEventHandler('qs-billing:client:Notify', function(msg, type)
    SendTextMessage(msg, type)
end)