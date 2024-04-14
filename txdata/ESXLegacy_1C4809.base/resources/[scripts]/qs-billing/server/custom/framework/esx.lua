--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]
if Config.Framework ~= "esx" then
    return
end

local legacyEsx = pcall(
    function()
        ESX = exports["es_extended"]:getSharedObject()
    end
)

if not legacyEsx then
    TriggerEvent(
        "esx:getSharedObject",
        function(obj)
            ESX = obj
        end
    )
end
function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
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

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier) -- attempt to get player
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetJob(player)
    return GetPlayerFromId(player).job
end

function GetCharacterName(source)
    local player = GetPlayerFromId(source)
    return player.getName()
end

function GetJobName(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.job and playerObj.job.name then
        return playerObj.job.name
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGrade(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.job and playerObj.job.grade then
        return playerObj.job.grade
    else
        return Lang('UNKNOWN')
    end
end

function GetPlayers()
    return ESX.GetPlayers()
end

function GetPlayerIdentifier(id)
    return ESX.GetPlayerFromId(id)?.identifier
end

function GetMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.getMoney()
end

function AddMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.addAccountMoney("money", price)
end

function RemoveMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeAccountMoney("money", price)
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.getAccount("bank").money
end

function AddBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.addAccountMoney("bank", price)
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeAccountMoney("bank", price)
end

function CreateUseableItem(name, cb)
    ESX.RegisterUsableItem(name, function(playerId)
        cb(playerId)
    end)
end

function GetCharacterRPData(source)
    local xPlayer = GetPlayerFromId(source)
    if (xPlayer == nil) then
        return {
            firstName = Lang('UNKNOWN'),
            lastName = Lang('UNKNOWN'),
            identifier = Lang('UNKNOWN')
        }
    end
    if (ESX == nil) then
        return {
            firstName = Lang('UNKNOWN'),
            lastName = Lang('UNKNOWN'),
            identifier = Lang('UNKNOWN')
        }
    end
    local firstName, lastName

    if xPlayer.get and xPlayer.get("firstName") and xPlayer.get("lastName") then
        firstName = xPlayer.get("firstName")
        lastName = xPlayer.get("lastName")
    else
        local result =
            MySQL.Sync.fetchAll(
                "SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = @identifier",
                { ["@identifier"] = xPlayer.identifier }
            )
        if not result[1] then
            return {
                firstName = GetPlayerName(source),
                lastName = "",
                identifier = xPlayer.identifier
            }
        end
        firstName, lastName = result[1]?.firstname or GetPlayerName(source), result[1]?.lastname or ""
    end
    DebugPrint({ firstName = firstName, lastName = lastName, identifier = xPlayer.identifier })
    return { firstName = firstName, lastName = lastName, identifier = xPlayer.identifier }
end

function AddMoneyToSociety(society, ammount)
    TriggerEvent("esx_addonaccount:getSharedAccount", society, function(account)
        if account ~= nil then
            account.addMoney(ammount)
        end
    end)
end
