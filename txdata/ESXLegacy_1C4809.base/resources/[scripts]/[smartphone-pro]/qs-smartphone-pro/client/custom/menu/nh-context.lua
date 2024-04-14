if Config.Menu ~= 'nh-context' then
    return
end

function openRecipeMenu()
    TriggerServerCallback('phone:CheckExistRecipe', function(exist)
        local method = exist?.method or ''
        local moment_header = ([[
            Moment %s
        ]]):format(method == 'moment' and '<span style="color:green; margin-left: 4px"> - ' .. Lang('PHONE_MENU_RECIPES_OPTION_CURRENTLY') .. exist?.amount .. '</span>' or '')
        local daily_header = ([[
            Daily %s
        ]]):format(method == 'daily' and ' - ' .. Lang('PHONE_MENU_RECIPES_OPTION_CURRENTLY') or '')
        local data = {
            {
                header = Lang('PHONE_MENU_RECIPES_TITLE'),
            },
            {
                header = daily_header,
                context = Lang('PHONE_MENU_RECIPES_UPDATED'),
                event = 'phone:recipeSelectMethod',
                args = { 'daily' }
            },
            {
                header = moment_header,
                context = Lang('PHONE_MENU_RECIPES_CONTOUR'),
                event = 'phone:recipeSelectMethod',
                args = { 'moment' }
            },
        }
        if exist then
            table.insert(data, {
                header = "<span style='color: gray'>" .. Lang('PHONE_MENU_RECIPES_OPTION_CANCEL') .. '</span>',
                context = Lang('PHONE_MENU_RECIPES_CANCEL'),
                event = 'phone:CancelRecipe',
                server = true,
                args = {}
            })
        end
        TriggerEvent('nh-context:createMenu', data)
    end)
end

function openPhoneBoothMenu(isNearPB)
    local data = {
        {
            header = Lang('PHONE_MENU_BOOTH_CALL_TITLE'),
        },
        {
            header = Lang('PHONE_MENU_BOOTH_CALL_POLICE'),
            context = 'police',
            event = 'phone:boothCall',
            args = { 'police' }
        },
        {
            header = Lang('PHONE_MENU_BOOTH_CALL_AMBULANCE'),
            context = 'ambulance',
            event = 'phone:boothCall',
            args = { 'ambulance' }
        },
        {
            header = Lang('PHONE_MENU_BOOTH_CALL_MECHANIC'),
            context = 'mechanic',
            event = 'phone:boothCall',
            args = { 'mechanic' }
        },
        {
            header = Lang('PHONE_MENU_BOOTH_CALL_NUMBER'),
            context = 'othercall',
            event = 'phone:boothCall',
            args = { 'othercall' }
        }
    }

    TriggerEvent('nh-context:createMenu', data)
end

function openRentalMenu(key)
    local data = {
        {
            header = Lang('PHONE_MENU_RENTEL_TITLE')
        }
    }
    local coords = { x = Config.RentelLocations[key]['coords'].x, y = Config.RentelLocations[key]['coords'].y, z = Config.RentelLocations[key]['coords'].z, h = Config.RentelLocations[key]['coords'].w }
    for model, v in pairs(Config.RentelVehicles) do
        if v.stored then
            table.insert(data, {
                header = v.label .. ' - ' .. Lang('PHONE_MENU_RENTEL_STORED'),
                context = 'Rentel',
                event = 'phone:server:spawnVehicle',
                server = true,
                args = { {
                    model = model, price = 0, coords = coords
                } }
            })
        else
            table.insert(data, {
                header = v.label .. ' - ' .. Lang('PHONE_MENU_RENTEL_MONEY') .. v.price,
                context = 'Rentel',
                event = 'phone:server:spawnVehicle',
                server = true,
                args = { {
                    model = model, price = v.price, coords = coords
                } }
            })
        end
    end
    TriggerEvent('nh-context:createMenu', data)
end

