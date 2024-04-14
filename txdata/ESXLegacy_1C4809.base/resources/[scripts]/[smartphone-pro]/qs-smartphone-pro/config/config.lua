--[[
    Welcome to the qs-smartphone-pro configuration!
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

PHONE_PATH = 'https://cfx-nui-qs-smartphone-pro/' -- Do not touch this, it is the path to the phone files.

Config = Config or {}
Locales = Locales or {}

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!

	Languages available by default:
    	'de'
    	'en'
    	'es'
    	'fr'
    	'hu'
]]

Config.Language = 'en'

--[[
    The current system will detect if you use qb-core or es_extended,
    but if you rename it, you can remove the value from Config.Framework
    and add it yourself after you have modified the framework files inside
    this script.

    Please keep in mind that this code is automatic, do not edit if
    you do not know how to do it.
]]

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'
local l2sHas = GetResourceState('l2s-core') == 'started'

Config.Framework = esxHas and 'esx' or l2sHas and 'qb' or qbHas and 'qb' or 'standalone' -- You can change to 'qb', 'esx', 'standalone'

--[[
    Inventory system, more specifically dedicated to metadata, with this you will
    be able to share your phone information with other people, since the item will
    have the information. This system will automatically detect between qs-inventory,
    qb-inventory, ox_inventory or esx_default.

    Please note that the default option does not contain metadata, therefore
    Config.UniquePhone should be disabled.
]]

local function getInventory()
    local qsInvHas = GetResourceState('qs-inventory') == 'started'
    local qbInvHas = GetResourceState('qb-inventory') == 'started'
    local l2sInvHas = GetResourceState('l2s-inventory') == 'started'
    local origenInvHas = GetResourceState('origen_inventory') == 'started'
    local psInvHas = GetResourceState('ps-inventory') == 'started'
    local oxInvHas = GetResourceState('ox_inventory') == 'started'
    local coreInvHas = GetResourceState('core_inventory') == 'started'
    local codemInvHas = GetResourceState('codem-inventory') == 'started'
    if qsInvHas then
        return 'qs-inventory'
    elseif qbInvHas or l2sInvHas or psInvHas then
        return 'qb-inventory'
    elseif origenInvHas then
        return 'origen_inventory'
    elseif oxInvHas then
        return 'ox_inventory'
    elseif coreInvHas then
        return 'core_inventory'
    elseif codemInvHas then
        return 'codem-inventory'
    else
        return 'default'
    end
end

Config.UniquePhone = getInventory() ~= 'default' and Config.Framework ~= 'standalone'
Config.Inventory = (Config.Framework == 'standalone' and 'default' or getInventory())

Config.OpenPhoneByPress = true      -- You can set false only if you are using UniquePhone (Disable F1)
Config.KeyOpenOnlyOwnedPhone = true -- Only the owner's phone will be opened with the F1 key?

local function getHouses()
    local qsHousesHas = GetResourceState('qs-housing') == 'started'
    local qbHousesHas = GetResourceState('qb-houses') == 'started'
    if qsHousesHas then
        return 'qs-housing'
    elseif qbHousesHas then
        return 'qb-houses'
    else
        return 'default'
    end
end

Config.Houses = getHouses()

Config.Prefix = '376'             -- Phone number prefix
Config.NumberDigits = 6           -- Number of digits after the prefix
Config.MailDomain = '@icloud.com' -- Choose the email domain

Config.AutoBackup = false         -- Automatically backup the phone when you turn it off
Config.DisplayRadar = true        -- Enable or disable the minimap for camera interactions

--[[
    Menu types and general/visual configurations of the asset, by default it only
    contains nh-context and ox_lib, it is always best to use ox_lib, if you want
    to create a new one, you can do so or edit it from client/custom/menu.

    IMPORTANT, this asset works with ox_target and qb-target, use only true/false!
]]

Config.Menu = 'ox_lib'   -- 'nh-context' or 'ox_lib'
Config.UseTarget = false -- bool (true/false)

-- This is a RegisterKeyMapping, see how it works here:
-- https://docs.quasar-store.com/codding-information/register-key-mapping
Config.OpenPhone = 'F1'

--[[
    Select one of the following options to run your voice,
    remember that you can edit these options in client/custom/voice
    and server/custom/voice.

    Options: pma, mumble, toko, or salty
]]

Config.Voice = 'pma' -- pma, mumble, toko, salty

Config.RepeatTimeout = 2000
Config.CallRepeats = 999999

--[[
    Default phone ringtones, you can add as many as you want, always remember
    to have the copyright controlled so as not to affect rockstar or streamers!
]]

local ringtone_path = PHONE_PATH .. '/html/sounds/ringtones/'
Config.Ringtones = {
    defaultRingtone = ringtone_path .. 'default.mp3',
    ringtones = {
        { url = ringtone_path .. 'default.mp3',  name = 'Pear' },
        { url = ringtone_path .. 'classic.mp3',  name = 'Classic' },
        { url = ringtone_path .. 'XianNomi.mp3', name = 'XianNomi' },
        { url = ringtone_path .. 'osito.mp3',    name = 'Osito Gominola' },
        { url = ringtone_path .. 'faded.mp3',    name = 'Faded' },
        { url = ringtone_path .. 'missyou.mp3',  name = 'Miss You' },
        { url = ringtone_path .. 'lifegoes.mp3', name = 'Life Goes On' }
    }
}

--[[
    The sound system comes by default with xsound, but you can purchase mx-surround,
    this script will work natively by default without you configuring anything, a high
    quality sound asset with 3d/8d sounds that will give you a great realistic system.

    You can buy mx-surround here: https://mxstore.tebex.io/package/5864855
]]

