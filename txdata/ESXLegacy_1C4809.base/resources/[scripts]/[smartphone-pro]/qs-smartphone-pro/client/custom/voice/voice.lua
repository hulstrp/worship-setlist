local pma = exports['pma-voice']
local mumble = exports['mumble-voip']
local toko = exports['tokovoip_script']

function AddToCall(callId)
    if Config.Voice == 'pma' then
        pma:addPlayerToCall(callId)
    elseif Config.Voice == 'mumble' then
        mumble:addPlayerToCall(callId)
    elseif Config.Voice == 'salty' then
        TriggerServerEvent('phone:addToCall', callId)
    elseif Config.Voice == 'toko' then
        toko:addPlayerToRadio(callId)
    end
end

function RemoveFromCall(callId)
    if Config.Voice == 'pma' then
        pma:removePlayerFromCall()
    elseif Config.Voice == 'mumble' then
        mumble:removePlayerFromCall()
    elseif Config.Voice == 'salty' then
        TriggerServerEvent('phone:removeFromCall', callId)
    elseif Config.Voice == 'toko' then
        toko:removePlayerFromRadio(callId)
    end
end
