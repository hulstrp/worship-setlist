-- These are examples of how to use the custom functions in the client.

-- Example of how to use the notification function.
RegisterCommand('notifi', function(source)
    exports['qs-smartphone-pro']:SendTempNotification({
        title = 'Test',
        content = 'This is a test notification.',
        type = 'success',
        timeout = 5000,
        disableBadge = true, -- Disables the badge on the app icon.
    })
end, false)

-- Its same as the old one
RegisterCommand('notifiOld', function(source)
    exports['qs-smartphone-pro']:SendTempNotificationOld({
        title = 'Test',
        content = 'This is a test notification.',
        type = 'success',
        timeout = 5000,
        disableBadge = true, -- Disables the badge on the app icon.
    })
end, false)

-- Example of how to use the sendNewMail event.
RegisterCommand('mailTest', function(source)
    TriggerServerEvent('phone:sendNewMail', {
        sender = 'Movistar Plus',
        subject = 'Family telephone balance promotion',
        message = 'Enjoy the family balance at only $8.50 per month, what are you waiting for?'
    })
end, false)

-- Example of how to use the sendNewMail event for the old smartphone.
RegisterCommand('mailTestOld', function(source)
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Movistar Plus',
        subject = 'Family telephone balance promotion',
        message = 'Enjoy the family balance at only $8.50 per month, what are you waiting for?'
    })
end, false)

-- You can check if user is using phone.
RegisterCommand('phoneCheck', function(source)
    local isUsingPhone = exports['qs-smartphone-pro']:InPhone()
    if isUsingPhone then
        print('User is using phone.')
    else
        print('User is not using phone.')
    end
end, false)
