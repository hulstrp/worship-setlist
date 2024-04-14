--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'qb' then
    return
end

ESX = nil

Citizen.CreateThread(function()
    ESX = exports['qb-core']:GetCoreObject()
end)

function TriggerServerCallback(name, cb, ...)
    ESX.Functions.TriggerCallback(name, cb, ...)
end

exports('TriggerServerCallback', TriggerServerCallback)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('qb-crypto:server:FetchWorth')
    TriggerServerEvent('qb-crypto:server:GetRebootState')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    SendNUIMessage({
        action = 'UpdateApplications',
        jobName = JobInfo.name,
        applications = PhoneApplications
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Logout()
end)

function GetPlayerData()
    return ESX.Functions.GetPlayerData()
end

local brutalDead = GetResourceState('brutal_ambulancejob') == 'started'
function isDead()
    if brutalDead then
        return exports.brutal_ambulancejob:IsDead()
    end
    return GetPlayerData().metadata['ishandcuffed'] or GetPlayerData().metadata['inlaststand'] or GetPlayerData().metadata['isdead'] or IsPauseMenuActive() or LocalPlayer.state.dead
end

function GetIdentifier()
    return GetPlayerData().citizenid
end

function GetHungry()
    return GetPlayerData().metadata.hunger
end

function GetThirsty()
    return GetPlayerData().metadata.thirst
end

function GetInventory()
    return GetPlayerData().items
end

function GetJobName()
    return GetPlayerData().job.name
end

function GetMoney()
    return GetPlayerData().money.bank or 0
end

function FrameworkGetClosestVehicle()
    return ESX.Functions.GetClosestVehicle()
end

function FrameworkSpawnVehicle(model, coords, heading, cb)
    ESX.Functions.SpawnVehicle(model, cb, coords, true)
end

function FrameworkSetVehicleProperties(vehicle, props)
    ESX.Functions.SetVehicleProperties(vehicle, props)
end

function FrameworkGetVehicles(cb)
    return ESX.Functions.GetVehicles(cb)
end

function GetPlayerMoney()
    return GetPlayerData().money['cash']
end

function SendTextMessage(message, type)
    if type == 'success' then
        TriggerEvent('QBCore:Notify', message, 'success', 5000)
    elseif type == 'error' then
        TriggerEvent('QBCore:Notify', message, 'error', 5000)
    elseif type == 'inform' then
        TriggerEvent('QBCore:Notify', message, 'error', 5000)
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

function GetCompanyData(cb)
    local playerJob = GetPlayerData().job
    local jobData = {
        job = playerJob.name,
        jobLabel = playerJob.label,
        isBoss = playerJob.isboss,
    }

    if jobData.isBoss then
        local moneyPromise = promise.new()
        TriggerServerCallback('qb-bossmenu:server:GetAccount', function(money)
            moneyPromise:resolve(money)
        end, jobData.job)
        jobData.balance = Citizen.Await(moneyPromise)

        local employeesPromise = promise.new()
        TriggerServerCallback('qb-bossmenu:server:GetEmployees', function(employees)
            for i = 1, #employees do
                local employee = employees[i]
                employees[i] = {
                    name = employee.name,
                    id = employee.empSource,

                    gradeLabel = employee.grade.name,
                    grade = employee.grade.level,

                    canInteract = not employee.isboss
                }
            end
            employeesPromise:resolve(employees)
        end, jobData.job)
        jobData.employees = Citizen.Await(employeesPromise)

        jobData.grades = {}
        for k, v in pairs(ESX.Shared.Jobs[jobData.job].grades) do
            jobData.grades[#jobData.grades + 1] = {
                key = tonumber(k),
                value = v.name,
            }
        end

        table.sort(jobData.grades, function(a, b)
            return a.grade < b.grade
        end)
    end

    cb(jobData)
end

function DepositMoney(amount, cb)
    TriggerServerEvent('qb-bossmenu:server:depositMoney', amount)
    SetTimeout(1500, function()
        TriggerServerCallback('qb-bossmenu:server:GetAccount', cb, GetPlayerData().job.name)
    end)
end

function WithdrawMoney(amount, cb)
    TriggerServerEvent('qb-bossmenu:server:withdrawMoney', amount)
    SetTimeout(1500, function()
        TriggerServerCallback('qb-bossmenu:server:GetAccount', cb, GetPlayerData().job.name)
    end)
end

function HireEmployee(source, cb)
    TriggerServerEvent('qb-bossmenu:server:HireEmployee', source)
    TriggerServerCallback('phone:market:getPlayerData', function(playerData)
        cb({
            name = playerData.name,
            id = playerData.id
        })
    end, source)
end

function FireEmployee(source, cb)
    TriggerServerEvent('qb-bossmenu:server:FireEmployee', source)
    cb(GetPlayerData().job.isboss)
end

function SetGrade(identifier, newGrade, cb)
    local maxGrade = 0
    for grade, _ in pairs(ESX.Shared.Jobs[GetPlayerData().job.name].grades) do
        grade = tonumber(grade)
        if grade and grade > maxGrade then
            maxGrade = grade
        end
    end

    if newGrade > maxGrade then
        return cb(false)
    end

    TriggerServerEvent('qb-bossmenu:server:GradeUpdate', {
        cid = identifier,
        grade = newGrade,
        gradename = ESX.Shared.Jobs[GetPlayerData().job.name].grades[tostring(newGrade)].name
    })
    cb(true)
end
