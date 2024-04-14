if Config.Inventory ~= 'qb-inventory' then
    return
end

function GetUserData(identifier)
    local str = ([[
        SELECT charinfo FROM players WHERE citizenid = ?
    ]])
    local result = MySQL.Sync.fetchAll(str, {
        identifier
    })
    if not result[1] then return false end
    local charinfo = json.decode(result[1].charinfo)
    Debug('GetUserData', identifier, 'firstname', charinfo.firstname, 'lastname', charinfo.lastname)
    return charinfo.firstname, charinfo.lastname, charinfo.phone
end

function InitPhoneMeta(src, slot, data)
    local player = GetPlayerFromId(src)
    player.PlayerData.items[slot].info.metadata = data.metadata
    player.PlayerData.items[slot].info.charinfo = data.charinfo
    player.PlayerData.items[slot].info.phoneNumber = data.phoneNumber
    player.PlayerData.items[slot].info.owneridentifier = data.owneridentifier
    player.Functions.SetInventory(player.PlayerData.items)
    Debug('Init phone meta', src, slot, data)
end

function SaveMetadataToInventory(src, customNumber)
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    if not items then return end
    local phone = customNumber or MetaData[src].phoneNumber
    for k, v in pairs(items) do
        local meta = v.info and v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            if v.info then
                v.info = MetaData[src]
            else
                v.metadata = MetaData[src]
            end
            break
        end
    end
    player.Functions.SetInventory(items)
end

function RegisterItems()
    for k, v in pairs(Config.Phones) do
        RegisterUsableItem(k, function(source, item)
            local player = GetPlayerFromId(source)
            if not item?.info or not item?.info?.phoneNumber then
                local identifier = GetIdentifier(source)
                local firstname, lastname = GetUserData(identifier)
                local info = CreatePhoneMetaData({
                    firstname = firstname,
                    lastname = lastname,
                    identifier = identifier,
                })
                item.info = info
                InitPhoneMeta(source, item.slot, info)
                Debug('Created phone meta')
            end
            TriggerClientEvent('phone:openPhone', source, v, k, item.info)
        end)
    end
end

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
