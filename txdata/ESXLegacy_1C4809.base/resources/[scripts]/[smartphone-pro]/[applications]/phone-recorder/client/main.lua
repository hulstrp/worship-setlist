while GetResourceState('qs-smartphone-pro') ~= 'started' do
    Wait(500)
end

local ui = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/ui/build/'

RegisterNUICallback('getRecords', function(data, cb)
    local records = exports['qs-smartphone-pro']:getRecords()
    cb(records)
end)

RegisterNUICallback('setRecords', function(data, cb)
    local records = data.records
    exports['qs-smartphone-pro']:setRecords(records)
    cb(true)
end)

RegisterCommand('test', function()
    SendNUIMessage({
        action = 'foo',
        data = 'damn'
    })
end, false)

local function addApp()
    local added = exports['qs-smartphone-pro']:addCustomApp({
        app = 'recorder',
        image = ui .. 'icon.png',
        ui = ui .. 'index.html',
        label = 'Recorder',
        job = false,
        blockedJobs = {},
        timeout = 5500,
        creator = 'Quasar',
        category = 'social',
        isGame = false,
        description = 'Super useful and comfortable audio recording application!',
        age = '16+',
        extraDescription = {
            {
                header = 'Audio Recorder',
                head = 'Record your audios and show them in public!',
                image = 'https://i.ibb.co/Pz6mzTp/recorder.webp',
                footer = 'Super useful and comfortable audio recording application!'
            }
        }
    })
    if not added then
        return print('Failed to add app')
    end
    print('App added')
end

local function removeApp()
    local removed = exports['qs-smartphone-pro']:removeCustomApp('recorder')
    if not removed then
        return print('Failed to remove app')
    end
    print('App removed')
end

RegisterCommand('removeapp', function()
    removeApp()
end, false)

CreateThread(addApp)

AddEventHandler('onResourceStart', function(resource)
    if resource == 'qs-smartphone-pro' then
        addApp()
    end
end)
