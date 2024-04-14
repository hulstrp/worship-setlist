if Config.Inventory ~= 'default' then
    return
end

function GetUserData(identifier)
    if Config.Framework == 'standalone' then
        return GetStandaloneUserData(identifier)
    end
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
