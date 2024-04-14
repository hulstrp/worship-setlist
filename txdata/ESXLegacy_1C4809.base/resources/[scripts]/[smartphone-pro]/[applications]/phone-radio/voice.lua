local pmaHas = GetResourceState('pma-voice') == 'started'
local mumbleHas = GetResourceState('mumble-voip') == 'started'
local tokoHas = GetResourceState('tokovoip_script') == 'started'
local saltyHas = GetResourceState('saltychat') == 'started'

local pma = exports['pma-voice']
local mumble = exports['mumble-voip']
local toko = exports['tokovoip_script']
local salty = exports['saltychat']

local connectedChannel
local TokoVoipID = nil
RegisterNUICallback('setRadio', function(data, cb)
    if pmaHas and 'pma' then
        pma:setVoiceProperty('radioEnabled', true)
        pma:setRadioChannel(tonumber(data.freq))
        -- exports['rp-radio']:SetRadioEnabled(true)
        -- exports['rp-radio']:SetAllowRadioWhenClosed(true)
        connectedChannel = data.freq
    elseif mumbleHas and 'mumble' then
        mumble:SetRadioChannel(data.freq)
        mumble:SetMumbleProperty('radioEnabled', true)
        -- exports['rp-radio']:SetRadio(true)
        connectedChannel = data.freq
    elseif tokoHas and 'toko' then
        toko:addPlayerToRadio(data.freq + 120)
        TokoVoipID = data.freq + 120
    elseif saltyHas and 'salty' then
        salty:SetRadioChannel(data.freq, true)
        connectedChannel = data.freq
    end
    AddToHistory(data.freq)

    exports['qs-smartphone-pro']:SendTempNotificationOld({
        app = 'radio',
        title = 'Radio',
        text = exports['qs-smartphone-pro']:Lang('PHONE_NOTIFICATION_RADIO_CONNECT'),
        timeout = 2500,
    })
    cb(true)
end)

local function leaveRadio()
    if pmaHas and 'pma' then
        pma:SetRadioChannel(0)
    elseif mumbleHas and 'mumble' then
        mumble:removePlayerFromCall()
    elseif tokoHas and 'toko' then
        toko:removePlayerFromRadio(connectedChannel)
    elseif saltyHas and 'salty' then
        salty:SetRadioChannel('', true)
    end

    connectedChannel = nil
    SetTimeout(1000, function()
        exports['qs-smartphone-pro']:SendTempNotificationOld({
            app = 'radio',
            title = 'Radio',
            text = exports['qs-smartphone-pro']:Lang('PHONE_NOTIFICATION_RADIO_LEAVE'),
            timeout = 2500,
        })
    end)

    cb(true)
end

RegisterNUICallback('leaveRadio', function(data, cb)
    leaveRadio()
    cb(true)
end)

RegisterNUICallback('getHistory', function(data, cb)
    local history = exports['qs-smartphone-pro']:GetMetaData('radioHistory')
    history = history or {}
    cb(history)
end)

function AddToHistory(freq)
    local history = exports['qs-smartphone-pro']:GetMetaData('radioHistory')
    history = history or {}
    table.insert(history, tonumber(freq))
    exports['qs-smartphone-pro']:UpdateMetaData('radioHistory', history)
end

RegisterNUICallback('getPrivateChannels', function(data, cb)
    cb(Config.PrivateChannels)
end)

RegisterNUICallback('checkPrivateChannel', function(data, cb)
    local freq = data.freq
    local pass = data.pass
    local found = false
    for k, v in pairs(Config.PrivateChannels) do
        if v.frequency == freq and v.password == pass then
            found = true
            break
        end
    end
    cb(found)
end)

CreateThread(function()
    local phone = exports['qs-smartphone-pro']
    while true do
        if not connectedChannel then
            Wait(5000)
            goto continue
        end
        local hasPhone = phone:HasPhone()
        if not hasPhone then
            leaveRadio()
        end
        Wait(2000)
        ::continue::
    end
end)
