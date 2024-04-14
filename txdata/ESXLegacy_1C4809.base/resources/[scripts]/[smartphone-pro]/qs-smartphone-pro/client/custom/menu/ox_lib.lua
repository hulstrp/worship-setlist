if Config.Menu ~= 'ox_lib' then
    return
end

function openRecipeMenu()
    TriggerServerCallback('phone:CheckExistRecipe', function(exist)
        local method = exist?.method or ''
        local moment_header = ([[
            Moment %s
        ]]):format(method == 'moment' and ' - ' .. Lang('PHONE_MENU_RECIPES_OPTION_CURRENTLY') .. exist?.amount or '')
        local daily_header = ([[
            Daily %s
        ]]):format(method == 'daily' and ' - ' .. Lang('PHONE_MENU_RECIPES_OPTION_CURRENTLY') or '')
        local data = {
            {
                title = Lang('PHONE_MENU_RECIPES_UPDATED'),
                description = daily_header,
                onSelect = function(args)
                    TriggerEvent('phone:recipeSelectMethod', 'daily')
                end
            },
            {
                title = Lang('PHONE_MENU_RECIPES_CONTOUR'),
                description = moment_header,
                onSelect = function(args)
                    TriggerEvent('phone:recipeSelectMethod', 'moment')
                end
            }
        }
        if exist then
            table.insert(data, {
                title = Lang('PHONE_MENU_RECIPES_CANCEL'),
                onSelect = function(args)
                    TriggerServerEvent('phone:CancelRecipe')
                end
            })
        end
        lib.registerContext({
            id = 'recipe_spot',
            title = Lang('PHONE_MENU_RECIPES_TITLE'),
            options = data
        })
        lib.showContext('recipe_spot')
    end)
end

function openPhoneBoothMenu(isNearPB)
    local data = {
        {
            title = Lang('PHONE_MENU_BOOTH_CALL_POLICE'),
            onSelect = function(args)
                TriggerEvent('phone:boothCall', 'police')
            end
        },
        {
            title = Lang('PHONE_MENU_BOOTH_CALL_AMBULANCE'),
            onSelect = function(args)
                TriggerEvent('phone:boothCall', 'police')
            end
        },
        {
            title = Lang('PHONE_MENU_BOOTH_CALL_MECHANIC'),
            onSelect = function(args)
                TriggerEvent('phone:boothCall', 'police')
            end
        },
        {
            title = Lang('PHONE_MENU_BOOTH_CALL_NUMBER'),
            onSelect = function(args)
                TriggerEvent('phone:boothCall', 'othercall')
            end
        },
    }
    lib.registerContext({
        id = 'phone_booth',
        title = Lang('PHONE_MENU_BOOTH_CALL_TITLE'),
        options = data
    })
    lib.showContext('phone_booth')
end

function openRentalMenu(key)
    local coords = { x = Config.RentelLocations[key]['coords'].x, y = Config.RentelLocations[key]['coords'].y, z = Config.RentelLocations[key]['coords'].z, h = Config.RentelLocations[key]['coords'].w }
    local data = {}
    for model, v in pairs(Config.RentelVehicles) do
        if v.stored then
            table.insert(data, {
                title = v.label .. ' - ' .. Lang('PHONE_MENU_RENTEL_STORED'),
                onSelect = function(args)
                    TriggerServerEvent('phone:server:spawnVehicle', { model = model, price = 0, coords = coords })
                end
            })
        else
            table.insert(data, {
                title = v.label .. ' - ' .. Lang('PHONE_MENU_RENTEL_MONEY') .. v.price,
                onSelect = function(args)
                    TriggerServerEvent('phone:server:spawnVehicle', { model = model, price = v.price, coords = coords })
                end
            })
        end
    end
    lib.registerContext({
        id = 'rentel_spot',
        title = Lang('PHONE_MENU_RENTEL_TITLE'),
        options = data
    })
    lib.showContext('rentel_spot')
