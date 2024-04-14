Config = {}


------------------------------ BIKE IN CLUB HOUSE ------------------------------
Config.bike1 = {
    ['coords'] = vector4(1021.79, -2509.94, 28.12, 230.15),
    ['bike1'] =  'nightblade',
    ['plate'] = 'TRIBE', -- Make sure only 8 characters
}
Config.bike = {
    ['coords'] = vector4(1023.58, -2510.11, 28.11, 227.61),
    ['bike'] =  'nightblade',
    ['plate'] = 'TRIBE', -- Make sure only 8 characters
}


r, g, b = 0, 0, 0  -- RGB Colour
x, y, z = 0, 0, 0  -- RGB Colour



    CreateThread(function()
        local model = GetHashKey(Config.bike1['bike1'])
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        local veh = CreateVehicle(model, Config.bike1['coords'].x, Config.bike1['coords'].y, Config.bike1['coords'].z-0.5, false, false)
        SetModelAsNoLongerNeeded(model)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleDoorsLocked(veh, 3)
        SetEntityHeading(veh,Config.bike1['coords'].w)
        SetVehicleCustomPrimaryColour(veh, r, g, b) -- bike1 colour
        SetVehicleCustomSecondaryColour(veh, r, g, b) -- bike1 colour
        SetVehicleExtraColours(veh, 1, 1)-- bike1 colour
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, Config.bike1['plate'])
    end)

    CreateThread(function()
        local model = GetHashKey(Config.bike['bike'])
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        local veh = CreateVehicle(model, Config.bike['coords'].x, Config.bike['coords'].y, Config.bike['coords'].z-0.5, false, false)
        SetModelAsNoLongerNeeded(model)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleDoorsLocked(veh, 3)
        SetEntityHeading(veh,Config.bike['coords'].w)
        SetVehicleCustomPrimaryColour(veh, x, y, z) -- bike colour
        SetVehicleCustomSecondaryColour(veh, x, y, z) -- bike colour
        SetVehicleExtraColours(veh, 1, 1)-- bike colour
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, Config.bike['plate'])
    end)





------------------------------ CLEAR PEDS FROM AREA ------------------------------
CreateThread(function()
    while true do
        ClearAreaOfPeds(1017.58, -2508.05, 28.45, 20.0); 
        -- ClearAreaOfVehicles(1452.67, -2605.99, 48.52, 15.0, false, false, false, false, false);
        Wait(100)
    end
end)

