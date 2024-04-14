if Config.Vehiclekeys ~= 'qb-vehiclekeys' then
    return
end

function AddVehiclekeys(vehicle)
    TriggerEvent('vehiclekeys:client:SetOwner', ESX.Functions.GetPlate(vehicle))
end
