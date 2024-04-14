if Config.Inventory ~= 'ox_inventory' then
    return
end

ox_inventory = exports['ox_inventory']

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
    Error('You failed to adapt phone to ox_inventory properly! Please check the docs!')
end

function SaveMetadataToInventory(src, customNumber)
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    local slot = 0
    if not items then return Debug('Save metadata to inventory failed. items is nil', 'Player src:', src) end
    local phone = customNumber or MetaData[src].phoneNumber
    for k, v in pairs(items) do
        local meta = v.info and v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            slot = v.slot
            if v.info then
                v.info = MetaData[src]
            else
                v.metadata = MetaData[src]
            end
            break
        end
    end
    ox_inventory:SetMetadata(src, slot, MetaData[src])
end

function RegisterItems() end

RegisterNetEvent('phone:usePhoneItem', function(itemData)
    local src = source
    local identifier = GetIdentifier(src)
    local itemName = itemData.name
    local colorData = Config.Phones[itemName]
    if not Config.UniquePhone then
        local meta = GetDataForWithOutMetaData(src)
        TriggerClientEvent('phone:openPhone', src, colorData, itemName, meta)
        return
    end
    if not itemData.metadata or not itemData.metadata.phoneNumber then return TriggerClientEvent('phone:client:sendTextMessage', src, Lang('PHONE_NOTIFICATION_PHONE_USE_OTHER'), 'error') end
    TriggerClientEvent('phone:openPhone', src, colorData, itemName, itemData.metadata)
end)

exports('handleDeleteItem', function(source, itemData)
    if itemData then
        local metaPhone = MetaData[source]?.phoneNumber
        local itemIsPhone = ItemIsPhone(itemData.name)
        if not itemIsPhone then return end
        local itemPhoneNumber = itemData.info.phoneNumber
        if metaPhone and itemPhoneNumber and itemPhoneNumber == metaPhone then
            MetaData[source] = nil
            TriggerClientEvent('phone:UpdatedMeta', source, nil)
            Debug('Cleared metadata. for: ' .. source)
        end
    else
        local metaPhone = MetaData[source]?.phoneNumber
        local existPhone = FindUserExistPhone(source, metaPhone)
        if not existPhone then
            MetaData[source] = nil
            TriggerClientEvent('phone:UpdatedMeta', source, nil)
            Debug('Cleared metadata. for: ' .. source)
        end
    end
end)

local function getPhoneWithNotPhoneNumber(source)
    local player = GetPlayerFromId(source)
    local items = GetItems(player)
    for a, x in pairs(Config.Phones) do
        for k, v in pairs(items) do
            local meta = v?.info or v?.metadata
            if v.name == a and not meta.phoneNumber then
                return v
            end
        end
    end
    return false
end

RegisterNetEvent('phone:itemAdd', function()
    local src = source
    local item = getPhoneWithNotPhoneNumber(src)
    if not item then return print('OX Error: item is nil') end
    if not item?.metadata.phoneNumber then
        local identifier = GetIdentifier(src)
        local firstname, lastname, phone = GetUserData(identifier)
        if not firstname then return print('OX Error: firstname is nil') end
        local metadata = CreatePhoneMetaData({
            firstname = firstname,
            lastname = lastname,
            identifier = identifier,
        })
        item.metadata = metadata
        metadata.description = Lang('PHONE_NUI_INVENTORY_INFORMATION') .. ' ' .. metadata.phoneNumber
        ox_inventory:SetMetadata(src, item.slot, metadata)
        return
    end
end)
