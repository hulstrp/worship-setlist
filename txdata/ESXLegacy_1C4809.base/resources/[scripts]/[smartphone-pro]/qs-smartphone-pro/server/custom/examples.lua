-- These are examples of how to use the custom functions in the server.

-- Example of how to use the sendNewMail export.
RegisterCommand('mailTest', function(source)
    exports['qs-smartphone-pro']:sendNewMail(source, {
        sender = 'Quasar',
        subject = 'Es tu culpa',
        message = 'Es tu culpa que no haya un ejemplo de como usar esto...'
    })
end, false)

-- You can get phone name by using this export. It returns all phone names.
RegisterCommand('phoneNames', function(source)
    local phoneNames = exports['qs-smartphone-pro']:getPhoneNames()
    print(json.encode(phoneNames, { indent = true }))
end, false)

-- This export returns player's phone number. If the user has used the phone. It prioritizes that phone. If the user has never used a phone, it returns the phone number of any phone from its inventory.
RegisterCommand('getPhone', function(source, args)
    local identifier = GetIdentifier(source) -- This is a player identifier. Like ESX.GetPlayerFromId(source).identifier
    local mustBePhoneOwner = true            -- If its true, checks phone owner is the identifier. So you can handle to a stolen phone.
    local number = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, mustBePhoneOwner)
    print(number)                            -- phone number or false
end, false)

-- This export returns player's currently using or last used phone meta
RegisterCommand('getMeta', function(source, args)
    local meta = exports['qs-smartphone-pro']:getMetaFromSource(source)
    print(json.encode(meta, { indent = true })) -- phone meta or false
end, false)

-- This export sends a new message to a phone number.
RegisterCommand('sendNewMessage', function(source, args)
    local identifier = GetIdentifier(source)
    local sender = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false) -- Sender phone number
    local target = '293823'                                                                     -- Target phone number
    local message = 'Hello world!'
    local type = 'message'                                                                      -- message or location
    exports['qs-smartphone-pro']:sendNewMessage(sender, target, message, type)
end, false)

-- This export sends a SOS message to a phone number.
RegisterCommand('sendSOSMessage', function(source, args)
    local src = source
    local identifier = GetIdentifier(src)
    local phoneNumber = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false) -- Sender phone number
    local job = 'ambulance'
    local coords = GetEntityCoords(GetPlayerPed(src))
    exports['qs-smartphone-pro']:sendSOSMessage(phoneNumber, job, json.encode(coords), 'location')
end, false)

-- This export sends a new message from a app. You can use this to send a message from a app.
RegisterCommand('sendNewMessageFromApp', function(source, args)
    local src = source
    local identifier = GetIdentifier(src)
    local phone = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false) -- Sender phone number
    local message = 'Quasar: Hello from twitter!'
    local appName = 'twitter'
    exports['qs-smartphone-pro']:sendNewMessageFromApp(src, phone, message, appName)
end, false)

-- This export sends a new notification to a phone number.
RegisterCommand('sendNewNotification', function(source, args)
    local phone = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(GetIdentifier(source), false)
    local disableTempNotification = false -- Disables the temporary notification. (Pop up notification)
    exports['qs-smartphone-pro']:sendNotification(phone, {
        app = 'twitter',
        msg = 'Hello world!',
        head = 'Quasar'
    }, disableTempNotification)
end, false)

-- Same as sendNewNotification
RegisterCommand('sendNewNotification', function(source, args)
    local phone = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(GetIdentifier(source), false)
    local disableTempNotification = false -- Disables the temporary notification. (Pop up notification)
    exports['qs-smartphone-pro']:sendNotificationOld(phone, {
        app = 'twitter',
        msg = 'Hello world!',
        head = 'Quasar'
    }, disableTempNotification)
end, false)

RegisterCommand('sendNewMessage', function(source, args)
    local phone = '323'
    local targetPhone = '123'
    local message = 'Hello'
    local type = 'message' -- message, location
    local success = exports['qs-smartphone-pro']:sendNewMessage(phone, targetPhone, message, type)
    print('Success: ', success)
end, false)