Config.MXSurround = GetResourceState('mx-surround') == 'started'
Config.MXSurroundPanner = {        -- This is a custom 3d panner for mx-surround. It doesn't work with xsound
    panningModel = 'HRTF',
    refDistance = 1.5,             -- Distance of the volume dropoff start
    rolloffFactor = 3.0,           -- How fast the volume drops off (don't 0.1)
    distanceModel = 'exponential', -- How the volume drops off (linear, inverse, exponential)
}

--[[
    This is the general configuration of phones, their colors, their props and
    their backgrounds that will come by default in the system. Remember to edit
    this having at least the basic knowledge of CSS and Lua.

    You can add infinite phones if you wish.
]]

Config.Phones = {
    ['phone'] = {
        phone = 'rgb(57, 51, 77) 0px 0px 0.1em 0.25em, rgb(211, 205, 228) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #fff, #2a2a35)'
    },
    ['white_phone'] = {
        phone = 'rgb(202, 201, 207) 0px 0px 0.1em 0.25em, rgb(128, 127, 131) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #fff, #2a2a35)'
    },
    ['yellow_phone'] = {
        phone = 'rgb(202, 199, 166) 0px 0px 0.1em 0.25em, rgb(114, 107, 97) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #fff, #2a2a35)'
    },
    ['red_phone'] = {
        phone = 'rgb(194, 84, 84) 0px 0px 0.1em 0.25em, rgb(87, 31, 31) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #fff, #b14040)'
    },
    ['green_phone'] = {
        phone = 'rgb(73, 129, 70) 0px 0px 0.1em 0.25em, rgb(40, 90, 39) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #d5f1cc, #57a865)'
    },
    ['black_phone'] = {
        phone = 'rgb(82, 82, 82) 0px 0px 0.1em 0.25em, rgb(51, 51, 51) 0px 0px 0px 0.4em',
        buttons = 'linear-gradient(90deg, #747474, #424242)'
    },
}

Config.PhonesCustomWallpaper = {
    ['phone'] = 'b2.jpg',
    ['white_phone'] = 'b1.jpg',
    ['yellow_phone'] = 'b3.jpg',
    ['red_phone'] = 'b4.jpg',
    ['green_phone'] = 'b6.jpg',
    ['black_phone'] = 'b5.jpg',
}

Config.PhonesProps = {
    ['phone'] = `ks_iphone_01`,
    ['white_phone'] = `ks_iphone_02`,
    ['yellow_phone'] = `ks_iphone_03`,
    ['red_phone'] = `ks_iphone_04`,
    ['green_phone'] = `ks_iphone_05`,
    ['black_phone'] = `ks_iphone_06`,
}

--[[
    Signal system for the telephone could be low or high depending on the area.
    In this case we did it with ox_lib zones, each zone that is created within
    the game would be a low signal zone where you will not be able to use certain
    applications that you can configure in the same config.js (Config.WorkWithWifiApps).
]]

Config.Mountains = {
    {
        coords = vec3(1849.0, 362.0, 113.0),
        size = vec3(1081.0, 1994.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 1',
    },
    {
        coords = vec3(1954.219727, -1600.285767, 380.278320),
        size = vec3(581.0, 1394.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 2',
    },
    {
        coords = vec3(747.758240, 1232.281372, 512.465088),
        size = vec3(900.0, 900.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 3',
    },
    {
        coords = vec3(-890.030762, 1260.052734, 490.257080),
        size = vec3(1900.0, 700.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 4',
    },
    {
        coords = vec3(-697.740662, 2372.030762, 340.428589),
        size = vec3(1500.0, 1520.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 5',
    },
    {
        coords = vec3(-2601.098877, 1386.118652, 340.428589),
        size = vec3(800.0, 2520.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 6',
    },
    {
        coords = vec3(-960.778015, 4467.547363, 560.807373),
        size = vec3(1800.0, 2300.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 6',
    },
    {
        coords = vec3(758.518677, 5517.468262, 856.268799),
        size = vec3(1800.0, 1800.0, 2023.0),
        rotation = 0.0,
        name = 'Mount Chiliad 7',
    },
    {
        coords = vec3(3204.184570, 4860.448242, 504.562744),
        size = vec3(700.0, 4000.0, 2023.0),
        rotation = 15.0,
        name = 'Mount Chiliad 8',
    },
    {
        coords = vec3(1560.158203, 3230.914307, 181.113525),
        size = vec3(2500.0, 500.0, 2023.0),
        rotation = 20.0,
        name = 'Mount Chiliad 9',
    }
}

--[[
    Battery and charger system, you can give a default value to each app so that
    it uses more or less battery, you can also charge the phone using the 'powerbank' item.

    It also has compatibility with qs-housing.
]]

Config.PowerbankSpeed = 1.0    -- 3 second later +1 charge
Config.HousingChargers = false -- If you using qs-housing
Config.ReturnPowerbank = false -- After charging, will the powerbank return to your inventory?

Config.Battery = {
    enabled = true,
    interval = 1000,
    default = 0.001,
    apps = {
        -- More battery is drained if these apps are open.
        ['phone'] = 0.002,
        ['whatsapp'] = 0.002,
        ['twitter'] = 0.002,
        ['settings'] = 0.002,
        ['mail'] = 0.002,
        ['state'] = 0.002,
        ['weather'] = 0.002,
        ['spotify'] = 0.002,
        ['gallery'] = 0.002,
        ['camera'] = 0.002,
        ['notes'] = 0.002,
        ['calculator'] = 0.002,
        ['youtube'] = 0.002,
        ['store'] = 0.002,
        ['crypto'] = 0.002,
        ['bank'] = 0.002,
        ['help'] = 0.002,
        ['messages'] = 0.002,
        ['tinder'] = 0.002,
        ['clock'] = 0.002,
        ['houses'] = 0.002,
        ['yellowpages'] = 0.002,
        ['rentel'] = 0.002,
        ['tetris'] = 0.002,
        ['uber'] = 0.002,
        ['darkweb'] = 0.002,
        ['racing'] = 0.002,
        ['darkchat'] = 0.002,
        ['uberRider'] = 0.002,
        ['tiktok'] = 0.002,
        ['market'] = 0.002
    }
}

Config.ChargeCoordsMarker = {
    marker = 2,
    color = { 255, 255, 255, 255 },
}

Config.ChargeCoords = {
    {
        coords = vec3(25.882116, -1341.416138, 29.397023),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-42.846802, -1755.070435, 29.34313),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(1129.596680, -981.305786, 46.315859),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(19.335779, -1103.538940, 29.697037),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-666.523926, -934.613037, 21.729231),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-704.892212, -908.886719, 19.115588),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-1220.993774, -912.881836, 12.226359),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(1164.968506, -317.935669, 69.10504),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(255.742645, -47.225620, 69.841032),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-1302.567993, -391.261780, 36.595755),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-1481.958374, -376.235596, 40.063452),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(375.456482, 331.734283, 103.466353),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(2571.713379, 291.965973, 108.634848),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(2551.379639, 382.528137, 108.522986),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(2673.661621, 3283.618896, 55.141119),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(1701.339600, 4919.229980, 41.96369),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(1731.790039, 6419.871582, 34.937209),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-334.757660, 6082.848633, 31.35476),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-3175.626709, 1085.157104, 20.738764),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-3248.010742, 1002.042542, 12.730703),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-3044.983887, 584.189758, 7.808927),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
    {
        coords = vec3(-2962.195801, 388.839691, 14.943318),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge
    },
}

--[[
    Public telephone system, you can create as many public telephones as you want,
    these can be used by players to make calls with a payment of money.

    This system includes beautiful cinematics that will be super realistic and players will love.
]]

Config.PhoneBoothBlip = {
    active = false,
    sprite = 459,
    color = 2,
    scale = 0.8,
    name = 'Phone Booth',
}

Config.PhoneBooths = {
    { coords = vec4(128.940659, -2009.749390, 17.013823, 75.118103) },
    { coords = vec4(461.042816, -1852.384643, 26.57, 223.70495605) },
    { coords = vec4(252.936264, -2076.553955, 16.012837, 138.645660) },
    { coords = vec4(378.593414, -2147.301025, 14.601123, 29.094498) },
    { coords = vec4(406.918671, -1613.696655, 27.99307, 141.732285) },
    { coords = vec4(313.621979, -1691.129639, 28.044136, 141.732285) },
    { coords = vec4(38.676926, -1698.527466, 27.999007, 192.755920) },
    { coords = vec4(12.606594, -1532.162598, 27.989907, 48.188972) },
    { coords = vec4(209.723083, -1408.984619, 27.989907, 150.236221) },
    { coords = vec4(48.052750, -1379.274780, 27.979907, 2.834646) },
    { coords = vec4(-342.356049, -1471.872559, 29.465728, 87.874016) },
    { coords = vec4(-37.753845, -1115.314331, 25.132251, 246.614166) },
    { coords = vec4(-227.169220, -943.239563, 27.981307, 68.031494) },
    { coords = vec4(197.261536, -846.659363, 29.513232, 340.157471) },
    { coords = vec4(-53.419781, -721.846130, 42.959399, 153.070862) },
    { coords = vec4(-282.817566, -646.008789, 31.905811, 192.755920) },
    { coords = vec4(168.131866, -427.846161, 39.757861, 73.700790) },
    { coords = vec4(-359.419769, -267.929657, 32.343921, 51.023624) },
    { coords = vec4(-0.079117, -152.334061, 55.057544, 342.992126) },
    { coords = vec4(322.628571, -236.795593, 52.698535, 342.992126) },
    { coords = vec4(549.613159, 85.674728, 94.721973, 155.905502) },
    { coords = vec4(93.652756, 252.118683, 107.190845, 161.574799) },
    { coords = vec4(-64.602196, 180.949448, 86.044360, 221.102371) },
    { coords = vec4(240.342865, 83.947258, 91.149829, 158.740158) },
    { coords = vec4(-35.723076, -243.652740, 44.711719, 158.740158) },
    { coords = vec4(478.562653, 263.274719, 101.815723, 161.574799) },
    { coords = vec4(466.720886, -665.670349, 25.823047, 0.000000) },
    { coords = vec4(418.958252, -990.751648, 28.013599, 269.291351) },
    { coords = vec4(378.593414, -1125.257202, 28.097827, 175.748032) },
    { coords = vec4(759.599976, -889.107666, 23.852766, 90.708656) },
    { coords = vec4(809.789001, -1417.134033, 25.907275, 90.708656) },
    { coords = vec4(812.492310, -1968.909912, 27.912402, 257.952759) },
    { coords = vec4(723.626404, -2377.186768, 20.700732, 266.456696) },
    { coords = vec4(-1026.250488, -2743.833008, 18.864062, 240.944885) },
    { coords = vec4(-1205.103271, -1394.334106, 2.772510, 294.803162) },
    { coords = vec4(-1288.008789, -1092.514282, 5.805469, 204.094498) },
    { coords = vec4(-940.193420, -1199.314331, 3.817188, 212.598419) },
    { coords = vec4(-1099.846191, -806.043945, 16.9293823, 223.937012) },
    { coords = vec4(-687.032959, -675.336243, 29.631152, 181.417328) },
    { coords = vec4(-885.665955, -848.861511, 17.819385, 102.047249) },
    { coords = vec4(-1047.665894, -2084.070312, 12.157886, 229.606293) },
    { coords = vec4(1036.839600, -2249.960449, 30.574756, 87.874016) },
    { coords = vec4(1705.028564, -1639.424194, 111.167407, 99.212593) },
    { coords = vec4(948.3318481, -1740.544189, 29.8673049, 81.908905029) },
    { coords = vec4(1210.639404, -1282.588989, 34.0762893, 355.61618041) },
    { coords = vec4(-161.025924, -2632.566405, 4.73147220, 180.7557830) },
    { coords = vec4(1174.21386, -420.926635, 65.8176223, 73.64119720459) },
    { coords = vec4(1074.07434, -776.59481, 56.946246, 180.815017) },
    { coords = vec4(-694.045105, -278.991913, 34.991885, 122.858719) },
    { coords = vec4(-501.531799, -179.227325, 36.470996, 299.185577) },
    { coords = vec4(-616.994324, -420.016479, 33.463351, 85.884285) },
    { coords = vec4(-1002.513611, -391.252991, 36.660812, 115.867989) },
    { coords = vec4(-1252.519287, -538.408691, 29.098666, 131.531464) },
    { coords = vec4(-1470.224731, -708.601074, 24.366431, 139.815094) },
    { coords = vec4(-1541.711182, -467.244110, 34.132556, 31.676353) },
    { coords = vec4(553.173401, -2974.109619, 4.744457, 266.889771) },
    { coords = vec4(565.620667, -2722.715332, 4.75601, 2.830631) },
    { coords = vec4(754.894714, -3048.252197, 4.859356, 93.493866) },
    { coords = vec4(-1432.962769, -262.947510, 44.964626, 308.605591) },
    { coords = vec4(-1683.513306, -384.245758, 46.872443, 50.254704) },
    { coords = vec4(-1103.391113, -143.627167, 36.973937, 152.198273) },
    { coords = vec4(-464.103973, 144.347794, 63.170215, 2.164905) },
    { coords = vec4(811.837402, -173.348846, 71.396304, 336.024445) },
    { coords = vec4(-2289.707764, 419.038330, 173.301517, 153.477661) },
    { coords = vec4(-2958.663086, 447.199615, 13.995901, 359.032166) },
    { coords = vec4(-3037.492920, 587.248047, 6.511921, 111.270958) },
    { coords = vec4(-3146.152344, 1119.066895, 19.544858, 61.374123) },
    { coords = vec4(-1515.575806, 1499.105347, 113.837917, 78.183487) },
    { coords = vec4(2588.658447, 431.040131, 107.313152, 270.350830) },
    { coords = vec4(936.932983, 102.091782, 78.268443, 53.319496) },
    { coords = vec4(2745.979980, 3458.693115, 54.52346, 68.488243) },
    { coords = vec4(1692.605713, 3740.936035, 32.642169, 33.795506) },
    { coords = vec4(1937.438965, 3897.668213, 31.172103, 116.251793) },
    { coords = vec4(903.353943, 3656.837891, 31.289413, 275.263306) },
    { coords = vec4(595.806091, 2745.105957, 40.721877, 6.903358) },
    { coords = vec4(-1129.925537, 2677.800781, 17.0526, 311.245636) },
    { coords = vec4(-112.213196, 6306.829590, 30.204498, 134.958008) },
    { coords = vec4(1692.239746, 6432.220215, 31.462497, 334.389343) },
    { coords = vec4(1654.029785, 4888.356445, 40.742793, 102.488831) },
    { coords = vec4(2465.498047, 4949.440430, 43.957549, 183.070557) },
    { coords = vec4(-1878.619507, 2091.767334, 139.693729, 345.417999) },
}

