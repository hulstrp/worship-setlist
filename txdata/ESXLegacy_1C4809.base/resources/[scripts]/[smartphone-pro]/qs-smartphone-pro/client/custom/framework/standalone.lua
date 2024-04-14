--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'standalone' then
    return
end
local RequestId = 0
local serverRequests = {}

local clientCallbacks = {}

---@param eventName string
---@param callback function
---@param ... any
TriggerServerCallback = function(eventName, callback, ...)
    serverRequests[RequestId] = callback

    TriggerServerEvent('qs-smartphone-pro:triggerServerCallback', eventName, RequestId, GetInvokingResource() or 'unknown', ...)

    RequestId = RequestId + 1
end

exports('TriggerServerCallback', TriggerServerCallback)

RegisterNetEvent('qs-smartphone-pro:serverCallback', function(requestId, invoker, ...)
    if not serverRequests[requestId] then
        return print(('[^1ERROR^7] Server Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
    end

    serverRequests[requestId](...)
    serverRequests[requestId] = nil
end)

---@param eventName string
---@param callback function
_RegisterClientCallback = function(eventName, callback)
    clientCallbacks[eventName] = callback
end

RegisterNetEvent('qs-smartphone-pro:triggerClientCallback', function(eventName, requestId, invoker, ...)
    if not clientCallbacks[eventName] then
        return print(('[^1ERROR^7] Client Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
    end

    clientCallbacks[eventName](function(...)
        TriggerServerEvent('qs-smartphone-pro:clientCallback', requestId, invoker, ...)
    end, ...)
end)

function isDead()
    return IsPedDeadOrDying(PlayerPedId(), false) or IsEntityDead(PlayerPedId()) or IsPauseMenuActive() or LocalPlayer.state.dead
end

function GetHungry()
    Debug('GetHungry is used with standalone')
    return 100
end

function GetThirsty()
    Debug('GetThirsty is used with standalone')
    return 100
end

function GetPlayerData()
    return {}
end

function GetJobName()
    Debug('GetJobName is used with standalone')
    return 'unemployed'
end

function GetMoney()
    Debug('GetMoney is used with standalone')
    return 0
end

function GetVehicles() -- Leave the function for compatibility
    return GetGamePool('CVehicle')
end

function GetClosestEntity(entities, isPlayerEntities, coords, modelFilter)
    local closestEntity, closestEntityDistance, filteredEntities = -1, -1, nil

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    if modelFilter then
        filteredEntities = {}

        for k, entity in pairs(entities) do
            if modelFilter[GetEntityModel(entity)] then
                filteredEntities[#filteredEntities + 1] = entity
            end
        end
    end

    for k, entity in pairs(filteredEntities or entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if closestEntityDistance == -1 or distance < closestEntityDistance then
            closestEntity, closestEntityDistance = isPlayerEntities and k or entity, distance
        end
    end

    return closestEntity, closestEntityDistance
end

function FrameworkGetClosestVehicle()
    return GetClosestEntity(GetVehicles(), false, coords, modelFilter)
end

function _RequestModel(modelHash, cb)
    modelHash = (type(modelHash) == 'number' and modelHash or joaat(modelHash))

    if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end

    if cb ~= nil then
        cb()
    end
end

function FrameworkSpawnVehicle(vehicle, coords, heading, cb)
    local model = type(vehicle) == 'number' and vehicle or joaat(vehicle)
    local vector = type(coords) == 'vector3' and coords or vec(coords.x, coords.y, coords.z)
    networked = networked == nil and true or networked

    local playerCoords = GetEntityCoords(PlayerPedId())
    if not vector or not playerCoords then
        return
    end
    local dist = #(playerCoords - vector)
    if dist > 424 then -- Onesync infinity Range (https://docs.fivem.net/docs/scripting-reference/onesync/)
        local executingResource = GetInvokingResource() or 'Unknown'
        return print(('[^1ERROR^7] Resource ^5%s^7 Tried to spawn vehicle on the client but the position is too far away (Out of onesync range).'):format(executing_resource))
    end

    CreateThread(function()
        _RequestModel(model)

        local vehicle = CreateVehicle(model, vector.xyz, heading, networked, true)

        if networked and NetworkGetEntityIsNetworked(vehicle) then
            local id = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(id, true)
            SetEntityAsMissionEntity(vehicle, true, true)
        end
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetModelAsNoLongerNeeded(model)
        SetVehRadioStation(vehicle, 'OFF')

        RequestCollisionAtCoord(vector.xyz)
        while not HasCollisionLoadedAroundEntity(vehicle) do
            Wait(0)
        end

        if cb then
            cb(vehicle)
        end
    end)
end

function FrameworkSetVehicleProperties(vehicle, props)
    Debug('FrameworkSetVehicleProperties is used with standalone')
    return true
end

function FrameworkGetVehicles(cb)
    return GetVehicles()
end

function GetIdentifier()
    return TriggerServerCallbackSync('qs-smartphone-pro:GetIdentifier')
end

function GetPlayerMoney()
    Debug('GetPlayerMoney is used with standalone')
    return 100
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawGenericText(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.65, 0.65)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(0.825, 0.90)
end

function ProgressBar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('progressbar') ~= 'started' then error('progressbar needs to be started in order for Progressbar to work') end
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
                onFinish()
            end
        else
            if onCancel then
                onCancel()
            end
        end
    end)
end
