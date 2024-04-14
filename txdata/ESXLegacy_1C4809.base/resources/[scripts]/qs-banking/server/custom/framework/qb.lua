if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

userTable = 'players'
identifierColumn = 'citizenid'
accountsColumn = 'money'

if Config.EnablePeds then
    netIdTable = {}
    AddEventHandler('QBCore:Server:PlayerLoaded', function(playerId)
        TriggerClientEvent('banking:client:pedHandler', playerId, netIdTable)
    end)
end

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    return player?.PlayerData?.citizenid
end

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetPlayerFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function GetAccount(player)
    return json.decode(player.money)
end

function GetMoney(player, account)
    if account == 'money' then account = 'cash' end
    return player.PlayerData.money[account]
end

function AddMoney(player, account, amount)
    if account == 'money' then account = 'cash' end
    return player.Functions.AddMoney(account, amount)
end

function RemoveMoney(player, account, amount)
    if account == 'money' then account = 'cash' end
    return player.Functions.RemoveMoney(account, amount)
end

function AddItem(source, item, count, slot, metadata)
    local player = GetPlayerFromId(source)
    player.Functions.AddItem(item, count, slot, metadata)
end
