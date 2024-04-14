function TogglePhone()
    if isDead() or not canOpenPhone then return end
    if not Config.UniquePhone then
        local phoneData, name = TriggerServerCallbackSync('phone:server:HasPhone')
        if not phoneData then
            SendTextMessage(Lang('PHONE_NOTIFICATION_PHONE_NO_PHONE'), 'error')
            return false
        end
        local meta = TriggerServerCallbackSync('phone:GetPhoneDataForWithoutMeta')
        OpenPhone(phoneData, Config.PhonesProps[name], meta)
        return true
    end
    if not MetaData then
        TriggerServerEvent('phone:server:openRandomItemPhone')
        return
    end
    local phoneData, name = TriggerServerCallbackSync('phone:server:checkHasPhoneWithUniqueId', MetaData.uniqueId)
    if not phoneData then
        if MetaData then
            MetaData = nil
            TriggerServerEvent('phone:server:openRandomItemPhone')
            -- SendTextMessage('Your phone is fucked up', 'inform')
            return
        end
        SendTextMessage(Lang('PHONE_NOTIFICATION_PHONE_NO_PHONE'), 'error')
        return false
    end
    OpenPhone(CurrentPhoneData.type, CurrentPhoneData.phoneColor, MetaData)
    return true
end

if not Config.OpenPhoneByPress and Config.UniquePhone then return end
RegisterKeyMapping('TooglePhone', 'Open phone', 'keyboard', Config.OpenPhone)

RegisterCommand('TooglePhone', TogglePhone, false)
