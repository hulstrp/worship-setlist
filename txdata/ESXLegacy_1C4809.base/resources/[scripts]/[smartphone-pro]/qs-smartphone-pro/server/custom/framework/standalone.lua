--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'standalone' then
    return
end

-- ESX Callbacks
local serverCallbacks = {}

local clientRequests = {}
local RequestId = 0

---@param eventName string
---@param callback function
RegisterServerCallback = function(eventName, callback)
    serverCallbacks[eventName] = callback
end

exports('RegisterServerCallback', RegisterServerCallback)

RegisterNetEvent('qs-smartphone-pro:triggerServerCallback', function(eventName, requestId, invoker, ...)
    if not serverCallbacks[eventName] then
        return print(('[^1ERROR^7] Server Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
    end

    local source = source

    serverCallbacks[eventName](source, function(...)
        TriggerClientEvent('qs-smartphone-pro:serverCallback', source, requestId, invoker, ...)
    end, ...)
end)

---@param player number playerId
---@param eventName string
---@param callback function
---@param ... any
TriggerClientCallback = function(player, eventName, callback, ...)
    clientRequests[RequestId] = callback

    TriggerClientEvent('qs-smartphone-pro:triggerClientCallback', player, eventName, RequestId, GetInvokingResource() or 'unknown', ...)

    RequestId = RequestId + 1
end

RegisterNetEvent('qs-smartphone-pro:clientCallback', function(requestId, invoker, ...)
    if not clientRequests[requestId] then
        return print(('[^1ERROR^7] Client Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
    end

    clientRequests[requestId](...)
    clientRequests[requestId] = nil
end)

function GetCrypto(identifier)
    Debug('GetCrypto used with standalone')
    return 0
end

RegisterServerCallback('qs-smartphone-pro:GetIdentifier', function(source, cb)
    local identifier = GetIdentifier(source)
    cb(identifier)
end)

function RegisterUsableItem(name, cb)
    Debug('RegisterUsableItem is not supported with standalone')
    return false
end

function GetPlayerFromId(source)
    return {
        source = source,
        identifier = GetIdentifier(source)
    }
end

function GetPlayerFromIdentifier(identifier)
    identifier = string.gsub(identifier, ' ', '')
    local players = GetPlayers()
    for k, v in pairs(players) do
        if GetIdentifier(v) == identifier then
            return {
                source = v,
                identifier = identifier
            }
        end
    end
    return nil
end

function GetItem(player, item)
    Debug('GetItem used with standalone')
    return true
end

function AddItem(source, item, count, slot, metadata)
    Debug('AddItem used with standalone')
    return true
end

function AddWeapon(source, weapon, ammo)
    Debug('AddWeapon used with standalone')
    return true
end

function RemoveItem(source, item, count, slot)
    Debug('RemoveItem used with standalone')
    return true
end

function GetBankMoney(source)
    Debug('GetBankMoney used with standalone')
    return 0
end

function SetJob(source, job, grade)
    Debug('SetJob used with standalone')
    return true
end

function AddBankMoney(source, amount)
    Debug('AddBankMoney used with standalone')
    return false
end

function RemoveBankMoney(source, amount)
    Debug('RemoveBankMoney used with standalone')
    return false
end

function GetJobName(source)
    Debug('GetJobName used with standalone')
    return 'unemployed'
end

function IsAdmin(source)
    return IsPlayerAceAllowed(source, 'command.qsphone_admin') == 1
end

function GetIdentifier(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len('license:')) == 'license:' then
            return v:gsub('license:', '')
        end
    end
    return nil
end

function GetStandaloneUserData(identifier)
    local firstname = 'unknown'
    local lastname = 'unknown'
    local phone = Config.Prefix .. math.random(StartDigit, FinishDigit)
    return firstname, lastname, phone
end

function GetItems(player)
    Debug('Get Items used with standalone')
    return {
        {
            name = 'phone'
        }
    }
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
