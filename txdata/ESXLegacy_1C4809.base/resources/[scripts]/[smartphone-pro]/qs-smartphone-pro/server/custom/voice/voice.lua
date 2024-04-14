local salty = exports['saltychat']

RegisterNetEvent('phone:addToCall', function(callId)
    local src = source
    if Config.Voice == 'salty' then
        salty:AddPlayerToCall(tostring(callId), src)
    end
end)

RegisterNetEvent('phone:removeFromCall', function(callId)
    local src = source
    if Config.Voice == 'salty' then
        salty:RemovePlayerFromCall(tostring(callId), src)
    end
end)

RegisterNetEvent('phone:toggleSpeaker', function(enabled)
    local src = source
    if Config.Voice == 'salty' then
        salty:SetPhoneSpeaker(src, enabled == true)
    end
end)
