--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

Citizen.CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    DebugPrint(val)
    PlayerData = val
    RefreshableData()
end)


function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetJob()
    return {
        name = PlayerData?.job?.name,
        grade = PlayerData?.job?.grade?.level,
        label = PlayerData?.job?.label
    }
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end

-- register event to notify player
RegisterNetEvent('qs-billing:client:Notify')
AddEventHandler('qs-billing:client:Notify', function(msg, type)
    SendTextMessage(msg, type)
end)