function resetPasswordMenu()
    local data = {
        {
            header = Lang('PHONE_MENU_PHONE_TITLE')
        },
        {
            header = Lang('PHONE_MENU_PHONE_RESET_PASSWORD') .. Config.ResetPassword.money,
            context = 'Reset Password',
            event = 'phone:ResetPassword'
        }
    }
    TriggerEvent('nh-context:createMenu', data)
end

RegisterNetEvent('phone:openPhoneMenu', function(event, ...)
    local items = GetInventory()
    local data = {
        {
            header = Lang('PHONE_MENU_BATTERY_TITLE')
        }
    }
    if not Config.UniquePhone then
        local userData = TriggerServerCallbackSync('phone:getUserData')
        if not userData then
            Debug('phone', 'userData is nil')
            return
        end
        table.insert(data, {
            header = Lang('PHONE_MENU_BATTERY_PHONE_NUMBER') .. ' ' .. userData.phoneNumber,
            context = 'Phone',
            event = 'phone:selectPhone',
            args = { { name = 'phone', info = { phoneNumber = userData.phoneNumber } }, event, ... }
        })
    end
    if Config.UniquePhone then
        for phoneName in pairs(Config.Phones) do
            for k, v in pairs(items) do
                local meta = v.info or v.metadata
                if v.name == phoneName and meta?.phoneNumber then
                    table.insert(data, {
                        header = Lang('PHONE_MENU_BATTERY_PHONE_NUMBER') .. ' ' .. meta.phoneNumber,
                        context = 'Phone',
                        event = 'phone:selectPhone',
                        args = { v, event, ... }
                    })
                end
            end
        end
    end

    if #data < 2 then return SendTextMessage(Lang('PHONE_NOTIFICATION_PHONE_NO_PHONE'), 'error') end
    TriggerEvent('nh-context:createMenu', data)
end)

RegisterNetEvent('phone:client:openChannelMenu', function()
    if not MetaData then return SendTextMessage(Lang('PHONE_NOTIFICATION_RECIPES_USE_PHONE_FIRST'), 'inform') end
    local keyboard, channelName, passcode = exports['nh-keyboard']:Keyboard({
        header = Lang('PHONE_MENU_DISCORD_CHANNEL_TITLE'),
        rows = { Lang('PHONE_MENU_DISCORD_SELECT_NAME'), Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD') }
    })

    if keyboard then
        local roomData = {
            room_owner_name = MetaData.charinfo.firstname .. ' ' .. MetaData.charinfo.lastname
        }

        local allGood = false

        if channelName then
            roomData.room_name = channelName
            allGood = true
        end

        if passcode then
            roomData.room_pin = passcode
        end

        if allGood then
            TriggerServerCallback('phone:server:PurchaseRoom', function(status)
                if status then
                    local source = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('phone:server:CreateRoom', source, roomData)
                end
            end, 250)
        end
    end
end)

RegisterNetEvent('phone:client:openChannelHackedMenu', function()
    if not MetaData then return SendTextMessage(Lang('PHONE_NOTIFICATION_RECIPES_USE_PHONE_FIRST'), 'inform') end

    local keyboard, channelName, passcode = exports['nh-keyboard']:Keyboard({
        header = Lang('PHONE_MENU_DISCORD_SECURE_TITLE'),
        rows = { Lang('PHONE_MENU_DISCORD_SELECT_NAME'), Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD') }
    })

    if keyboard then
        local roomData = {
            room_owner_name = MetaData.charinfo.firstname .. ' ' .. MetaData.charinfo.lastname
        }

        local allGood = false

        if channelName then
            roomData.room_name = channelName
            allGood = true
        end

        if passcode then
            roomData.room_pin = passcode
        end

        if allGood then
            TriggerServerCallback('phone:server:PurchaseRoom', function(status)
                if status then
                    local source = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('phone:server:CreateRoom', source, roomData, true)
                end
            end, 5000)
        end
    end
end)
