if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

userTable = 'users'
identifierColumn = 'identifier'
accountsColumn = 'accounts'
if Config.EnablePeds then
    netIdTable = {}
    AddEventHandler('esx:playerLoaded', function(playerId)
        TriggerClientEvent('banking:client:pedHandler', playerId, netIdTable)
    end)
end

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    return player?.identifier
end

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetAccount(player)
    return json.decode(player.accounts)
end

function GetMoney(player, account)
    return player.getAccount(account).money
end

function AddMoney(player, account, amount)
    return player.addAccountMoney(account, amount)
end

function RemoveMoney(player, account, amount)
    return player.removeAccountMoney(account, amount)
end

function AddItem(source, item, count, slot, metadata)
    local player = GetPlayerFromId(source)
    player.addInventoryItem(item, count, metadata, slot)
end
