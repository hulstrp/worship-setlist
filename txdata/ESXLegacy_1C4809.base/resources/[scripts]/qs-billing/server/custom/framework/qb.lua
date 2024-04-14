--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]
if Config.Framework ~= "qb" then
    return
end

QBCore = exports["qb-core"]:GetCoreObject()
function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetItemMetadata(item, itemData)
    if item.metadata ~= nil then
        return item.metadata
    end
    if type(itemData) ~= 'table' and type(itemData) == 'table' then
        return itemData?.info
    else
        return item?.info
    end
end

function GetPlayerFromIdentifier(citizenid)
    local data = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    local id = QBCore.Functions.GetSource(citizenid)
    return {
        data = data,
        id = id
    }
end

function GetPlayerFromId(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function GetCharacterName(source)
    local player = GetPlayerFromId(source).PlayerData.charinfo
    return player.firstname .. " " .. player.lastname
end

function GetJob(player)
    return GetPlayerFromId(player).PlayerData.job
end

function GetJobName(player)
    local playerObj = GetPlayerFromId(player)

    if playerObj and playerObj.PlayerData and playerObj.PlayerData.job and playerObj.PlayerData.job.name then
        return playerObj.PlayerData.job.name
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGrade(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.PlayerData and playerObj.PlayerData.job and playerObj.PlayerData.job.grade and playerObj.PlayerData.job.grade.level then
        return playerObj.PlayerData.job.grade.level
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGradeName(player)
    return GetPlayerFromId(player).PlayerData.job.grade.name
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetPlayerIdentifier(id)
    return QBCore.Functions.GetPlayer(id)?.PlayerData?.citizenid
end

function GetMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money["cash"]
end

function AddMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney("cash", price)
end

function RemoveMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney("cash", price)
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money["bank"]
end

function AddBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney("bank", price)
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney("bank", price)
end

function CreateUseableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then return end
        cb(source)
    end)
end

function GetCharacterRPData(source)
    local xPlayer = GetPlayerFromId(source)
    if (xPlayer == nil) then return { firstName = Lang('UNKNOWN'), lastName = Lang('UNKNOWN'),
            identifier = Lang('UNKNOWN') } end
    local firstName, lastName


    firstName, lastName = GetCharacterName(source)
    return { firstName = firstName, lastName = lastName, identifier = GetPlayerIdentifier(source) }
end

function AddMoneyToSociety(society, ammount)
    TriggerEvent("qb-bossmenu:server:okokBillingDeposit", society, ammount)
end