--[[
    This configuration is the phone repairer. If you lost your phone password or don't know
    what a phone's password is, you can go to it and it will reset your password.
]]

Config.ResetPassword = {
    coords = vec3(1000.32, -103.89, 73.95),
    ped = {
        coords = vec4(1000.32, -103.89, 73.95, 121.65),
        model = `a_m_m_afriamer_01`
    },
    blip = {
        coords = vec3(1000.32, -103.89, 73.95),
        name = 'Technical',
        sprite = 89,
        color = 1,
        scale = 0.5
    },
    money = 500
}

--[[
    The recipe system refers to the telephone balance system, you can enable
    or disable the option that a telephone plan is necessary to be able to
    communicate with other players through calls.

    You will have two types of telephone plans, one with a daily balance
    and another with a temporary balance.
]]

Config.EnableRecipe = false
Config.BuyRecipe = {
    coords = {
        vec3(324.93, -229.56, 54.22)
    },
    prices = {
        daily = 100000, -- Daily pay 100000$
        moment = 1000,  -- 1 recipe 1000$
    },
    blip = {
        sprite = 52,
        color = 2,
        scale = 0.8,
        name = 'Recipe Shop',
    }
}

--[[
    Job system for multiple applications, here you can configure the system of
    workers necessary for certain applications that will be discussed one by one.

    Within the Settings application you can enter service without using a command.

    Please read one by one what are the config.
]]

-- News Application, here you can configure the workers who can post new news.
Config.WeazelJob = {
    'police',
    'weazel'
}

-- Here you can select which workers can use the /sendbill command.
Config.BillJobs = {
    'police',
    'ambulance'
}

-- SOS message when life is under Config.SOSHealth
Config.SOSMessage = true
Config.SOSJob = 'ambulance'
Config.SOSHealth = 25

-- Workers through the contacts, phone and messages app!
-- These can be put into service using the settings app in the Duty option.
Config.Jobs = {
    'police',
    'ambulance',
    'mechanic',
    'taxi'
}

Config.jobNumbers = {
    ['police'] = '911', -- Just enter a number here, this is the number that will appear when you call
    ['ambulance'] = '912',
    ['mechanic'] = '913',
}

Config.JobLabels = {
    ['police'] = 'Police',
    ['ambulance'] = 'Ambulance',
    ['mechanic'] = 'Mechanic',
    ['taxi'] = 'Taxi'
}

-- These are the Job Center application jobs, the jobs that players can apply for.
Config.JobCenter = {
    [1] = {
        job = 'trucker',
        label = 'Trucker',
        Coords = { 141.18, -3204.59 },
    },
    [2] = {
        job = 'taxi',
        label = 'Taxi Driver',
        Coords = { 909.49, -177.24 },
    },
    [3] = {
        job = 'tow',
        label = 'Towing',
        Coords = { 489.67, -1331.82 },
    },
    [4] = {
        job = 'reporter',
        label = 'News Reporter',
        Coords = { -552.29, -925.59 },
    },
    [5] = {
        job = 'garbage',
        label = 'Trash Collector',
        Coords = { -313.85, -1522.82 },
    },
    [6] = {
        job = 'bus',
        label = 'Bus Driver',
        Coords = { 462.22, -641.15 },
    },
}

--[[
    Vehicle systems, valet prices, uber colors, models for uber, etc.
    Configure it to your liking. Remember that these values are the ones that the
    Uber and Garages applications will bring.

    The vehiclekeys system will automatically detect your vehiclekeys
    or will display 'none' if none are used. The default vehiclekeys are:
        'mono_carkeys'
        'qb-vehiclekeys'
        'qs-vehiclekeys'
        'vehicle_keys'
        'wasabi_carlock'

    If you don't use any, directly ignore this!
]]

local qsGarage = GetResourceState('qs-advancedgarages') == 'started'
local jgGarage = GetResourceState('jg-advancedgarages') == 'started'
local cdGarage = GetResourceState('cd_garage') == 'started'
local lfGarage = GetResourceState('loaf_garage') == 'started'
local okGarage = GetResourceState('okokGarage') == 'started'
local codemGarage = GetResourceState('codem-garage') == 'started'

Config.Garage = qsGarage and 'qs-advancedgarages' or jgGarage and 'jg-advancedgarages' or cdGarage and 'cd_garage' or lfGarage and 'loaf_garage' or okGarage and 'okokGarage' or codemGarage and 'codem-garage' or 'default'

local keysMn = GetResourceState('mono_carkeys') == 'started'
local keysQb = GetResourceState('qb-vehiclekeys') == 'started'
local keysQs = GetResourceState('qs-vehiclekeys') == 'started'
local keysJs = GetResourceState('vehicle_keys') == 'started'
local keysWb = GetResourceState('wasabi_carlock') == 'started'
local keysMk = GetResourceState('mk_vehiclekeys') == 'started'
local keysOk = GetResourceState('okokGarage') == 'started'

Config.Vehiclekeys = keysMn and 'mono_carkeys' or keysQb and 'qb-vehiclekeys' or keysQs and 'qs-vehiclekeys' or keysJs and 'vehicle_keys' or keysWb and 'wasabi_carlock' or keysMk and 'mk_vehiclekeys' or keysOk and 'okokGarage' or 'none'

Config.Valet = true      -- Enable or disable the valet system
Config.ValetPrice = 1000 -- Price that the valet will charge

