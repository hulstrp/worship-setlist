--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'esx' then
    return
end

ESX = nil

local legacyEsx = pcall(function()
    ESX = exports['es_extended']:getSharedObject()
end)
if not legacyEsx then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

identifierTable = 'identifier'
userColumn = 'users'

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

exports('RegisterServerCallback', RegisterServerCallback)

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerFromIdentifier(identifier)
    identifier = string.gsub(identifier, ' ', '')
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetItem(player, item)
    return player.getInventoryItem(item)
end

function GetCrypto(identifier)
    local str = ([[
        SELECT cryptocurrency FROM %s WHERE %s = ? LIMIT 1
    ]]):format(userColumn, identifierTable)
    local result = MySQL.Sync.fetchAll(str, { identifier })
    if not result[1] or not result[1].cryptocurrency then
        return 0
    end
    return result[1].cryptocurrency
end

function AddItem(source, item, count, slot, metadata)
    local player = GetPlayerFromId(source)
    player.addInventoryItem(item, count, metadata, slot)
end

function AddWeapon(source, weapon, ammo)
    local player = GetPlayerFromId(source)
    player.addWeapon(weapon, ammo)
end

function RemoveItem(source, item, count, slot)
    local player = GetPlayerFromId(source)
    player.removeInventoryItem(item, count, nil, slot)
end

function GetBankMoney(source)
    local player = GetPlayerFromId(source)
    return player.getAccount('bank').money
end

function SetJob(source, job, grade)
    local player = GetPlayerFromId(source)
    player.setJob(job, grade)
end

function AddBankMoney(source, amount)
    local player = GetPlayerFromId(source)
    player.addAccountMoney('bank', amount)
end

function RemoveBankMoney(source, amount)
    local player = GetPlayerFromId(source)
    player.removeAccountMoney('bank', amount)
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    if not player then return 'unemployed' end
    return player.getJob().name
end

function IsAdmin(source)
    local player = GetPlayerFromId(source)
    return player.getGroup() == 'admin'
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        print('ESX player not found. Source: ', source)
        return false
    end
    return player.identifier
end

function GetItems(player)
    if not player then return end
    local inventory = player.getInventory()
    for k, v in pairs(inventory) do
        local amount = v.amount or v.count
        if tonumber(amount) <= 0 then
            inventory[k] = nil
        end
    end
    return inventory
end

function GetPlayerSource(player)
    return player.source
end

function GetDataForWithOutMetaData(source)
    local player = GetPlayerFromId(source)
    local identifier = GetIdentifier(source)
    local result = MySQL.Sync.fetchAll('SELECT * FROM phone_metadata WHERE identifier = ?', {
        identifier
    })
    result = result[1]
    if result then return json.decode(result.metadata) end
    local info
    local firstname, lastname, phone = GetUserData(identifier)
    info = CreatePhoneMetaData({
        firstname = firstname,
        lastname = lastname,
        identifier = identifier,
        phone = phone
    })
    MySQL.Async.execute('INSERT INTO phone_metadata (identifier, metadata, phoneNumber) VALUES (?, ?, ?)', {
        identifier,
        json.encode(info),
        info.phoneNumber
    })
    return info
end
