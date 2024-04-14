if Config.Inventory ~= 'core_inventory' then
    return
end

CoreInventory = exports['core_inventory']

function GetUserData(identifier)
    local str = ([[
        SELECT %s FROM %s WHERE %s = ?
    ]]):format(Config.Framework == 'esx' and 'firstname, lastname, phone_number' or 'charinfo', userColumn, identifierTable)
    local result = MySQL.Sync.fetchAll(str, {
        identifier
    })
    result = result[1]
    if not result then return false end
    local firstname, lastname, phone
    if Config.Framework == 'esx' then
        firstname = result.firstname
        lastname = result.lastname
        phone = result.phone_number
    elseif Config.Framework == 'qb' then
        local data = json.decode(result.charinfo)
        firstname = data.firstname
        lastname = data.lastname
        phone = data.phone
    end
    if not phone and Config.Framework == 'esx' then
        phone = Config.Prefix .. math.random(StartDigit, FinishDigit)
        MySQL.Sync.execute('UPDATE `users` SET `phone_number` = ? WHERE `identifier` = ?', {
            phone,
            identifier
        })
    end
    return firstname, lastname, phone
end

function InitPhoneMeta(src, slot, data)
    local identifier = GetIdentifier(src)
    local inventory = 'content-' .. identifier:gsub(':', '')
    CoreInventory:updateMetadata(inventory, slot, data)
    Debug('Init phone meta', src, slot, data)
end

function SaveMetadataToInventory(src, customNumber)
    local identifier = GetIdentifier(src)
    local inventory = 'content-' .. identifier:gsub(':', '')
    local items = CoreInventory:getInventory(inventory)
    if not items then return end
    local phone = customNumber or MetaData[src].phoneNumber
    local itemToUpdate = nil
    for k, v in pairs(items) do
        local meta = v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            itemToUpdate = v
            break
        end
    end
    CoreInventory:updateMetadata(inventory, itemToUpdate.id, MetaData[src])
end

local usedPhone = {} -- This fix for the laggy phone

function RegisterItems()
    for k, v in pairs(Config.Phones) do
        RegisterUsableItem(k, function(source, item, itemData)
            local time = os.time()
            if usedPhone[source] and usedPhone[source] > time then return end
            usedPhone[source] = time + 2
            local player = GetPlayerFromId(source)
            if not type(item) ~= 'table' and type(itemData) == 'table' then
                item = itemData
            end
            item.info = item.metadata
            if not item.info or not item.info?.phoneNumber then
                local identifier = GetIdentifier(source)
                local firstname, lastname = GetUserData(identifier)
                local info = CreatePhoneMetaData({
                    firstname = firstname,
                    lastname = lastname,
                    identifier = identifier,
                })
                item.info = info
                InitPhoneMeta(source, item.id, info)
                Debug('Created phone meta')
            end
            Debug('loading with', item.info.phoneNumber)
            TriggerClientEvent('phone:openPhone', source, v, k, item.info)
        end)
    end
end
