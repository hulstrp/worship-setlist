if Config.UseTarget ~= 'ox_target' then
    return
end

CreateThread(function()
    Wait(100)
    for _, bank in ipairs(Config.Bank) do
        local options = {
            coords = vec3(bank.x, bank.y, bank.z),
            distance = 2.5,
            rotation = 0.0,
            debug = Config.ZoneDebug,
            options = {
                {
                    icon = 'fa-solid fa-building-columns',
                    label = 'Bank',
                    distance = 2.5,
                    onSelect = function()
                        openUI()
                        isAtm = false
                        TriggerServerEvent('banking:server:balance')
                    end
                }
            },
        }
        exports.ox_target:addBoxZone(options)
    end

    if Config.Metadata then
        for _, card in ipairs(Config.CreateCard) do
            local cardOptions = {
                coords = card.coords,
                distance = 2.5,
                rotation = 0.0,
                debug = Config.ZoneDebug,
                options = {
                    {
                        icon = 'fa-solid fa-credit-card',
                        label = 'Create Card',
                        distance = 2.5,
                        onSelect = function()
                            SendNUIMessage({ type = 'createPin' })
                            SetNuiFocus(true, true)
                        end
                    }
                },
            }
            exports.ox_target:addBoxZone(cardOptions)
        end
    end

    if not Config.Metadata then
        for _, v in pairs(Config.ATMModels) do
            local options = {
                {
                    icon = 'fa-solid fa-money-bills',
                    label = 'ATM',
                    distance = 2.5,
                    onSelect = function()
                        TriggerEvent('banking:client:OpenAtm')
                    end
                },
            }
            exports.ox_target:addModel(v, options)
        end
    end
end)