Config.Colors = {
    [0] = 'Metallic Black',
    [1] = 'Metallic Graphite Black',
    [2] = 'Metallic Black Steel',
    [3] = 'Metallic Dark Silver',
    [4] = 'Metallic Silver',
    [5] = 'Metallic Blue Silver',
    [6] = 'Metallic Steel Grey',
    [7] = 'Metallic Shadow Silver',
    [8] = 'Metallic Stone Silver',
    [9] = 'Metallic Midnight Silver',
    [10] = 'Metallic Weapon Metal',
    [11] = 'Metallic Anthracite Grey',
    [12] = 'Matte Black',
    [13] = 'Matte Grey',
    [14] = 'Matte Light Grey',
    [15] = 'Util Black',
    [16] = 'Util Black Poly',
    [17] = 'Util Dark silver',
    [18] = 'Util Silver',
    [19] = 'Util Gun Metal',
    [20] = 'Util Shadow Silver',
    [21] = 'Worn Black',
    [22] = 'Worn Graphite',
    [23] = 'Worn Silver Grey',
    [24] = 'Worn Silver',
    [25] = 'Worn Blue Silver',
    [26] = 'Worn Shadow Silver',
    [27] = 'Metallic Red',
    [28] = 'Turin Red Metallic',
    [29] = 'Metallic Formula Red',
    [30] = 'Metallic Blaze Red',
    [31] = 'Metallic Elegant Red',
    [32] = 'Metallic Garnet Red',
    [33] = 'Metallic Desert Red',
    [34] = 'Cabernet Red Metallic',
    [35] = 'Metallic Candy Red',
    [36] = 'Metallic Sunrise Orange',
    [37] = 'Metallic Classic Gold',
    [38] = 'Metallic Orange',
    [39] = 'Matte Red',
    [40] = 'Matte Dark Red',
    [41] = 'Matte Orange',
    [42] = 'Matte Yellow',
    [43] = 'Util Red',
    [44] = 'Util Brilliant Red',
    [45] = 'Util Garnet Red',
    [46] = 'Worn Red',
    [47] = 'Golden Red Worn',
    [48] = 'Dark Red Worn',
    [49] = 'Metallic Dark Green',
    [50] = 'Race Green Metallic',
    [51] = 'Metallic Sea Green',
    [52] = 'Metallic Olive Green',
    [53] = 'Metallic Green',
    [54] = 'Metallic Petrol Blue Green',
    [55] = 'Matte Lime Green',
    [56] = 'Util Dark Green',
    [57] = 'Util Green',
    [58] = 'Dark Worn Green',
    [59] = 'Weathered Green',
    [60] = 'Worn Sea Wash',
    [61] = 'Metallic Midnight Blue',
    [62] = 'Metallic Dark Blue',
    [63] = 'Saxon Blue Metallic',
    [64] = 'Metallic Blue',
    [65] = 'Metallic Marine Blue',
    [66] = 'Port Metallic Blue',
    [67] = 'Metallic Diamond Blue',
    [68] = 'Metallic Surf Blue',
    [69] = 'Metallic Teal',
    [70] = 'Metallic Brilliant Blue',
    [71] = 'Metallic Purple Blue',
    [72] = 'Metallic Spinnaker Blue',
    [73] = 'Metallic Ultra Blue',
    [74] = 'Metallic Brilliant Blue',
    [75] = 'Util Dark Blue',
    [76] = 'Util Midnight Blue',
    [77] = 'Util Blue',
    [78] = 'Util Sea Foam Blue',
    [79] = 'Util Light blue',
    [80] = 'Util Maui Blue Poly',
    [81] = 'Util Brilliant Blue',
    [82] = 'Matte Dark Blue',
    [83] = 'Matte Blue',
    [84] = 'Matte Midnight Blue',
    [85] = 'Worn Dark blue',
    [86] = 'Worn Blue',
    [87] = 'Worn Light blue',
    [88] = 'Metallic Taxi Yellow',
    [89] = 'Race Metallic Yellow',
    [90] = 'Metallic Bronze',
    [91] = 'Metallic Yellow Bird',
    [92] = 'Metallic Lime',
    [93] = 'Metallic Champagne',
    [94] = 'Metallic Pueblo Beige',
    [95] = 'Metallic Dark Ivory',
    [96] = 'Metallic Choco Brown',
    [97] = 'Metallic Gold Brown',
    [98] = 'Metallic Light Brown',
    [99] = 'Metallic Mesh Beige',
    [100] = 'Metallic Moss Brown',
    [101] = 'Metallic Biston Brown',
    [102] = 'Metallic Beech Wood',
    [103] = 'Metallic Dark Beech',
    [104] = 'Metallic Choco Orange',
    [105] = 'Metallic Beach Sand',
    [106] = 'Metallic Sun Bleeched Sand',
    [107] = 'Metallic Cream',
    [108] = 'Util Coffee',
    [109] = 'Util Medium Brown',
    [110] = 'Util Light Brown',
    [111] = 'Metallic White',
    [112] = 'Metallic Frost White',
    [113] = 'Weathered Honey Beige',
    [114] = 'Worn Brown',
    [115] = 'Worn Dark Brown',
    [116] = 'Worn straw beige',
    [117] = 'Brushed Steel',
    [118] = 'Brushed Black steel',
    [119] = 'Brushed Aluminum',
    [120] = 'Chrome',
    [121] = 'Worn White',
    [122] = 'Util Off-White',
    [123] = 'Worn Orange',
    [124] = 'Worn Light Orange',
    [125] = 'Metallic Securicor Green',
    [126] = 'Worn Taxi Yellow',
    [127] = 'police car blue',
    [128] = 'Matte Green',
    [129] = 'Matte Brown',
    [130] = 'Worn Orange',
    [131] = 'Matte White',
    [132] = 'Worn White',
    [133] = 'Worn Olive Army Green',
    [134] = 'Pure White',
    [135] = 'Hot Pink',
    [136] = 'Salmon pink',
    [137] = 'Metallic Vermillion Pink',
    [138] = 'Orange',
    [139] = 'Green',
    [140] = 'Blue',
    [141] = 'Metallic Black Blue',
    [142] = 'Metallic Black Purple',
    [143] = 'Metallic Black Red',
    [144] = 'hunter green',
    [145] = 'Metallic Purple',
    [146] = 'Metallic V Dark Blue',
    [147] = 'MODSHOP BLACK',
    [148] = 'Matte Purple',
    [149] = 'Matte Dark Purple',
    [150] = 'Metallic Lava Red',
    [151] = 'Matte Forest Green',
    [152] = 'Matte Olive Green',
    [153] = 'Matte Desert Brown',
    [154] = 'Matte Desert Tan',
    [155] = 'Matte Foilage Green',
    [156] = 'DEFAULT ALLOY COLOR',
    [157] = 'Epsilon Blue',
    [158] = 'Pure Gold',
    [159] = 'Brushed Gold',
    [160] = 'Red',
    [161] = 'Anod Red',
    [162] = 'Anod Wine',
    [163] = 'Anod Purple',
    [164] = 'Anod Blue',
    [165] = 'Anod Green',
    [166] = 'Anod Lime',
    [167] = 'Anod Copper',
    [168] = 'Anod Bronze',
    [169] = 'Anod Champagne',
    [170] = 'Anod Gold',
    [171] = 'Green Blue Flip',
    [172] = 'Green Red Flip',
    [173] = 'Green Brow Flip',
    [174] = 'Green Turq Flip',
    [175] = 'Green Purp Flip',
    [176] = 'Teal Red Flip',
    [177] = 'Turq Red Flip',
    [178] = 'Turq Purp Flip',
    [179] = 'Cyan Puro Flip',
    [180] = 'Blue Pink Flip',
    [181] = 'Blue Green Flip',
    [182] = 'Purp Red Flip',
    [183] = 'Purp Green Flip',
    [184] = 'Magen Gree Flip',
    [185] = 'Magen Yell Flip',
    [186] = 'Burg Green Flip',
    [187] = 'Magen Cyan Flip',
    [188] = 'Coppe Purp Flip',
    [189] = 'Magen Orange Flip',
    [190] = 'Red Orange Flip',
    [191] = 'Orange Purp Flip',
    [192] = 'Orange Blue Flip',
    [193] = 'White Purp Flip',
    [194] = 'Red Rainbow Flip',
    [195] = 'Blue Rainbow Flip',
    [196] = 'Dark Green Pearl',
    [197] = 'Dark Teal Pearl',
    [198] = 'Dark Blue Pearl',
    [199] = 'Dar Purple Pearl',
    [200] = 'Oil Slick Pearl',
    [201] = 'Lit Green Pearl',
    [202] = 'Lit Blue Pearl',
    [203] = 'Lit Purp Pearl',
    [204] = 'Lit Pink Pearl',
    [205] = 'Offwhite Prisma',
    [206] = 'Pink Pearl',
    [207] = 'Yellow Pearl',
    [208] = 'Green Pearl',
    [209] = 'Blue Pearl',
    [210] = 'Cream Pearl',
    [211] = 'White Prisma',
    [212] = 'Graphite Prisma',
    [213] = 'Dark Blue Prisma',
    [214] = 'Dark Purple Prisma',
    [215] = 'Hot Pink Prisma',
    [216] = 'Red Prisma',
    [217] = 'Green Prisma',
    [218] = 'Black Prisma',
    [219] = 'Oil Slic Prisma',
    [220] = 'Rainbow Prisma',
    [221] = 'Black Holo',
    [222] = 'White Holo',
}

