if Config.UseTarget ~= 'qb-target' then
    return
end

CreateThread(function()
    Wait(100)
    for _, bank in ipairs(Config.Bank) do
        exports['qb-target']:AddBoxZone(_, vec3(bank.x, bank.y, bank.z), 1.5, 1.5, {
            name = 'Bank',
            heading = 90.0,
            debugPoly = Config.ZoneDebug,
        }, {
            options = {
                {
                    type = 'server',
                    icon = 'fa-solid fa-building-columns',
                    label = 'Bank',
                    canInteract = function(entity, distance, data)
                        return true
                    end,
                    action = function(entity)
                        openUI()
                        isAtm = false
                        TriggerServerEvent('banking:server:balance')
                    end,
                },
            },
            distance = 1.5
        })
    end

    if Config.Metadata then
        for _, card in ipairs(Config.CreateCard) do
            exports['qb-target']:AddBoxZone(_, card.coords, 1.5, 1.5, {
                name = 'Bank',
                heading = 90.0,
                debugPoly = Config.ZoneDebug,
            }, {
                options = {
                    {
                        type = 'client',
                        icon = 'fa-solid fa-credit-card',
                        label = 'Create Card',
                        canInteract = function(entity, distance, data)
                            return true
                        end,
                        action = function(entity)
                            SendNUIMessage({ type = 'createPin' })
                            SetNuiFocus(true, true)
                        end,
                    },
                },
                distance = 1.5
            })
        end
    end

    if not Config.Metadata then
        for _, v in pairs(Config.ATMModels) do
            exports['qb-target']:AddTargetModel(v, {
                options = {
                    {
                        icon = 'fa-solid fa-money-bills',
                        label = 'ATM',
                        action = function()
                            TriggerEvent('banking:client:OpenAtm')
                        end
                    },
                },
                distance = 1.5
            })
        end
    end
end)
