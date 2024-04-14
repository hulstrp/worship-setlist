
Config = {}
Config.Debug = false
Config.Framework = 'esx' -- esx / qb
Config.Language = 'en' -- en / es

--[[
	Inventory system will you use (NEED METADATA) DEFAULT COMPATIBLE WITH:
		- qs-inventory
		- ox_inventory
		- none
]]

Config.Inventory = 'qs-inventory' 
Config.InvoiceItemName = 'bill_paper' -- item name TO VIEW SPECIFICiNVOICE

Config.Keys = {
	['OpenArcadeBillingMenu'] = 'F7'
}

Config.AutoPayInterval = 10 -- in minutes 
Config.LimitToPayInvoice = 7 -- in days 
-- [[NOT AVAILABLE AT THE MOMENT]] -- Config.ChargesOfUnpaidInvoiceByDay = 10 -- 10% of the invoice amount of charges per day of not paid invoice and if the invoice is unpayed after Limit to pay invoice days
Config.SocietyPrefix = 'society_'
Config.PercentageOfElectronicTransaction = 3 -- this percentege is the amount + the percentage of the invoice amount 

Config.PlayersDistanceDetect = 10.0 -- distance to detect players in the map

Config.Societys = {
	['police'] = {
		canAccessGrade = { -- can view all invoices of the society, delete and mark as payed
			[4] = true,
			['boss'] = true,
		}
	}
}


Config.PresentialBillingPayment = {
	['Enabled'] = true,
	['Distance'] = 1.5,
	['Blips'] = {
		enabled = true,
		sprite = 207,
		display = 4,
		scale = 0.8,
		colour = 2,
		shortRange = true,
	},
	['Points'] = {
		{
			label = 'Pay Invoice', -- if you need stack the blip in the map you can use the same label in all points
			coords = vector3(241.8698, 224.2415, 106.2868),
			markerId = 21,
			distance = 3
		},
		{
			label = 'Pay Invoice',
			coords = vector3(246.7510, 222.9073, 106.2868),
			markerId = 21,
			distance = 3
		},
		{
			label = 'Pay Invoice',
			coords = vector3(-1270.0256, -3048.5208, 13.9807),
			markerId = 21,
			distance = 3
		}
	}
}