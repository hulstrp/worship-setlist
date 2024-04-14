local configData = {}
local spawnVoertuig = `ambulance4`
if type(spawnVoertuig) ~= 'number' then
    spawnVoertuigB = GetHashKey(spawnVoertuig)
    spawnVoertuig = spawnVoertuigB
end
configData[spawnVoertuig] = {
    blauw = {1,5,6},
    directLinks = {2},
    directRechts = {3},
    directCenter = {4},
    sirene = 'hoog2',
    excludeSiren = {},
    Dualsirene = 'BPcall',
    sf = {},
    unique = {
        directLinks = {},
        directRechts = {},
        directCenter = {},
    }
}
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local respons = TriggerEvent("controlPanelV2:retrieveConfigs", configData, spawnVoertuig)
        Wait(1000)
        while respons == nil do
            respons = TriggerEvent("controlPanelV2:retrieveConfigs", configData, spawnVoertuig)
        end
    end
end)