Config.Classes = {
    [0] = 'COMPACT',       -- Compacts
    [1] = 'SEDAN',         -- Sedans
    [2] = 'SUV',           -- SUVs
    [3] = 'COUPE',         -- Coupes
    [4] = 'MUSCLE',        -- Muscle
    [5] = 'SPORT CLASSIC', -- Sports Classics
    [6] = 'SPORT',         -- Sports
    [7] = 'SUPER',         -- Super
    [8] = 'MOTOR',         -- Motorcycles
    [9] = 'OFFROAD',       -- Off-road
}

--[[
    Configuration of Uber Eats and Uber Eats, here you can configure the price for trips.
    Choose carefully so as not to break your budget. Below you can choose the value of
    the Uber Eats tips and items.
]]

Config.UberTipMin = 30
Config.UberTipMax = 50
Config.UberPriceMultiplier = 1.5

Config.RequestSecureUber = 5000 -- Minimum money to order an Uber, in case of cancellation this money will be given to the driver for canceling a pending trip.

Config.UberDelivery = {
    [1] = { ['x'] = 8.69, ['y'] = -243.09, ['z'] = 47.66 },
    [2] = { ['x'] = 113.74, ['y'] = -277.95, ['z'] = 54.51 },
    [3] = { ['x'] = 201.56, ['y'] = -148.76, ['z'] = 61.47 },
    [4] = { ['x'] = -206.84, ['y'] = 159.49, ['z'] = 74.08 },
    [5] = { ['x'] = 38.83, ['y'] = -71.64, ['z'] = 63.83 },
    [6] = { ['x'] = 47.84, ['y'] = -29.16, ['z'] = 73.71 },
    [7] = { ['x'] = -264.41, ['y'] = 98.82, ['z'] = 69.27 },
    [8] = { ['x'] = -419.34, ['y'] = 221.12, ['z'] = 83.6 },
    [9] = { ['x'] = -998.43, ['y'] = 158.42, ['z'] = 62.31 },
    [10] = { ['x'] = -1026.57, ['y'] = 360.64, ['z'] = 71.36 },
    [11] = { ['x'] = -967.06, ['y'] = 510.76, ['z'] = 82.07 },
    [12] = { ['x'] = -1009.64, ['y'] = 478.93, ['z'] = 79.41 },
    [13] = { ['x'] = -1308.05, ['y'] = 448.59, ['z'] = 100.86 },
    [14] = { ['x'] = 557.39, ['y'] = -1759.57, ['z'] = 29.31 },
    [15] = { ['x'] = 325.1, ['y'] = -229.59, ['z'] = 54.22 },
    [16] = { ['x'] = 414.82, ['y'] = -217.57, ['z'] = 59.91 },
    [17] = { ['x'] = 430.85, ['y'] = -941.91, ['z'] = 29.19 },
    [18] = { ['x'] = -587.79, ['y'] = -783.53, ['z'] = 25.4 },
    [19] = { ['x'] = -741.54, ['y'] = -982.28, ['z'] = 17.44 },
    [20] = { ['x'] = -668.23, ['y'] = -971.58, ['z'] = 22.34 },
    [21] = { ['x'] = -664.21, ['y'] = -1218.25, ['z'] = 11.81 },
    [22] = { ['x'] = 249.99, ['y'] = -1730.79, ['z'] = 29.67 },
    [23] = { ['x'] = 405.77, ['y'] = -1751.18, ['z'] = 29.71 },
    [24] = { ['x'] = 454.96, ['y'] = -1580.25, ['z'] = 32.82 },
    [25] = { ['x'] = 278.81, ['y'] = -1117.96, ['z'] = 29.42 },
    [26] = { ['x'] = 101.82, ['y'] = -819.49, ['z'] = 31.31 },
    [27] = { ['x'] = -416.72, ['y'] = -186.79, ['z'] = 37.45 },
}

Config.UberItems = {
    [1] = { ['item'] = 'phone', ['name'] = 'Phone', ['price'] = 300 },
    [2] = { ['item'] = 'sandwich', ['name'] = 'Sandwich', ['price'] = 200 },
    [3] = { ['item'] = 'water_bottle', ['name'] = 'Water Bottle', ['price'] = 120 },
    [4] = { ['item'] = 'repairkit', ['name'] = 'Repair kit', ['price'] = 200 },
}

--[[
    Configuration of the Marketplace app markets, here you can add different companies,
    jobs or ventures so that your players can manage their clients in the best way.
]]

Config.Market = {
    Management = {}
}

Config.Market.Management.Deposit = true
Config.Market.Management.Withdraw = true
Config.Market.Management.Hire = true
Config.Market.Management.Fire = true
Config.Market.Management.Promote = true

