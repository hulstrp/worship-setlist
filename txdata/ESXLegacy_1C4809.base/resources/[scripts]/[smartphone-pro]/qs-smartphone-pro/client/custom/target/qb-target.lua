if not Config.UseTarget then
    return
end

local hasHackedPhone = false

function UberEatsDoors(uberChoosenAdress)
    exports['qb-target']:AddBoxZone('uber_eats_zone', vec3(Config.UberDelivery[uberChoosenAdress]['x'], Config.UberDelivery[uberChoosenAdress]['y'], Config.UberDelivery[uberChoosenAdress]['z'] - 1), 2.5, 2.5, {
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = Config.UberDelivery[uberChoosenAdress]['z'] - 1,
        maxZ = Config.UberDelivery[uberChoosenAdress]['z'] + 1,
    }, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = Lang('PHONE_TARGET_UBEREATS_DELIVER_DELIVERY'),
                action = function()
                    TriggerServerCallback('phone:checkItem', function(qtty)
                        if qtty > 0 then
                            TriggerServerEvent('phone:removeItem', Config.UberItems[uberChoosenItem]['item'])
                            doorKnocked = true
                            npcHome = math.random(1, 2)
                            PlayAnimation(PlayerPedId(), 'timetable@jimmy@doorknock@', 'knockdoor_idle')
                            Citizen.Wait(3000)

                            if npcHome == 1 then
                                Citizen.Wait(2000)
                                packagePoint = false
                                UberReward()
                            else
                                Citizen.Wait(2000)
                                UberReward()
                            end
                            -- Después de la acción, eliminar el target
                            RemoveUberTarget()
                            uberTargeted = false
                        else
                            SendTextMessage(Lang('PHONE_NOTIFICATION_UBEREATS_NO_ITEM') .. ' ' .. Config.UberItems[uberChoosenItem]['name'], 'error')
                        end
                    end, Config.UberItems[uberChoosenItem]['item'])
                end,
            },
        },
        distance = 2.5
    })
end

function RemoveUberTarget()
    exports['qb-target']:RemoveZone('uber_eats_zone')
