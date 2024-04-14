--[[
    Welcome to the qs-banking configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]

Config = Config or {}
Locales = Locales or {}

--██████╗░░█████╗░███╗░░██╗██╗░░██╗██╗███╗░░██╗░██████╗░
--██╔══██╗██╔══██╗████╗░██║██║░██╔╝██║████╗░██║██╔════╝░
--██████╦╝███████║██╔██╗██║█████═╝░██║██╔██╗██║██║░░██╗░
--██╔══██╗██╔══██║██║╚████║██╔═██╗░██║██║╚████║██║░░╚██╗
--██████╦╝██║░░██║██║░╚███║██║░╚██╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!
]]

Config.Language = 'en' -- 'en' or 'es' by default (you can create more)

--[[
    Framework configuration and tools of your server!
    Please read the usable options carefully, in case they
    are not here you can add more or modify the default ones
    in the client/custom/* and server/custom/* directories.

    Please choose from the following options:

    Framework:
        'esx'
        'qb'

    UseTarget:
        'ox_target'
        'qb-target'

        'none'
]]

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx' -- You can change to 'qb' or 'esx'

--[[
    Select your target system:

    UseTarget:
        'ox_target'
        'qb-target'

        'none'
]]

Config.UseTarget = 'none'     -- 'ox_target', 'qb-target' or 'none'
Config.QBCoreDrawText = false -- Set true/false (you need exports['qb-core']:DrawText(...))

--[[
    Extra configurations that will serve to maintain a stable
    economy and even manage general visuals of your script
]]

Config.Symbol = '€'
Config.ShowBlips = true     -- Do you want to enable blips on the map?

Config.AtmLimit = 2500      -- Money withdrawal limit through ATMs
Config.DepositLimit = true  -- Do you want to enable Deposit limit?
Config.WithdrawLimit = true -- Do you want to enable Withdraw limit?
Config.TransferLimit = true -- Do you want to enable Transfer limit?

--[[
    This part will deal with metadata and for this you need to
    have a system compatible with metadata items. Below I will
    mention the inventories that are compatible with this function.

    'qs-inventory'
    'qb-inventory'
    'ox_inventory'
    'core_inventory'

    If you do not have these, ignore this step. Otherwise, here
    you can set the price for creating credit cards and even
    spot exclusively for creating credit cards if you want.
]]

Config.Metadata = true             -- Only use this option if you use an inventory mentioned above
Config.CreateCardPrice = 100       -- The price to create a credit card
Config.MaxiCardsCreated = 3        -- Select the maximum number of cards that a player can create, if you eliminate one you will have more spaces
Config.AttemptsCards = 3           -- If you fail the password three times, it will be blocked, increase or decrease its number here

Config.CreateCardEverywhere = true -- Can you create cards in all banks or only in the configured spots?
Config.CreateCard = {              -- Spots to create cards (optional)
    {
        coords = vec3(143.26641845703, -1042.5906982422, 29.367889404297)
    },
    -- Here you can add specific points to create cards (need Config.Metadata)
}

--[[
    Here you can add the spots of the banks you want, each one will
    have its ID so you can choose its blip. You can also add props
    considered as ATM, if it does not use metadata, they will be normal
    banks, if it uses metadata you will only be able to access using the card.
]]

Config.Bank = { -- All physical banks
    vec3(149.91, -1040.74, 29.374),
    vec3(-1212.63, -330.78, 37.59),
    vec3(-2962.47, 482.93, 15.5),
    vec3(-113.01, 6470.24, 31.43),
    vec3(314.16, -279.09, 53.97),
    vec3(-350.99, -49.99, 48.84),
    vec3(1175.02, 2706.87, 37.89),
    vec3(246.63, 223.62, 106.0)
}

--[[
    If you want to enable the ped behind the counters, you can use
    this feature to have a ped doing a specific animation inside
    the bench, if you want to disable it you can do it!
]]

Config.EnablePeds = true -- Enable or disable the peds system
Config.Peds = {
    {
        position = vector4(149.5513, -1042.1570, 29.3680, 341.6520),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(-1211.8585, -331.9854, 37.7809, 28.5983),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(-2961.0720, 483.1107, 15.6970, 88.1986),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(-112.2223, 6471.1128, 31.6267, 132.7517),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(313.8176, -280.5338, 54.1647, 339.1609),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(-351.3247, -51.3466, 49.0365, 339.3305),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(1174.9718, 2708.2034, 38.0879, 178.2974),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    {
        position = vector4(247.0348, 225.1851, 106.2875, 158.7528),
        model = `U_M_M_BankMan`,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    }
}

Config.ATMModels = { -- All ATM in your city
    'prop_atm_01',
    'prop_atm_02',
    'prop_atm_03',
    'prop_fleeca_atm'
}

--[[
    Debug mode, this mode is to receive constant prints and information
    from the system, we do not recommend enabling it if you are not a
    developer, but it will help to understand how the resource works.
]]

Config.Debug = true
Config.ZoneDebug = false