end

function resetPasswordMenu()
    local data = {
        {
            title = Lang('PHONE_MENU_PHONE_RESET_PASSWORD') .. Config.ResetPassword.money,
            onSelect = function(args)
                TriggerEvent('phone:ResetPassword')
            end
        }
    }
    lib.registerContext({
        id = 'reset_password',
        title = Lang('PHONE_MENU_PHONE_TITLE'),
        options = data
    })
    lib.showContext('reset_password')
end

RegisterNetEvent('phone:openPhoneMenu', function(event, ...)
    local items = GetInventory()
    local data = {}
    local varargs = { ... }
    if not Config.UniquePhone then
        local userData = TriggerServerCallbackSync('phone:getUserData')
        if userData then
            table.insert(data, {
                title = Lang('PHONE_MENU_BATTERY_PHONE_NUMBER') .. ' ' .. userData.phoneNumber,
                onSelect = function(args)
                    TriggerServerEvent(event, {
                        name = 'phone',
                        info = { phoneNumber = userData.phoneNumber }
                    }, table.unpack(varargs))
                end,
            })
        end
    else
        for phoneName in pairs(Config.Phones) do
            for k, v in pairs(items) do
                local meta = v.info or v.metadata
                if v.name == phoneName and meta?.phoneNumber then
                    table.insert(data, {
                        title = Lang('PHONE_MENU_BATTERY_PHONE_NUMBER') .. ' ' .. meta.phoneNumber,
                        onSelect = function(args)
                            TriggerServerEvent(event, v, table.unpack(varargs))
                        end,
                    })
                end
            end
        end
    end

    if #data < 1 then return SendTextMessage(Lang('PHONE_NOTIFICATION_PHONE_NO_PHONE'), 'error') end
    lib.registerContext({
        id = 'charger_spot',
        title = Lang('PHONE_MENU_BATTERY_TITLE'),
        options = data
    })
    lib.showContext('charger_spot')
end)

RegisterNetEvent('phone:client:openChannelMenu', function()
    if not MetaData then return SendTextMessage(Lang('PHONE_NOTIFICATION_RECIPES_USE_PHONE_FIRST'), 'inform') end
    local input = lib.inputDialog(Lang('PHONE_MENU_DISCORD_CHANNEL_TITLE'), {
        { type = 'input',  label = Lang('PHONE_MENU_DISCORD_SELECT_NAME'),     description = Lang('PHONE_MENU_DISCORD_SELECT_NAME_INFO'),     required = true },
        { type = 'number', label = Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD'), description = Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD_INFO'), required = false },
    })

    if input[1] then
        local roomData = {
            room_owner_name = MetaData.charinfo.firstname .. ' ' .. MetaData.charinfo.lastname
        }

        local allGood = false

        if input[1] then
            roomData.room_name = input[1]
            allGood = true
        end

        if input[2] then
            roomData.room_pin = input[2]
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
    local input = lib.inputDialog(Lang('PHONE_MENU_DISCORD_SECURE_TITLE'), {
        { type = 'input',  label = Lang('PHONE_MENU_DISCORD_SELECT_NAME'),     description = Lang('PHONE_MENU_DISCORD_SELECT_NAME_INFO'),     required = true },
        { type = 'number', label = Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD'), description = Lang('PHONE_MENU_DISCORD_SELECT_PASSWORD_INFO'), required = false },
    })

    if input[1] then
        local roomData = {
            room_owner_name = MetaData.charinfo.firstname .. ' ' .. MetaData.charinfo.lastname
        }

        local allGood = false

        if input[1] then
            roomData.room_name = input[1]
            allGood = true
        end

        if input[2] then
            roomData.room_pin = input[2]
        end

        if allGood then
            TriggerServerCallback('phone:server:PurchaseRoom', function(status)
                if status then
                    local source = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('phone:server:CreateRoom', source, roomData, true)
                end
            end, 250)
        end
    end
end)