end

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.ChatSeller, {
        options = {
            {
                type = 'client',
                event = 'phone:client:openChannelMenu',
                icon = 'fas fa-comment-dots',
                label = Lang('PHONE_TARGET_DISCORD_PURCHASE_CHAT_CHANNEL'),
                targeticon = 'fas fa-comments',
            },
            {
                type = 'client',
                event = 'phone:client:openChannelHackedMenu',
                icon = 'fas fa-user-secret',
                label = Lang('PHONE_TARGET_DISCORD_PURCHASE_SECURE_CHANNEL'),
                targeticon = 'fas fa-comments',
                canInteract = function()
                    TriggerServerCallback('phone:server:hasHackedPhone', function(result)
                        hasHackedPhone = result
                    end)
                    Citizen.Wait(500)

                    return hasHackedPhone
                end
            }
        },
        distance = 5.0
    })

    exports['qb-target']:AddBoxZone('crypto_spot', vec3(Crypto.Exchange.coords.x, Crypto.Exchange.coords.y, Crypto.Exchange.coords.z), 1.5, 1.5, {
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = Crypto.Exchange.coords.z - 1,
        maxZ = Crypto.Exchange.coords.z + 1,
    }, {
        options = {
            {
                icon = 'fa-solid fa-coins',
                label = Lang('PHONE_TARGET_STOCK_ENTER_USB'),
                canInteract = function()
                    HasItem = TriggerServerCallbackSync('qb-crypto:server:HasSticky')
                    return HasItem
                end,
                action = function()
                    TriggerEvent('mhacking:show')
                    TriggerEvent('mhacking:start', math.random(4, 6), 45, HackingSuccess)
                end,
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddTargetModel('a_m_m_afriamer_01', {
        options = {
            {
                icon = 'fa-solid fa-gun',
                label = Lang('PHONE_TARGET_DARKWEB_TAKE_ORDER'),
                canInteract = function()
                    return waitingDarkWebData
                end,
                action = function()
                    TriggerServerCallbackSync('phone:darkweb:buyItem', waitingDarkWebData.item, waitingDarkWebData.amount)
                    SendTempNotificationOld({
                        app = 'darkweb',
                        title = Lang('PHONE_NOTIFICATION_DARKWEB_TITLE'),
                        text = Lang('PHONE_NOTIFICATION_DARKWEB_SUCCESS'),
                        timeout = 2500,
                    })
                    darkWebSuccess = true
                    waitingDarkWebData = nil
                end,
            },
        },
        distance = 5.0
    })

    for k, v in pairs(Config.RentelLocations) do
        exports['qb-target']:AddBoxZone('rentel', vec3(v['coords'][1], v['coords'][2], v['coords'][3] - 1), 2.5, 2.5, {
            heading = 90.0,
            debugPoly = Config.ZoneDebug,
            minZ = v['coords'][3] - 1,
            maxZ = v['coords'][3] + 1,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-bicycle',
                    label = Lang('PHONE_DRAWTEXT_RENTEL_TARGET_RENTAL'),
                    action = function()
                        if not IsPedInAnyVehicle(PlayerPedId(), false) then
                            openRentalMenu(k)
                        else
                            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                            local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                            model = string.lower(model)
                            if Config.RentelVehicles[model] then
                                local keysQs = GetResourceState('qs-vehiclekeys') == 'started'
                                if keysQs then
                                    local plate = GetVehicleNumberPlateText(veh)
                                    exports['qs-vehiclekeys']:RemoveKeys(plate, model)
                                end
                                TaskLeaveVehicle(PlayerPedId(), veh, 256)
                                DeleteVehicle(veh)
                                SendTempNotificationOld({
                                    app = 'rentel',
                                    title = Lang('PHONE_NOTIFICATION_RENTEL_TITLE'),
                                    text = Lang('PHONE_NOTIFICATION_RENTEL_RETURN_VEHICLE_POST'),
                                    timeout = 2500,
                                    disableBadge = true,
                                })
                            else
                                SendTextMessage(Lang('PHONE_NOTIFICATION_RENTEL_VEHICLE_INVALID'), 'error')
                            end
                        end
                    end,
                },
            },
            distance = 2.5
        })
    end

    for k, v in pairs(Config.ChargeCoords) do
        local coords = v.coords
        exports['qb-target']:AddBoxZone('charger_spots', vec3(coords.x, coords.y, coords.z - 1), 2.5, 2.5, {
            heading = 90.0,
            debugPoly = Config.ZoneDebug,
            minZ = v['coords'][3] - 1,
            maxZ = v['coords'][3] + 1,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-battery-full',
                    label = Lang('PHONE_TARGET_BATTERY_CHARGE_PHONE'),
                    action = function()
                        if Config.ChargeCoords[k].isAvailable then
                            TriggerEvent('phone:openPhoneMenu', 'phone:ChargePhone', k)
                        else
                            if Config.ChargeCoords[k].takeable ~= GetIdentifier() then
                                SendTextMessage(Lang('PHONE_NOTIFICATION_BATTERY_NOT_OWNER'), 'error')
                            else
                                TriggerServerEvent('phone:TakeBackPhoneFromCharging', k)
                            end
                        end
                    end,
                },
            },
            distance = 2.5
        })
    end

    exports['qb-target']:AddTargetModel(Config.ResetPassword.ped.model, {
        options = {
            {
                type = 'client',
                event = 'phone:client:openChannelMenu',
                icon = 'fas fa-comment-dots',
                label = Lang('PHONE_TARGET_PHONE_RESET_PASSWORD'),
                action = function()
                    resetPasswordMenu()
                end,
            },
        },
        distance = 5.0
    })

    for _, phoneBooth in ipairs(Config.PhoneBooths) do
        exports['qb-target']:AddBoxZone('booth_zone', vec3(phoneBooth.coords.x, phoneBooth.coords.y, phoneBooth.coords.z), 1.5, 1.5, {
            heading = phoneBooth.coords.w or 0.0,
            debugPoly = Config.ZoneDebug,
            minZ = phoneBooth.coords.z - 1,
            maxZ = phoneBooth.coords.z + 1,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-phone',
                    label = Lang('PHONE_TARGET_BOOTH_OPEN_BOOTH'),
                    action = function()
                        if currentCash > 0 then
                            TriggerServerCallback('phone:server:HasPhone', function(HasPhone, itemName)
                                if not HasPhone then
                                    openPhoneBoothMenu(isNearPB)
                                else
                                    SendTextMessage(Lang('PHONE_NOTIFICATION_BOOTH_NOT_ACCESSIBLE'), 'error')
                                end
                            end)
                        else
                            SendTextMessage(Lang('PHONE_NOTIFICATION_BOOTH_NO_MONEY'), 'error')
                        end
                    end,
                },
            },
            distance = 2.5
        })
    end

    if Config.EnableRecipe then
        for _, recipeShop in ipairs(Config.BuyRecipe.coords) do
            exports['qb-target']:AddBoxZone('booth_zone', vec3(recipeShop.x, recipeShop.y, recipeShop.z - 1), 1.5, 1.5, {
                heading = recipeShop.w or 0.0,
                debugPoly = Config.ZoneDebug,
                minZ = recipeShop.z - 1,
                maxZ = recipeShop.z + 1,
            }, {
                options = {
                    {
                        icon = 'fa-solid fa-phone',
                        label = Lang('PHONE_TARGET_RECIPES_BUY'),
                        action = function()
                            if MetaData then
                                openRecipeMenu()
                            else
                                SendTextMessage(Lang('PHONE_NOTIFICATION_RECIPES_USE_PHONE_FIRST'), 'inform')
                            end
                        end,
                    },
                },
                distance = 2.5
            })
        end
    end
end)
