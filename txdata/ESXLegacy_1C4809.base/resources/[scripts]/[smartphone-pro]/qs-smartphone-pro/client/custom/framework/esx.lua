--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'esx' then
    return
end

ESX = nil

Citizen.CreateThread(function()
    local legacyEsx = pcall(function()
        ESX = exports['es_extended']:getSharedObject()
    end)
    Citizen.Wait(0)
    if legacyEsx then return end
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

exports('TriggerServerCallback', TriggerServerCallback)

RegisterNetEvent('esx:playerLoaded', function()
    TriggerServerEvent('qb-crypto:server:FetchWorth')
    TriggerServerEvent('qb-crypto:server:GetRebootState')
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    Logout()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(JobInfo)
    SendNUIMessage({
        action = 'UpdateApplications',
        jobName = JobInfo.name,
        applications = PhoneApplications
    })
end)

local brutalDead = GetResourceState('brutal_ambulancejob') == 'started'
function isDead()
    if brutalDead then
        return exports.brutal_ambulancejob:IsDead()
    end
    return IsPedDeadOrDying(PlayerPedId(), false) or IsEntityDead(PlayerPedId()) or IsPauseMenuActive() or LocalPlayer.state.dead
end

function GetHungry()
    local promise = promise.new()
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        promise:resolve(status.getPercent())
    end)
    return Citizen.Await(promise)
end

function GetThirsty()
    local promise = promise:new()
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        promise:resolve(status.getPercent())
    end)
    return Citizen.Await(promise)
end

function GetPlayerData()
    return ESX.GetPlayerData()
end

function GetInventory()
    return GetPlayerData().inventory
end

function GetJobName()
    return GetPlayerData().job.name
end

function GetMoney()
    for k, v in pairs(GetPlayerData().accounts) do
        if v.name == 'bank' then return v.money end
    end
    return 0
end

function FrameworkGetClosestVehicle()
    return ESX.Game.GetClosestVehicle()
end

function FrameworkSpawnVehicle(model, coords, heading, cb)
    ESX.Game.SpawnVehicle(model, coords, heading, cb)
end

function FrameworkSetVehicleProperties(vehicle, props)
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function FrameworkGetVehicles(cb)
    return ESX.Game.GetVehicles()
end

function GetIdentifier()
    return GetPlayerData().identifier
end

function GetPlayerMoney()
    local playerData = GetPlayerData()
    for i = 1, #playerData.accounts, 1 do
        if playerData.accounts[i].name == 'money' then
            return playerData.accounts[i].money
        end
    end
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

function DepositMoney(amount, cb)
    TriggerServerEvent('esx_society:depositMoney', GetJobName(), amount)
    SetTimeout(500, function()
        TriggerServerCallback('esx_society:getSocietyMoney', cb, GetJobName())
    end)
end

function WithdrawMoney(amount, cb)
    TriggerServerEvent('esx_society:withdrawMoney', GetJobName(), amount)
    SetTimeout(500, function()
        TriggerServerCallback('esx_society:getSocietyMoney', cb, GetJobName())
    end)
end

function HireEmployee(source, cb)
    TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
        for i = 1, #players do
            local player = players[i]
            if player.source == source then
                TriggerServerCallback('esx_society:setJob', function()
                    cb({
                        name = player.name,
                        id = player.identifier
                    })
                end, player.identifier, GetJobName(), 0, 'hire')
                return
            end
        end
    end)
end

function FireEmployee(identifier, cb)
    TriggerServerCallback('esx_society:setJob', function()
        cb(true)
    end, identifier, 'unemployed', 0, 'fire')
end

function SetGrade(identifier, newGrade, cb)
    TriggerServerCallback('esx_society:getJob', function(job)
        if newGrade > #job.grades - 1 then
            return cb(false)
        end

        TriggerServerCallback('esx_society:setJob', function()
            cb(true)
        end, identifier, GetJobName(), newGrade, 'promote')
    end, GetJobName())
end

RegisterNUICallback('getMarketData', function(data, cb)
    local playerData = GetPlayerData()
    local jobData = {
        job = playerData.job.name,
        jobLabel = playerData.job.label,
        isBoss = playerData.job.grade_name == 'boss'
    }

    if not jobData.isBoss then
        for cId = 1, #Config.Markets do
            local market = Config.Markets[cId]
            if table.includes(market.job, jobData.job) then
                if not market.bossRanks then
                    break
                end

                jobData.bossRanks = market.bossRanks
                for i = 1, #market.bossRanks do
                    if market.bossRanks[i] == playerData.job.grade_name then
                        jobData.isBoss = true
                        break
                    end
                end
                break
            end
        end
    end

    if jobData.isBoss then
        local moneyPromise = promise.new()
        TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            jobData.balance = money
            moneyPromise:resolve()
        end, jobData.job)
        Citizen.Await(moneyPromise)

        local employeesPromise = promise.new()
        TriggerServerCallback('esx_society:getEmployees', function(employees)
            jobData.employees = employees
            for i = 1, #employees do
                local employee = employees[i]
                employees[i] = {
                    name = employee.name,
                    id = employee.identifier,

                    gradeLabel = employee.job.grade_label,
                    grade = employee.job.grade,

                    canInteract = employee.job.grade_name ~= 'boss'
                }
            end
            employeesPromise:resolve()
        end, jobData.job)
        Citizen.Await(employeesPromise)

        local gradesPromise = promise.new()
        TriggerServerCallback('esx_society:getJob', function(job)
            local grades = {}
            for i = 1, #job.grades do
                local grade = job.grades[i]
                grades[i] = {
                    key = grade.grade,
                    value = grade.label
                }
            end
            jobData.grades = grades
            gradesPromise:resolve()
        end, jobData.job)
        Citizen.Await(gradesPromise)
    end

    cb(jobData)
end)