Config.Markets = {
    {
        id = 1, -- Market id (unique)
        name = 'Los Santos Police Department',
        image = 'https://static.wikia.nocookie.net/gtawiki/images/d/dc/MissionRowPoliceStation-GTAV.png',
        description = 'The city police, always willing to help you, let us know if you have any problems in Los Santos.',
        job = {
            'police',
            'sheriff',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(452.12, -980.55, 30.69)
    },
    {
        id = 2, -- Market id (unique)
        name = 'Pillbox Medical Center',
        image = 'https://static.wikia.nocookie.net/esgta/images/e/e7/PillboxHillMedicalCenterGTAV.png',
        description = 'If you need a doctor, contact the Los Santos Emergency Center!',
        job = {
            'ambulance',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(335.12, -584.55, 43.69)
    },
    {
        id = 3, -- Market id (unique)
        name = 'Bean Machine',
        image = 'https://cdnb.artstation.com/p/assets/images/images/062/724/785/large/synced3d-unbenannt.jpg',
        description = 'The best coffee shop in the city now with home delivery, order your coffee, cappuccino, with milk, or whatever you want, call us now!',
        job = {
            'beanmachine',
            'deliver',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(280.799988, -963.982422, 29.414673)
    },
    {
        id = 4, -- Market id (unique)
        name = 'Jamaican Roast',
        image = 'https://pbs.twimg.com/media/D3KNTUcW4AAQwRQ.jpg',
        description = 'Home delivery, in-store sales, try the best cappuccino in all of Los Santos, Toasts, Meals, Grill, come or order your order!',
        job = {
            'jamaican',
            'deliver',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(273.468140, -832.971436, 29.397827)
    },
    {
        id = 5, -- Market id (unique)
        name = 'Pizza This',
        image = 'https://img.gta5-mods.com/q95/images/foodworks-food-delivery-pack/20d2bc-7.jpg',
        description = 'The best pizzeria in Los Santos, since 1988 we have brought the best Italian pizza to your palate, choose your flavor and contact us!',
        job = {
            'pizzajob',
            'deliver',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(287.736267, -963.969238, 29.414673)
    },
    {
        id = 6, -- Market id (unique)
        name = 'Bennys Original Motor Works',
        image = 'https://static.wikia.nocookie.net/esgta/images/6/64/GTAOnlineLowrider5.jpg',
        description = 'The best mechanic company in the city allows you to request home orders or direct contact through Marketplace, get in touch if you need a repair, we are here!',
        job = {
            'mechanic',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(-206.004395, -1310.281372, 31.285034)
    },
    {
        id = 7, -- Market id (unique)
        name = 'Premium Deluxe Motorsport',
        image = 'https://i.ytimg.com/vi/M6ZNvc7dpR4/maxresdefault.jpg',
        description = 'Order your new car, ask for prices and even vehicle delivery, what are you waiting for to receive your new sports car?',
        job = {
            'dealership',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(-45.362637, -1107.309937, 26.432251)
    },
    {
        id = 8, -- Market id (unique)
        name = 'Vanilla Unicorn',
        image = 'https://static.wikia.nocookie.net/esgta/images/a/ae/VanillaUnicornfrente.png',
        description = 'Come have a beer, a drink or even enjoy the best women/men in the entire city, place your alcohol order or reserve your favorite woman/man!',
        job = {
            'unicornjob',
        },
        bossRanks = {
            'boss',
            'lieutenant'
        },
        coords = vec3(128.795609, -1297.265869, 29.145020)
    },
    -- You can add or edit the jobs you want
}

--[[
    The entire illegal Darkweb system can be configured here, choose the
    values you want, in Config.Darkweb you can configure the items and the
    maximum duration of the delivery mini-game.
]]

Config.ChatSeller = 'csb_sol'
Config.SellerLocation = vector4(328.14, -940.16, 29.41, 182.57)

Config.DarkWebCoords = {
    vec3(93.45, -1928.67, 20.79),
    vec3(1134.81, -416.3, 67.05),
}

Config.Darkweb = {
    List = {
        [1] = { item = 'weapon_snspistol', label = 'SNS Pistol', price = 2500, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [2] = { item = 'weapon_minismg', label = 'Mini SMG', price = 2800, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [3] = { item = 'weapon_microsmg', label = 'Micro SMG', price = 3000, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [4] = { item = 'weapon_bullpuprifle', label = 'Bullpup Rifle', price = 4000, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [5] = { item = 'weapon_carbinerifle', label = 'Carbine Rifle', price = 9000, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [6] = { item = 'weapon_sawnoffshotgun', label = 'Shotgun', price = 12000, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [7] = { item = 'weapon_sniperrifle', label = 'Sniper Rifle', price = 28000, isWeapon = true, deliveryTime = 1 * 60 * 1000 },
        [8] = { item = 'url_weapontint', label = 'Custom Weapon Tint', price = 2000, isWeapon = false, deliveryTime = 1 * 60 * 1000 },
        [9] = { item = 'weapon_molotov', label = 'Molotov', price = 500, isWeapon = false, deliveryTime = 1 * 60 * 1000 },
        [10] = { item = 'weapon_stickybomb', label = 'Sticky Bomd', price = 900, isWeapon = false, deliveryTime = 1 * 60 * 1000 },
    },
}

--[[
    Coordinates that appear by default in the Map application, you can add
    as many as you want and people will be able to make waypoints there.
]]

Config.DefaultPhoneMapBlips = {
    {
        name = 'Hell Yeah',
        x = 0,
        y = 0,
        icon = 'https://cdn-icons-png.flaticon.com/512/0/619.png',
    }
}

--[[
    Vehicle rental and your vehicles and spawn points, choose the ones you want
]]

Config.RentelVehicles = {
    ['tribike3'] = { ['model'] = 'tribike3', ['label'] = 'Classic ARO 26', ['price'] = 100 },
    ['bmx'] = { ['model'] = 'bmx', ['label'] = 'BMX Zprinter Myland', ['price'] = 120 },
    ['panto'] = { ['model'] = 'panto', ['label'] = 'Smark Fortwo', ['price'] = 250 },
    ['felon'] = { ['model'] = 'felon', ['label'] = 'Merced Benz E', ['price'] = 400 },
}

Config.RentelLocations = {
    ['Courthouse Paystation'] = {
        ['coords'] = vector4(129.93887, -898.5326, 30.148599, 166.04177)
    },
    ['Train Station'] = {
        ['coords'] = vector4(-213.4004, -1003.342, 29.144016, 345.36584)
    },
    ['Bus Station'] = {
        ['coords'] = vector4(416.98699, -641.6024, 28.500173, 90.011344)
    },
    ['Morningwood Blvd'] = {
        ['coords'] = vector4(-1274.631, -419.1656, 34.215377, 209.4456)
    },
    ['South Rockford Drive'] = {
        ['coords'] = vector4(-682.9262, -1112.928, 14.525076, 37.729667)
    },
    ['Tinsel Towers Street'] = {
        ['coords'] = vector4(-716.9338, -58.31439, 37.472839, 297.83691)
    }
}

--[[
    Complete Crypto application system, you can edit it as you like and add your values
    as you wish. Be careful as this could break your finances if you manage it poorly.
]]

Crypto = {
    Lower = 500,
    Upper = 5000,
    History = {
        ['btc'] = {}
    },

    Worth = {
        ['btc'] = 1000
    },

    Labels = {
        ['btc'] = 'BTC'
    },

    Exchange = {
        coords = vector3(1276.21, -1709.88, 54.57),
        RebootInfo = {
            state = false,
            percentage = 0
        },
    },

    -- For auto updating the value of btc
    Coin = 'btc',
    RefreshTimer = 10, -- In minutes, so every 10 minutes.

    -- Crashes or luck
    ChanceOfCrashOrLuck = 2, -- This is in % (1-100)
    Crash = { 20, 80 },      -- Min / Max
    Luck = { 20, 45 },       -- Min / Max

    -- If not not Chance of crash or luck, then this shit
    ChanceOfDown = 30,      -- If out of 100 hits less or equal to
    ChanceOfUp = 60,        -- If out of 100 is greater or equal to
    CasualDown = { 1, 10 }, -- Min / Max (If it goes down)
    CasualUp = { 1, 10 },   -- Min / Max (If it goes up)
}

Ticker = {
    Enabled = false,               -- Decide whether the real life price ticker should be enabled or not :)
    coin = 'BTC',                  -- The coin, please make sure you find the actual name, for example: Bitcoin vs BTC, BTC would be correct
    currency = 'USD',              -- For example USD, NOK, SEK, EUR, CAD and more here https://www.countries-ofthe-world.com/world-currencies.html
    tick_time = 2,                 -- Minutes (Minimum is 2 minutes) 20,160 Requests a month, Its recommended to get the free API key so the crypto script doesnt switch on and off if ratelimit is encountered
    Api_key = 'add_your_key_here', -- If you decide to get an api key for the API (https://min-api.cryptocompare.com/pricing) The free plan should be more than enough for 1 Fivem server
    --- Error handle stuff, for more user friendly and readable errors, Don't touch.
    Error_handle = {
        ['fsym is a required param.'] = 'Config error: Invalid / Missing coin name',
        ['tsyms is a required param.'] = 'Config error: Invalid / Missing currency',
        ['cccagg_or_exchange'] = 'Config error: Invalid currency / coin combination', -- For some reason api throws this error if either coin or currency is invalid
    },
}

--[[
    Whitelist system for racing app, you can create races being an administrator or
    having the role here, manage it with the identifier.
]]

Config.RaceSetupAllowed = true
Config.WhitelistedCreators = {
    'PUTCID',
}

Config.InstagramShowAllPostsEveryone = true -- If true, everyone can see all posts, if false, only followers can see posts

--[[
    All the applications that you will find in the App Store, edit them as you wish and
    be careful when translating them, the name of the app is the 'label'.

    The first configuration is for the home panels of the App Store application.

    In the examples you can see how we add games and applications.
]]

Config.StoreAppToday = {
    {
        header = 'Arcade Games',
        head = 'Download and play the most bizarre games you will find!',
        image = 'https://www.apple.com/newsroom/images/product/apple-arcade/Apple_Arcade-Update_disney-melee-mania_11152021.jpg.news_app_ed.jpg',
        footer = 'Discover our new games in the App Store, play with your friends but dont forget to enjoy Roleplay!'
    },
    {
        header = 'Music everywhere',
        head = 'With Soundfy you can enjoy your favorite music everywhere!',
        image = 'https://www.apple.com/newsroom/images/product/app-store/Apple-women-developers-apps-games-Niamh-Fitzgerald-and-Chantelle-Cole_inline.jpg.large.jpg',
        footer = 'Search for your favorite hits, create playlists and show your friends the real music, enjoy all this with Soundfy'
    }
}

Config.StoreApps = {
    {
        app = 'instagram',
        image = 'img/apps/instagram.png',
        label = 'Instagraph',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 10000,
        creator = 'Instagraph, Inc',
        category = 'Social',
        isGame = false,
        description = 'Photo and video application',
        age = '16+',
        extraDescription = {
            {
                header = 'Instagraph',
                head = 'Share unique images and stories with Instagraph',
                image = 'https://i.ibb.co/0DWsBDf/instagram.webp',
                footer = 'Connect with friends, share what you do, or check out whats new from people around the world'
            },
        }
    },
    {
        app = 'garage',
        image = 'img/apps/garage.png',
        label = 'iCar',
        job = false,      -- or { 'ambulance' }
        timeout = 15000,
        blockedJobs = {}, -- or { 'ambulance' }
        creator = 'Los Santos',
        category = 'Other',
        isGame = false,
        description = 'Check and manage the garages of all Los Santos!',
        age = '16+',
        extraDescription = {
            {
                header = 'Los Santos Garages',
                head = 'Specialized application to control your vehicles or garages for all saints',
                image = 'https://i.ibb.co/4t8q7M1/garage.webp',
                footer = 'What are you waiting for to manage all your vehicles in the most comfortable way?'
            },
        }
    },
    {
        app = 'twitter',
        image = 'img/apps/twitter.png',
        label = 'Tweedle',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 15000,
        creator = 'X Corp',
        category = 'social',
        isGame = false,
        description = 'Post about your day and enjoy with your friends',
        age = '16+',
        extraDescription = {
            {
                header = 'Tweedle',
                head = 'The Tweedle app is the trusted global digital marketplace for everyone',
                image = 'https://i.ibb.co/bK1jp0q/twitter.webp',
                footer = 'Post content for everyone to see and participate in public conversations'
            }
        }
    },
    {
        app = 'bank',
        image = 'img/apps/bank.png',
        label = 'C. Banking',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 15000,
        creator = 'C. Banking',
        category = 'Productivity & Finance',
        isGame = false,
        description = 'Post about your day and enjoy with your friends',
        age = '18+',
        extraDescription = {
            {
                header = 'Central Banking',
                head = 'Manage your money through Central Banking',
                image = 'https://i.ibb.co/sQRx7Yb/bank.webp',
                footer = 'Your money is always safe, we know you, we love you at Central Banking'
            }
        }
    },
    {
        app = 'whatsapp',
        image = 'img/apps/whatsapp.png',
        label = 'ChitChat',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 17000,
        creator = 'ChitChat Inc',
        category = 'social',
        isGame = false,
        description = 'Chat with your friends now!',
        age = '16+',
        extraDescription = {
            {
                header = 'ChitChat',
                head = 'Enjoy group chats and calls with your friends!',
                image = 'https://i.ibb.co/dcPPG7h/whatsapp.webp',
                footer = 'Contact your friends through your contacts and talk to them at any time'
            }
        }
    },
    {
        app = 'state',
        image = 'img/apps/state.png',
        label = 'State',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 14000,
        creator = 'Los Santos',
        category = 'Information & Reading',
        isGame = false,
        description = 'Search for workers online',
        age = '9+',
        extraDescription = {
            {
                header = 'State',
                head = 'Are you looking to communicate with a specific worker?',
                image = 'https://i.ibb.co/sKFvrmW/state.webp',
                footer = 'Call the most sought-after workers with the best reputation in Los Santos'
            }
        }
    },
    {
        app = 'spotify',
        image = 'img/apps/spotify.png',
        label = 'Soundfy',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 14000,
        creator = 'Soundfy Inc',
        category = 'Entertainment',
        isGame = false,
        description = 'Listen and play albums',
        age = '3+',
        extraDescription = {
            {
                header = 'Soundfy',
                head = 'With Soundfy, listening to the radio or songs from your artists with their lyrics or downloading music and podcasts is very simple',
                image = 'https://i.ibb.co/bztwrsJ/spotify.webp',
                footer = 'Soundfy is the perfect platform to listen to your favorite music, radio and podcasts on your mobile, tablet, computer and more'
            }
        }
    },
    {
        app = 'youtube',
        image = 'img/apps/youtube.png',
        label = 'YouLink',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 19000,
        creator = 'Link Inc',
        category = 'Entertainment',
        isGame = false,
        description = 'Watch videos online',
        age = '8+',
        extraDescription = {
            {
                header = 'YouLink',
                head = 'Get the official YouLink application on your Phone',
                image = 'https://i.ibb.co/rm1cz8Y/youtube.webp',
                footer = 'Discover what topics are sweeping the world!'
            }
        }
    },
    {
        app = 'tinder',
        image = 'img/apps/tinder.png',
        label = 'Finder',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 19000,
        creator = '4Love',
        category = 'Social',
        isGame = false,
        description = 'Find a partner and meet people',
        age = '18+',
        extraDescription = {
            {
                header = 'Finder',
                head = 'Are you looking for a partner? An open relationship?',
                image = 'https://i.ibb.co/yh8F0GS/tinder.webp',
                footer = 'With over 70 billion matches to date, Finder is the number one free dating app and the best place to meet people'
            }
        }
    },
    {
        app = 'yellowpages',
        image = 'img/apps/yellowpages.png',
        label = 'Yellow Posts',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 11000,
        creator = 'Los Santos',
        category = 'Information & Reading',
        isGame = false,
        description = 'Buying and selling items online',
        age = '18+',
        extraDescription = {
            {
                header = 'Yellow Posts',
                head = 'Find and sell items online',
                image = 'https://i.ibb.co/RvLkNJK/yellowpages.webp',
                footer = 'Find your favorite product or sell your belongings at Yellow Posts Los Santos'
            }
        }
    },
    {
        app = 'rentel',
        image = 'img/apps/rentel.png',
        label = 'Aventon',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 12000,
        creator = 'Aventon Tech',
        category = 'Other',
        isGame = false,
        description = 'Rent a car now!',
        age = '16+',
        extraDescription = {
            {
                header = 'Aventon',
                head = 'Find your ideal vehicle and rent it',
                image = 'https://i.ibb.co/bPgfgd4/rental.webp',
                footer = 'Rent vehicles and pick them up at the Aventon spot in Los Santos'
            }
        }
    },
    {
        app = 'uber',
        image = 'img/apps/uber.png',
        label = 'Door Run',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 18000,
        creator = 'doorRun SLU',
        category = 'Other',
        isGame = false,
        description = 'Work with us by placing orders',
        age = '6+',
        extraDescription = {
            {
                header = 'Door Run',
                head = 'Work at Door Run with just one click!',
                image = 'https://i.ibb.co/sy9PGfR/ubereats.webp',
                footer = 'Visit the most hidden places in Los Santos delivering orders for Door Run'
            }
        }
    },
    {
        app = 'darkweb',
        image = 'img/apps/darkweb.png',
        label = 'Onion Browser',
        job = false,                -- or { 'ambulance' }
        blockedJobs = { 'police' }, -- or { 'ambulance' }
        timeout = 12000,
        creator = 'Thor',
        category = 'Other',
        isGame = false,
        description = 'The deepest of the internet',
        age = '18+',
        extraDescription = {
            {
                header = 'Onion Browser',
                head = 'Discover the darkest stores on the internet',
                image = 'https://i.ibb.co/J2v1nnZ/darkweb.webp',
                footer = 'Buying and selling anonymous weapons with unique serial numbers'
            }
        }
    },
    {
        app = 'racing',
        image = 'img/apps/racing.png',
        label = 'Racing',
        job = false,                -- or { 'ambulance' }
        blockedJobs = { 'police' }, -- or { 'ambulance' }
        timeout = 21000,
        creator = 'Insane Team',
        category = 'Other',
        isGame = false,
        description = 'Urban racing in a single app',
        age = '18+',
        extraDescription = {
            {
                header = 'Racing',
                head = 'Join street racing in Los Santos',
                image = 'https://i.ibb.co/2cynM0k/racing.webp',
                footer = 'Compete for the prize, participate in races and appear at the top of Los Santos Racing'
            }
        }
    },
    {
        app = 'darkchat',
        image = 'img/apps/darkchat.png',
        label = 'D-Chat',
        job = false,                -- or { 'ambulance' }
        blockedJobs = { 'police' }, -- or { 'ambulance' }
        timeout = 12000,
        creator = 'Thor',
        category = 'Other',
        isGame = false,
        description = 'Private chats without registrations',
        age = '18+',
        extraDescription = {
            {
                header = 'D-Chat',
                head = 'Create your forum and chat with other people without any fear of data disclosure',
                image = 'https://i.ibb.co/K2qznvW/darkchat.png',
                footer = 'D-Chat works hosted by each user, so there is no way to recover or track messages'
            }
        }
    },
    {
        app = 'uberRider',
        image = 'img/apps/uberRider.png',
        label = 'Drive Now',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 22000,
        creator = 'Drive Tech',
        category = 'Other',
        isGame = false,
        description = 'Tax-free travel',
        age = '18+',
        extraDescription = {
            {
                header = 'Drive Now',
                head = 'Request your trips or even sign up among our drivers',
                image = 'https://i.ibb.co/wd5BPJ4/uber.webp',
                footer = 'The safest website for your trips in all Los Santos'
            }
        }
    },
    {
        app = 'tiktok',
        image = 'img/apps/tiktok.png',
        label = 'TickTock',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 29000,
        creator = 'TickTock Inc',
        category = 'Social',
        isGame = false,
        description = 'Upload videos with your friends',
        age = '12+',
        extraDescription = {
            {
                header = 'TickTock',
                head = 'Be number one by posting the funniest videos',
                image = 'https://i.ibb.co/kKJqbyn/tiktok.webp',
                footer = 'Upload videos, listen to music, compete with your friends for the best post'
            }
        }
    },
    {
        app = 'market',
        image = 'img/apps/market.png',
        label = 'Marketplace',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 29000,
        creator = 'Los Santos',
        category = 'Other',
        isGame = false,
        description = 'Your favorite shops',
        age = '9+',
        extraDescription = {
            {
                header = 'Marketplace',
                head = 'The best shops in Los Santos have arrived',
                image = 'https://i.ibb.co/cJ1yPjL/market.webp',
                footer = 'Place your orders or even manage your business with Marketplace'
            }
        }
    },
    {
        app = 'discord',
        image = 'img/apps/discord.png',
        label = 'Catcord',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 13000,
        creator = 'Catcord Inc',
        category = 'Social',
        isGame = false,
        description = 'Channels to chat',
        age = '12+',
        extraDescription = {
            {
                header = 'Catcord',
                head = 'Channels to chat with your friends',
                image = 'https://i.ibb.co/vmtL0MK/discord.webp',
                footer = 'Create and manage your own channels with Catcord!'
            }
        }
    },
    {
        app = 'jobcenter',
        image = 'img/apps/jobcenter.png',
        label = 'Job Center',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 16000,
        creator = 'Jobs SLU',
        category = 'Other',
        isGame = false,
        description = 'Find a job quickly',
        age = '18+',
        extraDescription = {
            {
                header = 'Job Center',
                head = 'Search for jobs online with Likedin',
                image = 'https://i.ibb.co/dMmQJqS/jobcenter.webp',
                footer = 'Get hired by the best companies in Los Santos with Likedin!'
            }
        }
    },

    -- Games
    {
        app = 'fruitchop',
        image = 'https://cdn.jim-nielsen.com/ios/512/fruit-ninja-2020-08-31.png',
        label = 'Fruit Chop',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 28000,
        creator = 'Gamezop Inc',
        category = 'Games',
        description = 'Slide cutting fruits',
        age = '3+',
        isGame = true,
        game = {
            name = 'fruitchop',
            iframe = 'https://cdn-factory.marketjs.com/en/fruit-slice-frenzy/index.html',
            css = {
                -- If you make it with css, you can use it like this .fruitchop-app iframe { css values },
                width = '215%',
                height = '50%',
                transform = 'rotate(90deg)', -- Required for rotate
                border = 'none',
                position = 'absolute',
                left = '-60%',
                top = '25%',
            },
            rotate = true
        },
        extraDescription = {
            {
                header = 'Fruit Chop',
                head = 'Cut the fruits in time to win!',
                image = 'https://assets1.ignimgs.com/2016/05/20/fruit-ninjajpg-6da9b1_160w.jpg?width=1280',
                footer = 'Intuitive game that allows you to cut fruits and earn many rewards'
            }
        }
    },
    {
        app = 'chikenblast',
        image = 'https://i.ibb.co/tBbDWqL/3.webp',
        label = 'Chiken Blast',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 28000,
        creator = 'Gamezop Inc',
        category = 'Games',
        description = 'Collect colorful chickens and complete the game',
        age = '16+',
        isGame = true,
        game = {
            name = 'chikenblast',
            iframe = 'https://cdn-factory.marketjs.com/en/chicken-blast/index.html',
            css = {
                -- If you make it with css, you can use it like this .chikenblast-app iframe { css values },
                width = '215%',
                height = '50%',
                transform = 'rotate(90deg)', -- Required for rotate
                border = 'none',
                position = 'absolute',
                left = '-60%',
                top = '25%',
            },
            rotate = true
        },
        extraDescription = {
            {
                header = 'Chiken Blast',
                head = 'Collect colorful chickens and complete the game',
                image = 'https://www.marketjs.com/item/chicken-blast/chicken-blast.jpg',
                footer = 'The most played chicken game this 2024'
            }
        }
    },
    {
        app = 'kingkongracing',
        image = 'https://i.ibb.co/p0Xp9DS/2.webp',
        label = 'King Kong Racing',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 28000,
        creator = 'Gamezop Inc',
        category = 'Games',
        description = 'Epic monkey races',
        age = '3+',
        isGame = true,
        game = {
            name = 'kingkongracing',
            iframe = 'https://cdn-factory.marketjs.com/en/king-kong-kart-racing/index.html',
            css = {
                -- If you make it with css, you can use it like this .kingkongracing-app iframe { css values },
                width = '215%',
                height = '50%',
                transform = 'rotate(90deg)', -- Required for rotate
                border = 'none',
                position = 'absolute',
                left = '-60%',
                top = '25%',
            },
            rotate = true
        },
        extraDescription = {
            {
                header = 'King Kong Racing',
                head = 'Epic monkey races',
                image = 'https://a.silvergames.com/screenshots/king-kong-kart-racing/2_kart-race.jpg',
                footer = 'Be the champion of the world of monkeys!'
            }
        }
    },
    {
        app = 'mmacitybrawl',
        image = 'https://i.ibb.co/pvQpJHp/1.webp',
        label = 'MMA City Brawl',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        timeout = 28000,  --28000,
        creator = 'Gamezop Inc',
        category = 'Games',
        description = 'Online street fights!',
        age = '18+',
        isGame = true,
        game = {
            name = 'mmacitybrawl',
            iframe = 'https://cdn-factory.marketjs.com/en/mma-city-brawl/index.html',
            css = {
                -- If you make it with css, you can use it like this .mmacitybrawl-app iframe { css values },
                width = '215%',
                height = '50%',
                transform = 'rotate(90deg)', -- Required for rotate
                border = 'none',
                position = 'absolute',
                left = '-60%',
                top = '25%',
            },
            rotate = true
        },
        extraDescription = {
            {
                header = 'MMA City Brawl',
                head = 'Online street fights!',
                image = 'https://www.marketjs.com/item/mma-city-brawl/mma-city-brawl.jpg',
                footer = 'Fight with other players to be the champion!'
            }
        }
    },
}

--[[
    DO NOT EDIT CUSTOM APP EVENTS.

    This configuration brings all the default apps on the phone, you can edit their translations and more.
]]

Config.CustomApplications = {}

for _, v in pairs(Config.CustomApplications) do
    table.insert(Config.StoreApps, v)
end

Config.PhoneApplications = {
    {
        app = 'phone',
        image = 'img/apps/phone.png',
        label = 'Phone',
        job = false,                        -- or { 'ambulance' }
        blockedJobs = {},                   -- or { 'ambulance' }
        category = 'Social',
        hideInSettingsNotifications = true, -- hide in settings notifications
        notificationSound = '',             -- if you want to use default notification sound, delete this line
    },
    {
        app = 'messages',
        image = 'img/apps/messages.png',
        label = 'Messages',
        job = false,      -- or { 'ambulance' }
        category = 'Social',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'settings',
        image = 'img/apps/settings.png',
        label = 'Settings',
        job = false,      -- or { 'ambulance' }
        category = 'Utilities',
        blockedJobs = {}, -- or { 'ambulance' }
        blockBadge = true
    },
    {
        app = 'camera',
        image = 'img/apps/camera.png',
        label = 'Camera',
        category = 'Creativity',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'contacts',
        image = 'img/apps/contacts.png',
        label = 'Contacts',
        job = false,      -- or { 'ambulance' }
        category = 'Social',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'mail',
        image = 'img/apps/mail.png',
        label = 'Mail',
        category = 'Productivity & Finance',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'weather',
        image = 'img/apps/weather.png',
        label = 'Weather',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        category = 'Information & Reading',
    },
    {
        app = 'calendar',
        image = 'img/apps/calendar.png',
        label = 'Calendar',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        category = 'Productivity & Finance',
    },
    {
        app = 'reminder',
        image = 'img/apps/reminders.png',
        label = 'Reminders',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        category = 'Productivity & Finance',
    },
    {
        app = 'gallery',
        image = 'img/apps/gallery.png',
        label = 'Gallery',
        job = false,      -- or { 'ambulance' }
        category = 'Creativity',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'health',
        image = 'img/apps/health.png',
        label = 'Health',
        job = false,      -- or { 'ambulance' }
        category = 'Creativity',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'notes',
        image = 'img/apps/notes.png',
        label = 'Notes',
        category = 'Productivity & Finance',
        job = false,      -- or { 'ambulance' }
        blockedJobs = {}, -- or { 'ambulance' }
        hideInSettingsNotifications = true
    },
    {
        app = 'calculator',
        image = 'img/apps/calculator.png',
        label = 'Calculator',
        job = false,      -- or { 'ambulance' }
        category = 'Utilities',
        blockedJobs = {}, -- or { 'ambulance' }
        hideInSettingsNotifications = true
    },
    {
        app = 'store',
        image = 'img/apps/store.png',
        label = 'App Store',
        job = false,      -- or { 'ambulance' }
        category = 'Utilities',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'crypto',
        image = 'img/apps/stock.png',
        label = 'Stock',
        job = false,      -- or { 'ambulance' }
        category = 'Productivity & Finance',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'clock',
        image = 'img/apps/clock.png',
        label = 'Clock',
        job = false,      -- or { 'ambulance' }
        category = 'Utilities',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'houses',
        image = 'img/apps/houses.png',
        label = 'Home',
        job = false,      -- or { 'ambulance' }
        category = 'Utilities',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'weazel',
        image = 'img/apps/news.png',
        label = 'News',
        job = false,      -- or { 'ambulance' }
        category = 'Other',
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'map',
        image = 'img/apps/maps.png',
        label = 'Maps',
        category = 'Utilities',
        job = nil,
        blockedJobs = {}, -- or { 'ambulance' }
    },
    {
        app = 'safari',
        category = 'Utilities',
        label = 'Safari',
        game = {
            iframe = 'https://www.bing.com',
            rotate = false,
            name = 'safari',
            css = {
                top = '0',
                border = 'none',
                height = '100%',
                position = 'absolute',
                width = '100%'
            }
        },
        image = 'img/apps/safari.png',
        blockedJobs = {}
    },
    {
        app = 'facetime',
        image = 'img/apps/facetime.png',
        label = 'FaceTime',
        category = 'Social',
        job = false, -- or { 'ambulance' }
        blockedJobs = {}
    },
}

--[[
    Debug mode, this mode is to receive constant prints and information
    from the system, we do not recommend enabling it if you are not a
    developer, but it will help to understand how the resource works.
]]

Config.Debug = false
Config.ZoneDebug = false
Config.DeleteStoriesAndNotifies = false
